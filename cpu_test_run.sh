OUTPUT=/master_thesis/outputs
RESULT_FILE="${OUTPUT}/result.txt"
cipher_commands="md5 sha512 aes-256-cbc rsa2048 dsa2048"
for test in ${cipher_commands}; do
    echo "Running openssl speed ${test} test"
    openssl speed -multi 16 "${test}" 2>&1 | tee "${OUTPUT}/${test}-output.txt"

    case "${test}" in
      # Parse asymmetric encryption output.
      rsa2048|dsa2048)
        awk -v test_case_id="${test}" 'match($1$2, test_case_id) \
            {printf("%s-sign pass %s sign/s\n", test_case_id, $(NF-1)); \
            printf("%s-verify pass %s verify/s\n", test_case_id, $NF)}' \
            "${OUTPUT}/${test}-output.txt" | tee -a "${RESULT_FILE}"
        ;;
      # Parse symmetric encryption output.
      (aes-256-cbc)
        awk -v test_case_id="${test}" \
            '/^Doing/ {printf("%s-%s pass %d bytes/s\n", test_case_id, $7, $7*$10/3)}' \
            "${OUTPUT}/${test}-output.txt" | tee -a "${RESULT_FILE}"
        ;;
      *)
        awk -v test_case_id="${test}" \
            '/^Doing/ {printf("%s-%s pass %d bytes/s\n", test_case_id, $6, $6*$9/3)}' \
            "${OUTPUT}/${test}-output.txt" | tee -a "${RESULT_FILE}"
        ;;
    esac
done

stress-ng --cpu 16 --cpu-method fft -t 300 --metrics-brief 2>  "${OUTPUT}/fft-output.txt"
stress-ng --cpu 16 --cpu-method pi -t 300 --metrics-brief 2> "${OUTPUT}/pi-output.txt"
stress-ng --cpu 16 --matrix 16 -t 300 --matrix-method hadamard --metrics-brief 2> "${OUTPUT}/matrix-output.txt"

echo "FFT BOGOS/s: $(cat ${OUTPUT}/fft-output.txt | grep cpu | awk '{print $9}')" >> "${RESULT_FILE}"
echo "PI BOGOS/s: $(cat ${OUTPUT}/pi-output.txt | grep cpu | awk '{print $9}')" >>  "${RESULT_FILE}"
echo "MATRIX BOGOS/s: $(cat ${OUTPUT}/matrix-output.txt | grep matrix | awk '{print $9}')" >> "${RESULT_FILE}"

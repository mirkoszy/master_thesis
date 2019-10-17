OUTPUT=/master_thesis/outputs
RESULT_FILE="${OUTPUT}/result.out"
test="rsa2048"
for i in {1..34}; do
    echo "Running openssl speed ${test} test"
    openssl speed -multi 4 "${test}" 2>&1 | tee "${OUTPUT}/${test}-output.txt"

    awk -v test_case_id="${test}" 'match($1$2, test_case_id) \
      {printf("%s-sign pass %s sign/s\n", test_case_id, $(NF-1)); \
      printf("%s-verify pass %s verify/s\n", test_case_id, $NF)}' \
      "${OUTPUT}/${test}-output.txt" | tee -a "${RESULT_FILE}"
    ./kcbench -n 1 >> kcbench.log 
done

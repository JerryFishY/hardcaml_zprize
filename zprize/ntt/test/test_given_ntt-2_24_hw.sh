#!/bin/bash

set -euo pipefail

export INPUT_FILENAME="$1"
export EXPECTED_OUTPUT_FILENAME="$2"
export OUTPUT_FILENAME="/tmp/ntt-fpga-evaluate-given-output.txt"

make -C ../host evaluate_given.exe
cp ../host/evaluate_given.exe ./

# xsim requires xrt.ini requires absolute directory for pre-run tcl scripts.
sed -e "s#CURRENT_DIRECTORY#$PWD#g" xrt.template.ini >xrt.ini

../host/evaluate_given.exe  \
    --xclbin ../fpga/ntt-2_24/build/build_dir.hw.xilinx_u55n_gen3x4_xdma_2_202110_1/ntt_fpga.xclbin \
    --core-type NTT-2_24 \
    --input-filename "$INPUT_FILENAME" \
    --output-filename "$OUTPUT_FILENAME"

diff "$OUTPUT_FILENAME" "$EXPECTED_OUTPUT_FILENAME"

# if the diff returns 0, it means it is is empty and the test succeeded.
echo "Test succeeded!"

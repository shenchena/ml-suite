#!/usr/bin/env bash
#
# // SPDX-License-Identifier: BSD-3-CLAUSE
#
# (C) Copyright 2018, Xilinx, Inc.
#
#!/bin/bash

# Set Platform Environment Variables
if [ -z $MLSUITE_ROOT ]; then
  MLSUITE_ROOT=../..
fi

. ${MLSUITE_ROOT}/overlaybins/setup.sh

for kcfg in med large v3; do
    if [ ${kcfg} == med ]; then
        BPP=2
        DSP_WIDTH=28
        MEM=4
    elif [ ${kcfg} == large ]; then
        BPP=2
        DSP_WIDTH=56
        MEM=6
    elif [ ${kcfg} == v3 ]; then
        BPP=1
        DSP_WIDTH=96
        MEM=9
    fi
    DDR=256

    python $MLSUITE_ROOT/xfdnn/tools/compile/bin/xfdnn_compiler_caffe.py \
        -n $MLSUITE_ROOT/models/caffe/yolov2/fp32/yolo_deploy_608.prototxt \
        -g $MLSUITE_ROOT/examples/compile/work/caffe/yolov2/fp32/yolo_deploy_608_${DSP_WIDTH}.cmds \
        -w $MLSUITE_ROOT/models/caffe/yolov2/fp32/yolov2.caffemodel \
        -s all \
        -b ${BPP} \
        -i ${DSP_WIDTH} \
        -m ${MEM} \
        -d ${DDR}
done

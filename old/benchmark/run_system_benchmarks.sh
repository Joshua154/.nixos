#!/bin/bash

echo "== CPU Benchmark =="
sysbench cpu --cpu-max-prime=20000 run

echo "== Disk Benchmark =="
fio --name=readwrite --ioengine=libaio --iodepth=16 --rw=randrw --bs=4k --direct=1 --size=1G --numjobs=4 --runtime=60 --time_based --group_reporting

echo "== GPU Benchmark =="
glmark2

echo "== Vulkan Test =="
vkcube


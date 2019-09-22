#!/bin/bash

# 並列処理数
PARALLEL_NUM=4

# サーバー試験の実行
bundler exec rake spec -j PARALLEL_NUM -m

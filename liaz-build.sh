#!/bin/bash

flutter clean

flutter build apk --release --dart-define=CHANNEL=official --split-per-abi

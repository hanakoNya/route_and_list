#!/bin/bash -e
set -o pipefail

CUR_DIR=$(pwd)
TMP_DIR=$(mktemp -d /tmp/toplist.XXXXXX)

SRC_URL="https://downloads.majesticseo.com/majestic_million.csv"
DEST_FILE="dist/toplist/toplist.txt"

gen_list() {
  cd $TMP_DIR

  curl -sSL $SRC_URL |
    # unzip
    # gunzip |
    # extract domain
    awk -F ',' 'NR>1 {print $3}' > toplist.txt

  cd $CUR_DIR
}

copy_dest() {
  install -D -m 644 $TMP_DIR/toplist.txt $DEST_FILE
}

clean_up() {
  rm -r $TMP_DIR
}

gen_list
copy_dest
clean_up

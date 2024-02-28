#!/usr/bin/env bash

HS_SCRIPT="cabal exec needle-count"
FS_SCRIPT="dotnet run --project ./Needle.CLI/Needle.CLI.fsproj"
TEST_DIR="e2e-test"

run_golden_test () {
  local command=$1
  local file_name_input=$2
  local filename_expected=$3
  actual=$($command "$file_name_input" 2>&1)
  if grep -q "$actual" "$filename_expected"; then
    printf "ok\n"
  else
    local expected
    expected=$(cat "$filename_expected")
    printf "not ok\n\nexpected: %s\nactual: %s\n" "$expected" "$actual"
    printf "command: %s" "$command"
    exit 1
  fi
}

run_test () {
  local command=$1
  local file_name_input=$2
  local expected=$3
  actual=$($command "$file_name_input" 2>&1)
  if [ "$actual" = "$expected" ]; then
    printf "ok\n"
  else
    printf "not ok\n\nexpected: %s\nactual: %s\n" "$expected" "$actual"
    printf "command: %s" "$command"
    exit 1
  fi
}

for dir in "$TEST_DIR"/*/
do
  dir=${dir%*/}
  basename="${dir##*/}"
  filename_expected="../$dir/expected-output.txt"
  filename_input="../$dir/$basename.txt"
  pushd hs > /dev/null || exit
  run_golden_test "$HS_SCRIPT" "$filename_input" "$filename_expected"
  popd > /dev/null || exit

  pushd fs > /dev/null || exit
  run_golden_test "$FS_SCRIPT" "$filename_input" "$filename_expected"
  popd > /dev/null || exit
done

pushd hs > /dev/null || exit
run_test "$HS_SCRIPT" "non-existent-file.txt" "File not found"
popd > /dev/null || exit

pushd fs > /dev/null || exit
run_test "$FS_SCRIPT" "non-existent-file.txt" "File not found"
popd > /dev/null || exit

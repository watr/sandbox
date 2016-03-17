script_dir=$(cd $(dirname $BASH_SOURCE); pwd)
sketchtool export layers --items="bar" --use-id-for-name="YES" --scale="1.0" "$script_dir/sample.sketch"
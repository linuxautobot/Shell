 IFS=$'\n';for f in `find .`; do file=$(echo $f | tr [:blank:] '_'); [ -e $f ] && [ ! -e $file ] && mv "$f" $file;done;unset IFS

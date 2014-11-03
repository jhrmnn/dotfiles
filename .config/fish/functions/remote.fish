function remote
    last -a ^/dev/null | grep $USER | head -n 1 | awk '{print $NF}'
end

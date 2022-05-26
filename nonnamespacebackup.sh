#!/bin/bash
non_ns_api=`kubectl api-resources -o name --namespaced=false`

mkdir cluster

echo Exporting cluster resources
for r in $non_ns_api
do
    names=`kubectl get $r -o name`
    if [ -z "$names" ];
    then
        printf "Skipping because of empty value \n"
    else
        printf "Drumping $r \n\n"
        for name in $names
        do
            mkdir -p `dirname cluster/$name`
            kubectl get $name -o yaml | kubectl neat > cluster/$name.yaml
            printf "manifest saved to cluster/$name.yaml \n"
        done
    fi
done




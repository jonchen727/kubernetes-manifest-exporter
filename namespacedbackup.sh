#!/bin/bash

ns_api=`kubectl api-resources -o name --namespaced=true`
namespaces=`kubectl get namespaces -o name | sed 's/namespace\// /g'`

 echo Exporting namespaced resources
 mkdir namespaces

 for n in $namespaces
 do
     for r in $ns_api
     do
         names=`kubectl get $r -n $n -o name`
         if [ -z "$names" ];
         then
             printf "Skipping becasue of empty value\n"
         else
             printf "Dumping $r in $n \n\n"
             for name in $names
             do
                 mkdir -p `dirname namespaces/$n/$name`
                 kubectl get $name -n $n -o yaml | kubectl neat > namespaces/$n/$name.yaml
                 printf "manifest saved to namespaces/$n/$name.yaml \n"
             done
         fi
     done
 done

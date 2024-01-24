#!/usr/bin/env bash
makefile=`pwd`/apps.Makefile
current=`pwd`
echo $CURRENT_ENV
ENVS=${CURRENT_ENV:-"."}
# git crypt unlock /etc/git-crypt/conny-infra.key

lint()
{
 local dir=$1
 if ! kubeconform --ignore-missing-schemas --summary --strict $dir/gen-output ; then
     echo "failed to validate $f"
     exit 1
 fi
}

for envpath in $ENVS; do
    echo $envpath
    cd $current/$envpath
    for f in $(find . -name kustomization.yaml -not -path "*/gen-output/*"); do
        dir=$current/$envpath/"$(dirname "$f")"
        cd $dir

        if [ $1 = 'gen-all' ]; then
            echo "GEN: $dir"
            cp "$makefile" "$dir"
            mv $dir/apps.Makefile $dir/apps.Makefile
            if [ -f $dir/.gen-skip ]; then
                echo "skipping $dir"
                continue
            fi
            make gen -f apps.Makefile &
           if [ $? -ne 0 ]; then
               echo "Error with: $dir"
               exit 1
           fi
        elif [ $1 = 'lint' ]; then
            echo "LINT: $dir"
            lint $dir &
        else
            echo "wrong command: chose lint or gen-all"
        fi
    done
    wait
done
exit 0
# #!/usr/bin/env bash
# makefile=`pwd`/apps.Makefile
# current=`pwd`
# ENVS=${CURRENT_ENV:-"."}
# # git crypt unlock /etc/git-crypt/conny-infra.key
# for envpath in $ENVS; do
#     echo $envpath
#     cd $current/$envpath
#     for f in $(find . -name kustomization.yaml -not -path "*/gen-output/*"); do
#         dir=$current/$envpath/"$(dirname "$f")"
#         cd $dir

#         if [ $1 = 'gen-all' ]; then
#             echo "GEN: $dir"
#             cp "$makefile" "$dir"
#             mv $dir/apps.Makefile $dir/apps.Makefile
#             make gen -f $dir/apps.Makefile
#            if [ $? -ne 0 ]; then
#                echo "Error with: $dir"
#                exit 1
#            fi
#         elif [ $1 = 'lint' ]; then
#             echo "LINT: $dir"
#             if ! kubeconform --ignore-missing-schemas --summary --strict $dir/gen-output ; then
#                 echo "failed to validate $f"
#                 exit 1
#             fi
#         else
#             echo "wrong command: chose lint or gen-all"
#         fi
#     done
# done
# exit 0

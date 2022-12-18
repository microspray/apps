# curl -sL https://run.linkerd.io/install | sh
#  \

linkerd  upgrade \
            --skip-inbound-ports="4567,4568,22,25,443,587,3306,4444,5432,6379,9300,11211,6443,27017,9200" \
            --skip-outbound-ports="4567,4568,22,25,443,587,3306,4444,5432,6379,9300,11211,6443,27017,9200" \
            --ha \
            > manifests/upstream/linkerd.aio.yaml

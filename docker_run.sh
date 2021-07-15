# -v adds local directory to container
# -p for port forwarding 8899 locally is mapped to container 8888
docker run -p 8899:8888 -v $PWD:/app mck-uspgxa-ea-ds.jfrog.io/spark-intern-demo:latest
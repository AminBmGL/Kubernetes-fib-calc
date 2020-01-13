docker build -t $DOCKER_USERNAME/fib-client:latest -t $DOCKER_USERNAME/fib-client:$SHA -f ./frontend/Dockerfile ./frontend
docker build -t $DOCKER_USERNAME/fib-server:latest -t $DOCKER_USERNAME/fib-server:$SHA -f ./express/Dockerfile ./express
docker build -t $DOCKER_USERNAME/fib-worker:latest -t $DOCKER_USERNAME/fib-worker:$SHA -f ./worker/Dockerfile ./worker

docker push $DOCKER_USERNAME/fib-client:latest
docker push $DOCKER_USERNAME/fib-server:latest
docker push $DOCKER_USERNAME/fib-worker:latest

docker push $DOCKER_USERNAME/fib-client:$SHA
docker push $DOCKER_USERNAME/fib-server:$SHA
docker push $DOCKER_USERNAME/fib-worker:$SHA



kubectl apply -f k8s
kubectl set image deployments/server-deployment server=$DOCKER_USERNAME/fib-server:$SHA
kubectl set image deployments/client-deployment client=$DOCKER_USERNAME/fib-client:$SHA
kubectl set image deployments/worker-deployment worker=$DOCKER_USERNAME/fib-worker:$SHA
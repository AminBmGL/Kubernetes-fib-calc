docker build -t medamin2019/fib-client:latest -t medamin2019/fib-client:$SHA -f ./frontend/Dockerfile ./frontend
docker build -t medamin2019/fib-server:latest -t medamin2019/fib-server:$SHA -f ./express/Dockerfile ./express
docker build -t medamin2019/fib-worker:latest -t medamin2019/fib-worker:$SHA -f ./worker/Dockerfile ./worker

docker push medamin2019/fib-client:latest
docker push medamin2019/fib-server:latest
docker push medamin2019/fib-worker:latest

docker push medamin2019/fib-client:$SHA
docker push medamin2019/fib-server:$SHA
docker push medamin2019/fib-worker:$SHA



kubectl apply -f k8s
kubectl set image deployments/server-deployment server=medamin2019/fib-server:$SHA
kubectl set image deployments/client-deployment client=medamin2019/fib-client:$SHA
kubectl set image deployments/worker-deployment worker=medamin2019/fib-worker:$SHA
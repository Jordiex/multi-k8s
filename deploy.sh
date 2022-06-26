docker build -t jxrdy/multi-client:latest -t jxrdy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jxrdy/multi-server:latest -t jxrdy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jxrdy/multi-worker:latest -t jxrdy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jxrdy/multi-client:latest
docker push jxrdy/multi-server:latest
docker push jxrdy/multi-worker:latest

docker push jxrdy/multi-client:$SHA
docker push jxrdy/multi-server:$SHA
docker push jxrdy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jxrdy/multi-server:$SHA
kubectl set image deployments/client-deployment client=jxrdy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jxrdy/multi-worker:$SHA


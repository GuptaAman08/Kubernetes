docker build -t dockeramgupta04/multi-container-client:latest -t dockeramgupta04/multi-container-client:$SHA -f ./client/Dockerfile ./client
docker build -t dockeramgupta04/multi-container-server:latest -t dockeramgupta04/multi-container-server:$SHA -f ./server/Dockerfile ./server
docker build -t dockeramgupta04/multi-container-worker:latest -t dockeramgupta04/multi-container-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dockeramgupta04/multi-container-client:latest
docker push dockeramgupta04/multi-container-server:latest
docker push dockeramgupta04/multi-container-worker:latest

docker push dockeramgupta04/multi-container-client:$SHA
docker push dockeramgupta04/multi-container-server:$SHA
docker push dockeramgupta04/multi-container-worker:$SHA

kubectl apply -f K8s

kubectl set image deployment/client-deployment client=dockeramgupta04/multi-container-client:$SHA
kubectl set image deployment/server-deployment server=dockeramgupta04/multi-container-server:$SHA
kubectl set image deployment/worker-deployment worker=dockeramgupta04/multi-container-worker:$SHA
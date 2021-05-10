docker build -t ducnha7791/multi-client:latest -t ducnha7791/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t ducnha7791/multi-server:latest -t ducnha7791/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t ducnha7791/multi-worker:latest -t ducnha7791/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push ducnha7791/multi-client:latest
docker push ducnha7791/multi-server:latest
docker push ducnha7791/multi-worker:latest

docker push ducnha7791/multi-client:$SHA
docker push ducnha7791/multi-server:$SHA
docker push ducnha7791/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ducnha7791/multi-server:$SHA
kubectl set image deployments/client-deployment server=ducnha7791/multi-client:$SHA
kubectl set image deployments/worker-deployment server=ducnha7791/multi-worker:$SHA
  
# building images
docker build -t antoniotre86/multi-client:latest -t antoniotre86/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t antoniotre86/multi-server:latest -t antoniotre86/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t antoniotre86/multi-worker:latest -t antoniotre86/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

# pushing to dockerhub
docker push antoniotre86/multi-client:latest
docker push antoniotre86/multi-server:latest
docker push antoniotre86/multi-worker:latest

docker push antoniotre86/multi-client:$GIT_SHA
docker push antoniotre86/multi-server:$GIT_SHA
docker push antoniotre86/multi-worker:$GIT_SHA

# apply with kubectl
kubectl apply -f k8s

# imperatively set latst imates for each deployment
kubectl set image deployments/server-deployment server=antoniotre86/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=antoniotre86/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=antoniotre86/multi-worker:$GIT_SHA

docker-compose up --build

docker build -t athena-agent .

docker build -t athena-agent:10sec .

docker run --name user-agent1 --network athena_frontend athena-agent

docker run --name user-agent1 --network athena_frontend athena-agent:10sec
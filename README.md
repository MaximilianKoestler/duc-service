# Duc-Service
Run [Duc](https://duc.zevv.nl/) in Docker and re-index the file system using a schedule.

## Developing

### With docker-compose
Build:
```
docker-compose build
```

Run:
```
docker-compose up --build --detach
```

### Without docker-compose
Build:
```
docker build . -t duc-service
```

Run:
```
docker run -e "SCHEDULE=0 0 * * *" -p 80:80 --mount type=bind,src=/,dst=/scan/root,readonly --mount type=volume,src=duc_database,dst=/database duc-service
```

# GBS Films

This API is responsible for feeding the database of films through informed titles.

This project is splited in API and one worker.

* **API** is responsible to send all titles request to RabbitMq, retrieve processed films and job status.

* **Worker** is responsible to get message in RabbitMq and execute request to amdbapi to retrieve film information and save in local database.  

## Dependencies
- Docker
- Docker-compose

## First Execution

1. Run `docker-compose build`
2. Run `docker-compose run --rm app mix setup`
3. To start Run `docker-compose up`
4. Project is running.

**Obs.:** If necessary more workers, using flag `--scale worker=total_of_workers` after `docker-compose command`

## Routes

The routes can see in ENDPOINTS.apib. My sugestion is run `docker run -it --rm -v $PWD:/doc -p 8088:8088  --entrypoint='' quay.io/bukalapak/snowboard:v1 snowboard html -o output.html -b 0.0.0.0:8088 -s ENDPOINTS.apib`

## TO DO
* Create tests
* Treat unexpected request body
* Add cache instead of querying data existence in the database

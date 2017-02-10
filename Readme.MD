# Setup Instructions

## Clone the repository

```
docker-compose up -d (if you want to run in background)
```

http://localhost:5050/browser/ (fire up pgAdmin)

Web:
 - host: vainsocial_postgres_web
 - port: 5432
 - user: vainweb
 - password: vainweb
 - db: vainsocial-web

 Raw:
 - host: vainsocial_postgres_raw
 - port: 5432
 - user: vainraw
 - password: vainraw
 - db: vainsocial-raw


 Running the Vainsocial.com
 > only needed if you are running the container for the first time

 ```
 docker-compose exec workspace bash
 ```

 > once logged into the container

 ```
 cd /var/www/vainsocial
 cp .env.dev .env // you can select the .env file of your choice
 composer update
 php artisan migrate
 ```

> the following will only work on a Unix based container. If you are using Windows, you will need to have NPM installed locally on your windows machine.
 
 ```
 npm update
 npm run dev
 ```

 > Setup your hosts file by adding the following entry
 ```
 127.0.0.1 vainsocial.dev
 ```

 open browser and run the following to view the home page
 ```
 vainsocial.dev/home
 ```

 
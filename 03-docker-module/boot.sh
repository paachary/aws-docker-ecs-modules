#!/bin/sh

cd /home/microblog/flask-app

export POSTGRES_USER=employee_usr 
export POSTGRES_PASSWORD=emp@13%loyee^ 
export POSTGRES_DB=employee_db 
export POSTGRES_URL=postgres:5432 
export POSTGRES_PW=emp@13%loyee^ 

. myenv/bin/activate

flask db stamp head
flask db migrate -m "installing the db code"
flask db upgrade
exec gunicorn -b :8000 --access-logfile - --error-logfile - microblog:app --daemon 

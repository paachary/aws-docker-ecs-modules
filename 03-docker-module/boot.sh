#!/bin/sh

cd /home/microblog/flask-app

export AWS_ACCESS_KEY_ID=<REPLACE-ME>
export AWS_SECRET_ACCESS_KEY=<REPLACE-ME>
export AWS_DEFAULT_REGION=<REPLACE-ME>

aws configure set region `curl --silent http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region`

. myenv/bin/activate

export POSTGRES_USER=$(aws ssm get-parameters --region ${AWS_DEFAULT_REGION} --names PostgresUser --query Parameters[0].Value | tr -d '"')
export POSTGRES_PW=$(aws secretsmanager get-secret-value --secret-id PostgresRdsDbSecretPwd | jq --raw-output '.SecretString' | jq -r .password)
export POSTGRES_DB=$(aws ssm get-parameters --region ${AWS_DEFAULT_REGION} --names PostgresDb --query Parameters[0].Value | tr -d '"')                    
export FLASK_APP=$(aws ssm get-parameters --region ${AWS_DEFAULT_REGION} --names FlaskApp --query Parameters[0].Value | tr -d '"')
export POSTGRES_URL=$(aws ssm get-parameters --region ${AWS_DEFAULT_REGION} --names DbHostUrl --query Parameters[0].Value | tr -d '"')
export POSTGRES_HOST=`echo $POSTGRES_URL | cut -f1 -d":"`

flask db stamp head
flask db migrate -m "installing the db code"
flask db upgrade
exec gunicorn -b :8000 --access-logfile - --error-logfile - microblog:app

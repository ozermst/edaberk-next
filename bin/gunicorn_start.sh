#!/bin/bash

NAME="edaberk"  #Django application name
DIR=/home/ozermst/edaberk   #Directory where project is located
USER=ozermst   #User to run this script as
GROUP=ozermst  #Group to run this script as
WORKERS=3     #Number of workers that Gunicorn should spawn
SOCKFILE=/home/ozermst/edaberk/run/gunicorn.sock   #This socket file will communicate with Nginx 
# SOCKFILE=/home/ozermst/edaberk/gunicorn.sock 
LOGFILE=/home/ozermst/edaberk/logs/nginx-error.log
DJANGO_SETTINGS_MODULE=edaberk.settings.production   #Which Django setting file should use
DJANGO_WSGI_MODULE=edaberk.wsgi           #Which WSGI file should use
LOG_LEVEL=debug     # ???

echo "Starting $NAME as `whoami`"

# Activate the virtual environment
cd $DIR
source env/bin/activate 
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DIR:$PYTHONPATH

# Create the run directory if it doesn't exist
RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR

# Create the log directory if it doesn't exist
LOGDIR=$(dirname $LOGFILE)
test -d $LOGDIR || mkdir -p $LOGDIR


# Command to run the progam under supervisor
exec env/bin/gunicorn ${DJANGO_WSGI_MODULE} \
--name $NAME \
--workers $WORKERS \
--user=$USER \
--group=$GROUP \
--bind=unix:$SOCKFILE \
--log-level=$LOG_LEVEL \
--log-file=-

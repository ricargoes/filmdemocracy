#!/bin/bash

PROJECT_DIR=$(pwd)

rm $PROJECT_DIR/local/db.sqlite3
rm -rf $PROJECT_DIR/local/media
rm -rf $PROJECT_DIR/local/sent_emails
rm -rf $PROJECT_DIR/filmdemocracy/static
rm -rf $PROJECT_DIR/filmdemocracy/registration/migrations
rm -rf $PROJECT_DIR/filmdemocracy/democracy/migrations
python manage.py makemigrations registration
python manage.py makemigrations democracy
python manage.py sqlmigrate registration 0001
python manage.py sqlmigrate democracy 0001
python manage.py migrate

#echo "Collecting static files..."
#python manage.py collectstatic

echo "Creating mock database..."
python manage.py shell < create_mock_db.py

echo "Database restarted."
echo "Starting server..."
python manage.py runserver

exit 0

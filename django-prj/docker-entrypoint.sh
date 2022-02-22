#!/bin/bash

# wait for database before migrate and start Django.
#
# Author: Fernando Maia


while_not_available()
{
    # When executing a command on a /dev/tcp/$host/$port pseudo-device file, 
    # Bash opens a TCP connection to the associated socket.
    # 
    { cat < /dev/null > /dev/tcp/$1/$2; } &> /dev/null
    if [ $? != 0 ]; then
        echo "port $2 of $1 is not yet available."
        sleep 5
        while_not_available $1 $2
    fi
}

# wait until db port is available
while_not_available db 5432

set -e

# Migrate
python manage.py migrate

# Create SuperUser if it doesn't exist
django_user_script=$(cat << EOF
from django.contrib.auth import get_user_model;
User = get_user_model(); 
User.objects.filter(email='$DJANGO_SUPERUSER_EMAIL').last() or User.objects.create_superuser('$DJANGO_SUPERUSER_USERNAME', '$DJANGO_SUPERUSER_EMAIL', '$DJANGO_SUPERUSER_PASSWORD');
quit;
EOF
);

echo $django_user_script | python manage.py shell

# Start
python manage.py runserver 0.0.0.0:$DJANGO_PORT

exit 1

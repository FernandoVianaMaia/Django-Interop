FROM intersystemsdc/iris-community

ARG DEBIAN_FRONTEND=noninteractive

USER root   
# Install python requirements/dependencies
RUN apt-get update && \
    apt-get install -y libpq-dev
COPY django-prj/requirements.txt ./
RUN pip install --ignore-installed -r requirements.txt --no-cache-dir --target $ISC_PACKAGE_INSTALLDIR/mgr/python
# Copy Django project codebase to django_prj
COPY django-prj $ISC_PACKAGE_INSTALLDIR/mgr/python/django_prj

RUN ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /opt/irisbuild
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisbuild
USER ${ISC_PACKAGE_MGRUSER}


# Install IRIS packages and deal with expired users
ARG IRIS_DJANGO_NAMESPACE

COPY iris/DjangoInterop.Installer.cls ./
COPY iris/src ./src
COPY iris/iris.script ./

RUN iris start $ISC_PACKAGE_INSTANCENAME \
    && iris session $ISC_PACKAGE_INSTANCENAME < iris.script \
    && iris stop $ISC_PACKAGE_INSTANCENAME quietly

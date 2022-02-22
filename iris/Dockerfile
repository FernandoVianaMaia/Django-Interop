FROM intersystemsdc/iris-community

ARG DEBIAN_FRONTEND=noninteractive

USER root   
# Install python requirements/dependencies
RUN apt-get update && \
    apt-get install -y libpq-dev curl
COPY django-prj/requirements.txt ./
RUN pip install --ignore-installed -r requirements.txt --no-cache-dir --target $ISC_PACKAGE_INSTALLDIR/mgr/python
# Because Django project uses irisnative it must be installed here
RUN curl -OL http://raw.githubusercontent.com/intersystems/quickstarts-python/master/Solutions/nativeAPI_wheel/irisnative-1.0.0-cp34-abi3-linux_x86_64.whl && \
    pip install irisnative-1.0.0-cp34-abi3-linux_x86_64.whl --target $ISC_PACKAGE_INSTALLDIR/mgr/python

# Copy Django project codebase to django_prj
COPY django-prj $ISC_PACKAGE_INSTALLDIR/mgr/python/django_prj

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

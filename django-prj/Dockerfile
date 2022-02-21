FROM python:3.9

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /code

# Install Django project requirements

COPY requirements.txt ./
RUN pip install --ignore-installed -r requirements.txt
RUN pip install ipython

# Install irisnative - InterSystems IRIS Native API for Python

# COPY --from=intersystemsdc/iris-community /usr/irissys/dev/python/intersystems_irispython-3.2.0-py3-none-any.whl ./
# RUN pip install intersystems_irispython-3.2.0-py3-none-any.whl

RUN curl -OL http://raw.githubusercontent.com/intersystems/quickstarts-python/master/Solutions/nativeAPI_wheel/irisnative-1.0.0-cp34-abi3-linux_x86_64.whl && \
    pip install irisnative-1.0.0-cp34-abi3-linux_x86_64.whl

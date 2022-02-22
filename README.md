# Django-Interop
This docker-compose project is a playful attempt to develop useful tools to interoperate Django and InterSystems Iris in a bi-directional way.

## Prerequisites
- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Docker desktop](https://www.docker.com/products/docker-desktop).

## Installation 
Clone/git pull the repo into any local directory
```
git clone https://github.com/FernandoVianaMaia/Django-Interop.git && cd Django-Interop
```
Build the images with docker compose: 
```
docker-compose build
```
Run the services (IRIS, Django and Postgres): 
```
docker-compose up
```

## Intended requirements

|Requirement            |  Description                                |
|-----------------------|:-------------------------------------------:|
|ORM Django list users  | Operation to list current users.         |
|Workflow IRIS x Admin  | Send a request from IRIS Interoperability to Django, then Send the response from Django to IRIS when the request is approved|
|Management Command     | *Pending* -Config a service in IRIS to run a Django management command at some schedule. |

## Credentials   
* IRIS - User **_SYSTEM**, Password **SYS**
* Django Admin - User **django_admin**, Password **12345**
* Default credential values are available in the `.env` file.

## How to Test it


1. Go to Interoperability portal http://localhost:54773/csp/djint/EnsPortal.ProductionConfig.zen, select the `request_service_approval` component and submit a test request.
* The response will be deferred, so the testing service will timeout. You can confirm the message is in Deferred status http://localhost:54773/csp/djint/EnsPortal.MessageViewer.zen?SOURCEORTARGET=request_service_approval
2. Open Django Admin http://localhost:8000/admin/service/serviceauthorization/, select the checkbox corresponding to your approval request, then select the action `Approve request - send the response to IRIS` and click go. 
3. Go back to IRIS interoperability and check the response in the Visual Trace page http://localhost:54773/csp/djint/EnsPortal.MessageViewer.zen?SOURCEORTARGET=request_service_approval


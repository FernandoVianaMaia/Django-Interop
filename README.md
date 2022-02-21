# Django-Interop-embeddedPython
This docker-compose project is a playful attempt to develop useful tools to interoperate Django and InterSystems Iris in a bi-directional way.

## Prerequisites
- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Docker desktop](https://www.docker.com/products/docker-desktop).

## Installation 
Clone/git pull the repo into any local directory
```
git clone https://github.com/<>/<project>.git
```
Run both IRIS container and django container a once with docker compose: 
```
docker-compose up -d --build
```
## Intended requirements

======================  ============================================= 
Reuirement              Description  
======================  =============================================
ORM Django list users   operation to list current users. OK
Workflow IRIS x Admin   Pending
Management Command      Config a service in IRIS to run a Django management command at some schedule. Pending
======================  =============================================

## How to Test it
==================  ============================================= 
IRIS Credentials    localhost:  
==================  =============================================
User                _SYSTEM
Password            SYS    
==================  =============================================
 * Default credential values are available in the `.env` file.


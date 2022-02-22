from operator import index
from django.db import models
from django.contrib.auth.models import User


class Service(models.Model):
    description = models.CharField(max_length=200)
    creation_date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.description


class ServiceAuthorization(models.Model):
    service = models.ForeignKey(Service, on_delete=models.CASCADE)
    iris_token = models.CharField(max_length=64,db_index=True,null=True)
    approved_by = models.ForeignKey(User, on_delete=models.SET_NULL, blank=True, null=True)
    creation_date = models.DateTimeField(auto_now_add=True)
    approval_date = models.DateTimeField(null=True)

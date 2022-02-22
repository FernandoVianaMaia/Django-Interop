import datetime
from django.contrib import admin
from .models import Service, ServiceAuthorization

from iris_helper import trigger_response


class ServiceAuthorizationAdmin(admin.ModelAdmin):

    list_display = fields = ['service', 'iris_token', 'approved_by',
                             'creation_date', 'approval_date']
    readonly_fields = ['creation_date']

    def has_add_permission(self, request, obj=None):
        # Requests for service authorization should come from IRIS Interoperability ONLY
        return False

    @admin.action(description='Approve request - send the response to IRIS')
    def approve_request(self, request, queryset):

        queryset.update(approved_by=request.user,
                        approval_date=datetime.datetime.now())
        # Trigger response to IRIS
        for token in queryset.values_list('iris_token', flat=True):
            trigger_response(token, request.user.email)

    actions = ['approve_request']


class ServiceAdmin(admin.ModelAdmin):
    list_display = fields = ['creation_date', 'description']
    readonly_fields = ['creation_date']


admin.site.register(Service, ServiceAdmin)
admin.site.register(ServiceAuthorization, ServiceAuthorizationAdmin)

Class djangointerop.bo.RequestServiceAccessOperation Extends djangointerop.bo.CommonOperation
{

Property Service As %SYS.Python;

Property ServiceAuthorization As %SYS.Python;

Method OnMessage(request As djangointerop.bo.RequestServiceAccessRequest, Output response As djangointerop.bo.RequestServiceAccessResponse) As %Status
{
    #dim sc As %Status = $$$OK
    try {
        // Django admin will send an answer when it's approved
		Set sc = ..DeferResponse(.token)
		if $System.Status.IsError(sc) quit
        // Request service for approval
        do ..RequestApproval(token,request.service)
    } catch ex {
        set sc  = ex.AsStatus()
    }
    return sc
}

Method RequestApproval(token, serviceDescription) [ Language = python ]
{
    self.ServiceAuthorization.objects.create(
        service=self.Service.objects.get(description=serviceDescription),
        iris_token=token
    )
}

Method OnInit() As %Status
{
    #dim sc As %Status = $$$OK
    try {
        set sc = ##super()
        if $System.Status.IsError(sc) quit
        do ..ImportExtraModels()
    } catch ex {
        set sc = ex.AsStatus()
    }
    quit sc
}

/// Import Service and ServiceAuthorization Model classes at startup
Method ImportExtraModels() [ Language = python ]
{
    from service.models import Service, ServiceAuthorization
    self.Service = Service
    self.ServiceAuthorization = ServiceAuthorization
}

}

Class djangointerop.bo.CommonOperation Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Property model As %SYS.Python;

Property serialize As %SYS.Python;

Method OnMessage(request As Ens.StringContainer, Output response As Ens.StringContainer) As %Status
{
    #dim sc As %Status = $$$OK
    try {
        set response = ##class(Ens.StringContainer).%New(..GetUsers())
    } catch ex {
        set sc  = ex.AsStatus()
    }
    
    return sc
}

Method OnInit() As %Status
{
    #dim sc As %Status = $$$OK
    try {
        $$$LOGWARNING("so far ok")
        do ..PyInit()
    } catch ex {
        set sc = ex.AsStatus()
    }
    quit sc
}

Method GetUsers() [ Language = python ]
{
    result = [ user.email for user in self.model.objects.all() ]
    return self.serialize(result, indent=4)
}

/// Setup Django
Method PyInit() [ Language = python ]
{
    import django
    django.setup(set_prefix=False)

    from json import dumps
    self.serialize = dumps
    
    from django.contrib.auth import get_user_model
    self.model =  get_user_model()
}

}

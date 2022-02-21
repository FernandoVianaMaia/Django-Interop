Class djangointerop.bo.GetUsersOperation Extends djangointerop.bo.CommonOperation
{

Property User As %SYS.Python;

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

Method GetUsers() [ Language = python ]
{
    result = [ user.email for user in self.User.objects.all() ]
    return self.serialize(result, indent=4)
}

Method OnInit() As %Status
{
    #dim sc As %Status = $$$OK
    try {
        set sc = ##super() ; call PyInit() to initialize django context
        if $System.Status.IsError(sc) quit
        do ..ImportUserModel()
    } catch ex {
        set sc = ex.AsStatus()
    }
    quit sc
}

/// Import User Model class at startup
Method ImportUserModel() [ Language = python ]
{
    from django.contrib.auth import get_user_model
    self.User =  get_user_model()
}

}

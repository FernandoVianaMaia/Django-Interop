Class djangointerop.bo.CommonOperation Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Property serialize As %SYS.Python;

Method OnMessage(request As Ens.StringContainer, Output response As Ens.StringContainer) As %Status
{
    #dim sc As %Status = $$$OK
    try {
        set response = ##class(Ens.StringContainer).%New("NOT IMPLEMENTED")
    } catch ex {
        set sc  = ex.AsStatus()
    }
    return sc
}

Method OnInit() As %Status
{
    #dim sc As %Status = $$$OK
    try {
        do ..PyInit()
    } catch ex {
        set sc = ex.AsStatus()
    }
    quit sc
}

/// Setup Django
Method PyInit() [ Language = python ]
{
    import django
    django.setup(set_prefix=False)

    from json import dumps
    self.serialize = dumps
}

}

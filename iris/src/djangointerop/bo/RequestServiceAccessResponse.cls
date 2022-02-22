Class djangointerop.bo.RequestServiceAccessResponse Extends Ens.StringContainer
{

Property ApprovedBy As %String;

ClassMethod ProduceDeferredResponse(token, user)
{
    set response = ..%New()
    set response.ApprovedBy = user
    Do ##class(Ens.Host).SendDeferredResponse(token,response)
}

Storage Default
{
<Data name="RequestServiceAccessResponseDefaultData">
<Subscript>"RequestServiceAccessResponse"</Subscript>
<Value name="1">
<Value>ApprovedBy</Value>
</Value>
</Data>
<DefaultData>RequestServiceAccessResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}

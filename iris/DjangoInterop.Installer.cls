/// Installer class
Class DjangoInterop.Installer
{

Parameter IRISDJANGONAMESPACE = {$SYSTEM.Util.GetEnviron("IRIS_DJANGO_NAMESPACE")};

Parameter IRISDJANGODATABASE = {$ZCvt($SYSTEM.Util.GetEnviron("IRIS_DJANGO_NAMESPACE"),"L")};

/// AVAILABLE VARIABLES: https://docs.intersystems.com/iris20201/csp/docbook/DocBook.UI.Page.cls?KEY=GCI_manifest#GCI_manifest_vars
/// 
XData setup
{
<Manifest>
  <Default Name="Namespace" Value='${#IRISDJANGONAMESPACE}'/>
  <Default Name="database" Value="${#IRISDJANGODATABASE}"/>
  <Default Name="CSPApplication" Value="django-interop"/>
  
  <Namespace Name="${Namespace}" Code="${Namespace}" Data="${Namespace}" Create="yes" Ensemble="1">
    <Configuration>
      <Database Name="${Namespace}" Dir="${MGRDIR}${database}/data" Create="yes" Resource="%DB_${Namespace}"/>
      <CSPApplication 
        Directory="${CSPDIR}${CSPApplication}/"
        Url="/${CSPApplication}"
        AuthenticationMethods="64"
        Recurse="1"
        UseSessionCookie="2"
        CookiePath="/${CSPApplication}"
        IsNamespaceDefault="0"
       />

    </Configuration>
  </Namespace>
  
  <Log Level="3" Text="${#IRISDJANGONAMESPACE} Installer Manifest has completed."/>
</Manifest>
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  #; Let XGL document generate code for this method. 
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "setup")
}

}

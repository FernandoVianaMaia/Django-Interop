Class djangointerop.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="djangointerop.Production" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="get_user_email" Category="django" ClassName="djangointerop.bo.GetUsersOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}

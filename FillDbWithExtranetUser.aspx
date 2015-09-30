<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Page Language="C#" Debug="true" %>
<!--
Create Sitecore Dummy Users
Place this script below the /sitecore/admin folder 
And run with url:  /sitecore/admin/FillDbWithExtranetUser.aspx
-->
<HTML>
   <script runat="server" language="C#">
   	string log = string.Empty;
	public void Page_Load(object sender, EventArgs e)
	{
		var start = 0;
		var end = 150000;
		var action = Request["action"];
		Sitecore.Diagnostics.Log.Info("Mirabeau FillDbWithExtranetUser call action: "+action, this);
		if (action == "start" || action == "delete")
		{
			for (var count=start; count <end; count++)
			{
				var userName = string.Format("extranet\\user{0}", count);
				try {
					if (action == "start") {
						Membership.CreateUser(userName, "b", "stockpick@example.com");
					} else {
						Membership.DeleteUser(userName);
					}
				} catch (MembershipCreateUserException ex) 
				{
					log += string.Format("user: {0} : {1}<br>\n",userName,ex.Message);
				}
			}
			if (string.IsNullOrEmpty(log)) { log = "no errors"; }
		}
	}
   </script>
   <body>
   <h1>Create Sitecore Dummy Users</h1>
   <p>Creating or deleting 150K Sitecore extranet user take some time, Choose:</p>
   	<p><a href="?action=start">Start create Extranet users</a></p>
   	<p><a href="?action=delete">Delete the FillDbWithExtranetUser created users</a></p>
	<p>
      		Error log:<br><%=log %>
      	</p>
   </body>
</HTML>
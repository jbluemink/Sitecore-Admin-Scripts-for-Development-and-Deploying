<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="Sitecore.Security.Accounts" %>
<%@ Page Language="C#" Debug="true" %>
<HTML>
   <script runat="server" language="C#">
   	string log = string.Empty;
   	string userName = "sitecore\\admin";
	public void Page_Load(object sender, EventArgs e)
	{
		
		var action = Request["action"];
		Sitecore.Diagnostics.Log.Info("Mirabeau reset Admin call action: "+action, this);
		if (action == "start" )
		{
			try {
				var user = Membership.GetUser(userName);
				user.UnlockUser();
				user.ChangePassword(user.ResetPassword(), "b");

			} catch (MembershipCreateUserException ex) 
			{
				log += string.Format("user: {0} : {1}<br>\n",userName,ex.Message);
			}

			if (string.IsNullOrEmpty(log)) { log = "no errors"; }
		}
	}
   </script>
   <body>
   <h1><a href="https://github.com/jbluemink/Sitecore-Admin-Scripts-for-Development-and-Deploying">Sitecore admin tools</a></h1>
   <p>Reset password and unlock a Sitecore user, Choose:</p>
   	<p><a href="?action=start">Reset login <%=userName %></a></p>
   	
	<p>
      		Error log:<br><%=log %>
      	</p>
   </body>
</HTML>
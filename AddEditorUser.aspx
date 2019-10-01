<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="Sitecore.Security.Accounts" %>
<%@ Page Language="C#" Debug="true" %>
<!--
Create Sitecore User
Place this script in the webroot
And run with url:  /AddEditorUser.aspx
-->
<HTML>
   <script runat="server" language="C#">
   	string log = string.Empty;
   	string userName = "sitecore\\editor";
   	string email = "jan@mirabeau.nl";
	public void Page_Load(object sender, EventArgs e)
	{
		
		var action = Request["action"];
		Sitecore.Diagnostics.Log.Info("Mirabeau add Editor user call action: "+action, this);
		if (action == "start" )
		{
			try {
				Membership.CreateUser(userName, "b", email);
				Sitecore.Security.Accounts.User user = Sitecore.Security.Accounts.User.FromName(userName, true);
				var Role1 = Sitecore.Security.Accounts.Role.FromName("sitecore\\Author");
            			user.Roles.Add(Role1);

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
   <p>Creating a Sitecore editor user, Choose:</p>
   	<p><a href="?action=start">Start create an users, with login <%=userName %></a></p>
   	
	<p>
      		Error log:<br><%=log %>
      	</p>
   </body>
</HTML>
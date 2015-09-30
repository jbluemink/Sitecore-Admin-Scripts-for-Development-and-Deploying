<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Text.RegularExpressions" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="log4net" %>
<%@ Import Namespace="Sitecore.Data.Engines" %>
<%@ Import Namespace="Sitecore.Data.Proxies" %>
<%@ Import Namespace="Sitecore.SecurityModel" %>
<%@ Import Namespace="Sitecore.Update.Installer" %>
<%@ Import Namespace="Sitecore.Update.Installer.Utils" %>
<%@ Import Namespace="Sitecore.Update" %>
<%@ Import Namespace="Sitecore.Update.Metadata" %>
<%@ Import Namespace="Sitecore.Update.Utils" %>
<%@ Import Namespace="Sitecore.Update.Installer.Exceptions" %>
<%@ Import Namespace="Sitecore.Update.Installer.Installer.Utils" %>


<%@ Language=C# %>
<HTML>
   <script runat="server" language="C#">
    public void Page_Load(object sender, EventArgs e)
    {
      var files = Directory.GetFiles(Server.MapPath("/sitecore/admin/Packages"), "*.update", SearchOption.AllDirectories);
      Sitecore.Context.SetActiveSite("shell");
      using (new SecurityDisabler())
      {
        using (new ProxyDisabler())
        {
          using (new SyncOperationContext())
          {
            foreach (var file in files)
            {
              Install(file);
              Response.Write("Installed Package: " + file + "<br>");
            }
          }
        }
      }
    }

    public static string Install(string path)
    {
	bool hasPostAction;
	string historyPath;
	string result= "";

	var log = LogManager.GetLogger("LogFileAppender");
	using (new ShutdownGuard())
	{
		DiffInstaller installer = new DiffInstaller(UpgradeAction.Upgrade);
		MetadataView view = UpdateHelper.LoadMetadata(path);

		//Get the package entries
		List<ContingencyEntry> entries = installer.InstallPackage(path, InstallMode.Install, log, out hasPostAction, out historyPath);

		installer.ExecutePostInstallationInstructions(path, historyPath, InstallMode.Install, view, log, ref entries);

		UpdateHelper.SaveInstallationMessages(entries, historyPath);
	}
	return result;
    }
        
    protected String GetTime()
    {
        return DateTime.Now.ToString("t");
    }
   </script>
   <body>
      <form id="MyForm" runat="server">
	<div>This page installs all .update packages from \sitecore\admin\Packages folder.</div>
	Current server time is <% =GetTime()%><br.>
      </form>
   </body>
</HTML>
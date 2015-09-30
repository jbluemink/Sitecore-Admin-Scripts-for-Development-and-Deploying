<%@ Assembly Name="Sitecore.Client" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Text.RegularExpressions" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="log4net" %>
<%@ Import Namespace="Sitecore.Data.Engines" %>
<%@ Import Namespace="Sitecore.Data.Proxies" %>
<%@ Import Namespace="Sitecore.Install.Files" %>
<%@ Import Namespace="Sitecore.Install.Utils" %>
<%@ Import Namespace="Sitecore.SecurityModel" %>
<%@ Import Namespace="Sitecore.Web" %>
<%@ Import namespace="Sitecore.Install.Framework" %>
<%@ Import namespace="Sitecore.Install.Items" %>
<%@ Import namespace="Sitecore.Install" %>
<%@ Import namespace="Sitecore.Diagnostics" %>

<%@  Language="C#" %>
<html>
<script runat="server" language="C#">
	public string status = string.Empty;

	public void Page_Load(object sender, EventArgs e)
	{
		var files = WebUtil.GetQueryString("modules").Split('|');
		var mode = WebUtil.GetQueryString("mode");
		if (files.Length == 0)
		{
			status = "No Modules specified";
			return;
		} else 
		{
			if (files[0] == "") {
				status = "No Modules specified";
				return;
			}
		}

		foreach (var file in files)
		{
			status = "Installed Package Ok: " + file + "<br>";
			try {
				InstallPackage(Path.Combine(Sitecore.Shell.Applications.Install.ApplicationContext.PackagePath, file),mode);
			} catch (Exception ex) {
				status = "Installed Package Fail: " + file + "<br>Exception : "+ex;
			}
		}

	}

    
        public void InstallPackage(string path, string mode)  
        {  

            FileInfo pkgFile = new FileInfo(path);  
          
            if (!pkgFile.Exists)  
                throw new Exception(string.Format("Cannot access path '{0}'. Please check path setting.", path));  
          
            Sitecore.Context.SetActiveSite("shell");  
            using (new SecurityDisabler())  
            {  
                using (new ProxyDisabler())  
                {  
                    using (new SyncOperationContext())  
                    {  
                    
                    	var installMode = Sitecore.Install.Utils.InstallMode.Overwrite;
                    	var mergemode = Sitecore.Install.Utils.MergeMode.Undefined;
                    	if (mode == "merge") {
                    		installMode = Sitecore.Install.Utils.InstallMode.Merge;
                    		mergemode = Sitecore.Install.Utils.MergeMode.Clear;
                    		status += "<br>mode = Merge Clear";
                    	} else {
                    		status += "<br>mode = Overwrite";
                    	}
                        Sitecore.Install.Framework.IProcessingContext context = new Sitecore.Install.Framework.SimpleProcessingContext();
                        Sitecore.Install.Items.IItemInstallerEvents itemEvents = new Sitecore.Install.Items.DefaultItemInstallerEvents(new Sitecore.Install.Utils.BehaviourOptions(installMode, mergemode));
                        context.AddAspect(itemEvents);
                        
                        // warning: no exception with a file right issue e.t.c.. (so you don't know of it is a success)
                        Sitecore.Install.Files.IFileInstallerEvents fileevents = new Sitecore.Install.Files.DefaultFileInstallerEvents(true);  
                        context.AddAspect(fileevents);  
                        var inst = new Sitecore.Install.Installer();  
                        inst.InstallPackage(Sitecore.MainUtil.MapPath(path), context);  
                    }  
                }  
            }
        }

    protected String GetTime()
    {
        return DateTime.Now.ToString("t");
    }
</script>
<body>
    <div>This page can installs packages from \data\Packages folder.</div>
    <div>
    	<p>use querystring parameters</p>
    	<p>
    	modules: for a seperated module list<br>
    	mode: overwrite (default) or merge (Merge - Clear)
    	</p>
    	<p>Example: /sitecore/admin/InstallZipPackage.aspx?modules=test.zip&mode=overwrite
    </div>
    <div>Current server time is <% =GetTime()%></div>
    <div id="log">log: <%= status %></div>
</body>
</html>

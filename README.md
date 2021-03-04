# Sitecore-Admin-Scripts-for-Development-and-Deploying

Various Scripts for the "sitecore\admin" folder.

## AddAdminUser.aspx
Script for programmatically adding a Sitecore admin users, place this script in the webroot instead of the admin folder

## AddEditorUser.aspx
Script for programmatically adding a Sitecore editor users

## ResetAdminPassword.aspx
Script for programmatically unlock and reset the Sitecore admin password, place this script in the webroot instead of the admin folder.
and run /ResetAdminPassword.aspx the user with the name admin will reste to password b or whatever password you entered in the file. Useful if you forgot admin password after installation. (remove this file form webroot after use)

## FillDbWithExtranetUser.aspx
Script for programmatically adding users to Sitecore, extranet users in bulk. See  [Bulk create Sitecore users](http://www.stockpick.nl/english/bulk-create-sitecore-users/)

## InstallUpdatePackage.aspx
For Sitecore 6 and 7, not for Sitecore 8+
Script for installing .update packages from TDS or Sitecore .update packages. It is based on the [Sitecore-Deployment-Helpers](https://github.com/adoprog/Sitecore-Deployment-Helpers) but now with support for post steps in the package.

## InstallZipPackage.aspx
For Sitecore 6, 7 and 8.
Script for installing normal .zip packages from Sitecore package designer or from modules. It is based on the [Sitecore-Deployment-Helpers](https://github.com/adoprog/Sitecore-Deployment-Helpers) but now with querystring parameter to give the install mode. And extra logging.

## ParameterDrivenPublish.aspx and IsPublishTaskRunning.aspx 
See [Sitecore Parameter driven publish deployment tool](https://github.com/jbluemink/Sitecore-Parameter-Driven-Publish)

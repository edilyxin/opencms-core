<%@ page import="org.opencms.workplace.commons.*"%><%	

	// initialize the workplace class
	CmsPreferences wp = new CmsPreferences(pageContext, request, response);
	
//////////////////// start of switch statement 
	
switch (wp.getAction()) {

case CmsPreferences.ACTION_CANCEL:		
//////////////////// ACTION: cancel button pressed, leave dialog

	if (!"true".equals(wp.getParamSetPressed())) {
		wp.actionCloseDialog();
		break;
	}	

case CmsPreferences.ACTION_RELOAD:		
//////////////////// ACTION: reload the workplace window after pressing "ok"
%>
<html>
<head></head>
<body onload="window.top.location.reload(true);"></body>
</html>
<%
	
break;
case CmsPreferences.ACTION_OK:
case CmsPreferences.ACTION_SET:		
//////////////////// ACTION: save the preferences

	wp.actionSave();
	
break;
case CmsPreferences.ACTION_CHPWD:
//////////////////// ACTION: change the user password

	wp.actionChangePassword();
	if (wp.getAction() == CmsPreferences.ACTION_ERROR) {
		break;
	}

case CmsPreferences.ACTION_DEFAULT:
case CmsPreferences.ACTION_SWITCHTAB:
default:

//////////////////// ACTION: show tab dialog (default)

	wp.setParamAction(wp.DIALOG_OK);

%><%= wp.htmlStart() %>
<%= wp.bodyStart("dialog", "onunload=\"top.closeTreeWin();\"") %>
<%= wp.dialogStart() %>

<form name="main" action="<%= wp.getDialogUri() %>" method="post" class="nomargin" onsubmit="return submitAction('<%= wp.DIALOG_OK %>', null, 'main');">
<%= wp.paramsAsHidden() %><input type="hidden" name="<%= wp.PARAM_FRAMENAME %>" value="">
<%= wp.dialogTabContentStart(wp.getParamTitle(), "style=\"height: 260px;\" id=\"tabcontent\"") %>

<%
switch (wp.getActiveTab()) {
case 1:
	// ########## workplace settings
	%>
		<%= wp.dialogBlockStart(wp.key("preferences.subhead.startup")) %>
		<table border="0" cellpadding="4" cellspacing="0">
		<tr>
			<td style="white-space: nowrap;"><%= wp.key("input.lang") %></td><td><%= wp.buildSelectLanguage("name=\"" + wp.PARAM_WORKPLACE_LANGUAGE + "\" style=\"width: 200px;\"") %></td>
			<td>&nbsp;</td>
			<td style="white-space: nowrap;"><%= wp.key("input.startupsite") %></td><td><%= wp.buildSelectSite("name=\"" + wp.PARAM_WORKPLACE_SITE + "\" style=\"width: 200px;\"") %></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td style="white-space: nowrap;"><%= wp.key("input.startupproject") %></td><td><%= wp.buildSelectProject("name=\"" + wp.PARAM_WORKPLACE_PROJECT + "\" style=\"width: 200px;\"") %></td>
			<td>&nbsp;</td>
			<td style="white-space: nowrap;"><%= wp.key("input.startupfolder") %></td><td><input type="text" name="<%= wp.PARAM_WORKPLACE_FOLDER %>" id="<%= wp.PARAM_WORKPLACE_FOLDER %>" value="<%= wp.getParamTabWpFolder() %>" style="width: 200px;"></td>
			<td><input name="selectfolder" type="button" value="<%= wp.key("button.search") %>" onClick="top.openTreeWin('preferences', false, 'main', '<%= wp.PARAM_WORKPLACE_FOLDER %>', document);" class="dialogbutton" style="width: 60px;">
		</tr>
		<tr>
			<td style="white-space: nowrap;"><%= wp.key("input.startupview") %></td><td><%= wp.buildSelectView("name=\"" + wp.PARAM_WORKPLACE_VIEW + "\" style=\"width: 200px;\"") %></td>
			<td>&nbsp;</td>
			<td colspan="3"><input type="checkbox" name="<%= wp.PARAM_WORKPLACE_RESTRICTEXPLORERVIEW %>" value="true"<%= wp.isChecked(wp.getParamTabWpRestrictExplorerView()) %>> <%= wp.key("input.restrictexplorerview") %></td>
		</tr>		
		</table>
		<%= wp.dialogBlockEnd() %>
		<%= wp.dialogSpacer() %>
		<%= wp.dialogBlockStart(wp.key("preferences.subhead.general")) %>
		<table border="0" cellpadding="4" cellspacing="0">
			<tr>
				<td style="white-space: nowrap;"><%= wp.key("input.workplace.buttonstyle") %></td><td><%= wp.buildSelectWorkplaceButtonStyle("name=\"" + wp.PARAM_WORKPLACE_BUTTONSTYLE + "\" style=\"width: 200px;\"") %></td>
			</tr>
			<tr>
				<td style="white-space: nowrap;"><%= wp.key("input.reporttype") %></td><td><%= wp.buildSelectReportType("name=\"" + wp.PARAM_WORKPLACE_REPORTTYPE + "\" style=\"width: 200px;\"") %></td>
			</tr>
			<tr>
				<td colspan="2" style="white-space: nowrap;"><input type="checkbox" name="<%= wp.PARAM_WORKPLACE_USEUPLOADAPPLET %>" value="true"<%= wp.isChecked(wp.getParamTabWpUseUploadApplet()) %>> <%= wp.key("input.uploadapplet") %></td>
			</tr>
		</table>		
		<%= wp.dialogBlockEnd() %>
	<%
break;
case 2:
	// ########## explorer display settings
	%>	
		<script type="text/javascript">
		<!--
			function setToDefault() {
				var theForm = document.forms[0];
				theForm.<%= wp.PARAM_EXPLORER_FILEENTRIES %>.selectedIndex = 2;
				theForm.<%= wp.PARAM_EXPLORER_BUTTONSTYLE %>.selectedIndex = 1;
				theForm.<%= wp.PARAM_EXPLORER_FILETITLE %>.checked = true;
				theForm.<%= wp.PARAM_EXPLORER_FILETYPE %>.checked = true;
				theForm.<%= wp.PARAM_EXPLORER_FILEDATELASTMODIFIED %>.checked = true;				
				theForm.<%= wp.PARAM_EXPLORER_FILEUSERLASTMODIFIED %>.checked = false;
				theForm.<%= wp.PARAM_EXPLORER_FILESIZE %>.checked = false;
				theForm.<%= wp.PARAM_EXPLORER_FILEDATECREATED %>.checked = false;
				theForm.<%= wp.PARAM_EXPLORER_FILEPERMISSIONS %>.checked = false;
				theForm.<%= wp.PARAM_EXPLORER_FILEUSERCREATED %>.checked = false;
				theForm.<%= wp.PARAM_EXPLORER_FILELOCKEDBY %>.checked = false;
				theForm.<%= wp.PARAM_EXPLORER_FILESTATE %>.checked = false;
			}
		//-->
		</script>
		<%= wp.dialogBlockStart(wp.key("preferences.subhead.general")) %>
		<table border="0" cellpadding="4" cellspacing="0">
		<tr>
			<td style="white-space: nowrap;"><%= wp.key("input.explorer.buttonstyle") %></td>
			<td><%= wp.buildSelectExplorerButtonStyle("name=\"" + wp.PARAM_EXPLORER_BUTTONSTYLE + "\" style=\"width: 200px;\"") %></td>
		</tr>
		<tr>
			<td style="white-space: nowrap;"><%= wp.key("input.fileentries") %></td>
			<td><%= wp.buildSelectExplorerFileEntries("name=\"" + wp.PARAM_EXPLORER_FILEENTRIES + "\" style=\"width: 200px;\"") %></td>
		</tr>
		</table>
		<%= wp.dialogBlockEnd() %>
		<%= wp.dialogSpacer() %>
		<%= wp.dialogBlockStart(wp.key("preferences.subhead.display")) %>
		<table border="0" cellpadding="4" cellspacing="0">
		<tr>
			<td><input type="checkbox" name="<%= wp.PARAM_EXPLORER_FILETITLE %>" value="true"<%= wp.isChecked(wp.getParamTabExFileTitle()) %>> <%= wp.key("input.title") %></td>
			<td style="width: 40px;">&nbsp;</td>
			<td><input type="checkbox" name="<%= wp.PARAM_EXPLORER_FILEDATELASTMODIFIED %>" value="true"<%= wp.isChecked(wp.getParamTabExFileDateLastModified()) %>> <%= wp.key("input.datelastmodified") %></td>
			<td style="width: 40px;">&nbsp;</td>
			<td><input type="checkbox" name="<%= wp.PARAM_EXPLORER_FILEDATERELEASED %>" value="true"<%= wp.isChecked(wp.getParamTabExFileDateReleased()) %>> <%= wp.key("input.datereleased") %></td>			
		</tr>
		<tr>
			<td><input type="checkbox" name="<%= wp.PARAM_EXPLORER_FILETYPE %>" value="true"<%= wp.isChecked(wp.getParamTabExFileType()) %>> <%= wp.key("input.type") %></td>
			<td>&nbsp;</td>
			<td><input type="checkbox" name="<%= wp.PARAM_EXPLORER_FILEUSERLASTMODIFIED %>" value="true"<%= wp.isChecked(wp.getParamTabExFileUserLastModified()) %>> <%= wp.key("input.userlastmodified") %></td>
			<td>&nbsp;</td>
			<td><input type="checkbox" name="<%= wp.PARAM_EXPLORER_FILEDATEEXPIRED %>" value="true"<%= wp.isChecked(wp.getParamTabExFileDateExpired()) %>> <%= wp.key("input.dateexpired") %></td>
		</tr>
		<tr>
			<td><input type="checkbox" name="<%= wp.PARAM_EXPLORER_FILESIZE %>" value="true"<%= wp.isChecked(wp.getParamTabExFileSize()) %>> <%= wp.key("input.size") %></td>
			<td>&nbsp;</td>
			<td><input type="checkbox" name="<%= wp.PARAM_EXPLORER_FILEDATECREATED %>" value="true"<%= wp.isChecked(wp.getParamTabExFileDateCreated()) %>> <%= wp.key("input.datecreated") %></td>
			<td>&nbsp;</td>
			<td><input type="checkbox" name="<%= wp.PARAM_EXPLORER_FILESTATE %>" value="true"<%= wp.isChecked(wp.getParamTabExFileState()) %>> <%= wp.key("input.state") %></td>
		</tr>
		<tr>
			<td><input type="checkbox" name="<%= wp.PARAM_EXPLORER_FILEPERMISSIONS %>" value="true"<%= wp.isChecked(wp.getParamTabExFilePermissions()) %>> <%= wp.key("input.permissions") %></td>
			<td>&nbsp;</td>
			<td><input type="checkbox" name="<%= wp.PARAM_EXPLORER_FILEUSERCREATED %>" value="true"<%= wp.isChecked(wp.getParamTabExFileUserCreated()) %>> <%= wp.key("input.usercreated") %></td>
			<td>&nbsp;</td>
			<td><input type="checkbox" name="<%= wp.PARAM_EXPLORER_FILELOCKEDBY %>" value="true"<%= wp.isChecked(wp.getParamTabExFileLockedBy()) %>> <%= wp.key("input.lockedby") %></td>		
		</tr>
		</table>
		<%= wp.dialogBlockEnd() %>
	<%
break;
case 3:
	// ########## dialogs settings
	%>
		<%= wp.dialogBlockStart(wp.key("preferences.subhead.dialogdefaults")) %>
		<table border="0" cellpadding="4" cellspacing="0">
			<tr>
				<td style="white-space: nowrap;"><%= wp.key("input.workplace.defaults.copyfile") %></td><td><%= wp.buildSelectCopyFileMode("name=\"" + wp.PARAM_DIALOGS_COPYFILEMODE + "\" style=\"width: 250px;\"") %></td>
			</tr>
			<tr>
				<td style="white-space: nowrap;"><%= wp.key("input.workplace.defaults.copyfolder") %></td><td><%= wp.buildSelectCopyFolderMode("name=\"" + wp.PARAM_DIALOGS_COPYFOLDERMODE + "\" style=\"width: 250px;\"") %></td>
			</tr>
			<tr>
				<td style="white-space: nowrap;"><%= wp.key("input.workplace.defaults.deletefile") %></td><td><%= wp.buildSelectDeleteFileMode("name=\"" + wp.PARAM_DIALOGS_DELETEFILEMODE + "\" style=\"width: 250px;\"") %></td>
			</tr>
			<tr>
				<td style="white-space: nowrap;"><%= wp.key("input.workplace.defaults.publishsiblings") %></td><td><%= wp.buildSelectPublishSiblings("name=\"" + wp.PARAM_DIALOGS_PUBLISHFILEMODE + "\" style=\"width: 250px;\"") %></td>
			</tr>
			<tr>
				<td colspan="2" style="white-space: nowrap;"><input type="checkbox" name="<%= wp.PARAM_DIALOGS_SHOWLOCK %>" value="true"<%= wp.isChecked(wp.getParamTabDiShowLock()) %>> <%= wp.key("input.showlockdialog") %></td>
			</tr>
		</table>			
		<%= wp.dialogBlockEnd() %>
	<%
break;
case 4:
	// ########## editor settings
	%>
		<%= wp.dialogBlockStart(wp.key("preferences.subhead.general")) %>
		<table border="0" cellpadding="4" cellspacing="0">
		<tr>
			<td style="white-space: nowrap;"><%= wp.key("input.editor.buttonstyle") %></td>
			<td><%= wp.buildSelectEditorButtonStyle("name=\"" + wp.PARAM_EDITOR_BUTTONSTYLE + "\" style=\"width: 200px;\"") %></td>
		</tr>
		<tr>
			<td style="white-space: nowrap;"><%= wp.key("input.directedit.buttonstyle") %></td>
			<td><%= wp.buildSelectDirectEditButtonStyle("name=\"" + wp.PARAM_DIRECTEDIT_BUTTONSTYLE + "\" style=\"width: 200px;\"") %></td>
		</tr>
		</table>
		<%= wp.dialogBlockEnd() %>
		<%= wp.dialogSpacer() %>
		<%= wp.dialogBlockStart(wp.key("preferences.subhead.editors")) %>
		<table border="0" cellpadding="4" cellspacing="0">
		<%= wp.buildSelectPreferredEditors("style=\"width: 200px;\"") %>
		</table>
		<%= wp.dialogBlockEnd() %>
	<%
break;
case 5:
	// ########## workflow settings
	%>
		<%= wp.dialogBlockStart(wp.key("preferences.subhead.general")) %>
		<table border="0" cellpadding="4" cellspacing="0">
		<tr>
			<td style="white-space: nowrap;"><%= wp.key("input.taskfilter") %>:</td>
			<td><%= wp.buildSelectFilter("name=\"" + wp.PARAM_WORKFLOW_FILTER + "\" style=\"width: 250px;\"") %></td>
			<td style="white-space: nowrap;"><input type="checkbox" name="<%= wp.PARAM_WORKFLOW_SHOWALLPROJECTS %>" value="true"<%= wp.isChecked(wp.getParamTabWfShowAllProjects()) %>> <%= wp.key("input.allprojects") %></td>
		</tr>
		</table>
		<%= wp.dialogBlockEnd() %>
		<%= wp.dialogSpacer() %>
		<%= wp.dialogBlockStart(wp.key("input.defaulttasks")) %>
		<table border="0" cellpadding="4" cellspacing="0">
		<tr>
			<td><input type="checkbox" name="<%= wp.PARAM_WORKFLOW_MESSAGEACCEPTED %>" value="true"<%= wp.isChecked(wp.getParamTabWfMessageAccepted()) %>> <%= wp.key("input.messageaccept") %></td>
		</tr>
		<tr>
			<td><input type="checkbox" name="<%= wp.PARAM_WORKFLOW_MESSAGEFORWARDED %>" value="true"<%= wp.isChecked(wp.getParamTabWfMessageForwarded()) %>> <%= wp.key("input.messageforward") %></td>
		</tr>
		<tr>
			<td><input type="checkbox" name="<%= wp.PARAM_WORKFLOW_MESSAGECOMPLETED %>" value="true"<%= wp.isChecked(wp.getParamTabWfMessageCompleted()) %>> <%= wp.key("input.messagecompleted") %></td>
		</tr>
		<tr>
			<td><input type="checkbox" name="<%= wp.PARAM_WORKFLOW_MESSAGEMEMBERS %>" value="true"<%= wp.isChecked(wp.getParamTabWfMessageMembers()) %>> <%= wp.key("input.messagemembers") %></td>
		</tr>
		</table>
		<%= wp.dialogBlockEnd() %>
	<%
break;
case 6:
	// ########## user data settings
	%>
		<script type="text/javascript">
		<!--
			function togglePassword() {
				var element = document.getElementById("changepwd");
    			var cl = element.className;
    			if (cl == "hide") {
        			element.className = "show";
        			document.getElementById("tabcontent").style.height = "320px"; 
    			} else {
        			element.className = "hide";
        			document.getElementById("tabcontent").style.height = "260px";
    			}
			}
			
			function changePassword() {
				var pwdForm = document.forms[0];
				var oldPwd = pwdForm.<%= wp.PARAM_OLDPASSWORD %>.value;
				var newPwd = pwdForm.<%= wp.PARAM_NEWPASSWORD %>.value;
				var conPwd = pwdForm.confirmpassword.value;
				if (oldPwd == null || newPwd == null || conPwd == null || oldPwd == "" || newPwd == "" || conPwd == "") {
					alert("<%= wp.key("error.message.chpwd.form") %>");
					return;
				}
				if (newPwd == conPwd) {
					pwdForm.<%= wp.PARAM_ACTION %>.value = "<%= wp.DIALOG_CHPWD %>";
					pwdForm.submit();
				} else {
					alert("<%= wp.key("error.message.chpwd.nomatch") %>");
				}
			}
		//-->
		</script>
		<%= wp.dialogBlockStart(wp.key("label.preferencesuser")) %>
		<%= wp.buildUserInformation() %>
		<%= wp.dialogBlockEnd() %>
		<%= wp.dialogSpacer() %>
		<input type="button" class="dialogbutton" style="margin-left: 0px;" value="<%= wp.key("button.changepasswd") %>" onclick="togglePassword();">
		<%= wp.dialogSpacer() %>
		<div class="hide" id="changepwd">
			<%= wp.dialogBlockStart("") %>
			<table border="0" cellpadding="4" cellspacing="0">
			<tr>
				<td style="white-space: nowrap;"><%= wp.key("input.oldpwd") %></td>
				<td><input type="password" name="<%= wp.PARAM_OLDPASSWORD %>" maxlength="32" style="width: 200px;"></td>
			</tr>
			<tr>
				<td style="white-space: nowrap;"><%= wp.key("input.newpwd") %></td>
				<td><input type="password" name="<%= wp.PARAM_NEWPASSWORD %>" maxlength="32" style="width: 200px;"></td> 
			</tr>
			<tr>
				<td style="white-space: nowrap;"><%= wp.key("input.newpwdrepeat") %></td>
				<td><input type="password" name="confirmpassword" maxlength="32" style="width: 200px;"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input type="button" class="dialogbutton" style="margin-left: 0px;" value="<%= wp.key("button.ok") %>" onclick="changePassword();"></td>
			</tr>
			</table>
			<%= wp.dialogBlockEnd() %>
		</div>
	<%
} // end of switch tab statement
%>

<%= wp.dialogTabContentEnd() %>
<%= wp.dialogButtonsSetOkCancel(null, null, null) %>
</form>

<%= wp.dialogEnd() %>
<%= wp.bodyEnd() %>
<%= wp.htmlEnd() %>
<%
} 
//////////////////// end of switch action statement 
%>
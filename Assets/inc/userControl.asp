<% 
If Session("GirisDeger") <> "1" Then Response.Redirect("default.asp")
sql="Select * From de_User WHERE Yetki="&Session("Yetki")&" and userID="&Session("userID")&""
Set user = conn.Execute(sql)
if user.eof then response.Redirect("default.asp")
%>
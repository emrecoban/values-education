<%
dim conn
set conn = server.createobject("adodb.connection")
conn.open "Provider=microsoft.jet.oledb.4.0;data source=" & server.mappath("App_Data\Data.mdb")

'OTURUMU KAPAT
if request.QueryString("exit")="ok" Then
Session("GirisDeger") = ""
Session("userID") = ""
Session("Yetki") = ""
Session.Abandon()
response.redirect "default.asp"
End if
'OTURUMU KAPAT
%>
<script language="javascript">
function Exit(){
	if(confirm("Çıkış yapmak istediğinizden emin misiniz ?")){
		location.href="?exit=ok";
	}
}
</script>
       <div id="userbar">
        	<div id="usertxt"><%=user("Ad")%>&nbsp;<%=user("Soyad")%> (<%if user("Yetki")=0 then response.write "Yönetici"
			 if user("Yetki")=1 then response.write "Öğretmen"%>) | <a href="javascript:Exit();" class="extlink">Güvenli Çıkış</a></div>
        	<div id="userico"><img src="Assets/img/ico3.png" width="25" height="28" border="0" /></div>
        </div>
<%
function clearstr(str) 
	str = replace(str," ","-")
	str = replace(str,"Ö","O")
	str = replace(str,"Ç","C")
	str = replace(str,"Þ","S")
	str = replace(str,"Ý","I")
	str = replace(str,"Ü","U")
	str = replace(str,"Ð","G")
	str = replace(str,"ö","o")
	str = replace(str,"ç","c")
	str = replace(str,"þ","s")
	str = replace(str,"ý","i")
	str = replace(str,"ü","u")
	str = replace(str,"ð","g")
	
	clearstr= str
end function

function clean(veri)
			veri = Replace (veri ,"`","")
			veri = Replace (veri ,"=","")
			veri = Replace (veri ,"&","")
			veri = Replace (veri ,"%","")
			veri = Replace (veri ,"!","")
			veri = Replace (veri ,"#","")
			veri = Replace (veri ,"<","")
			veri = Replace (veri ,">","")
			veri = Replace (veri ,"*","")
			veri = Replace (veri ,"And","")
			veri = Replace (veri ,"'","")
			veri = Replace (veri ,"Chr(34)","")
			veri = Replace (veri ,"Chr(39)","")
			veri = Replace (veri ,"'","")
			veri = Replace (veri ,"#","")
			veri = Replace (veri ,"--","")
			veri = Replace (veri ,"(","")
			veri = Replace (veri ,")","")
			veri = Replace (veri ,"[","")
			veri = Replace (veri ,"]","")
			clean=veri
end function

Function MailKontrol(EPosta) 
    Dim i,j, first, last, char 
    i = InStr(1, EPosta, "@" , vbtextcompare) 
    If i > 0 and i < Len(EPosta) Then 
          first = Left(EPosta, i - 1) 
          last = Mid(EPosta, i+1, Len(EPosta)) 
    Else 
          MailKontrol = false 
          exit Function 
    End If 
    i = 0 
    Do Until i = Len(first) 
          i = i + 1 
          char = Mid(first, i, 1) 
          ' If char is not in [.z-aA-Z0-9] 
          If Asc(char) <> 46 and Asc(char) <> 95  and (Asc(46) < 48 or Asc(char) > 57) and _ 
          (Asc(char) < 65 or Asc(char) > 90) and (Asc(char) < 97 or Asc(char) > 122) Then 
              MailKontrol = false 
              exit Function 
          End If 
    Loop 
    i = 0 
    nokta = false 
    Do Until i = Len(last) 
          i = i + 1 
          char = Mid(last, i, 1) 
          ' If char is not in [.z-aA-Z0-9] 
          If Asc(char) <> 46 and (Asc(46) < 48 or Asc(char) > 57) and _ 
          (Asc(char) < 65 or Asc(char) > 90) and (Asc(char) < 97 or Asc(char) > 122) Then 
              MailKontrol = false 
              exit Function 
          End If 
    Loop 
    nokta = false 
    If InStr(1, last, "." , 1) > 0 Then  
          nokta = true 
    End If 
    MailKontrol = nokta 
End Function 
%>
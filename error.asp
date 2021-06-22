<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>提示</title>
<SCRIPT src="../js/helpScript.js"></SCRIPT>
<style type="text/css">
<!--
.terTable
{
border:1px solid #000000
}
body 
{
	margin-left: 400px;
	margin-top: 200px;
}
.STYLE1 {color: #FFFFFF}
-->
</style>
</head>

<body>
<table width="300" height="130" cellpadding="0" cellspacing="0" class="terTable" >
  <tr>
    <td width="300" height="30" bgcolor="#333333" class="STYLE1">提示 </td>
  </tr>
  <tr>
    <td width="300" height="70" align="center" valign="middle" style="border:1px solid #000000"><%web_error_promt_get();%></td>
  </tr>
  <tr>
    <td width="300" height="30" align="center"  style="border:1px solid #000000"><input name="button" type="button" class="actButton1" onclick=<%web_error_go_url_get();%> value="继续"></td>
  </tr>
</table>
</body>
</html>

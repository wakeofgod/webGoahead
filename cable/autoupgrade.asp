<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ն��Զ�����</title>
<style type="text/css">
<!--
@import url("../css/table.css");
-->
</style>
</head>

<body>
<%web_eoc_auto_upgrade_get();%>
<form name="webEocAutoUpgradeSet" action=/goform/web_eoc_auto_upgrade_set method="post">
<table width="600" height="210" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30" colspan="3" class="tableTitle">�ն��Զ�����</td>
  </tr>
  <tr>
    <td height="20" colspan="3">&nbsp;</td>
  </tr>
  <tr>
    <td width="200" height="20">�ն��Զ��������ܣ�</td>
    <td width="200" height="20"><select name="autoupgrade" id="autoupgrade" class="selectPstat">
      <option value="0">�ر�</option>
      <option value="1">����</option>
    </select></td>
    <td width="200" height="20">&nbsp;</td>
  </tr>
  <tr>
    <td width="200" height="20">FTP������IP��ַ��</td>
    <td width="200" height="20">
      <input type="text" name="ftp_addr" id="ftp_addr" value="<%web_eoc_auto_upgrade_get_detail('2');%>" />
    </td>
    <td width="200" height="20">&nbsp;</td>
  </tr>
  <tr>
    <td width="200" height="20">FTP�������û�����</td>
    <td width="200" height="20">
      <input type="text" name="ftp_name" id="ftp_name" value="<%web_eoc_auto_upgrade_get_detail('3');%>" />
    </td>
    <td width="200" height="20">&nbsp;</td>
  </tr>
  <tr>
    <td width="200" height="20">FTP���������룺</td>
    <td width="200" height="20">
      <input type="text" name="ftp_password" id="ftp_password" value="<%web_eoc_auto_upgrade_get_detail('4');%>" />
    </td>
    <td width="200" height="20">&nbsp;</td>
  </tr>
  <tr>
    <td width="200" height="20">PIB�ļ�����</td>
    <td width="200">
      <input type="text" name="ftp_pib" id="ftp_pib" value="<%web_eoc_auto_upgrade_get_detail('5');%>" />
    </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="200" height="20">firmware�ļ�����</td>
    <td width="200" height="20">
      <input type="text" name="ftp_firmware" id="ftp_firmware" value="<%web_eoc_auto_upgrade_get_detail('6');%>" />
    </td>
    <td width="200" height="20">&nbsp;</td>
  </tr>
  <tr>
    <td height="20" colspan="3">&nbsp;</td>
  </tr>
  <tr>
    <td height="20" colspan="3"><input type="submit" name="BT1" value="ȷ��" />
      <input type="button" name="BT12" value="ˢ��" onclick="location='autoupgrade.asp'"/></td>
  </tr>
</table>
</form>
<script language="javascript">
		document.getElementById("autoupgrade").value = <%web_eoc_auto_upgrade_get_detail('1');%>;
	
</script>
</body>
</html>

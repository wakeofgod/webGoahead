<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>Reboot</title>
  <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css">
  <script src="../js/jquery.min.js"></script>
  <script src="../js/bootstrap.min.js"></script>
</head>

<body>
  <h3
    style="font-weight: bolder; text-align: center;background-color: rgb(241,241,241);height: 48px;line-height: 48px;">
    重启</h3>
  <br>
  <div class="container-fluid">
    <form name="web_sys_reboot" action=/goform/sysReboot method="POST">
      <table width="600" height="70" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td height="20" colspan="2" class="tableTitle">设备重启</td>
        </tr>
        <tr>
          <td height="20" colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td width="100" height="20">
            <button type="submit" class="btn btn-primary">重启
            </button>
          </td>
          <td width="500" height="20">设备重启前，请保存配置信息，重启期间，网络将自动断开。</td>
        </tr>
      </table>
    </form>
  </div>
</body>
</html>
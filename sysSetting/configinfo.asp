<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Info</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
</head>

<body>
    <form name="sysConfigBackup" action=/sysConfigBackup.cfg method="post">
        <table width="600" height="90" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td height="20" colspan="2" class="tableTitle">软件配置备份</td>
            </tr>
            <tr>
                <td height="20" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="100" height="20">
                    <button type="submit" class="btn btn-primary">备份
                    </button>
                </td>
                <td width="500" height="20">保存所有配置信息到你所指定的位置上</td>
            </tr>
            <tr>
                <td height="20" colspan="2">&nbsp;</td>
            </tr>
        </table>
    </form>
    </form>
    <form name="web_sys_restore_def" action=/goform/sysRestore method="post">
        <table width="600" height="90" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td height="20" colspan="2" class="tableTitle">恢复出厂配置</td>
            </tr>
            <tr>
                <td height="20" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="100" height="20">
                    <button type="submit" class="btn btn-primary">恢复出厂配置
                </td>
                <td width="500" height="20" align="center">该设备将恢复到出厂时的默认配置，以前的配置信息将会全部丢失。</td>
            </tr>
            <tr>
                <td height="20" colspan="2">&nbsp;</td>
            </tr>
        </table>

    </form>
    <script>
        function testAjax() {
            var xmlhttp;
            console.log("1111");
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
                console.log("222");
            }
            else {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                console.log("333");
            }
            console.log("444");
            xmlhttp.onreadystatechange = function () {
                console.log("555");
                debugger;
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    console.log("666");             
                }
            }
            console.log("777");
            xmlhttp.open("get", "/ajax/upgradeHandler", true);
            xmlhttp.send();
        }

        function testAjax2(){
            debugger;
            $.post("/goform/sysReboot",function(data){
                debugger;
            });
        }

        $(document).ready(function () {
            testAjax();
        });
    </script>
</body>
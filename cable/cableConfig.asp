<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>SNID/QoS����</title>
<style type="text/css">
<!--
@import url("../css/table.css");
.STYLE2 {font-size: 18px}
.STYLE3 {
	font-size: 14px;
	font-weight: bold;
}
-->
</style>
<script language="javascript">
function cableSelectChange()
{
	document.web_cable_rout_change.submit();	
}
</script>
</head>
<body>

	<%web_mgmt_config_all_get();%>	<%web_eoc_qos_info_get();%>
  <table width="900" height="430" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="900" height="90">
	<form name="web_cable_rout_change" action=/goform/web_cable_rout_change method="post">
	  <table width="900" height="90" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="20" colspan="2" class="tableTitle">Cable��·����</td>
          </tr>
          <tr>
            <td height="20" colspan="2">&nbsp;</td>
          </tr>
		  
          <tr>
            <td width="150" height="20">Cable��·��</td>
            <td><select name="cable_rout" class="selectPstat" id="cable_rout" onchange="cableSelectChange();">
               <%web_rfs_num_get();%> 
              </select></td>
          </tr>
		 
          <tr>
            <td height="20" colspan="2">&nbsp;</td>
          </tr>
        </table>
		</form>
		</td>
    </tr>
	<form name="web_cable_config_snid" action=/goform/web_cable_config_snid method="post">
    <tr>
      <td width="900" height="90"><table width="900" height="90" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="20" colspan="3" class="tableTitle">SNID����</td>
          </tr>
          <tr>
            <td height="20" colspan="3">&nbsp;</td>
          </tr>
          <tr>
            <td width="100" height="20">SNID:</td>
            <td width="150"><select name="cable_SNID" class="selectPstat" id="cable_SNID">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
                <option value="7">7</option>
                <option value="8">8</option>
                <option value="9">9</option>
                <option value="10">10</option>
                <option value="11">11</option>
                <option value="12">12</option>
                <option value="13">13</option>
                <option value="14">14</option>
                <option value="15">15</option>
            </select></td>
            <td><input type="submit" name="BT2" value="ȷ��"/></td>
          </tr>
          <tr>
            <td height="20" colspan="3">&nbsp;</td>
          </tr>
        </table></td>
    </tr>
	</form>
	<%web_eoc_qos_info_get();%>
	<form name="web_cable_config_qos" action=/goform/web_cable_config_qos method="post">
    <tr>
      <td width="900" height="260"><table width="900" height="220" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="20" colspan="9" class="tableTitle">QoS���ȼ�ӳ��</td>
          </tr>
          <tr>
            <td height="20" colspan="9">&nbsp;</td>
          </tr>
		  <tr>
            <td height="20" colspan="9"> QoS���� :
              <select name="qos_flag" class="select" id="qos_flag">
              <option value="0" <%web_eoc_qos_flag_get('0');%>>�ر�</option>
              <option value="1" <%web_eoc_qos_flag_get('1');%>>����</option>
            </select></td>
          </tr>
		  <tr>
            <td height="20" colspan="9">&nbsp;</td>
          </tr>
          <tr>
            <td width="100" height="20">QoS����</td>
            <td width="100" height="20">���ȼ�-0</td>
            <td width="100" height="20">���ȼ�-1</td>
            <td width="100" height="20">���ȼ�-2</td>
            <td width="100" height="20">���ȼ�-3</td>
            <td width="100" height="20">���ȼ�-4</td>
            <td width="100" height="20">���ȼ�-5</td>
            <td width="100" height="20">���ȼ�-6</td>
            <td width="100" height="20">���ȼ�-7</td>
          </tr>
          <tr>
            <td width="100" height="20"><select name="QoS_class" class="selectPstat" id="QoS_class">
                <option value="0" <%web_eoc_qos_type_get('0');%>>VLAN TAG</option>
                <option value="1" <%web_eoc_qos_type_get('1');%>>TOS ����</option>
                <option value="2" <%web_eoc_qos_type_get('2');%>>ȱʡ���ȼ�</option>
              </select></td>
            <td width="100" height="20"><select name="Pri_0" class="selectPstat" id="Pri_0">
                <option value="0" <%web_eoc_qos_pri_get('1');%>>���</option>
                <option value="1" <%web_eoc_qos_pri_get('2');%>>��</option>
                <option value="2" <%web_eoc_qos_pri_get('3');%>>��</option>
                <option value="3" <%web_eoc_qos_pri_get('4');%>>���</option>
              </select></td>
            <td width="100" height="20"><select name="Pri_1" class="selectPstat" id="Pri_1">
                <option value="0" <%web_eoc_qos_pri_get('11');%>>���</option>
                <option value="1" <%web_eoc_qos_pri_get('12');%>>��</option>
                <option value="2" <%web_eoc_qos_pri_get('13');%>>��</option>
                <option value="3" <%web_eoc_qos_pri_get('14');%>>���</option>
              </select></td>
            <td width="100" height="20"><select name="Pri_2" class="selectPstat" id="Pri_2">
                <option value="0" <%web_eoc_qos_pri_get('21');%>>���</option>
                <option value="1" <%web_eoc_qos_pri_get('22');%>>��</option>
                <option value="2" <%web_eoc_qos_pri_get('23');%>>��</option>
                <option value="3" <%web_eoc_qos_pri_get('24');%>>���</option>
              </select></td>
            <td width="100" height="20"><select name="Pri_3" class="selectPstat" id="Pri_3">
                <option value="0" <%web_eoc_qos_pri_get('31');%>>���</option>
                <option value="1" <%web_eoc_qos_pri_get('32');%>>��</option>
                <option value="2" <%web_eoc_qos_pri_get('33');%>>��</option>
                <option value="3" <%web_eoc_qos_pri_get('34');%>>���</option>
              </select></td>
            <td width="100" height="20"><select name="Pri_4" class="selectPstat" id="Pri_4">
                <option value="0" <%web_eoc_qos_pri_get('41');%>>���</option>
                <option value="1" <%web_eoc_qos_pri_get('42');%>>��</option>
                <option value="2" <%web_eoc_qos_pri_get('43');%>>��</option>
                <option value="3" <%web_eoc_qos_pri_get('44');%>>���</option>
              </select></td>
            <td width="100" height="20"><select name="Pri_5" class="selectPstat" id="Pri_5">
                <option value="0" <%web_eoc_qos_pri_get('51');%>>���</option>
                <option value="1" <%web_eoc_qos_pri_get('52');%>>��</option>
                <option value="2" <%web_eoc_qos_pri_get('53');%>>��</option>
                <option value="3" <%web_eoc_qos_pri_get('54');%>>���</option>
              </select></td>
            <td width="100" height="20"><select name="Pri_6" class="selectPstat" id="Pri_6">
                <option value="0" <%web_eoc_qos_pri_get('61');%>>���</option>
                <option value="1" <%web_eoc_qos_pri_get('62');%>>��</option>
                <option value="2" <%web_eoc_qos_pri_get('63');%>>��</option>
                <option value="3" <%web_eoc_qos_pri_get('64');%>>���</option>
              </select></td>
            <td width="100" height="20"><select name="Pri_7" class="selectPstat" id="Pri_7">
                <option value="0" <%web_eoc_qos_pri_get('71');%>>���</option>
                <option value="1" <%web_eoc_qos_pri_get('72');%>>��</option>
                <option value="2" <%web_eoc_qos_pri_get('73');%>>��</option>
                <option value="3" <%web_eoc_qos_pri_get('74');%>>���</option>
              </select></td>
          </tr>
          <tr>
            <td height="20" colspan="9">&nbsp;</td>
          </tr>
          <tr>
            <td height="20" colspan="9"><span class="STYLE2"><span class="STYLE3">ȱʡ���ȼ�</span>:</span></td>
          </tr>
          <tr>
            <td height="20" colspan="9">&nbsp;</td>
          </tr>
          <tr>
            <td width="100" height="20">�鲥Э��</td>
            <td width="100" height="20">����</td>
            <td width="100" height="20">�鲥��</td>
            <td width="100" height="20">�㲥</td>
            <td height="20" colspan="5">&nbsp;</td>
          </tr>
          <tr>
            <td width="100" height="20"><select name="mulCast_Pro" class="selectPstat" id="mulCast_Pro">
                <option value="0" <%web_eoc_qos_multicast_protocal_get('0');%>>���</option>
                <option value="1" <%web_eoc_qos_multicast_protocal_get('1');%>>��</option>
                <option value="2" <%web_eoc_qos_multicast_protocal_get('2');%>>��</option>
                <option value="3" <%web_eoc_qos_multicast_protocal_get('3');%>>���</option>
              </select></td>
            <td width="100" height="20"><select name="uniCast" class="selectPstat" id="uniCast">
                <option value="0" <%web_eoc_qos_unicast_get('0');%>>���</option>
                <option value="1" <%web_eoc_qos_unicast_get('1');%>>��</option>
                <option value="2" <%web_eoc_qos_unicast_get('2');%>>��</option>
                <option value="3" <%web_eoc_qos_unicast_get('3');%>>���</option>
              </select></td>
            <td width="100" height="20"><select name="mulCast_Stream" class="selectPstat" id="mulCast_Stream">
                <option value="0" <%web_eoc_qos_multicast_get('0');%>>���</option>
                <option value="1" <%web_eoc_qos_multicast_get('1');%>>��</option>
                <option value="2" <%web_eoc_qos_multicast_get('2');%>>��</option>
                <option value="3" <%web_eoc_qos_multicast_get('3');%>>���</option>
              </select></td>
            <td width="100" height="20"><select name="broadCast" class="selectPstat" id="broadCast">
                <option value="0" <%web_eoc_qos_broadcast_get('0');%>>���</option>
                <option value="1" <%web_eoc_qos_broadcast_get('1');%>>��</option>
                <option value="2" <%web_eoc_qos_broadcast_get('2');%>>��</option>
                <option value="3" <%web_eoc_qos_broadcast_get('3');%>>���</option>
              </select></td>
            <td height="20" colspan="5">&nbsp;</td>
          </tr>
          <tr>
            <td height="20" colspan="9">&nbsp;</td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td><input type="submit" name="BT1" value="ȷ��"/></td>
    </tr>
	</form>
  </table>

<script language="javascript">
	document.getElementById("cable_SNID").value =<%web_cable_port_snid_get();%>;
	document.getElementById("cable_rout").value =<%web_eoc_qos_snid_get();%>;
</script>
</body>
</html>

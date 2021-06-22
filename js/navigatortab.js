// JavaScript Document
var arrSysSetup = new Array(
'管理IP设置', 'ethernet_state.asp',
'管理VLAN设置', 'management_vlan.asp',
'NTP设置', 'st_ntp.asp',
'SNMP设置', 'snmp.asp'
//'Port Mode', 'WAN_link_speed.asp',
//'MAC Address Clone', 'WAN_mac_clone.asp'
);

var arrMenu = new Array(
'设备状态','../devicestatus/endstatus.asp',
'头端端口管理', '../port/portstat.asp',
'VLAN', '/goform/web_vlan_page_choose',
'头端设备管理', '../headendmanagement/cable_channel.asp',
'终端授权管理', '../terminalauthorizationmanagement/accounts_manage.asp',
'终端设备管理', '../devicemanagement/st_restart.asp',
'系统服务配置', '../systemserver/editip.asp',
'设备软件管理', '../updata/manage.asp'
<!--'保存配置信息', '../save/cfg_save.asp'-->	
);

var arrPort = new Array(
'端口属性', 'portstat.asp', 
'端口统计', 'port2.asp'

);

var arrVLAN=new Array
(
'802.1Q VLAN','vlan1.asp',
'端口-VLAN配置','vlan3.asp',
'VLAN类型切换','vlan4.asp'
);

var arrPVLAN=new Array
(
'VLAN透传','pvlan.asp',
'VLAN类型切换','vlan5.asp'
);

var arrDeviceMng = new Array(
'端口状态', 'st_restart.asp',
'终端配置', 'st_setting.asp',
'Qos配置', 'st_restore.asp',
'芯片配置信息','st_manage1.asp',
'芯片固件升级', 'st_firmware1.asp',
'通道设置', 'st_channel.asp'
);



var arrStatus = new Array(
'终端状态', 'endstatus.asp',
'设备信息', 'headendstatus.asp',
'MAC地址管理', 'macmanage.asp'
<!--'光接收机状态', 'photoreceiverstatus.asp',-->
<!--'系统日志', 'systemlogs.asp'-->
);

var arrDebug = new Array(
'内部调试', 'internal_debug.asp',
'Cable 调试','acmp_debug.asp',
'管理控制','manager_control.asp',
'功率调整','amplitude_modify.asp',
'TTL','qos_ttl.asp'
);

var arrSave = new Array(
'保存', 'cfg_save.asp'
);

var arracmp = new Array(
'Qos配置', 'acmp_etherset.asp'
);

var arrCable = new Array(
<!--'通道设置', 'cable_channel.asp',-->
'SNID配置', 'cable_snid.asp',
'QoS配置', 'cable_qos.asp',
'终端自动升级','cable_updata.asp',
'芯片配置信息', 'cable_manage.asp',
'芯片固件升级','cable_autoupdata.asp'
);

var arracmpConfig = new Array(
'链路状态', 'acmp_status.asp',
'QoS配置','acmp_etherset.asp',
'端口状态','acmp_portstatus.asp',
'升级','acmp_updateStep1.asp',
'管理','acmp_manage.asp'
);


var arracmpCCOConfig = new Array(
'链路状态', 'acmp_status.asp',
'升级','acmp_updateStep1.asp',
'管理','acmp_manage.asp'
);

var arracmpname = new Array(
'设备命名', 'acmp_set_name.asp'
);

var arrBusiness = new Array(
'授权模式','accounts_manage.asp',
'白名单','acmp_equipment.asp',
'黑名单','acmp_black.asp',
'终端模板','acmp_template.asp',
'非法设备上线记录','acmp_record.asp'
);

var arrSystem = new Array(
'带内管理接口','editip.asp',
'时间配置','setsystime.asp',
'Http服务','http.asp',
'SNMP服务','snmp.asp',
'系统日志', 'systemlogs.asp'
<!--'','telnet.asp'-->
);

var arrupdata = new Array(
'配置信息','manage.asp',
'系统升级','autoupdata.asp',
'保存配置信息', 'cfg_save.asp'
);

function logout()
{
   if ((confirm('真的需要退出吗 ?')))
   {
    window.opener = null;  
    window.open('', '_top', '');  
    window.parent.close();
   }
}

function buildMenu(arrGroup, curTab)
{
var itemActive = '<tr><td nowrap class=menuActive><A HREF=%URL% class=selectmenu>%TEXT%</a></td></tr>';
var itemNormal = '<tr><td nowrap class=menuNormal><A HREF=%URL% class=unselectmenu>%TEXT%</a></td></tr>';
var itemActiveNo = '<tr><td nowrap class=menuActiveNo><A HREF=%URL% class=selectmenu>%TEXT%</a></td></tr>';
var itemNormalNo = '<tr><td nowrap class=menuNormalNo><A HREF=%URL% class=unselectmenu>%TEXT%</a></td></tr>';
var navigatorBanner = 
'<table width=100% height=18 leftMargin=0 topMargin=0  MARGINHEIGHT=0' +
'MARGINWIDTH=0 border=0 cellpadding=0 cellspacing=0> <TBODY>' +
'%ITEM%' +
'</TBODY></table>';
var itemCount = arrGroup.length / 2;
var tdStr = '';
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
for (i = 1; i <itemCount + 1; i ++)
{
	j = (i - 1) * 2;
	
	if (i == curTab)
	{
		if(i==9)
		{
			myItemStr = itemActiveNo.replace('%URL%', arrGroup[j + 1]);
		}
		else
		{
			myItemStr = itemActive.replace('%URL%', arrGroup[j + 1]);
		}
		myItemStr = myItemStr.replace('%TEXT%', arrGroup[j]);
		tdStr += myItemStr;
	}
	else 
	{
		if(i==9)
		{
			myItemStr = itemNormalNo.replace('%URL%', arrGroup[j + 1]);
		}
		else
		{
			myItemStr = itemNormal.replace('%URL%', arrGroup[j + 1]);
		}
		myItemStr = myItemStr.replace('%TEXT%', arrGroup[j]);
		tdStr += myItemStr;
	}
}
navigatorBanner = navigatorBanner.replace('%ITEM%', tdStr);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
document.write(navigatorBanner);
	
}


function buildMenunew(arrGroup, curTab,arrGroupchildren,curTabchildren)
{
var itemActive = '<tr><td nowrap class=menuActive><A HREF=%URL% class=selectmenu>%TEXT%</a></td></tr>';
var itemNormal = '<tr><td nowrap class=menuNormal><A HREF=%URL% class=unselectmenu>%TEXT%</a></td></tr>';
var itemActiveNo = '<tr><td nowrap class=menuActiveNo><A HREF=%URL% class=selectmenu>%TEXT%</a></td></tr>';
var itemNormalNo = '<tr><td nowrap class=menuNormalNo><A HREF=%URL% class=unselectmenu>%TEXT%</a></td></tr>';
var navigatorBanner = 
'<table width=100% height=18 leftMargin=0 topMargin=0  MARGINHEIGHT=0' +
'MARGINWIDTH=0 border=0 cellpadding=0 cellspacing=0> <TBODY>' +
'%ITEM%' +
'</TBODY></table>';
var itemCount = arrGroup.length / 2;
var tdStr = '';


var itemActivechildren = '<tr><td nowrap class=navigatorActive><A HREF=%URL% class=select>%TEXT%</a></td></tr>';
var itemNormalchildren = '<tr><td nowrap class=navigator><A HREF=%URL% class=unselect>%TEXT%</a></td></tr>';
var navigatorBannerchildren = 
'<tr><td><table width=100% height=18 leftMargin=0 topMargin=0  MARGINHEIGHT=0' +
'MARGINWIDTH=0 border=0 cellpadding=0 cellspacing=0> <TBODY>' +
'%ITEM%' +
'</TBODY></table></td></tr>';
var itemCountchildren = arrGroupchildren.length / 2;
var tdStrchildren = '';


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
for (i = 1; i <itemCount + 1; i ++)
{
	j = (i - 1) * 2;
	
	if (i == curTab)
	{
		if(i==8)
		{
			myItemStr =itemActiveNo.replace('%URL%', arrGroup[j + 1]);
		}
		else
		{
			myItemStr = itemActive.replace('%URL%', arrGroup[j + 1]);
		}
		myItemStr = myItemStr.replace('%TEXT%', arrGroup[j]);
		tdStr += myItemStr;
		
		for (m = 1; m<itemCountchildren+ 1; m++)
			{
				n = (m - 1) * 2;
				if (m == curTabchildren)
				{
					myItemStrchildren = itemActivechildren.replace('%URL%', arrGroupchildren[n + 1]);
					myItemStrchildren = myItemStrchildren.replace('%TEXT%', arrGroupchildren[n]);
					tdStrchildren+= myItemStrchildren;
				}
				else 
				{
					myItemStrchildren = itemNormalchildren.replace('%URL%', arrGroupchildren[n + 1]);
					myItemStrchildren = myItemStrchildren.replace('%TEXT%', arrGroupchildren[n]);
					tdStrchildren += myItemStrchildren;
				}
			}
		
		navigatorBannerchildren= navigatorBannerchildren.replace('%ITEM%', tdStrchildren);
		tdStr += navigatorBannerchildren;
		
	}
	else 
	{
		if(i==8)
		{
			myItemStr = itemNormalNo.replace('%URL%', arrGroup[j + 1]);
		}
		else
		{
			myItemStr = itemNormal.replace('%URL%', arrGroup[j + 1]);
		}
		myItemStr = myItemStr.replace('%TEXT%', arrGroup[j]);
		tdStr += myItemStr;
	}
}
navigatorBanner = navigatorBanner.replace('%ITEM%', tdStr);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
document.write(navigatorBanner);
	
}


function buildTab(arrGroup, curTab)
{
var itemActive = '<td nowrap class=navigatorActive><A HREF=%URL% class=select>%TEXT%</a></td>';
var itemNormal = '<td nowrap class=navigator><A HREF=%URL% class=unselect>%TEXT%</a></td>';
var navigatorBanner = 
'<table width=100% height=18 leftMargin=0 topMargin=0  MARGINHEIGHT=0' +
'MARGINWIDTH=0 border=0 cellpadding=0 cellspacing=0> <TBODY>' +
'<tr>' +
'%ITEM%' +
'<td width=100% nowrap class=navigatorNormal>&nbsp;</TD>' +
'</tr></TBODY></table>';
var itemCount = arrGroup.length / 2;
var tdStr = '';
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
for (i = 1; i <itemCount + 1; i ++)
{
	j = (i - 1) * 2;
	if (i == curTab)
	{
		myItemStr = itemActive.replace('%URL%', arrGroup[j + 1]);
		myItemStr = myItemStr.replace('%TEXT%', arrGroup[j]);
		tdStr += myItemStr;
	}
	else 
	{
		myItemStr = itemNormal.replace('%URL%', arrGroup[j + 1]);
		myItemStr = myItemStr.replace('%TEXT%', arrGroup[j]);
		tdStr += myItemStr;
	}
}
navigatorBanner = navigatorBanner.replace('%ITEM%', tdStr);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
document.write(navigatorBanner);
}

function buildNavigatorTab(arrGroup, curTab)
{
var itemActive = '<td nowrap class=navigatorActive><A HREF=%URL% class=select>%TEXT%</a></td>';
var itemNormal = '<td nowrap class=navigator><A HREF=%URL% class=unselect>%TEXT%</a></td>';
var navigatorBanner = 
'<table width=100% height=18 leftMargin=0 topMargin=0  MARGINHEIGHT=0' +
'MARGINWIDTH=0 border=0 cellpadding=0 cellspacing=0> <TBODY>' +
'<tr>' +
'%ITEM%' +
'<td width=100% nowrap class=navigatorNormal>&nbsp;</TD>' +
'</tr></TBODY></table>';
var itemCount = arrGroup.length / 2;
var tdStr = '';
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
for (i = 1; i <itemCount + 1; i ++)
{
	j = (i - 1) * 2;
	if (i == curTab)
	{
		myItemStr = itemActive.replace('%URL%', arrGroup[j + 1]);
		myItemStr = myItemStr.replace('%TEXT%', arrGroup[j]);
		tdStr += myItemStr;
	}
	else 
	{
		myItemStr = itemNormal.replace('%URL%', arrGroup[j + 1]);
		myItemStr = myItemStr.replace('%TEXT%', arrGroup[j]);
		tdStr += myItemStr;
	}
}
navigatorBanner = navigatorBanner.replace('%ITEM%', tdStr);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
document.write(navigatorBanner);
}

function CopyrightInfo()
{
	var msg="";
	for (var i=0;i<1;i++)
	msg+='<p><TR><TD textCell>&nbsp;</TR></p>';
	/* BEGIN: Modified by t01840, 2009/8/13   PN:SHD10010*/
	msg+="<p align=center class=textCellC>Copyright &copy 2006-2009 浙江创亿科技有限公司 All rights reserved</p>";
	/* END:   Modified by t01840, 2009/8/13 */
	document.write(msg);
}

function Idle()
{
    alert("这个部分还没时间搞，先别点! 别点!!.");
}

function TrimSpace(string)
{
    var i=0;
    var j=0;
    var length = string.length;
    //搜索前面空格位置
    for(i=0;i<string.length;i++)
    {
        var c = string.charAt(i);
        if(c != ' ')
        {
            break;
        }
    }
    //如果整个字符串全是空格，返回空
    if(i == length)
    {
        return "";
    }
    //如果不是，从后面搜索空格位置
    for(j = length-1;j>0;j--)
    {
        var c = string.charAt(j);
        if(c != ' ')
        {
            break;
        }
    }
    //根据前后空格位置进行裁剪
    var result = string.substring(i,j+1);
    return result;
}

function isValidIdentifier(identifier)
{	
	//检测字符串是否有非法字符
    	result = identifier.match(/\s*[\w][\w-@\.\/]*\s*/);

	if(result != null)//匹配到字符串
	{		
		if(result[0] == identifier)//字符串中无非法字符
		{
			//匹配字符串格式
			result = identifier.match(/\B[-@\.\/]+|[-@\.\/]\B/);
		
			if(result != null)//格式不正确
			{
				return false;
			}
			else
			{			
				result = identifier.match(/\b_|_\b|\B__/);
				if(result != null)//格式不正确
				{
					return false;
				}
				return true;
			}
		}
		else
		{
			return false;
		}
	}   
	
	return false; 
}

function isValidDec(dec)
{	
	//检测字符串是否有非法字符
    	result = dec.match(/\s*[0-9]+\s*/);

	if(result != null)//匹配到字符串
	{		
		if(result[0] == dec)//字符串中无非法字符
		{
			return true;
		}
		else
		{
			return false;
		}
	}   
	
	return false; 
}



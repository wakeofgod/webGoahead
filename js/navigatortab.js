// JavaScript Document
var arrSysSetup = new Array(
'����IP����', 'ethernet_state.asp',
'����VLAN����', 'management_vlan.asp',
'NTP����', 'st_ntp.asp',
'SNMP����', 'snmp.asp'
//'Port Mode', 'WAN_link_speed.asp',
//'MAC Address Clone', 'WAN_mac_clone.asp'
);

var arrMenu = new Array(
'�豸״̬','../devicestatus/endstatus.asp',
'ͷ�˶˿ڹ���', '../port/portstat.asp',
'VLAN', '/goform/web_vlan_page_choose',
'ͷ���豸����', '../headendmanagement/cable_channel.asp',
'�ն���Ȩ����', '../terminalauthorizationmanagement/accounts_manage.asp',
'�ն��豸����', '../devicemanagement/st_restart.asp',
'ϵͳ��������', '../systemserver/editip.asp',
'�豸�������', '../updata/manage.asp'
<!--'����������Ϣ', '../save/cfg_save.asp'-->	
);

var arrPort = new Array(
'�˿�����', 'portstat.asp', 
'�˿�ͳ��', 'port2.asp'

);

var arrVLAN=new Array
(
'802.1Q VLAN','vlan1.asp',
'�˿�-VLAN����','vlan3.asp',
'VLAN�����л�','vlan4.asp'
);

var arrPVLAN=new Array
(
'VLAN͸��','pvlan.asp',
'VLAN�����л�','vlan5.asp'
);

var arrDeviceMng = new Array(
'�˿�״̬', 'st_restart.asp',
'�ն�����', 'st_setting.asp',
'Qos����', 'st_restore.asp',
'оƬ������Ϣ','st_manage1.asp',
'оƬ�̼�����', 'st_firmware1.asp',
'ͨ������', 'st_channel.asp'
);



var arrStatus = new Array(
'�ն�״̬', 'endstatus.asp',
'�豸��Ϣ', 'headendstatus.asp',
'MAC��ַ����', 'macmanage.asp'
<!--'����ջ�״̬', 'photoreceiverstatus.asp',-->
<!--'ϵͳ��־', 'systemlogs.asp'-->
);

var arrDebug = new Array(
'�ڲ�����', 'internal_debug.asp',
'Cable ����','acmp_debug.asp',
'�������','manager_control.asp',
'���ʵ���','amplitude_modify.asp',
'TTL','qos_ttl.asp'
);

var arrSave = new Array(
'����', 'cfg_save.asp'
);

var arracmp = new Array(
'Qos����', 'acmp_etherset.asp'
);

var arrCable = new Array(
<!--'ͨ������', 'cable_channel.asp',-->
'SNID����', 'cable_snid.asp',
'QoS����', 'cable_qos.asp',
'�ն��Զ�����','cable_updata.asp',
'оƬ������Ϣ', 'cable_manage.asp',
'оƬ�̼�����','cable_autoupdata.asp'
);

var arracmpConfig = new Array(
'��·״̬', 'acmp_status.asp',
'QoS����','acmp_etherset.asp',
'�˿�״̬','acmp_portstatus.asp',
'����','acmp_updateStep1.asp',
'����','acmp_manage.asp'
);


var arracmpCCOConfig = new Array(
'��·״̬', 'acmp_status.asp',
'����','acmp_updateStep1.asp',
'����','acmp_manage.asp'
);

var arracmpname = new Array(
'�豸����', 'acmp_set_name.asp'
);

var arrBusiness = new Array(
'��Ȩģʽ','accounts_manage.asp',
'������','acmp_equipment.asp',
'������','acmp_black.asp',
'�ն�ģ��','acmp_template.asp',
'�Ƿ��豸���߼�¼','acmp_record.asp'
);

var arrSystem = new Array(
'���ڹ���ӿ�','editip.asp',
'ʱ������','setsystime.asp',
'Http����','http.asp',
'SNMP����','snmp.asp',
'ϵͳ��־', 'systemlogs.asp'
<!--'','telnet.asp'-->
);

var arrupdata = new Array(
'������Ϣ','manage.asp',
'ϵͳ����','autoupdata.asp',
'����������Ϣ', 'cfg_save.asp'
);

function logout()
{
   if ((confirm('�����Ҫ�˳��� ?')))
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
	msg+="<p align=center class=textCellC>Copyright &copy 2006-2009 �㽭���ڿƼ����޹�˾ All rights reserved</p>";
	/* END:   Modified by t01840, 2009/8/13 */
	document.write(msg);
}

function Idle()
{
    alert("������ֻ�ûʱ��㣬�ȱ��! ���!!.");
}

function TrimSpace(string)
{
    var i=0;
    var j=0;
    var length = string.length;
    //����ǰ��ո�λ��
    for(i=0;i<string.length;i++)
    {
        var c = string.charAt(i);
        if(c != ' ')
        {
            break;
        }
    }
    //��������ַ���ȫ�ǿո񣬷��ؿ�
    if(i == length)
    {
        return "";
    }
    //������ǣ��Ӻ��������ո�λ��
    for(j = length-1;j>0;j--)
    {
        var c = string.charAt(j);
        if(c != ' ')
        {
            break;
        }
    }
    //����ǰ��ո�λ�ý��вü�
    var result = string.substring(i,j+1);
    return result;
}

function isValidIdentifier(identifier)
{	
	//����ַ����Ƿ��зǷ��ַ�
    	result = identifier.match(/\s*[\w][\w-@\.\/]*\s*/);

	if(result != null)//ƥ�䵽�ַ���
	{		
		if(result[0] == identifier)//�ַ������޷Ƿ��ַ�
		{
			//ƥ���ַ�����ʽ
			result = identifier.match(/\B[-@\.\/]+|[-@\.\/]\B/);
		
			if(result != null)//��ʽ����ȷ
			{
				return false;
			}
			else
			{			
				result = identifier.match(/\b_|_\b|\B__/);
				if(result != null)//��ʽ����ȷ
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
	//����ַ����Ƿ��зǷ��ַ�
    	result = dec.match(/\s*[0-9]+\s*/);

	if(result != null)//ƥ�䵽�ַ���
	{		
		if(result[0] == dec)//�ַ������޷Ƿ��ַ�
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



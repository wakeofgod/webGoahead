var cPage=window.location.toString().replace(/.*\//,'');
cPage=cPage.replace(/\?.*/,'');
function dayWriteMap(v1,v2,v3,v4,v5,v6,v7) {
   return (v1|(v2<<1)|(v3<<2)|(v4<<3)|(v5<<4)|(v6<<5)|(v7<<6));
}

function cutSpace(I)
{
	var l = I.value.length;
	var k;
	u = "";

	for(k=0; k<l; k++ )
	{
		ch = I.value.charAt(k);
		if ( ch == " " ) continue;
		u += ch;
	}
	I.value = u;

	if(u=="" || u=="0" || u.charAt(0)!="0") return u;
	else
	{
		l = I.value.length;
		u = "";
		for(k=0;k<l;k++)
		{
			ch = I.value.charAt(k);
			if ( (ch == "0") && ((k+1)!=l) && (u=="") )continue;
			u += ch;
		}
		I.value = u;
		return u;

	}

}

function dayReadMap(v, i)
{
  	return((v>>i)&1);
}
function macsCheck(I)
{
	var m = /(^([A-Fa-f0-9]{2}:){5}[A-Fa-f0-9]{2}$)/;
	if(I.length!=17 || !m.test(I))
	{
	    alert("MAC地址非法，请重新输入。");
	    return false;
	}
	if(I == "00:00:00:00:00:00")
	{
		alert("MAC地址非法，请重新输入。");
		return false;
	}
	var u = I.split(":");
	var wrong = /[fF]{2}/;
	if(wrong.test(u[0]))
	{
		if( wrong.test(u[1]) && wrong.test(u[2]) && wrong.test(u[3]) && wrong.test(u[4]) && wrong.test(u[5]))
		{
			alert("MAC地址非法，请重新输入。");
			return false;
		}
	}
	n=parseInt(u[0],16);
	if (n&0x1)
	{
		alert("MAC地址非法，请重新输入。");
	   	return false;
	}
	return true;
}
function validNumCheck(v,m)
{
	var t = /[^0-9]{1,}/;
	if (t.test(v.value))
	{
		alert(m) ;
		v.value=v.defaultValue;
		return false;
	}
	return true ;
}
function validNum_Check(v,m)
{
	var t = /[^0-9]{1,}/;
	if (t.test(v))
	{
		alert(m) ;
		return 0;
	}
	return 1 ;
}
function rangeCheck(v,a,b,s)
{
   	if (!validNumCheck(v,s)) return 0;
   	if ((v.value<a)||(v.value>b))
   	{
      		alert(s) ;
      		v.value=v.defaultValue ;
      		return 0 ;
   	} else return 1 ;
}

function rangeCheck_mtu(v,a,b,s)
{
   	if (!validNumCheck(v,s)) return 0;
   	if ((v.value<a)||(v.value>b))
   	{
      		alert(s) ;
      		return 0 ;
   	} else return 1 ;
}

function synratecheck(rate)
{
	u=parseInt(rate.value);
	if (u<=0)
	{
		alert("SYN Flood 值设置错误.");
		rate.value=rate.defaultValue ;
		return 0;
	}
}
function pmapCheck(v,m)
{
	var t = /[^0-9,-]{1,}/;
	var n,s,tmp;
	if (t.test(v.value))
	{
		alert(m);
		return 0;
	}
	tmp="";
	u = v.value.split(",");

	if ( u.length == 0 )
	{
		n = Number(u);
		if ( n < 1 || n > 65535 )
		{
			alert("不正确端口号 ["+ n + "] 请重新输入.");
			return 0;
		}
		tmp+=n;
	}

	for ( i=0; i<u.length; i++ )
	{
		s = u[i].split("-");

		if ( s.length == 0 )
		{
			n = Number(s);
			if ( n < 1 || n > 65535 )
			{
				alert("不正确端口号 ["+ n + "] 请重新输入.");
				return 0;
			}
			tmp+=n;
		}
		else if ( s.length == 1 )
		{
			n = Number(s);
			if ( n < 1 || n > 65535 )
			{
				alert("不正确端口号 ["+ n + "] 请重新输入.");
				return 0;
			}
			tmp+=n;
		}
		else
		{
			nf = Number(s[0]);
			if ( nf < 1 || nf > 65535 )
			{
				alert("不正确端口号 ["+ nf + "] 请重新输入.");
				return 0;
			}
			nb = Number(s[1]);
			if ( nb < 1 || nb > 65535 )
			{
				alert("不正确端口号 ["+ nb + "] 请重新输入.");
				return 0;
			}

			if ( nb < nf )
			{
				alert("不正确端口号顺序 ["+ nf + "-" + nb + "] 请重新输入.");
				return 0;
			}
			tmp+=nf+"-"+nb;
		}
		if(i!=u.length-1)
			tmp+=",";
	}
	v.value = tmp;
	return 1 ;
}

function scCheck(s,msg)
{
	var ck=/[\;]/;
	if (ck.test(s.value))
	{
		alert(msg+" 包含有不正确的字符: \;");
		return false;
	}
	return true;
}
function refresh(destination)
{
   window.location = destination ;
}
function decomList(str,len,idx,dot)
{
	var t = str.split(dot);
	return t[idx];
}
function decomListLen(str, dot)
{
	var t = str.split(dot);
	return t.length;
}
function typeToIdx(type)
{
	if (type=="tcp/udp")
		return 2 ;
	else if(type=="udp")
    	 	return 1 ;
	else
		return 0 ;
}
function IdxToType(idx)
{
	if (idx == 2)
		return "tcp/udp" ;
	else if(idx == 1)
		return "udp" ;
	else
		return "tcp";
}
function boolToType(bool)
{
   if (bool)
      return "tcp" ;
    else return "udp" ;
}
function boolToStr(bool)
{
   if (bool)
      return "1" ;
    else return "0" ;
}
/*
function keyCheck(F)
{
   	var ok = 1 ;
	var cmplen;
	var i;
	for (i=1;i<5;i++) if (F.WEPDefKey[i-1].checked) break;
	var k=eval('F.key'+i);

   	if (F.wep_type.selectedIndex==0)
		cmplen=10;
	else
		cmplen=26;

	if (k.value.length!=cmplen) 
	{
			alert("第 "+i+"个密码长度必须是 "+cmplen);
		ok=0 ;
	}
   	return ok ;
}
*/
function valueToDayIdx(value)
{
   return (value/86400) ;
}
function valueToTimeIdx(value)
{
   return ((value/3600)%24) ;
}
function setCheckValue(t)
{
   if (t.checked) t.value=1 ;
   else t.value=0 ;
}
function preLogout()
{
   if ((confirm('真的需要退出吗 ?')))
   {
    		parent.location = "login.htm";
   }
}
function showHidden(len)
{
   var s = "" ;
   for (i=0;i<len;i++)
      s=s+"*" ;
   return s ;
}
function combinIP(d1,d2,d3,d4)
{
    var ip=d1.value+"."+d2.value+"."+d3.value+"."+d4.value;
    if (ip=="...")
        ip="";
    return ip;
}
function combinMAC(m1,m2,m3,m4,m5,m6)
{
    var mac=m1.value+":"+m2.value+":"+m3.value+":"+m4.value+":"+m5.value+":"+m6.value;
    if (mac==":::::")
        mac="";
    return mac;
}
function verifyIP0(ipa,msg,subnet)
{
	var ip=combinIP2(ipa);
	if (ip=='' || ip=='0.0.0.0') return true;
	return verifyIP2(ipa,msg,subnet);
}

function convertip2array(ipa,ip)
{
	if (ipa.length==4)
	{
		for (var i=0;i<4;i++)
		{
			tmp=cutSpace(ipa[i]);
			if ( tmp =="" )
			{
				return false;
			}
			ip[i]=ipa[i].value;			
		}
		return true;
	}
	else
		ip=ipa.value.split(".");
}

function verifyIP2(ipa,msg,subnet)
{
	var ip = new Array();

	if((ipa.length!=4)||(parseInt(cutSpace(ipa[0]))==127))
	{
       	 alert("非法的" + msg +",请重新输入.");
		 return false;
	}

	if(!validipandmask(ipa,subnet))
	{
		alert("非法的" + msg +",请重新输入.");
		return false;
	}	
	return true;
}

function decomMAC2(ma,macs,nodef)
{
    var re = /^[0-9a-fA-F]{1,2}:[0-9a-fA-F]{1,2}:[0-9a-fA-F]{1,2}:[0-9a-fA-F]{1,2}:[0-9a-fA-F]{1,2}:[0-9a-fA-F]{1,2}$/;
    if (re.test(macs)||macs=='')
    {
	if (ma.length!=6)
	{
		ma.value=macs;
		return true;
	}
	if (macs!='')
        	var d=macs.split(":");
	else
		var d=['','','','','',''];
       for (i = 0; i <6; i++)
	{
            	ma[i].value=d[i];
		if (!nodef) ma[i].defaultValue=d[i];
	}
        return true;
    }
    return false;
}
function decomIP2(ipa,ips,nodef)
{
    var re = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
    if (re.test(ips))
    {
        var d =  ips.split(".");
        for (i = 0; i <4; i++)
	{
            ipa[i].value=d[i];
		if (!nodef) ipa[i].defaultValue=d[i];
	}
        return true;
    }
    return false;
}
function combinIP2(d)
{
    if (d.length!=4) return d.value;
    var ip=cutSpace(d[0])+"."+cutSpace(d[1])+"."+cutSpace(d[2])+"."+cutSpace(d[3]);
    if (ip=="...")
    {
        ip="";
    	return ip;
    }
    ip=parseInt(cutSpace(d[0]),10)+"."+parseInt(cutSpace(d[1]),10)+"."+parseInt(cutSpace(d[2]),10)+"."+parseInt(cutSpace(d[3]),10);
    if (ip=="...")
        ip="";
    return ip;
}
function combinMAC2(m)
{
    var mac=cutSpace(m[0])+":"+cutSpace(m[1])+":"+cutSpace(m[2])+":"+cutSpace(m[3])+":"+cutSpace(m[4])+":"+cutSpace(m[5]);
	mac=mac.toUpperCase();
    if (mac==":::::")
        mac="";
    return mac;
}
function ipMskChk(mn,str)
{
	var m=new Array();
	if (mn.length==4)
		for (i=0;i<4;i++) m[i]=mn[i].value;
	else
	{
		m=mn.value.split('.');
		if (m.length!=4) { alert("非法的"+str+",请重新输入.") ; return 0; }
	}
	var t = /[^0-9]{1,}/;
	for (var i=0;i<4;i++)
	{
		if (t.test(m[i])||m[i]>255) { alert("非法的"+str+",请重新输入.") ; return 0; }
	}
	var v=(m[0]<<24)|(m[1]<<16)|(m[2]<<8)|(m[3]);
   	var f=0 ;
   	for (k=0;k<32;k++)
	{
		if ((v>>k)&1) f = 1;
		else if (f==1)
		{
			alert("非法的"+str+",请重新输入.") ;
			return 0 ;
		}
	}
	if (f==0)
	{
		alert("非法的"+str+",请重新输入.") ;
		return 0;
	}
	return 1;
}

function pwdSame(p,p2)
{
   if (p != p2) { alert("两次输入的密码不一致!") ; return 0 ; }
   else return 1 ;
}
function chkPwdUpdate(po,p,pv,c)
{
//if (c.value=='0') return true;
    if (!pwdSame(p.value,pv.value)) return false;
    if (!confirm('真的更改密码吗 ?'))
    {
        c.value=0 ;
        po.value=p.value=pv.value="";
        return false;
    }
    return true;
}
function chkPwd1Chr(p,pv,c)
{
   	if (c.value=='0')
   	{
  		p.value=pv.value="";
  		c.value='1';
	}
}
function chkPwd1Chr2(po,p,pv,c)
{
   	if (c.value=='0')
   	{
  		po.value=p.value=pv.value="";
  		c.value='1';
	}
}

function chkPwd1Chr2withLength(po,p,pv,c,password)
{
   	if (c.value=='0')
   	{
  		po.value=p.value=pv.value="";
  		c.value='1';
	}
   	
   	if(password.value.length >=15)
	{
	    alert("新密码太长(超过15个字符).");
	}
}

function chkStrLen(s,m,M,msg)
{
	var str=s.value;
	if ( str.length <m || str.length> M )
	{
		alert(msg+" 长度必须在["+m+" - "+M+"]之间!");
		return false;
	}
    	return true;
}
function isIE()
{
	var agt = navigator.userAgent.toLowerCase();
	return (agt.indexOf("msie") != -1);
}
function fit2(n)
{
	var s=String(n+100).substr(1,2);
	return s;
}
function timeStr(t)
{
	if(t < 0)
	{
		str='00:00:00';
		return str;
	}
	var s=t%60;
	var m=parseInt(t/60)%60;
	var h=parseInt(t/3600)%24;
	var d=parseInt(t/86400);
	var str='';
	if (d) str+=d+' 天 ';
	str+=fit2(h)+':';
	str+=fit2(m)+':';
	str+=fit2(s);
	return str;
}
var dmnRng= new Array(16383,2047,2047,8191,1536,7680,16383);
function chanList(Opt,dn)
{
	var j = 0;
	for(var i=1;i<=14;i++)
	{
		if(dmnRng[dn] & (1<<(i-1)))
        	{
			var fr;
			if (i!=14) fr=i*0.005+2.407;
			else fr=2.484;
			var opn = new Option(i+" - "+fr+"GHz",i);
			Opt.options[j++] = opn;
		}
	}
}
function rmEntry(a,i)
{
	if (a.splice)
		a.splice(i,1);
	else
	{
		if (i>=a.length) return;
		for (var k=i+1;k<=a.length;k++)
		a[k-1]=a[k];
		a.length--;
	}
}
function getStyle(objId)
{
	var obj=document.getElementById(objId);
	if (obj) return obj.style;
	else return 0;
}
function setStyle(id, v)
{
    var st = getStyle(id);
    if(st)
    	{
    		st.visibility = v;
    		return true;
    	}
    else return false;
}

function setZindex(id, v)
{
    var st = getStyle(id);
    if(st)
    	{
    		st.zIndex = v;
    		return true;
    	}
    else return false;
}
function getparastr(strname)
{
	var hrefstr,pos,parastr,para,tempstr;
	hrefstr = window.location.href;
	pos = hrefstr.indexOf("?")
	parastr = hrefstr.substring(pos+1);
	para = parastr.split("&");
	tempstr="";
	for(i=0;i<para.length;i++)
	{
		tempstr = para[i];
		pos = tempstr.indexOf("=");
		if(tempstr.substring(0,pos) == strname)
		{
			return tempstr.substring(pos+1);
		}
	}
	return null;
}

function PortCheck(I)
{
	u=cutSpace(I);
	if ( u=="" ) return;
	m = '无效的端口号, 请重新输入.';
	if ( !validNumCheck(I,m) ) return 0;
	d =parseInt(I.value, 10);
	if ( !( d<65536 && d>=0) )
	{
		alert(m);
		I.value = I.defaultValue;
		return 0;
	}
	return 1;
}

function PortCheckACL(I)
{
	m = cutSpace(I);
	if ( m=="" ) return 1;
	return PortCheck(I)
}

function PortCheck2(I)
{
	m = '无效的端口号, 请重新输入.';
	if ( !validNumCheck(I,m) ) return 0;
	d =parseInt(I.value, 10);
	if ( !( d<65536 && d>=1025) )
	{
		alert(m);
		I.value = I.defaultValue;
		return 0;
	}
	return 1;
}

function IPCheck(I)
{
	u=cutSpace(I);
	if ( u=="" ) return false;
	m = '非法的IP地址, 请重新输入.';
	if ( !validNumCheck(I,m) ) return false;
	d =parseInt(I.value, 10);
	if ( !(d<256 && d>=0) )
	{
 		alert(m);
 		I.value = I.defaultValue;
		return false;
	}
	return true;
}

function IP_Check(I)
{
	m = '非法的IP地址, 请重新输入.';
	if( I.value == "0.0.0.0" ||  I.value == "255.255.255.255")
	{
		 alert(m);
		 return false;
	}	
	var i;
	ch = I.value.charAt(0);
	if(ch == "0")
	{
		alert(m);
		return false;
	}
	
	u=cutSpace(I);
	if ( u.value=="" )
	{
		alert("IP地址不能为空");
		return false;
	}
	
	var t = I.value.split(".");
	if(t.length != 4 || t[0] == 127 || t[0] >=224 || t[0] == 0)
	{
		 alert(m);
		 return false;
	}
	for( i=0; i<4; i++)
	{
		if(t[i].length > 3)
		{
			alert(m);
			return false;
		}
		n=parseInt(t[i],10);
		if ( t[i] == "" ) 
		{
			alert(m);
			return false;
		}
		if ( !validNum_Check(t[i],m) ) 
		{
			return false;
		}
	    if ( !(t[i]<256 && t[i]>=0) )
	    {
 		    alert(m);
		    return false;
	    }
	}

	/*
	var ipaddr = new Array(4);
	var net_mask = new Array(4);

	var ip = I.value.split(".");

	ipaddr = [parseInt(ip[0],10),
			parseInt(ip[1],10),
			parseInt(ip[2],10),
			parseInt(ip[3],10)];
	
	var ip0=parseInt(ip[0],10);

	if((ip0 & 0x80) == 0x00)
	{
		net_mask = ["255", "0","0","0"];	    	    		
	}
	else if((ip0 &0xc0) == 0x80)
	{
		net_mask = ["255", "255","0","0"];  
	}
	else if((ip0 & 0xe0) == 0xc0)
	{
		net_mask = ["255", "255","255","0"];	   
	}
	else
	{
		net_mask = ["255", "255","255","255"];
	}

	if( !((parseInt(ipaddr[1],10)&(~parseInt(net_mask[1],10))) ||
		(parseInt(ipaddr[2],10)&(~parseInt(net_mask[2],10))) ||
		(parseInt(ipaddr[3],10)&(~parseInt(net_mask[3],10))) ||
		(parseInt(ipaddr[0],10)&(~parseInt(net_mask[0],10)))))
	{
		alert(m);
		return false;
	}

	if( ((ipaddr[0]&(~net_mask[0])) == ((~net_mask[0])&0xff) ) &&
		((ipaddr[1]&(~net_mask[1])) == ((~net_mask[1])&0xff) ) &&
		((ipaddr[2]&(~net_mask[2])) == ((~net_mask[2])&0xff) ) &&
		((ipaddr[3]&(~net_mask[3])) == ((~net_mask[3])&0xff) ) )
	{
		alert(m);
		return false;
	}
    */
	return true;	

}

function IP0to254(I)
{
	u=cutSpace(I);
	if ( u=="" ) return;
	m = '非法的IP地址, 请重新输入.';
	if ( !validNumCheck(I,m) ) return;
	d =parseInt(I.value, 10);
	if ( !(d<255 && d>=0) )
	{
		alert(m);
  		I.value = I.defaultValue;
	}
}
function IP1to254(I)
{
	u=cutSpace(I);
	if ( u=="" ) return;
	m = '非法的IP地址, 请重新输入.';
	if ( !validNumCheck(I,m) ) return;

	d =parseInt(I.value, 10);
	if ( !(d<255 && d>0) )
	{
		alert(m);
		I.value = I.defaultValue;
	}
}

function IP1to223(I)
{
	u=cutSpace(I);
	if ( u=="" ) return;
	m = '非法的IP地址, 请重新输入.';
	if ( !validNumCheck(I,m) ) return;

	d =parseInt(I.value, 10);
	if ( !(d<224 && d>0) )
	{
		alert(m);
		I.value = I.defaultValue;
	}
}

function IP0to223(I)
{
	u=cutSpace(I);
	if ( u=="" ) return;
	m = '非法的IP地址, 请重新输入.';
	if ( !validNumCheck(I,m) ) return;

	d =parseInt(I.value, 10);
	if ( !(d<224 && d>=0) )
	{
		alert(m);
		I.value = I.defaultValue;
	}
}

function macCheck(I)
{
	var m1,m2=0,u;
	if ( u=="" )
	{
		I.value ='00';
		return 1;
	}
	m1=parseInt(I.value.charAt(0),16);
	m2=I.value.length==2?parseInt(I.value.charAt(1),16):0;
	if(isNaN(m1)||isNaN(m2))
	{
		alert('非法的MAC地址, 请重新输入.');
		I.value=I.defaultValue;
		return 0;
	}
	return 1;
}
function macCheck41(I)
{
	var m1,m2=0,u;
	if ( u=="" )
	{
		I.value ='00';
		return 0;
	}
	m1=parseInt(I.value.charAt(0),16);
	m2=I.value.length==2?parseInt(I.value.charAt(1),16):0;
	if(isNaN(m1)||isNaN(m2))
	{
		alert('非法的MAC地址, 请重新输入.');
		I.value=I.defaultValue;
		return 0;
	}
	if(m2 == 1 || m2 == 3 || m2 == 5 || m2 == 7 || m2 == 9 || m2 == 11 || m2 == 13 || m2 == 15 )
	{
		alert('非法的MAC地址, 请重新输入.');
		I.value=I.defaultValue;
		return 0;
	}
	return 1;
}
function mtuCheck(I,a,b)
{
	m = 'MTU值超出范围,请重新输入.';
	if ( !validNumCheck(I,m) ) return;
	d =parseInt(I.value, 10);
	if ( d<a || d>b )
	{
		alert(m);
		//I.value = I.defaultValue;
	}
}

function netMaskCheck(I)
{
	m = '非法的子网掩码, 请重新输入.';
	if ( !validNumCheck(I,m) ) return;
	d =parseInt(I.value, 10);
	if( !(d==0 || d==128 || d==192 || d==224 || d==240 || d==248 || d==252 || d==254 || d==255 ))
	{
		alert(m);
		I.value = I.defaultValue;
	}
}

function netMaskCheck3(I)
{
	m = '非法的子网掩码, 请重新输入.';
	if ( !validNumCheck(I,m) ) return;
	d =parseInt(I.value, 10);
	if( !(d==0 || d==128 || d==192 || d==224 || d==240 || d==248 || d==252 /*|| d==254*/ ))
	{
		alert(m);
		I.value = I.defaultValue;
	}
}

function selectIPModeWAN(f,q)
{
	var s;
	if ( q == 1 )
		s = "?quick=1";
	else
		s = "";
	if (f.IPMode.selectedIndex == 0)
		location="ethernet_static.htm" + s;
	else if (f.IPMode.selectedIndex == 1)
		location="ethernet_dynamic.htm" + s;
	/* BEGIN: Deleted by y03611, 2006/11/29   PN:do not support PPPOE dial*/
	/*else if (f.IPMode.selectedIndex == 2)
		location="WAN_ethernet_pppoe.htm" + s;*/
	/* END: Deleted by y03611, 2006/11/29 */
}

function GurlWan(q)
{
	var s;
	if ( q == 1 )
		s = "?quick=1";
	else
		s = "";
	location="WAN_ethernet_state.htm" + s;
}

function verifyMAC(ma,s,sp)
{
    	var t = /[0-9a-fA-F]{2}/;
	m = new Array();
	if (ma.length==6)
	{
		for (var i=0;i<6;i++)
			m[i]=ma[i].value;
	}
	else
		m=ma.value.split(":");

	if (sp)
	{
		if (m.toString()==',,,,,' ) return true;
	}
	for (var i=0;i<6;i++)
	{
		if (!t.test(m[i]))
		{
			alert("非法的"+s+",请重新输入.");
			return false;
		}
    	}

    	for(i=0; i<6; i++ )
    		if (m[i] !='00' ) break;

    	if ( i == 6 )
    	{
    		alert("非法的"+s+",请重新输入.");
    		return false;
    	}

    	if ( !macCheck41(ma[0]) )
    	{
    		alert("非法的"+s+",请重新输入.");
    		return false;
    	}

    	return true
}

function ifAtSameNet(IP,GW,NM)
{
	var v_ip=(parseInt(cutSpace(IP[0]),10)<<24)
	       | (parseInt(cutSpace(IP[1]),10)<<16)
	       | (parseInt(cutSpace(IP[2]),10)<<8)
	       | (parseInt(cutSpace(IP[3]),10));
	var v_gw=(parseInt(cutSpace(GW[0]),10)<<24)
	       | (parseInt(cutSpace(GW[1]),10)<<16)
	       | (parseInt(cutSpace(GW[2]),10)<<8)
	       | (parseInt(cutSpace(GW[3]),10));
	var v_nm;
	if (parseInt(cutSpace(NM[3]),10)== 0)
		v_nm=(parseInt(cutSpace(NM[0]),10)<<24)
	       | (parseInt(cutSpace(NM[1]),10)<<16)
	       | (parseInt(cutSpace(NM[2]),10)<<8)
	       | (parseInt(cutSpace(NM[3]),10));
	else
		v_nm=(255<<24)|(255<<16)|(255<<8)|(0);


	var net_ip = v_ip & v_nm;
	var net_gw = v_gw & v_nm;

	if(net_ip != net_gw) 	return 0;
	else return 1;

}
function CopyrightInfo()
{
	var msg="";
	for (var i=0;i<1;i++)
	msg+='<p><TR><TD textCell>&nbsp;</TR></p>';
	/* BEGIN: Modified by t01840, 2009/8/13   PN:SHD10010*/
	msg+="<p align=center class=textCellC>Copyright &copy 2007-2009 杭州华三通信技术有限公司 版权所有，保留一切权利。</p>";
	/* END:   Modified by t01840, 2009/8/13 */
	document.write(msg);
}

function verifyDNS(ipa,msg)
{
	var ip=combinIP2(ipa);
	if (ip=='' || ip=='0.0.0.0') return true;

	var ip0=parseInt(ipa[0].value,10);
	
	if ( (ip0 == 0) || (ip0 == 255) || (ip0 == 127) || (ip0 >= 224) ||!validipandmask(ipa,null))
    	{
    		alert("非法的" + msg +",请重新输入.");
		return false;
    	}

	return true;
}

function validipandmask(ip,mask)
{
	var ipaddr = new Array(4);
	var net_mask = new Array(4);

	ipaddr = [parseInt(cutSpace(ip[0]),10),
			parseInt(cutSpace(ip[1]),10),
			parseInt(cutSpace(ip[2]),10),
			parseInt(cutSpace(ip[3]),10)];

	if(mask == null)
	{
		var ip0=parseInt(ip[0].value,10);
		
		if((ip0 & 0x80) == 0x00)
		{
			net_mask = ["255", "0","0","0"];	    	    		
		}
		else if((ip0 &0xc0) == 0x80)
		{
			net_mask = ["255", "255","0","0"];  
		}
		else if((ip0 & 0xe0) == 0xc0)
		{
			net_mask = ["255", "255","255","0"];	   
		}
		else
		{
			net_mask = ["255", "255","255","255"];
		}
	}
	else
	{
		net_mask=[parseInt(cutSpace(mask[0]),10),
		       parseInt(cutSpace(mask[1]),10),
		       parseInt(cutSpace(mask[2]),10),
		       parseInt(cutSpace(mask[3]),10)];    
	}
	if( !((parseInt(ipaddr[1],10)&(~parseInt(net_mask[1],10))) ||
		(parseInt(ipaddr[2],10)&(~parseInt(net_mask[2],10))) ||
		(parseInt(ipaddr[3],10)&(~parseInt(net_mask[3],10))) ||
		(parseInt(ipaddr[0],10)&(~parseInt(net_mask[0],10)))))

		return false;

	if( ((ipaddr[0]&(~net_mask[0])) == ((~net_mask[0])&0xff) ) &&
		((ipaddr[1]&(~net_mask[1])) == ((~net_mask[1])&0xff) ) &&
		((ipaddr[2]&(~net_mask[2])) == ((~net_mask[2])&0xff) ) &&
		((ipaddr[3]&(~net_mask[3])) == ((~net_mask[3])&0xff) ) )

		return false;

	return true;	
}

function isValidString(string)
{	

    //检测字符串是否有非法字符
	result_str = string.match(/[\'\"\\/\<\>,.;]/);	                               
	if(result_str != null)//匹配到字符串
	{
	    return false;
	}
	
	return true;
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

function moveOption(from,to)
{
    for(var x=0;x < from.length;)
    {
        var opt=from.options[x];
        if(opt.selected)
        {
            if(opt.value=="")
            {
                opt.value=opt.text;
            }
            to.options[to.options.length]=new Option(opt.text,opt.value,0,0);
            from.options[x]=null;
        }
        else
        {
            x++;
        }
    }
    return true;
}

function TestBit(mask, bitNum)
{
	return (mask & (1 << bitNum))
}

function DisByMask(array,count,skip)
{
    var left=0;
    var on=0;
    var k,n;
    var begin=1;
    for(k=1,n=0;k<=count;k++)
    {
        if((k%8)==0)
        {
            n++;
        }
        if(array[n+skip]&(1<<(k-n*8)))
        {
            if(0==left)
            {
                if(1==begin)
                {
                    begin=0;
                }
                else
                {
                    document.write(', ');
                }
                left=1;
                document.write(k);
            }
            else
            {
                on=1;
            }
        }
        else
        {
            if(1==left)
            {
                if(1==on)
                {
                    document.write('-'+(k-1));
                }
                left=on=0;
            }
        }
    }
    if(1==on)
    {
        document.write('-'+count);
    }
}
function DisByEtherMask(portMask,etherMask,count)
{
	var port = 0;
	var n = 0;
	var h = false;
	var first = true;
	var cableStart = 0;
	var cableNum = 0;

	for(port=0; port<count; port++)
	{
		if(port%32 == 0 && port !=0)
		{
			n++;
		}

		if(TestBit(etherMask[n], port%32))
		{
			if(first)
			{
				cableStart = port;
				first = false;
			}
			cableNum++;
		}
	}

	first = true;
	n = 0;

	for(port=0; port<cableStart; port++)
	{
		if(port%32 == 0 && port !=0)
		{
			n++;
		}

		if(TestBit(portMask[n], port%32))
		{
			if( h )
			{
				if(port+1<cableStart && TestBit(portMask[n], (port+1)%32))
				{
					continue;
				}
				else
				{
					document.write('-');
					h = false;
				}
			}
			else
			{
				if(port+1<cableStart && TestBit(portMask[n], (port+1)%32))
				{
					h = true;
				}

				if(!first)
				{
					document.write(',');
				}
			}

			document.write("Cable");

			first = false;
		}
	}

	for(port=cableStart; port<count; port++)
	{
		if(port%32 == 0 && port !=0)
		{
			n++;
		}

		if(TestBit(portMask[n], port%32))
		{
			if( h )
			{
				if(port+1<count && TestBit(portMask[n], (port+1)%32))
				{
					continue;
				}
				else
				{
					document.write('-');
					h = false;
				}
			}
			else
			{
				if(port+1<count && TestBit(portMask[n], (port+1)%32))
				{
					h = true;
				}

				if(!first)
				{
					document.write(',');
				}
			}

			document.write("Ethernet");
			if(4 == count)
			{
				document.write(port);
			}

			first = false;
		}
	}	

}

function DisByPortMask(portMask,cableMask,count)
{
	var port = 0;
	var n = 0;
	var h = false;
	var first = true;
	var cableStart = 0;
	var cableNum = 0;

	for(port=0; port<count; port++)
	{
		if(port%32 == 0 && port !=0)
		{
			n++;
		}

		if(TestBit(cableMask[n], port%32))
		{
			if(first)
			{
				cableStart = port;
				first = false;
			}
			cableNum++;
		}
	}

	first = true;
	n = 0;

	for(port=0; port<cableStart; port++)
	{
		if(port%32 == 0 && port !=0)
		{
			n++;
		}

		if(TestBit(portMask[n], port%32))
		{
			if( h )
			{
				if(port+1<cableStart && TestBit(portMask[n], (port+1)%32))
				{
					continue;
				}
				else
				{
					document.write('-');
					h = false;
				}
			}
			else
			{
				if(port+1<cableStart && TestBit(portMask[n], (port+1)%32))
				{
					h = true;
				}

				if(!first)
				{
					document.write(',');
				}
			}

			document.write("Ethernet");
			document.write(port+1);

			first = false;
		}
	}

	for(port=cableStart; port<count; port++)
	{
		if(port%32 == 0 && port !=0)
		{
			n++;
		}

		if(TestBit(portMask[n], port%32))
		{
			if( h )
			{
				if(port+1<count && TestBit(portMask[n], (port+1)%32))
				{
					continue;
				}
				else
				{
					document.write('-');
					h = false;
				}
			}
			else
			{
				if(port+1<count && TestBit(portMask[n], (port+1)%32))
				{
					h = true;
				}

				if(!first)
				{
					document.write(',');
				}
			}

			document.write("Cable");
			if(cableNum>1)
			{
				document.write(port+1-cableStart);
			}

			first = false;
		}
	}
	if(first == true)
	{
		document.write('--');
	}	

}

function check_input(input,min,max)
{
    var valid=true;
    var inputtemp;
    var ch;
    var cnt;
	var len;
    inputtemp=input.toString();
	len=inputtemp.length;
	if(0==len)
	{
		valid=false;
        return valid;
	}
	for(cnt=len-1;cnt>=0;cnt--)
	{
		ch=inputtemp.charAt(cnt);
		if(' '==ch)
		{
		    len--;
		}
		else
	    {
		    break;
	    }	
	}
    for(cnt=0;cnt<len;cnt++)
    {
        ch=inputtemp.charAt(cnt);
        if((ch>'9')||(ch<'0'))
        {
            valid=false;
            return valid;
        }
    }
    if((input>max)||(input<min))
    {
        valid=false;
    }
    return valid;
}

function pmask2str(pMask)
{
    var i=0,j=0;
    var tmp = Array(8);
    var result='';

    for(i=0;i<8;i++)
        tmp[i]=0;
    
    for(i=0;i<8;i++)
    {
        tmp[i] = (pMask>>(4*i))&(0x0F);
    }
    
    for (i=0;i<8;i++)
    {
        result += tmp[7-i].toString(16);
    }
    result = '0x' + result;
    return result;
}


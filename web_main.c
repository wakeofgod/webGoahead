/*
 * main.c -- Main program for the GoAhead WebServer (LINUX version)
 *
 * Copyright (c) GoAhead Software Inc., 1995-2010. All Rights Reserved.
 *
 * See the file "license.txt" for usage and redistribution license requirements
 *
 */

/******************************** Description *********************************/

/*
 *	Main program for for the GoAhead WebServer.
 */

/********************************* Includes ***********************************/

#include "../uemf.h"
#include "../wsIntrn.h"
#include <signal.h>
#include <unistd.h>
#include <sys/types.h>

#ifdef WEBS_SSL_SUPPORT
#include "../websSSL.h"
#endif

#ifdef USER_MANAGEMENT_SUPPORT
#include "../um.h"
void formDefineUserMgmt(void);
#endif

#define WEBS_DEFAULT_PORT 8070
#define WEBS_DEFAULT_HOME T("index.html")
//T("index.html")
//T("index.htm")

/*********************************** Locals ***********************************/
/*
 *	Change configuration here
 */

static char_t *rootWeb = T("www");	   /* Root web directory */
static char_t *demoWeb = T("wwwdemo"); /* Root web directory */
static char_t *password = T("");	   /* Security password */
static int port = WEBS_DEFAULT_PORT;   /* Server port */
static int retries = 5;				   /* Server port retries */
static int finished = 0;			   /* Finished flag */

/****************************** Forward Declarations **************************/

static int initWebs(int demo);
static int aspTest(int eid, webs_t wp, int argc, char_t **argv);
static void formTest(webs_t wp, char_t *path, char_t *query);
static int websHomePageHandler(webs_t wp, char_t *urlPrefix, char_t *webDir,
							   int arg, char_t *url, char_t *path, char_t *query);
static void sigintHandler(int);
#ifdef B_STATS
static void printMemStats(int handle, char_t *fmt, ...);
static void memLeaks();
#endif
//////////////////////////////////////////////////////////////////////////////
static char data_buffer[40 * 1024] = {0};
static int ethAspGetAll(int eid, webs_t wp, int argc, char_t **argv);
static void ethFormPost(webs_t wp, char_t *path, char_t *query);
static int trunkAspGetEth(int eid, webs_t wp, int argc, char_t **argv);
static int trunkAspGetALl(int eid, webs_t wp, int argc, char_t **argv);
static void trunkFormPost(webs_t wp, char_t *path, char_t *query);
static void trunkFormDelete(webs_t wp, char_t *path, char_t *query);

static int vlanAspGetAll(int eid, webs_t wp, int argc, char_t **argv);
static int vlanAspGetTrunk(int eid, webs_t wp, int argc, char_t **argv);
static void vlanFormPost(webs_t wp, char_t *path, char_t *query);
static void vlanFormDelete(webs_t wp, char_t *path, char_t *query);

static int stpAspGetType(int eid, webs_t wp, int argc, char_t **argv);
static int stpAspGetVlan(int eid, webs_t wp, int argc, char_t **argv);
static int stpAspGetEth(int eid, webs_t wp, int argc, char_t **argv);
static int stpAspGetVlanDetail(int eid, webs_t wp, int argc, char_t **argv);
static int stpCstGetEnable(int eid, webs_t wp, int argc, char_t **argv);
static void stpFormType(webs_t wp, char_t *path, char_t *query);
static void stpFormEnable(webs_t wp, char_t *path, char_t *query);
static void stpFormCstEnable(webs_t wp, char_t *path, char_t *query);

static int igmpAspGetAll(int eid, webs_t wp, int argc, char_t **argv);
static int igmpAspGetEth(int eid, webs_t wp, int argc, char_t **argv);
static void igmpFormPost(webs_t wp, char_t *path, char_t *query);

static int upgradeHandler(webs_t wp, char_t *urlPrefix, char_t *webDir, int arg,
						  char_t *url, char_t *path, char_t *query);
static void sysSaveConfig(webs_t wp, char_t *path, char_t *query);
static void sysRestore(webs_t wp, char_t *path, char_t *query);
static void sysReboot(webs_t wp, char_t *path, char_t *query);
static void sysLogDownLoad(webs_t wp, char_t *path, char_t *query);
static void sysLogClear(webs_t wp, char_t *path, char_t *query);

static int ripAspGetAll(int eid, webs_t wp, int argc, char_t **argv);
static int ripAspGetAllRoute(int eid, webs_t wp, int argc, char_t **argv);
static int ripAspGetInfo(int eid, webs_t wp, int argc, char_t **argv);
static int ripAspGetStatus(int eid, webs_t wp, int argc, char_t **argv);
static void ripFormEnable(webs_t wp, char_t *path, char_t *query);
static void ripFormPost(webs_t wp, char_t *path, char_t *query);
static void ripFormDelete(webs_t wp, char_t *path, char_t *query);
static void ripFormRedis(webs_t wp, char_t *path, char_t *query);

static int ospfAspGetAll(int eid, webs_t wp, int argc, char_t **argv);
static int ospfAspGetInfo(int eid, webs_t wp, int argc, char_t **argv);
static void ospfFormEnable(webs_t wp, char_t *path, char_t *query);
static void ospfFormPost(webs_t wp, char_t *path, char_t *query);
static void ospfFormDelete(webs_t wp, char_t *path, char_t *query);

static int staticAspGetAll(int eid, webs_t wp, int argc, char_t **argv);
static void staticFormPost(webs_t wp, char_t *path, char_t *query);
static void staticFormDelete(webs_t wp, char_t *path, char_t *query);

/*********************************** Code *************************************/
/*
 *	Main -- entry point from LINUX
 */

int webs_main()
{
	int demo = 0;

	/*
 *	Initialize the memory allocator. Allow use of malloc and start 
 *	with a 60K heap.  For each page request approx 8KB is allocated.
 *	60KB allows for several concurrent page requests.  If more space
 *	is required, malloc will be used for the overflow.
 */
	bopen(NULL, (60 * 1024), B_USE_MALLOC);
	//signal(SIGPIPE, SIG_IGN);
	//signal(SIGINT, sigintHandler);
	//signal(SIGTERM, sigintHandler);

	/*
 *	Initialize the web server
 */
	if (initWebs(demo) < 0)
	{
		return -1;
	}

#ifdef WEBS_SSL_SUPPORT
	websSSLOpen();
/*	websRequireSSL("/"); */ /* Require all files be served via https */
#endif

	/*
 *	Basic event loop. SocketReady returns true when a socket is ready for
 *	service. SocketSelect will block until an event occurs. SocketProcess
 *	will actually do the servicing.
 */
	finished = 0;
	while (!finished)
	{
		if (socketReady(-1) || socketSelect(-1, 1000))
		{
			socketProcess(-1);
		}
		websCgiCleanup();
		emfSchedProcess();
	}

#ifdef WEBS_SSL_SUPPORT
	websSSLClose();
#endif

#ifdef USER_MANAGEMENT_SUPPORT
	umClose();
#endif

	/*
 *	Close the socket module, report memory leaks and close the memory allocator
 */
	websCloseServer();
	socketClose();
#ifdef B_STATS
	memLeaks();
#endif
	bclose();
	return 0;
}

void webs_init()
{
	pthread_t webstid;
	pthread_create(&webstid, NULL, webs_main, NULL);
}

/*
 *	Exit cleanly on interrupt
 */
static void sigintHandler(int unused)
{
	finished = 1;
}

/******************************************************************************/
/*
 *	Initialize the web server.
 */

static int initWebs(int demo)
{
	struct hostent *hp;
	struct in_addr intaddr;
	char host[128], dir[128], webdir[128];
	char *cp;
	char_t wbuf[128];

	/*
 *	Initialize the socket subsystem
 */
	socketOpen();

#ifdef USER_MANAGEMENT_SUPPORT
	/*
 *	Initialize the User Management database
 */
	umOpen();
	umRestore(T("umconfig.txt"));
#endif

	/*
 *	Define the local Ip address, host name, default home page and the 
 *	root web directory.
 */
	if (gethostname(host, sizeof(host)) < 0)
	{
		error(E_L, E_LOG, T("Can't get hostname"));
		return -1;
	}
#if 0
	if ((hp = gethostbyname(host)) == NULL) {
		error(E_L, E_LOG, T("Can't get host address"));
		return -1;
	}
	memcpy((char *) &intaddr, (char *) hp->h_addr_list[0],
		(size_t) hp->h_length);
#endif

	intaddr.s_addr = 0;

	/*
 *	Set ../web as the root web. Modify this to suit your needs
 *	A "-demo" option to the command line will set a webdemo root
 */
	getcwd(dir, sizeof(dir));
	if ((cp = strrchr(dir, '/')))
	{
		*cp = '\0';
	}
	if (demo)
	{
		sprintf(webdir, "%s/%s", dir, demoWeb);
	}
	else
	{
		sprintf(webdir, "%s/%s", dir, rootWeb);
	}

	/*
 *	Configure the web server options before opening the web server
 */
	websSetDefaultDir(webdir);
	cp = inet_ntoa(intaddr);
	ascToUni(wbuf, cp, min(strlen(cp) + 1, sizeof(wbuf)));
	websSetIpaddr(wbuf);
	ascToUni(wbuf, host, min(strlen(host) + 1, sizeof(wbuf)));
	websSetHost(wbuf);

	/*
 *	Configure the web server options before opening the web server
 */
	websSetDefaultPage(T("default.asp"));
	websSetPassword(password);

	/* 
 *	Open the web server on the given port. If that port is taken, try
 *	the next sequential port for up to "retries" attempts.
 */
	websOpenServer(port, retries);

	/*
 * 	First create the URL handlers. Note: handlers are called in sorted order
 *	with the longest path handler examined first. Here we define the security 
 *	handler, forms handler and the default web page handler.
 */
	websUrlHandlerDefine(T(""), NULL, 0, websSecurityHandler,
						 WEBS_HANDLER_FIRST);
	websUrlHandlerDefine(T("/goform"), NULL, 0, websFormHandler, 0);
	websUrlHandlerDefine(T("/cgi-bin"), NULL, 0, websCgiHandler, 0);
	websUrlHandlerDefine(T(""), NULL, 0, websDefaultHandler,
						 WEBS_HANDLER_LAST);

	/*
 *	Now define two test procedures. Replace these with your application
 *	relevant ASP script procedures and form functions.
 */
	websAspDefine(T("aspTest"), aspTest);
	websFormDefine(T("formTest"), formTest);

	websAspDefine(T("ethAspGetAll"), ethAspGetAll);
	websFormDefine(T("ethFormPost"), ethFormPost);

	websAspDefine(T("trunkAspGetEth"), trunkAspGetEth);
	websAspDefine(T("trunkAspGetALl"), trunkAspGetALl);
	websFormDefine(T("trunkFormPost"), trunkFormPost);
	websFormDefine(T("trunkFormDelete"), trunkFormDelete);

	websAspDefine(T("vlanAspGetAll"), vlanAspGetAll);
	websAspDefine(T("vlanAspGetTrunk"), vlanAspGetTrunk);
	websFormDefine(T("vlanFormPost"), vlanFormPost);
	websFormDefine(T("vlanFormDelete"), vlanFormDelete);

	websAspDefine(T("stpAspGetType"), stpAspGetType);
	websAspDefine(T("stpAspGetVlan"), stpAspGetVlan);
	websAspDefine(T("stpAspGetEth"), stpAspGetEth);
	websAspDefine(T("stpAspGetVlanDetail"), stpAspGetVlanDetail);
	websAspDefine(T("stpCstGetEnable"), stpCstGetEnable);
	websFormDefine(T("stpFormType"), stpFormType);
	websFormDefine(T("stpFormEnable"), stpFormEnable);
	websFormDefine(T("stpFormCstEnable"), stpFormCstEnable);

	websAspDefine(T("igmpAspGetAll"), igmpAspGetAll);
	websAspDefine(T("igmpAspGetEth"), igmpAspGetEth);
	websFormDefine(T("igmpFormPost"), igmpFormPost);

	websUrlHandlerDefine(T("/ajax"), NULL, 0, upgradeHandler, 0);
	websFormDefine(T("sysSaveConfig"), sysSaveConfig);
	websFormDefine(T("sysRestore"), sysRestore);
	websFormDefine(T("sysReboot"), sysReboot);
	websFormDefine(T("sysLogDownLoad"), sysLogDownLoad);
	websFormDefine(T("sysLogClear"), sysLogClear);

	websAspDefine(T("ripAspGetAll"), ripAspGetAll);
	websAspDefine(T("ripAspGetAllRoute"), ripAspGetAllRoute);
	websAspDefine(T("ripAspGetInfo"), ripAspGetInfo);
	websAspDefine(T("ripAspGetStatus"), ripAspGetStatus);
	websFormDefine(T("ripFormEnable"), ripFormEnable);
	websFormDefine(T("ripFormPost"), ripFormPost);
	websFormDefine(T("ripFormDelete"), ripFormDelete);
	websFormDefine(T("ripFormRedis"), ripFormRedis);

	websAspDefine(T("ospfAspGetAll"), ospfAspGetAll);
	websAspDefine(T("ospfAspGetInfo"), ospfAspGetInfo);
	websFormDefine(T("ospfFormEnable"), ospfFormEnable);
	websFormDefine(T("ospfFormPost"), ospfFormPost);
	websFormDefine(T("ospfFormDelete"), ospfFormDelete);

	websAspDefine(T("staticAspGetAll"), staticAspGetAll);
	websFormDefine(T("staticFormPost"), staticFormPost);
	websFormDefine(T("staticFormDelete"), staticFormDelete);
/*
 *	Create the Form handlers for the User Management pages
 */
#ifdef USER_MANAGEMENT_SUPPORT
	formDefineUserMgmt();
#endif

	/*
 *	Create a handler for the default home page
 */
	websUrlHandlerDefine(T("/"), NULL, 0, websHomePageHandler, 0);
	return 0;
}

/******************************************************************************/
/*
 *	Test Javascript binding for ASP. This will be invoked when "aspTest" is
 *	embedded in an ASP page. See web/asp.asp for usage. Set browser to 
 *	"localhost/asp.asp" to test.
 */

static int aspTest(int eid, webs_t wp, int argc, char_t **argv)
{
	char_t *name, *address;

	if (ejArgs(argc, argv, T("%s %s"), &name, &address) < 2)
	{
		websError(wp, 400, T("Insufficient args\n"));
		return -1;
	}
	return websWrite(wp, T("Name: %s, Address %s"), name, address);
}

/******************************************************************************/
/*
 *	Test form for posted data (in-memory CGI). This will be called when the
 *	form in web/forms.asp is invoked. Set browser to "localhost/forms.asp" to test.
 */

static void formTest(webs_t wp, char_t *path, char_t *query)
{
	char_t *name, *address;

	name = websGetVar(wp, T("name"), T("Joe Smith"));
	address = websGetVar(wp, T("address"), T("1212 Milky Way Ave."));

	websHeader(wp);
	websWrite(wp, T("<body><h2>Name: %s, Address: %s</h2>\n"), name, address);
	websFooter(wp);
	websDone(wp, 200);
}

/******************************************************************************/
/*
 *	Home page handler
 */

static int websHomePageHandler(webs_t wp, char_t *urlPrefix, char_t *webDir,
							   int arg, char_t *url, char_t *path, char_t *query)
{
	/*
 *	If the empty or "/" URL is invoked, redirect default URLs to the home page
 */
	if (*url == '\0' || gstrcmp(url, T("/")) == 0)
	{
		websRedirect(wp, WEBS_DEFAULT_HOME);
		return 1;
	}
	return 0;
}

/******************************************************************************/

#ifdef B_STATS
static void memLeaks()
{
	int fd;

	if ((fd = gopen(T("leak.txt"), O_CREAT | O_TRUNC | O_WRONLY, 0666)) >= 0)
	{
		bstats(fd, printMemStats);
		close(fd);
	}
}

/******************************************************************************/
/*
 *	Print memory usage / leaks
 */

static void printMemStats(int handle, char_t *fmt, ...)
{
	va_list args;
	char_t buf[256];

	va_start(args, fmt);
	vsprintf(buf, fmt, args);
	va_end(args);
	write(handle, buf, strlen(buf));
}
#endif

/******************************************************************************/

static int ethAspGetAll(int eid, webs_t wp, int argc, char_t **argv)
{
	memset(data_buffer, 0, sizeof(data_buffer));
	web_eth_get_all(data_buffer);

	return websWrite(wp, T("%s"), data_buffer);
}

static void ethFormPost(webs_t wp, char_t *path, char_t *query)
{
	char_t *hNo, *hDes, *hStatus, *hStatusTxt, *hPvid, *hRate, *hRateTxt, *hFlow, *hMtu;

	hNo = websGetVar(wp, T("hNo"), T("portNo"));
	hDes = websGetVar(wp, T("hDes"), T("hDes"));
	hStatus = websGetVar(wp, T("hStatus"), T("hStatus"));
	hStatusTxt = websGetVar(wp, T("hStatusTxt"), T("hStatusTxt"));
	hPvid = websGetVar(wp, T("hPvid"), T("hPvid"));
	hRate = websGetVar(wp, T("hRate"), T("hRate"));
	hRateTxt = websGetVar(wp, T("hRateTxt"), T("hRateTxt"));
	hFlow = websGetVar(wp, T("hFlow"), T("hFlow"));
	hMtu = websGetVar(wp, T("hMtu"), T("hMtu."));

	web_eth_set_single(hNo, hDes, hStatus, hStatusTxt, hPvid, hRate, hRateTxt, hFlow, hMtu);

	websRedirect(wp, "interface/eth.asp");
}
#pragma region trunk页面
/*
获取所有端口
获取所有trunk详细信息
新增或编辑一行
删除一行
*/
static int trunkAspGetEth(int eid, webs_t wp, int argc, char_t **argv)
{
	memset(data_buffer, 0, sizeof(data_buffer));
	web_sys_get_alleth(data_buffer);

	return websWrite(wp, T("%s"), data_buffer);
}
static int trunkAspGetALl(int eid, webs_t wp, int argc, char_t **argv)
{
	memset(data_buffer, 0, sizeof(data_buffer));
	web_trunk_get_all(data_buffer);

	return websWrite(wp, T("%s"), data_buffer);
}
static void trunkFormPost(webs_t wp, char_t *path, char_t *query)
{
	char_t *hNo, *hDes, *hManStatus, *hOperStatus, *hPvid, *hStrategy, *hMtu, *hGroup;
	hNo = websGetVar(wp, T("hNo"), T("1"));
	hDes = websGetVar(wp, T("hDes"), T("hDes"));
	hManStatus = websGetVar(wp, T("hManStatus"), T("1"));
	hOperStatus = websGetVar(wp, T("hOperStatus"), T("1"));
	hPvid = websGetVar(wp, T("hPvid"), T("222"));
	hStrategy = websGetVar(wp, T("hStrategy"), T("1"));
	hMtu = websGetVar(wp, T("hMtu"), T("123"));
	hGroup = websGetVar(wp, T("hGroup"), T("hGroup"));

	web_trunk_set_single(hNo, hDes, hManStatus, hOperStatus, hStrategy, hPvid, hMtu, hGroup);

	websRedirect(wp, "interface/trunk.asp");
}
static void trunkFormDelete(webs_t wp, char_t *path, char_t *query)
{
	char_t *hId;
	hId = websGetVar(wp, T("hId"), T("1"));
	web_trunk_delete(hId);

	websRedirect(wp, "interface/trunk.asp");
}
#pragma endregion

#pragma region vlan
static int vlanAspGetAll(int eid, webs_t wp, int argc, char_t **argv)
{
	memset(data_buffer, 0, sizeof(data_buffer));
	web_vlan_get_all(data_buffer);

	return websWrite(wp, T("%s"), data_buffer);
}

static int vlanAspGetTrunk(int eid, webs_t wp, int argc, char_t **argv)
{
	memset(data_buffer, 0, sizeof(data_buffer));
	web_sys_get_alltrunk(data_buffer);

	return websWrite(wp, T("%s"), data_buffer);
}

static void vlanFormPost(webs_t wp, char_t *path, char_t *query)
{
	char_t *hId, *hDes, *hType, *hStatus, *hEthGroup, *hTrunkGroup;
	hId = websGetVar(wp, T("hId"), T("1"));
	hDes = websGetVar(wp, T("hDes"), T("1"));
	hType = websGetVar(wp, T("hType"), T("1"));
	hStatus = websGetVar(wp, T("hStatus"), T("1"));
	hEthGroup = websGetVar(wp, T("hEthGroup"), T("1"));
	hTrunkGroup = websGetVar(wp, T("hTrunkGroup"), T("1"));

	web_vlan_set_single(hId, hType, hDes, hStatus, hEthGroup, hTrunkGroup);
	websRedirect(wp, "interface/vlan.asp");
}
static void vlanFormDelete(webs_t wp, char_t *path, char_t *query)
{
	char_t *hId;
	hId = websGetVar(wp, T("hId"), T("1"));

	web_vlan_delete(hId);
	websRedirect(wp, "interface/vlan.asp");
}
#pragma endregion

#pragma region stp
static int stpAspGetType(int eid, webs_t wp, int argc, char_t **argv)
{
	memset(data_buffer, 0, sizeof(data_buffer));
	web_stp_get_mode(data_buffer);
	return websWrite(wp, T("%s"), data_buffer);
}

static int stpAspGetVlan(int eid, webs_t wp, int argc, char_t **argv)
{
	memset(data_buffer, 0, sizeof(data_buffer));
	web_stp_get_pvst_vlan_list(data_buffer);
	return websWrite(wp, T("%s"), data_buffer);
}

static int stpAspGetEth(int eid, webs_t wp, int argc, char_t **argv)
{
	memset(data_buffer, 0, sizeof(data_buffer));
	web_stp_get_pvst_vlan_detail(data_buffer);

	return websWrite(wp, T("%s"), data_buffer);
}

static int stpAspGetVlanDetail(int eid, webs_t wp, int argc, char_t **argv)
{
	memset(data_buffer, 0, sizeof(data_buffer));
	web_stp_get_pvst_vlan_outlook(data_buffer);
	return websWrite(wp, T("%s"), data_buffer);
}

static void stpFormType(webs_t wp, char_t *path, char_t *query)
{
	char_t *hType;
	hType = websGetVar(wp, T("hType"), T("1"));
	STP_Mode_Selected(atoi(hType));
	websRedirect(wp, "interface/stp.asp");
}

static void stpFormEnable(webs_t wp, char_t *path, char_t *query)
{
	char_t *hId, *hEnable;
	hId = websGetVar(wp, T("hId"), T("1"));
	hEnable = websGetVar(wp, T("hEnable"), T("0"));

	if (atoi(hEnable) == 1)
	{
		STP_Pvst_CreateOnVlan(atoi(hId));
	}
	else
	{
		STP_Pvst_DeleteOnVlan(atoi(hId));
	}
	STP_Pvst_Vlan_enable(atoi(hId), atoi(hEnable));

	websRedirect(wp, "interface/stp.asp");
}
static int stpCstGetEnable(int eid, webs_t wp, int argc, char_t **argv)
{
	int enable = 0;
	STP_Cst_Get_Enable(&enable);

	return websWrite(wp, T("%d"), enable);
}
static void stpFormCstEnable(webs_t wp, char_t *path, char_t *query)
{
	char_t *hEnable;
	hEnable = websGetVar(wp, T("hCstEnable"), T("0"));

	STP_Cst_Enable(atoi(hEnable));
	websRedirect(wp, "interface/stp.asp");
}

#pragma endregion
#pragma region igmp
static int igmpAspGetAll(int eid, webs_t wp, int argc, char_t **argv)
{
	memset(data_buffer, 0, sizeof(data_buffer));
	web_l2igmp_get_var(data_buffer);
	return websWrite(wp, T("%s"), data_buffer);
}
static int igmpAspGetEth(int eid, webs_t wp, int argc, char_t **argv)
{
	memset(data_buffer, 0, sizeof(data_buffer));
	web_l2igmp_get_allentry(data_buffer);
	return websWrite(wp, T("%s"), data_buffer);
}
static void igmpFormPost(webs_t wp, char_t *path, char_t *query)
{
	char_t *hStatus, *hAging, *hFast;
	hStatus = websGetVar(wp, T("hStatus"), T("1"));
	hAging = websGetVar(wp, T("hAging"), T("0"));
	hFast = websGetVar(wp, T("hFast"), T("0"));
	printf("\r\n %s,%s,%s\r\n", hStatus, hAging, hFast);
	sleep(1);

	web_l2igmp_set_var(hStatus, hAging, hFast);
	websRedirect(wp, "interface/igmp.asp");
}
#pragma endregion

#pragma region system
static int upgradeHandler(webs_t wp, char_t *urlPrefix, char_t *webDir, int arg,
						  char_t *url, char_t *path, char_t *query)
{
	printf("\r\n %s \r\n", "before ajax");
	websWrite(wp, T("%s"), "this is a test");
	printf("\r\n %s \r\n", "after ajax");
	websDone(wp, 200);
	return 1;
}
static void sysSaveConfig(webs_t wp, char_t *path, char_t *query)
{
}

static void sysRestore(webs_t wp, char_t *path, char_t *query)
{
}

static void sysReboot(webs_t wp, char_t *path, char_t *query)
{
}

static void sysLogDownLoad(webs_t wp, char_t *path, char_t *query)
{
}

static void sysLogClear(webs_t wp, char_t *path, char_t *query)
{
}

#pragma endregion

#pragma region L3Protocal
static int ripAspGetAll(int eid, webs_t wp, int argc, char_t **argv)
{
	memset(data_buffer, 0, sizeof(data_buffer));
	rip_get_networks(data_buffer);
	return websWrite(wp, T("%s"), data_buffer);
}

static int ripAspGetAllRoute(int eid, webs_t wp, int argc, char_t **argv)
{
	memset(data_buffer, 0, sizeof(data_buffer));
	rip_show_all(data_buffer);
	return websWrite(wp, T("%s"), data_buffer);
}

static int ripAspGetStatus(int eid, webs_t wp, int argc, char_t **argv)
{
	int res = rip_get_enable();
	return websWrite(wp, T("%d"), res);
}

static int ripAspGetInfo(int eid, webs_t wp, int argc, char_t **argv)
{
	memset(data_buffer, 0, sizeof(data_buffer));
	rip_show_status(data_buffer);
	return websWrite(wp, T("%s"), data_buffer);
}

static void ripFormEnable(webs_t wp, char_t *path, char_t *query)
{
	char_t *hEnable;
	hEnable = websGetVar(wp, T("hEnable"), T("1"));
	printf("\r\n enable= %s\r\n", hEnable);
	rip_set_enable(atoi(hEnable));
	websRedirect(wp, "L3Protocal/rip.asp");
}

static void ripFormPost(webs_t wp, char_t *path, char_t *query)
{
	char_t *hRoute;
	hRoute = websGetVar(wp, T("hNetwork"), T("1"));
	printf("\r\n route= %s\r\n", hRoute);
	rip_set_add_network(hRoute);
	websRedirect(wp, "L3Protocal/rip.asp");
}

static void ripFormDelete(webs_t wp, char_t *path, char_t *query)
{
	char_t *hRoute;
	hRoute = websGetVar(wp, T("hDelete"), T("1"));
	printf("\r\n route= %s\r\n", hRoute);
	rip_set_delete_network(hRoute);
	websRedirect(wp, "L3Protocal/rip.asp");
}

static void ripFormRedis(webs_t wp, char_t *path, char_t *query)
{
	char_t *hRedis;
	hRedis= websGetVar(wp, T("hRedis"), T("1"));
	printf("\r\n route= %s\r\n", hRedis);
	rip_set_redistribute(hRedis);
	websRedirect(wp, "L3Protocal/rip.asp");
}

static int ospfAspGetAll(int eid, webs_t wp, int argc, char_t **argv)
{
}

static int ospfAspGetInfo(int eid, webs_t wp, int argc, char_t **argv)
{
}

static void ospfFormEnable(webs_t wp, char_t *path, char_t *query)
{
}

static void ospfFormPost(webs_t wp, char_t *path, char_t *query)
{
}

static void ospfFormDelete(webs_t wp, char_t *path, char_t *query)
{
}
//
static int staticAspGetAll(int eid, webs_t wp, int argc, char_t **argv)
{
}

static void staticFormPost(webs_t wp, char_t *path, char_t *query)
{
}

static void staticFormDelete(webs_t wp, char_t *path, char_t *query)
{
}
#pragma endregion
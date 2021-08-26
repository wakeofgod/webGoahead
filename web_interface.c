#include "zebra.h"
#include "vifDefs.h"

#include "vifPhy.h"
#include "vifTrunk.h"
#include "vifVlan.h"

static int eth_info_to_string(int phyUnit, char *pBuff)
{
    int len = 0, val = 0;
    PHY_OBJ *pObj;

    pObj = (PHY_OBJ *)phyifFindByUnit(phyUnit);

    vifGetPortCurDuplexSpeed(phyUnit, &val);

    len = sprintf(pBuff, "%s ,%s, %d, %d, %d, %d, %d, %d ,%d | ",
                  pObj->phy_name,
                  pObj->phy_cfgData.cfg_ifDescr,
                  pObj->phy_cfgData.cfg_ifAdminStatus,
                  pObj->phy_opera,
                  pObj->phy_cfgData.cfg_ifPvid,
                  pObj->phy_cfgData.cfg_ifSpeedDupLex,
                  val,
                  pObj->phy_cfgData.cfg_ifFlowCtrl,
                  pObj->phy_cfgData.cfg_ifMtu);
    return len;
}

int web_eth_get_all(char *strBufAll)
{
    int i, rc = 0;
    int count = 0, totoalLen = 0;
    int phyUnit, phyNextUnit;

    char *szPortInfo[128] = {0};

    rc = phyifGetFirstIndex(&phyUnit);
    if (rc == -1)
        return 0;

    for (i = 0; i < 128; i++)
        szPortInfo[i] = malloc(1024);

    totoalLen += eth_info_to_string(phyUnit, szPortInfo[count]);
    count++;

    do
    {
        rc = phyifGetNextIndex(phyUnit, &phyNextUnit);
        if (rc == -1)
        {
            for (i = 0; i < count; i++)
                strcat(strBufAll, szPortInfo[i]);

            for (i = 0; i < 128; i++)
                free(szPortInfo[i]);
            return totoalLen;
        }
        totoalLen += eth_info_to_string(phyNextUnit, szPortInfo[count]);
        count++;
        phyUnit = phyNextUnit;
    } while (1);
}

int web_eth_set_single(char *hNo, char *hDes, char *hStatus, char *hStatusTxt, char *hPvid,
                       char *hRate, char *hRateTxt, char *hFlow, char *hMtu)
{
    int rc = 0, phyUnit = 0;
    PHY_OBJ *pObj;

    rc = vifGetUnitFromName(hNo, &phyUnit);
    if (rc == -1)
        return -1;

    pObj = (PHY_OBJ *)phyifFindByUnit(phyUnit);
    if (pObj == NULL)
        return -1;

    strcpy(pObj->phy_cfgData.cfg_ifDescr, hDes);

    phyifCmdHandler(phyUnit, HANDLE_CMD_SET, m_ifAdminStatus, atoi(hStatus) == 1 ? 1 : 2);
    phyifCmdHandler(phyUnit, HANDLE_CMD_SET, m_ifOperateStatus, atoi(hStatusTxt) == 1 ? 1 : 2);
    phyifCmdHandler(phyUnit, HANDLE_CMD_SET, m_ifPvid, atoi(hPvid));
    phyifCmdHandler(phyUnit, HANDLE_CMD_SET, m_ifSpeedDupLex, atoi(hRate));
    phyifCmdHandler(phyUnit, HANDLE_CMD_SET, m_ifFlowCtrl, atoi(hFlow));
    phyifCmdHandler(phyUnit, HANDLE_CMD_SET, m_ifMtu, atoi(hMtu));

    return 0;
}

static int trunk_info_to_string(int trunkUnit, char *pBuff)
{
    int i, len = 0, count = 0, pdata[8] = {0};
    char eth_str[128] = {0};
    TRUNK_OBJ *pObj;

    pObj = (TRUNK_OBJ *)trunkifFindByUnit(trunkUnit);

    len = sprintf(pBuff, "%s, %s, %d, %d, %d, %d, %d, ",
                  pObj->trunk_name,
                  pObj->trunk_cfgData.cfg_ifDescr,
                  pObj->trunk_cfgData.cfg_ifAdminStatus,
                  pObj->trunk_opera,
                  pObj->trunk_psc,
                  pObj->trunk_cfgData.cfg_ifPvid,
                  pObj->trunk_cfgData.cfg_ifMtu);
    count = vifGetTrunkMember(trunkUnit, pdata);

    for (i = 0; i < count; i++)
    {
        strcat(eth_str, (char *)vifGetl2ifName(pdata[i]));
        strcat(eth_str, "*");
    }

    strcat(eth_str, "|");

    sprintf(pBuff + len, "%s", eth_str);
    return (len + strlen(eth_str));
}

int web_trunk_get_all(char *strBufAll)
{
    int i, rc = 0;
    int count = 0, totoalLen = 0;
    int trunkUnit, trunkNextUnit;

    char *szPortInfo[8] = {0};

    rc = trunkifGetFirstIndex(&trunkUnit);
    if (rc == -1)
        return 0;

    for (i = 0; i < 8; i++)
        szPortInfo[i] = malloc(1024);

    totoalLen += trunk_info_to_string(trunkUnit, szPortInfo[count]);
    count++;

    do
    {
        rc = trunkifGetNextIndex(trunkUnit, &trunkNextUnit);
        if (rc == -1)
        {
            for (i = 0; i < count; i++)
                strcat(strBufAll, szPortInfo[i]);

            for (i = 0; i < 8; i++)
                free(szPortInfo[i]);
            return totoalLen;
        }
        totoalLen += trunk_info_to_string(trunkNextUnit, szPortInfo[count]);
        count++;
        trunkUnit = trunkNextUnit;
    } while (1);
}

int web_trunk_delete(char *trunkName)
{
    int rc = 0, trunkid;

    trunkid = atoi(trunkName + 5);
    rc = trunkifDestroy(trunkid);
    return rc;
}

static int web_get_eth_list(char *eth_list, int *pdata)
{
    int rc, count = 0, phyUnit = 0;
    char *delim = ",";
    char *p = strtok(eth_list, delim);

    while (p != NULL)
    {
        rc = vifGetUnitFromName(p, &phyUnit);
        if (rc == -1)
            continue;

        pdata[count++] = phyUnit;

        p = strtok(NULL, delim);
    }

    return count;
}

int web_trunk_set_single(char *hNo, char *hDes, char *hStatus, char *hStatusTxt, char *psc, char *hPvid,
                         char *hMtu, char *eth_list)
{
    int rc = 0, trunkUnit = 0, trunkid = 0;
    TRUNK_OBJ *pObj;
    int i, count, pdata[64] = {0};

    rc = vifGetUnitFromName(hNo, &trunkUnit);
    if (rc == -1)
        return -1;

    vifGetTrunkIdFromUnit(trunkUnit, &trunkid);

    pObj = (TRUNK_OBJ *)trunkifFindByUnit(trunkUnit);
    if (pObj == NULL)
    {
        rc = trunkifCreate(trunkid);
        if (rc == -1)
            return -1;
    }

    pObj = (TRUNK_OBJ *)trunkifFindByUnit(trunkUnit);
    strcpy(pObj->trunk_cfgData.cfg_ifDescr, hDes);

    trunkifCmdHandler(trunkUnit, HANDLE_CMD_SET, m_ifAdminStatus, atoi(hStatus) == 1 ? 1 : 2);

    //trunkifCmdHandler(trunkUnit, HANDLE_CMD_SET, m_ifOperateStatus, atoi(hStatusTxt) == 1? 1:2);
    trunkifCmdHandler(trunkUnit, HANDLE_CMD_SET, m_agPsc, atoi(psc));
    trunkifCmdHandler(trunkUnit, HANDLE_CMD_SET, m_ifPvid, atoi(hPvid));
    trunkifCmdHandler(trunkUnit, HANDLE_CMD_SET, m_ifMtu, atoi(hMtu));

    count = vifGetTrunkMember(trunkUnit, pdata);
    for (i = 0; i < count; i++)
        phyifCmdHandler(pdata[i], HANDLE_CMD_SET, m_ifQuitTrunk, (void *)trunkid);

    memset(pdata, 0, sizeof(pdata));
    count = web_get_eth_list(eth_list, pdata);
    for (i = 0; i < count; i++)
    {
        phyifCmdHandler(pdata[i], HANDLE_CMD_SET, m_ifJoinTrunk, (void *)trunkid);
    }

    return 0;
}

int web_sys_get_alleth(char *strBufAll)
{
    int i, rc = 0;
    int count = 0, pdata[64];
    int phyUnit, phyNextUnit;
    char ethBuff[1024] = {0};

    rc = phyifGetFirstIndex(&phyUnit);
    while (rc == 0)
    {
        pdata[count++] = phyUnit;
        rc = phyifGetNextIndex(phyUnit, &phyNextUnit);
        phyUnit = phyNextUnit;
    }

    for (i = 0; i < count; i++)
    {
        strcat(ethBuff, (char *)vifGetl2ifName(pdata[i]));
        strcat(ethBuff, "*");
    }

    strcpy(strBufAll, ethBuff);
    return strlen(ethBuff);
}

int web_sys_get_alltrunk(char *strBufAll)
{
    int i, rc = 0;
    int count = 0, pdata[64];
    int trunkUnit, trunkNextUnit;
    char ethBuff[1024] = {0};

    rc = trunkifGetFirstIndex(&trunkUnit);
    while (rc == 0)
    {
        pdata[count++] = trunkUnit;
        rc = trunkifGetNextIndex(trunkUnit, &trunkNextUnit);
        trunkUnit = trunkNextUnit;
    }

    for (i = 0; i < count; i++)
    {
        strcat(ethBuff, (char *)vifGetl2ifName(pdata[i]));
        strcat(ethBuff, "*");
    }

    strcpy(strBufAll, ethBuff);
    return strlen(ethBuff);
}

static int vlan_info_to_string(int vlanUnit, char *pBuff)
{
    int i, countall = 0;
    int all_buf[64] = {0};

    char phyBuf[256] = {0};
    char trunkBuf[128] = {0};

    int vid;
    VLAN_OBJ *pObj;

    vifGetVidFromUnit(vlanUnit, &vid);

    pObj = (VLAN_OBJ *)vlanifFindByUnit(vlanUnit);

    sprintf(pBuff, "%s, %d, %s, %d, ",
            pObj->vlan_name,
            pObj->vlan_type,
            pObj->vlan_description,
            pObj->vlan_opera);

    memset(all_buf, 0, sizeof(all_buf));
    countall = vlanifCmdHandler(vlanUnit, HANDLE_CMD_GET, m_swMemberAll, (void *)all_buf);

    memset(phyBuf, 0, sizeof(phyBuf));
    for (i = 0; i < countall; i++)
    {
        int tag = 0;
        if (!vifIsPhyPort(all_buf[i]))
            continue;

        strcat(phyBuf, (char *)vifGetl2ifName(all_buf[i]));

        vifPhyInVlan(all_buf[i], vid, &tag);

        if (tag)
            strcat(phyBuf, "-t");
        else
            strcat(phyBuf, "-u");

        strcat(phyBuf, "*");
    }

    memset(trunkBuf, 0, sizeof(trunkBuf));
    for (i = 0; i < countall; i++)
    {
        int tag = 0;
        if (!vifIsTrunkPort(all_buf[i]))
            continue;

        strcat(trunkBuf, (char *)vifGetl2ifName(all_buf[i]));

        vifTrunkInVlan(all_buf[i], vid, &tag);

        if (tag)
            strcat(trunkBuf, "-t");
        else
            strcat(trunkBuf, "-u");

        strcat(trunkBuf, "*");
    }

    strcat(pBuff, phyBuf);
    strcat(pBuff, ", ");
    strcat(pBuff, trunkBuf);
    strcat(pBuff, "|");

    return strlen(pBuff);
}

int web_vlan_get_all(char *strBufAll)
{
    int i, rc = 0;
    int count = 0;
    int vlanUnit, vlanNextUnit;

    char *szPortInfo[4096] = {0};

    rc = vlanifGetFirstIndex(&vlanUnit);
    if (rc == -1)
        return 0;

    for (i = 0; i < 4096; i++)
        szPortInfo[i] = malloc(512);

    vlan_info_to_string(vlanUnit, szPortInfo[count]);
    count++;

    do
    {
        rc = vlanifGetNextIndex(vlanUnit, &vlanNextUnit);
        if (rc == -1)
        {
            for (i = 0; i < count; i++)
                strcat(strBufAll, szPortInfo[i]);

            for (i = 0; i < 4096; i++)
            {
                if (szPortInfo[i])
                    free(szPortInfo[i]);
            }

            return strlen(strBufAll);
        }
        vlan_info_to_string(vlanNextUnit, szPortInfo[count]);
        count++;
        vlanUnit = vlanNextUnit;
    } while (1);
}

int web_vlan_delete(char *vlanName)
{
    int rc = 0, vid;

    vid = atoi(vlanName + 4);
    rc = vlanifDestroy(vid);
    return rc;
}

typedef struct
{
    int unit;
    int tag;
} WEB_VLAN_PORT;

static int web_parse_eth_attribute(char *port, int *phyUnit, int *tag)
{
    char name[16] = {0};
    char tagch = 0;

    sscanf(port, "%s-%c", name, &tagch);

    vifGetUnitFromName(name, phyUnit);

    if (port[strlen(port) - 1] == 't')
        *tag = 1;
    else
        *tag = 0;

    return 0;
}

static int web_vlan_get_eth_list(char *eth_list, WEB_VLAN_PORT pdata[])
{
    int rc, tag = 0, count = 0, phyUnit = 0;
    char *p, *buff = eth_list;
    char sub[16] = {0};

    p = strsep(&buff, "*");
    while (p != NULL)
    {
        strcpy(sub, p);
        rc = web_parse_eth_attribute(sub, &phyUnit, &tag);

        pdata[count].unit = phyUnit;
        pdata[count].tag = tag;
        count++;

        p = strsep(&buff, "*");
    }

    return count;
}

static web_parse_trunk_attribute(char *port, int *trunkUnit, int *tag)
{
    char name[16] = {0};
    char tagch = 0;

    sscanf(port, "%s-%c", name, &tagch);

     vifGetUnitFromName(name, trunkUnit);

    if (port[strlen(port) - 1] == 't')
        *tag = 1;
    else
        *tag = 0;

    return 0;
}

static int web_vlan_get_trunk_list(char *trunk_list, WEB_VLAN_PORT pdata[])
{
    int rc, tag = 0, count = 0, trunkUnit = 0;
    char *p, *buff = trunk_list;
    char sub[16] = {0};
    p = strsep(&buff, "*");

    while (p != NULL)
    {
        strcpy(sub, p);
        rc = web_parse_trunk_attribute(p, &trunkUnit, &tag);

        pdata[count].unit = trunkUnit;
        pdata[count].tag = tag;
        count++;

        p = strsep(&buff, "*");
    }

    return count;
}

int web_vlan_set_single(char *hNo, char *type, char *hDes, char *hStatus, char *eth_list, char *trunk_list)
{
    int rc = 0;
    VLAN_OBJ *pObj;
    int i, count;
    int vid, vlanUnit;
    WEB_VLAN_PORT pdata[64];

    vid = atoi(hNo + 4);

    vifGetUnitFromVid(vid, &vlanUnit);

    pObj = (VLAN_OBJ *)vlanifFindByUnit(vlanUnit);
    if (pObj == NULL)
    {
        rc = vlanifCreate(vid, 1);
        if (rc == -1)
            return -1;
    }

    pObj = (VLAN_OBJ *)vlanifFindByUnit(vlanUnit);

    strcpy(pObj->vlan_description, hDes);

    memset(pdata, 0, sizeof(pdata));

    count = web_vlan_get_eth_list(eth_list, pdata);
    for (i = 0; i < count; i++)
    {
        rc = vifVlanAddMember(vlanUnit, pdata[i].unit, pdata[i].tag);
    }

    memset(pdata, 0, sizeof(pdata));
    count = web_vlan_get_trunk_list(trunk_list, pdata);
    for (i = 0; i < count; i++)
    {
        rc =  vifVlanAddMember(vlanUnit, pdata[i].unit, pdata[i].tag);
    }

    return 0;
}


typedef struct
{
	int vid;
	int enable;
}pvst_vlan_t;

static int web_stp_get_pvst_vlan(int count, pvst_vlan_t pvid[], int vlanUnit)
{
    int i, vid = 0;

    vifGetVidFromUnit(vlanUnit, &vid);

    for (i=0; i<count; i++)
    {
        if (pvid[i].vid == vid) return pvid[i].enable;       
    }

    return 0;
}

int web_stp_get_mode(char *strBufAll)
{
    sprintf(strBufAll, "%d", STP_GetCurrentSTPMode());
    return strlen(strBufAll);
}

int web_stp_get_pvst_vlan_list(char *strBufAll)
{
    int rc = 0;
    int vlanUnit, vlanNextUnit;
    int count = 0;
    int enable = 0;
    char strBuf[32] = {0};
    pvst_vlan_t pvlan[64] = {{0}};

    count = STP_Get_PvstStatistic(pvlan);
    
    rc = vlanifGetFirstIndex(&vlanUnit);
    while (rc == 0)
    {
        strcat(strBufAll, (char *)vifGetVlanUnitName(vlanUnit));
        enable = web_stp_get_pvst_vlan(count, pvlan, vlanUnit);
        sprintf(strBuf, "%d | ", enable);
        strcat(strBufAll, strBuf);
        
        rc = vlanifGetNextIndex(vlanUnit, &vlanNextUnit);
        vlanUnit = vlanNextUnit;
    }

    return strlen(strBufAll);
}

int web_stp_get_pvst_vlan_outlook(char *strBufAll)
{
    char vidBuf[8] = {0};
    int count = 0;
    char strBuf[1024] = {0};
    int i;
    pvst_vlan_t  pvid[64] = {{0}};

    count = STP_Get_PvstStatistic(pvid);

    for (i=0; i<count; i++)
    {
        memset(strBuf, 0, sizeof(strBuf));
        STP_Get_pvst_bridge_statistics(pvid[i].vid, strBuf);
        sprintf(vidBuf, "%d, ", pvid[i].vid);
   	 strcat(strBufAll, vidBuf);	
        strcat(strBufAll, strBuf);
        strcat(strBufAll, "|");
    }   
    
    return strlen(strBufAll);
}

int web_stp_get_pvst_vlan_detail(char *strBufAll)
{
    int count = 0;
    char strBuf[4096] = {0}, vidBuf[8];
    int i;
    pvst_vlan_t  pvid[64] = {{0}};

    count = STP_Get_PvstStatistic(pvid);

    for (i=0; i<count; i++)
    {
        memset(strBuf, 0, sizeof(strBuf));
        STP_Get_pvst_bridge_port_statistics(pvid[i].vid, strBuf);

        sprintf(vidBuf, "%d, ", pvid[i].vid);
        strcat(strBufAll, vidBuf);
        strcat(strBufAll, strBuf);
        strcat(strBufAll, "|");
    }   
    
    return strlen(strBufAll);
}

int web_l2igmp_get_var(char *strBufAll)
{
    char strBuf[64] = {0};
    
    sprintf(strBuf, "%d", igmpsnoop_is_enable());
    strcat(strBufAll, strBuf);
    strcat(strBufAll, ",");
    sprintf(strBuf, "%d", igmpsnoop_get_aging());
    strcat(strBufAll, strBuf);
    strcat(strBufAll, ",");
    sprintf(strBuf, "%d", igmpsnoop_get_fastleave());
    strcat(strBufAll, strBuf);
    return strlen(strBufAll);
}

int web_l2igmp_set_var(char *glb, char *aging, char *fastlv)
{
    int value = 0;

    value = atoi(glb);

    if (value) 
    {
    	igmpsnoop_start();
	igmpsnoop_set_enable();
    }
    else 
    {
	igmpsnoop_stop();
	igmpsnoop_set_disable();
    }
		
    value = atoi(aging);
    igmpsnoop_set_aging(value);

    value = atoi(fastlv);
    igmpsnoop_set_fastleave(value);
    
    return 0;
}

int web_l2igmp_get_allentry(char *strBufAll)
{
    vifL2mcGetAll(strBufAll);
    return strlen(strBufAll);
}


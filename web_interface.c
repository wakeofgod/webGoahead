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
    if (rc == -1) return 0;

    for (i=0; i<128; i++) szPortInfo[i] = malloc(1024);
	
    totoalLen += eth_info_to_string(phyUnit, szPortInfo[count]);
    count++;
    
    do {
        rc = phyifGetNextIndex(phyUnit, &phyNextUnit);
        if (rc == -1) {
		for (i=0; i<count; i++)
			strcat(strBufAll, szPortInfo[i]);

	       for (i=0; i<128; i++) free(szPortInfo[i]);
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
	if (rc == -1) return -1;

    	pObj = (PHY_OBJ *)phyifFindByUnit(phyUnit);	
	if (pObj == NULL) return -1;

       strcpy(pObj->phy_cfgData.cfg_ifDescr, hDes);

	phyifCmdHandler(phyUnit, HANDLE_CMD_SET, m_ifAdminStatus, atoi(hStatus) == 1? 1:2);
	phyifCmdHandler(phyUnit, HANDLE_CMD_SET, m_ifOperateStatus, atoi(hStatusTxt) == 1? 1:2);
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

    for (i=0; i<count; i++)
    {
        strcat(eth_str, (char *)vifGetl2ifName(pdata[i]));
        strcat(eth_str, "*");
    }

    strcat(eth_str, "|");

    sprintf(pBuff+len, "%s", eth_str);
    return (len+strlen(eth_str));
}

int web_trunk_get_all(char *strBufAll)
{
    int i, rc = 0;
    int count = 0, totoalLen = 0;
    int trunkUnit, trunkNextUnit;

    char *szPortInfo[8] = {0};
   
    rc = trunkifGetFirstIndex(&trunkUnit);
    if (rc == -1) return 0;

    for (i=0; i<8; i++) szPortInfo[i] = malloc(1024);
    
    totoalLen += trunk_info_to_string(trunkUnit, szPortInfo[count]);
    count++;
    
    do {
        rc = trunkifGetNextIndex(trunkUnit, &trunkNextUnit);
        if (rc == -1) {
        for (i=0; i<count; i++)
            strcat(strBufAll, szPortInfo[i]);

           for (i=0; i<8; i++) free(szPortInfo[i]);
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

    trunkid = atoi(trunkName+5);
    rc = trunkifDestroy(trunkid);
    return rc;
}

static int web_get_eth_list(char *eth_list, int *pdata)
{
    int rc, count = 0, phyUnit = 0;
    char* delim = ",";
    char* p = strtok(eth_list, delim);

    while (p != NULL)
    {   
        rc = vifGetUnitFromName(p, &phyUnit);
        if (rc == -1) continue;

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
    if (rc == -1) return -1;

    vifGetTrunkIdFromUnit(trunkUnit, &trunkid);

    pObj = (TRUNK_OBJ *)trunkifFindByUnit(trunkUnit); 
    if (pObj == NULL) 
    {
        rc = trunkifCreate(trunkid);
        if (rc == -1) return -1;
    }

    pObj = (TRUNK_OBJ *)trunkifFindByUnit(trunkUnit); 
    strcpy(pObj->trunk_cfgData.cfg_ifDescr, hDes);
	
    trunkifCmdHandler(trunkUnit, HANDLE_CMD_SET, m_ifAdminStatus, atoi(hStatus) == 1? 1:2);

    //trunkifCmdHandler(trunkUnit, HANDLE_CMD_SET, m_ifOperateStatus, atoi(hStatusTxt) == 1? 1:2);
    trunkifCmdHandler(trunkUnit, HANDLE_CMD_SET, m_agPsc, atoi(psc));
    trunkifCmdHandler(trunkUnit, HANDLE_CMD_SET, m_ifPvid, atoi(hPvid));
    trunkifCmdHandler(trunkUnit, HANDLE_CMD_SET, m_ifMtu, atoi(hMtu));

    count = vifGetTrunkMember(trunkUnit, pdata);
    for (i=0; i<count; i++)
        phyifCmdHandler(pdata[i], HANDLE_CMD_SET, m_ifQuitTrunk, (void *) trunkid);

    memset(pdata, 0, sizeof(pdata));        
    count = web_get_eth_list(eth_list, pdata);	
    for (i=0; i<count; i++)
    	{
        phyifCmdHandler(pdata[i], HANDLE_CMD_SET, m_ifJoinTrunk, (void *) trunkid);
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

    for (i=0; i<count; i++)
    {
        strcat(ethBuff, (char *)vifGetl2ifName(pdata[i]));
        strcat(ethBuff, "*");
    }

    strcpy(strBufAll, ethBuff);
    return strlen(ethBuff);
}



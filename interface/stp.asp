<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>STP</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <style>
        .current {
            background-color: #FFA07A;
            color: white;
            font: bold;
        }

        .tab_list {
            height: 50px;
            width: 80%;
        }

        .tab_list ul {
            padding-left: 0px;
            height: 50px;
        }

        .tab_list li {
            display: inline-block;
            box-sizing: border-box;
            padding-left: 20px;
            padding-right: 20px;
            text-align: center;
            height: 50px;
            line-height: 50px;
            margin: 0;
            font: bolder !important;
        }

        .myhref {
            color: #000000;
            text-decoration: none;
            font-weight: bolder;
            display: block;
            justify-content: center;
            align-items: center;
        }

        #myTabContent .table-hover>tbody>tr:hover {
            background-color: #33ccff;
        }

        .arrow-right {
            width: 20px;
            height: 20px;
            background-color: transparent;
            /* 模块背景为透明 */
            border-color: #f02c57;
            border-style: solid;
            border-width: 6px 6px 0 0;
            margin: auto;
            transform: rotate(45deg);
            /*箭头方向可以自由切换角度*/
        }
    </style>
</head>

<body>
    <h3
        style="font-weight: bolder; text-align: center;background-color: rgb(241,241,241);height: 48px;line-height: 48px;">
        STP协议</h3>
    <div>
        <div class="tab_list">
            <ul id="myTab">
                <li value="1" class="current">
                    <a href="#divPVST" class="myhref" data-toggle="tab">PVST</a>
                </li>
                <li value="2" style="display: none;">
                    <a href="#divMSTP" class="myhref" data-toggle="tab">MSTP</a>
                </li>
                <li value="0">
                    <a href="#divALL" class="myhref" data-toggle="tab">CST</a>
                </li>
            </ul>
        </div>
        <div style="transform:translateY(-50px); float: right;margin-right: 50px;">
            <label>当前模式:</label>
            <label style="color: #FFA07A;" id="txtCurrentType"></label>
            <btn type="button" id="btnMode" class="btn" style="color: #fff; background-color: #f9a11b;">
                模式切换
            </btn>
        </div>
    </div>
    <div id="myTabContent" class="tab-content">
        <div class="tab-pane fade in active" id="divPVST" style="width: 95%; height:100px;">
            <div class="row" id="divSelVlan" style="margin-top: 20px;">
                <label class="col-md-1 control-label">VLAN列表</label>
                <select title="vlan" class="col-md-1" id="selVlan">
                    <option selected>请选择</option>
                    <option value="1" statusvalue="1">Vlan1</option>
                    <option value="2" statusvalue="0">Vlan2</option>
                    <option value="3" statusvalue="1">Vlan3</option>
                </select>
            </div>
            <div class="row" id="titleVlan" style="display: none;">
                <label class="col-md-2 control-label">当前选中的VLAN是:</label>
                <label class="col-md-1" style="color: #FFA07A;" id="txtVlanName"></label>
                <label class="col-md-1 control-label">状态:</label>
                <label class="col-md-1 control-label" style="color:#FFA07A;" id="txtVlanStatus"></label>
                <button type="button" id="btnPvstEnalbe" class="btn btn-primary">使能
                </button>
                <button type="button" id="btnPvstDisable" class="btn btn-primary">不使能
                </button>
            </div>

        </div>
        <div class="tab-pane fade" id="divMSTP" style="width: 95%; height:400px; overflow:auto">
            <table id="tableMSTP" class="table table-striped table-bordered table-hover">
                <thead style="font-weight: bolder;">
                    <tr>
                        <td width="10%">VLAN名称</td>
                        <td width="10%">VLAN ID</td>
                        <td width="20%">VLAN 描述</td>
                        <td width="10%">VLAN 状态</td>
                        <td width="20%">ETH成员</td>
                        <td width="20%">TRUNK成员</td>
                        <td>操作</td>
                    </tr>
                </thead>
                <tbody id="bodyMstp">

                </tbody>
            </table>
        </div>
        <div class="tab-pane fade" id="divALL" style="width: 95%; height:100px;">
            <div class="row" id="divCstTitle">
                <label class="col-md-2 control-label">CST当前状态是:</label>
                <label class="col-md-1"style="color: #FFA07A;" id="txtCstStatus"></label>
                <button type="button" id="btnCstEnalbe" class="btn btn-primary">使能
                </button>
                <button type="button" id="btnCstDisable" class="btn btn-primary">不使能
                </button>
            </div>
        </div>
    </div>
    <div id="vlanDetail" style="display: none;margin-top: 20px;">
        <div class="container-fluid" id="divStpTree">
            <div class="row">
                <div class="col-md-offset-4 col-md-2" style="font-weight: bolder;">Designated Root:</div>
                <div class="col-md-2">00:01:01:01:01:01</div>
            </div>
            <div class="row">
                <div class="col-md-offset-4 col-md-2" style="font-weight: bolder;">Designated Root Priority:</div>
                <div class="col-md-2">32678</div>
            </div>
            <div class="row">
                <div class="col-md-offset-4 col-md-2" style="font-weight: bolder;">Designated Root Path Cost:</div>
                <div class="col-md-2">0</div>
            </div>
            <div class="row">
                <div class="col-md-offset-4 col-md-2" style="font-weight: bolder;">Root Port:</div>
                <div class="col-md-2">none</div>
            </div>
            <div class="row">
                <div class="col-md-offset-2 col-md-1" style="font-weight: bolder;">Root Max Age:</div>
                <div class="col-md-1">20</div>
                <div class=" col-md-2" style="font-weight: bolder;">Hello Time:</div>
                <div class="col-md-2">2</div>
                <div class=" col-md-1" style="font-weight: bolder;">Forward Delay:</div>
                <div class="col-md-1">15</div>
            </div>
            <hr size=1 style=" height:2px;border:none;background-color:#6B8E23;">
            <div class="row">
                <div class="col-md-offset-4 col-md-2" style="font-weight: bolder;">Bridge ID Mac Address</div>
                <div class="col-md-2">00:01:01:01:01:01</div>
            </div>
            <div class="row">
                <div class="col-md-offset-4 col-md-2" style="font-weight: bolder;">Bridge ID Priority:</div>
                <div class="col-md-2">32768</div>
            </div>
            <div class="row">
                <div class="col-md-offset-4 col-md-2" style="font-weight: bolder;">Bridge ForceVersion:</div>
                <div class="col-md-2">2</div>
            </div>
            <div class="row">
                <div class="col-md-offset-2 col-md-1" style="font-weight: bolder;">Bridge Max Age:</div>
                <div class="col-md-1">20</div>
                <div class=" col-md-2" style="font-weight: bolder;">Hello Time:</div>
                <div class="col-md-2">2</div>
                <div class=" col-md-1" style="font-weight: bolder;">Forward Delay:</div>
                <div class="col-md-1">15</div>
            </div>
        </div>
    </div>
    <div class="container-fluid" style="width: 95%;">
        <div id="vlanEthHead">
            <table class="table table-striped table-bordered ">
                <thead style="font-weight: bolder;">
                    <tr>
                        <td width="10%">Name</td>
                        <td width="10%">Priority</td>
                        <td width="10%">Cost</td>
                        <td width="10%">Role</td>
                        <td width="10%">Span State</td>
                        <td width="5%">lk</td>
                        <td width="5%">p2p</td>
                        <td width="5%">eg </td>
                        <td width="10%">Desi-Bridge-Id</td>
                        <td width="10%">Dcost</td>
                        <td>D-port</td>
                    </tr>
                </thead>
            </table>
        </div>
        <div id="vlanEthTable" style="height: 300px;overflow-y: auto;overflow-x: hidden;margin-top: -22px;">
            <table class="table table-striped table-bordered ">
                <tbody id="bodyVlanEth">

                </tbody>
            </table>
        </div>
    </div>
    <div class="modal fade" id="modeModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">模式切换</h4>
                </div>
                <div class="modal-body">
                    <p>你选择了<span id="txtModeSpan"></span>模式，确定要更换吗？</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="btnModeSave">提交更改</button>
                </div>
            </div>
        </div>
    </div>
    <div>
        <form id="hTypeForm" style="display: none; visibility:hidden;" method="post" action="/goform/stpFormType">
            <input name="hType" value="" />
        </form>
    </div>
    <div>
        <form id="hEnableForm" style="display: none; visibility:hidden;" method="post" action="/goform/stpFormEnable">
            <input name="hId" value="" />
            <input name="hEnable" value="" />
        </form>
    </div>
    <div>
        <form id="hCstForm" style="display: none; visibility:hidden;" method="post" action="/goform/stpFormCstEnable">
            <input name="hCstEnable" value="" />
        </form>
    </div>
    <script>
        var inDiv = false;
        var tab_list = document.getElementById("myTab");
        var list = tab_list.querySelectorAll("li");
        var currentMode = 1;
        var selectMode = 1;
        var modeTextArray = ["CST", "PVST", "MSTP"];
        var pvstSet = [];
        var mstpSet = [];
        var allSet = [];
        var pvstTreeSet = [];
        var ethSetAll = [];
        var statusTextArray = ["不使能", "使能"];
        var spanTextArray = ["Discarding", "Forwarding"];
        var selectedTree = [];
        var selectedEht = [];
        var selectedValnId = -1;
        var selectedVlanStatus = -1;
        var html = ('');
        var cstStatus = 0;
        function getData() {
            let modeData = "<%stpAspGetType();%>";
            let vlanData = "<%stpAspGetVlan();%>";
            let ethData = "<%stpAspGetEth();%>";
            let treeData = "<%stpAspGetVlanDetail();%>";
            let cstStatusData = "<%stpCstGetEnable();%>"
            modeData = modeData.trim();
            if (parseInt(modeData) == 2) {
                currentMode = 1;
            }
            else if (parseInt(modeData) == 1) {
                currentMode = 0;
            }
            selectMode = currentMode;
            if (vlanData.trim() != "") {
                vlanData = vlanData.trim();
                if (vlanData.lastIndexOf('|') == vlanData.length - 1) {
                    vlanData = vlanData.substring(0, vlanData.length - 1);
                }
                let tmpVlanData = vlanData.split('|');
                let tCount = tmpVlanData.length;
                if (tCount > 0) {
                    pvstSet = [];
                    for (let i = 0; i < tCount; i++) {
                        let rowData = tmpVlanData[i].trim();
                        pvstSet.push([rowData.substring(0, rowData.length - 1), rowData.substring(rowData.length - 1)]);
                    }
                }
            }
            if (treeData.trim() != "") {
                treeData = treeData.trim();
                if (treeData.lastIndexOf('|') == treeData.length - 1) {
                    treeData = treeData.substring(0, treeData.length - 1);
                }
                let tmpTreeData = treeData.split('|');
                let tcount = tmpTreeData.length;
                if (tcount > 0) {
                    for (let i = 0; i < tcount; i++) {
                        let rowData = tmpTreeData[i].split(',');
                        if (rowData.length >= 13) {
                            pvstTreeSet.push([rowData[1], rowData[2], rowData[3], rowData[4], rowData[5], rowData[6], rowData[7], rowData[8], rowData[9], rowData[10], rowData[11], rowData[12], rowData[13], rowData[0]]);
                        }

                    }
                }
            }
            if (ethData.trim() != "") {
                ethData = ethData.trim();
                if (ethData.lastIndexOf("|") == ethData.length - 1) {
                    ethData = ethData.substring(0, ethData.length - 1);
                    let sectionData = ethData.split('|');
                    let sCount = sectionData.length;
                    if (sCount > 0) {
                        for (let i = 0; i < sCount; i++) {
                            if (sectionData[i].lastIndexOf('*') == sectionData[i].length - 1) {
                                sectionData[i] = sectionData[i].substring(0, sectionData[i].length - 1);
                            }
                            let tmpEthData = sectionData[i].split('*');
                            let tCount = tmpEthData.length;
                            let vlanId = 0;
                            for (let j = 0; j < tCount; j++) {
                                if (tmpEthData[j].trim() != "") {
                                    let ethRowData = tmpEthData[j].split(',');
                                    if (ethRowData.length >= 10) {
                                        if (j == 0) {
                                            vlanId = ethRowData[0];
                                            ethSetAll.push([ethRowData[1], ethRowData[2], ethRowData[3], ethRowData[4], ethRowData[5], ethRowData[6], ethRowData[7], ethRowData[8], ethRowData[9], ethRowData[10], ethRowData[11], vlanId]);
                                        }
                                        else {
                                            ethSetAll.push([ethRowData[0], ethRowData[1], ethRowData[2], ethRowData[3], ethRowData[4], ethRowData[5], ethRowData[6], ethRowData[7], ethRowData[8], ethRowData[9], ethRowData[10], vlanId]);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            if (cstStatusData.trim() != "1") {
                cstStatus = 0;
            }
            else {
                cstStatus = 1;
            }
            $("#txtCstStatus").html(statusTextArray[cstStatus]);
        }

        function loadPage() {
            //#region pvst
            let pCount = pvstSet.length;
            //#endregion
        }

        function loadSelect() {
            let pCount = pvstSet.length;
            if (pCount > 0) {
                html = ('');
                html += ('<option value="-1" selected>请选择</option>');
                for (let i = 0; i < pCount; i++) {
                    if (pvstSet[i][0] == "default") {
                        pvstSet[i][0] = "vlan1";
                    }
                    html += ('<option value="' + pvstSet[i][0].substring(4) + '" txtvalue="' + pvstSet[i][0] + '" statusvalue="' + pvstSet[i][1] + '" >' + pvstSet[i][0] + '</option>');
                }
                $("#selVlan").html(html);
            }
        }

        function loadEthPage(vlanId) {
            selectedEht = [];
            $("#bodyVlanEth").html("");
            for (let i = 0; i < ethSetAll.length; i++) {
                if (vlanId == ethSetAll[i][11]) {
                    selectedEht.push(ethSetAll[i]);
                }
            }
            let ethCount = selectedEht.length;
            if (ethCount > 0) {
                html = ('');
                for (let i = 0; i < ethCount; i++) {
                    html += ('<tr>');
                    html += ('<td width="10%">' + selectedEht[i][0] + '</td>');
                    html += ('<td width="10%">' + selectedEht[i][1] + '</td>');
                    html += ('<td width="10%">' + selectedEht[i][2] + '</td>');
                    html += ('<td width="10%">' + selectedEht[i][3] + '</td>');
                    html += ('<td width="10%">' + selectedEht[i][4] + '</td>');
                    html += ('<td width="5%">' + selectedEht[i][5] + '</td>');
                    html += ('<td width="5%">' + selectedEht[i][6] + '</td>');
                    html += ('<td width="5%">' + selectedEht[i][7] + '</td>');
                    html += ('<td width="10%">' + selectedEht[i][8] + '</td>');
                    html += ('<td width="10%">' + selectedEht[i][9] + '</td>');
                    html += ('<td>' + selectedEht[i][10] + '</td>');
                    html += ('</tr>');
                }
                $("#bodyVlanEth").html(html);
                isScroll();
            }
        }

        function loadTreeDetailPage(vlanId) {
            selectedTree = [];
            $("#divStpTree").html("");
            for (let i = 0; i < pvstTreeSet.length; i++) {
                if (vlanId == pvstTreeSet[i][13]) {
                    selectedTree.push(pvstTreeSet[i]);
                }
            }
            let treeCount = selectedTree.length;
            if (treeCount > 0) {
                html = ('');
                for (let i = 0; i < treeCount; i++) {
                    html += ('<div class="row">');
                    html += ('<div class="col-md-offset-4 col-md-2" style="font-weight: bolder;">Designated Root:</div>');
                    html += ('<div class="col-md-2">' + selectedTree[i][0] + '</div>');
                    html += ('</div>');
                    html += ('<div class="row">');
                    html += ('<div class="col-md-offset-4 col-md-2" style="font-weight: bolder;">Designated Root Priority:</div>');
                    html += ('<div class="col-md-2">' + selectedTree[i][1] + '</div>');
                    html += ('</div>');
                    html += ('<div class="row">');
                    html += ('<div class="col-md-offset-4 col-md-2" style="font-weight: bolder;">Designated Root Path Cost:</div>');
                    html += ('<div class="col-md-2">' + selectedTree[i][2] + '</div>');
                    html += ('</div>');
                    html += ('<div class="row">');
                    html += ('<div class="col-md-offset-4 col-md-2" style="font-weight: bolder;">Root Port:</div>');
                    html += ('<div class="col-md-2">' + selectedTree[i][3] + '</div>');
                    html += ('</div>');
                    html += ('<div class="row">');
                    html += ('<div class="col-md-offset-2 col-md-1" style="font-weight: bolder;">Root Max Age:</div>');
                    html += ('<div class="col-md-1">' + selectedTree[i][4] + '</div>');
                    html += ('<div class=" col-md-2" style="font-weight: bolder;">Hello Time:</div>');
                    html += ('<div class="col-md-2">' + selectedTree[i][5] + '</div>');
                    html += ('<div class=" col-md-1" style="font-weight: bolder;">Forward Delay:</div>');
                    html += ('<div class="col-md-1">' + selectedTree[i][6] + '</div>');
                    html += ('</div>');
                    html += ('<hr size=1 style=" height:2px;border:none;background-color: #6B8E23;">');
                    html += ('<div class="row">');
                    html += ('<div class="col-md-offset-4 col-md-2" style="font-weight: bolder;">Bridge ID Mac Address</div>');
                    html += ('<div class="col-md-2">' + selectedTree[i][7] + '</div>');
                    html += ('</div>');
                    html += ('<div class="row">');
                    html += ('<div class="col-md-offset-4 col-md-2" style="font-weight: bolder;">Bridge ID Priority:</div>');
                    html += ('<div class="col-md-2">' + selectedTree[i][8] + '</div>');
                    html += ('</div>');
                    html += ('<div class="row">');
                    html += ('<div class="col-md-offset-4 col-md-2" style="font-weight: bolder;">Bridge ForceVersion:</div>');
                    html += ('<div class="col-md-2">' + selectedTree[i][9] + '</div>');
                    html += ('</div>');
                    html += ('<div class="row">');
                    html += ('<div class="col-md-offset-2 col-md-1" style="font-weight: bolder;">Bridge Max Age:</div>');
                    html += ('<div class="col-md-1">' + selectedTree[i][10] + '</div>');
                    html += ('<div class=" col-md-2" style="font-weight: bolder;">Hello Time:</div>');
                    html += ('<div class="col-md-2">' + selectedTree[i][11] + '</div>');
                    html += ('<div class=" col-md-1" style="font-weight: bolder;">Forward Delay:</div>');
                    html += ('<div class="col-md-1">' + selectedTree[i][12] + '</div>');
                    html += ('</div>');
                }
                $("#divStpTree").html(html);
            }

        }

        function stopPvst() {
            $("#divSelVlan").attr("style", "display:none");
            $("#titleVlan").attr("style", "display:none");

        }
        function startPvst() {
            $("#divSelVlan").attr("style", "margin-top:20px;");
            $("#titleVlan").attr("style", "margin-top:20px;");
        }
        function startCst() {
            $("#divCstTitle").attr("style", "width: 95%; height:100px;margin-top:20px;");
        }
        function stopCst() {
            $("#divCstTitle").attr("style", "display:none");
        }

        function isScroll() {
            let eHeight = $("#vlanEthTable")[0].scrollHeight;
            if (eHeight > 300) {
                $("#vlanEthHead").attr("style", "padding-right:17px;margin-top:20px;");
            }
            else{
                $("#vlanEthHead").attr("style", "margin-top:20px;");
            }
        }

        $("#myTab").on('click', "li", function () {
            //清除所有li的默认样式
            for (let i = 0; i < list.length; i++) {
                $(list[i]).removeClass();
            }
            $(this).addClass("current");
            selectMode = parseInt($(this).val());
            if (selectMode != currentMode) {
                $("#vlanEthTable").attr("style", "display:none;");
            }
            else {
                $("#vlanEthTable").attr("style", "height: 300px;overflow-y: auto;overflow-x: hidden;margin-top: -22px;");
            }
        });
        $("#tablePVST tbody").on('click', "tr td:not(:last-child)", function () {
            $("#vlanDetail").attr("style", "margin-top:20px;");
            let tmpId = parseInt($(this).parent().find("[name='txtValnId']").attr("value"));
            let spanList = document.getElementsByName("txtCursor");
            $.each(spanList, function () {
                $(this).html("");
            });
            $(this).parent().find("[name='txtCursor']").html('<div class="arrow-right"></div>');
            loadTreeDetailPage(tmpId);
            loadEthPage(tmpId);
        });

        $("#tablePVST").on('click', '[name="btnPvstEnalbe"]', function () {
            alert($(this).attr("textvalue") + " " + $(this).attr("value"));
        }).on('click', '[name="btnPvstDisable"]', function () {
            alert($(this).attr("textvalue") + " " + $(this).attr("value"));
        });

        $("#selVlan").change(function () {
            let options = $("#selVlan option:selected");
            let vlanId = parseInt(options.attr("value"));
            let vlanTxt = options.attr("txtvalue");
            let vlanStatus = parseInt(options.attr("statusvalue"));
            if (vlanId != -1) {
                $("#vlanDetail").attr("style", "margin-top:20px;");
                $("#titleVlan").attr("style", "margin-top:20px;");
                $("#vlanEthTable").attr("style", "height: 300px;overflow-y: auto;overflow-x: hidden;margin-top: -22px;");
                $("#txtVlanName").html(vlanTxt);
                $("#txtVlanStatus").html(statusTextArray[vlanStatus]);
                selectedValnId = vlanId;
                selectedVlanStatus = vlanStatus;
                loadTreeDetailPage(vlanId);
                loadEthPage(vlanId);
            }
            else {
                selectedValnId = 0;
                selectedVlanStatus = 0;
                $("#vlanDetail").attr("style", "display:none;");
                $("#vlanEthTable").attr("style", "display:none;");
                $("#titleVlan").attr("style", "display:none;");
            }
        });

        $("#btnPvstEnalbe").on('click', function () {
            if (selectedVlanStatus == 1) {
                alert("当前状态使能");
            }
            else if (selectedValnId == -1) {
                alert("请选择要求改的vlan");
            }
            else {
                $("[name='hId']").val(selectedValnId);
                $("[name='hEnable']").val(1);
                $("#hEnableForm").submit();
            }
        });

        $("#btnPvstDisable").on('click', function () {
            if (selectedVlanStatus == 0) {
                alert("当前状态不使能");
            }
            else if (selectedValnId == -1) {
                alert("请选择要求改的vlan");
            }
            else {
                $("[name='hId']").val(selectedValnId);
                $("[name='hEnable']").val(0);
                $("#hEnableForm").submit();
            }
        });

        $("#btnModeSave").on('click', function () {
            if (selectMode == currentMode) {
                alert("模式未更改");
            }
            else {
                $("[name='hType']").val(selectMode);
                $("#hTypeForm").submit();
            }
        });

        //鼠标移动监听，这里不用mouseout mousein 会频繁触发导致值不准
        $("#myTabContent").mouseenter(function () {
            inDiv = true;
        }).mouseleave(function () {
            inDiv = false;
        });
        $("#vlanDetail").mouseenter(function () {
            inDiv = true;
        }).mouseleave(function () {
            inDiv = false;
        });
        //鼠标点击事件，eth div隐藏
        document.onclick = function (event) {
            if (!inDiv) {
                $("#vlanDetail").attr("style", "display:none;");
                let spanList = document.getElementsByName("txtCursor");
                $.each(spanList, function () {
                    $(this).html("");
                });
            }
        };

        $("#btnMode").click(function () {
            $("#txtModeSpan").html(modeTextArray[selectMode]);
            $("#modeModal").modal('show');
        });

        $("#btnCstEnalbe").click(function () {
            if (cstStatus == 1) {
                alert("当前CST使能");
            }
            else {
                $("[name='hCstEnable']").val(1);
                $("#hCstForm").submit();
            }
        });

        $("#btnCstDisable").click(function () {
            if (cstStatus == 0) {
                alert("当前CST不使能");
            }
            else {
                $("[name='hCstEnable']").val(0);
                $("#hCstForm").submit();
            }
        });

        $(document).ready(function () {
            getData();
            //loadPage();
            loadSelect();
            if (currentMode == 1) {
                $("#myTab>li").eq(0).addClass("active current");
                $("#myTab>li").eq(1).removeClass("active current");
                $("#myTab>li").eq(2).removeClass("active current");
                $("#divPVST").addClass("tab-pane fade active in");
                $("#divALL").removeClass().addClass("tab-pane fade");
                stopCst();
                startPvst();
            }
            else if (currentMode == 0) {
                $("#myTab>li").eq(0).removeClass("active current");
                $("#myTab>li").eq(1).removeClass("active current");
                $("#myTab>li").eq(2).addClass("active current");
                $("#divALL").addClass("tab-pane fade active in");
                $("#divPVST").removeClass().addClass("tab-pane fade");
                $("#divStpTree").attr("style", "display:none");
                stopPvst();
                startCst();
                loadEthPage(0);
            }
            $("#txtCurrentType").html(modeTextArray[currentMode]);
        });
    </script>
</body>

</html>
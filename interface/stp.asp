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
            background-color: #ff3333;
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
            padding: 10px;
            text-decoration: none;
            font-weight: bolder;
        }

        /* .myhref :active .myhref :link .myhref :hover .myhref :visited{
            color: white;
        } */
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
                <li value="3">
                    <a href="#divALL" class="myhref" data-toggle="tab">CST</a>
                </li>
            </ul>
        </div>
        <div style="transform:translateY(-50px);">
            <btn type="button" id="btnMode" class="btn btn-warning" style="float: right;margin-right: 30px;">
                模式切换
            </btn>
        </div>
    </div>
    <div id="myTabContent" class="tab-content">
        <div class="tab-pane fade in active" id="divPVST" style="width: 95%; height:100px;">
            <div class="row" style="margin-top: 20px;">
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
                <label class="col-md-1" id="txtVlanName"></label>
                <label class="col-md-1 control-label">状态:</label>
                <label class="col-md-1 control-label" id="txtVlanStatus"></label>
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
                    <tr>
                        <td>trunkMSTP</td>
                        <td>
                            300
                        </td>
                        <td>
                            test vlanMSTP
                        </td>
                        <td>
                            up
                        </td>
                        <td>
                            eth0/17 eth0/18
                        </td>
                        <td>trunk1
                        </td>
                        <td>
                            <button type="button" class="btn btn-primary">修改
                            </button>
                            <button type="button" class="btn btn-primary">删除
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>trunkMSTP</td>
                        <td>
                            400
                        </td>
                        <td>
                            test vlanMSTP
                        </td>
                        <td>
                            up
                        </td>
                        <td>
                            eth0/27 eth0/28
                        </td>
                        <td>trunk1
                        </td>
                        <td>
                            <button type="button" class="btn btn-primary">修改
                            </button>
                            <button type="button" class="btn btn-primary">删除
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="tab-pane fade" id="divALL" style="width: 95%; height:400px; overflow:auto">
            <table id="tableAll" class="table table-striped table-bordered table-hover">
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
                <tbody id="bodyAll">
                    <tr>
                        <td>trunkALL</td>
                        <td>
                            500
                        </td>
                        <td>
                            test vlanALL
                        </td>
                        <td>
                            up
                        </td>
                        <td>
                            eth0/7 eth0/8
                        </td>
                        <td>trunk1
                        </td>
                        <td>
                            <button type="button" class="btn btn-primary">修改
                            </button>
                            <button type="button" class="btn btn-primary">删除
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>trunkALL</td>
                        <td>
                            600
                        </td>
                        <td>
                            test vlanALL
                        </td>
                        <td>
                            up
                        </td>
                        <td>
                            eth0/7 eth0/8
                        </td>
                        <td>trunk1
                        </td>
                        <td>
                            <button type="button" class="btn btn-primary">修改
                            </button>
                            <button type="button" class="btn btn-primary">删除
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
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
            <hr size=1 style=" height:2px;border:none;background-color: green;">
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
        <table class="table table-striped table-bordered " style="width: 95%;margin-top: 10px;">
            <thead style="font-weight: bolder;">
                <tr>
                    <td width="10%">Name</td>
                    <td width="15%">Priority</td>
                    <td width="10%">Cost</td>
                    <td width="10%">Role</td>
                    <td width="15%">Span State</td>
                    <td width="20%">Desi-Bridge-Id</td>

                </tr>
            </thead>
            <tbody id="bodyVlanEth">
                <tr>
                    <td>eth0/0</td>
                    <td>128</td>
                    <td>200000</td>
                    <td>Dis</td>
                    <td>Discarding</td>
                    <td></td>
                </tr>
            </tbody>
        </table>
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
        <form id="hTypeForm" style="display: none; visibility:hidden;" method="post" action="/goform/">
            <input name="hType" value="" />
        </form>
    </div>
    <div>
        <form id="hEnableForm" style="display: none; visibility:hidden;" method="post" action="/goform/">
            <input name="hId" value="" />
            <input name="hEnable" value="" />
        </form>
    </div>
    <script>
        var inDiv = false;
        var tab_list = document.getElementById("myTab");
        var list = tab_list.querySelectorAll("li");
        var currentMode = 1;
        var selectMode = 1;
        var modeTextArray = ["PVST", "MSTP", "CST"];
        var pvstSet = [];
        var mstpSet = [];
        var allSet = [];
        var pvstTreeSet = [];
        var ethSetAll = [];
        var statusTextArray = ["不使能", "使能"];
        var spanTextArray = ["Discarding", "Forwarding"];
        var selectedTree = [];
        var selectedEht = [];
        var selectedValnId = "";
        var selectedVlanStatus = 0;
        var html = ('');
        function getData() {
            var modeData = "<%stpAspGetType();%>";
            var vlanData = "<%stpAspGetVlan();%>";
            var ethData = "<%stpAspGetEth();%>";
            var treeData = "<%stpAspGetVlanDetail();%>";
            currentMode = parseInt(modeData.trim());
            if (vlanData.trim() != "") {
                vlanData = vlanData.trim();
                if (vlanData.lastIndexOf('|') == vlanData.length - 1) {
                    vlanData = vlanData.substring(0, vlanData.length - 1);
                }
                var tmpVlanData = vlanData.split('|');
                var tCount = tmpVlanData.length;
                if (tCount > 0) {
                    pvstSet = [];
                    for (var i = 0; i < tCount; i++) {
                        var rowData = tmpVlanData[i].trim();
                        pvstSet.push([rowData.substring(0, rowData.length - 1), rowData.substring(rowData.length - 1)]);
                    }
                }
            }
            if(treeData.trim()!=""){
                treeData = treeData.trim();
                if (treeData.lastIndexOf('|') == treeData.length - 1) {
                    treeData = treeData.substring(0, treeData.length - 1);
                }
                var tmpTreeData = treeData.split('|');
                var tcount = tmpTreeData.length;
                if(tcount>0){
                    for(var i =0; i<tcount;i++){
                        var rowData = tmpTreeData.split(',');
                        debugger;
                        pvstTreeSet.push([]);
                    }
                }
            }

        }

        function loadPage() {
            //#region pvst
            var pCount = pvstSet.length;
            //#endregion
        }

        function loadSelect() {
            var pCount = pvstSet.length;
            if (pCount > 0) {
                html = ('');
                html += ('<option value="-1" selected>请选择</option>');
                for (var i = 0; i < pCount; i++) {
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
            for (var i = 0; i < ethSetAll.length; i++) {
                if (vlanId == ethSetAll[i][6]) {
                    selectedEht.push(ethSetAll[i]);
                }
            }
            var ethCount = selectedEht.length;
            if (ethCount > 0) {
                html = ('');
                for (var i = 0; i < ethCount; i++) {
                    html += ('<tr>');
                    html += ('<td >' + selectedEht[i][0] + '</td>');
                    html += ('<td>' + selectedEht[i][1] + '</td>');
                    html += ('<td>' + selectedEht[i][2] + '</td>');
                    html += ('<td>' + selectedEht[i][3] + '</td>');
                    html += ('<td>' + selectedEht[i][4] + '</td>');
                    html += ('<td>' + selectedEht[i][5] + '</td>');
                    html += ('</tr>');
                }
                $("#bodyVlanEth").html(html);
            }
        }

        function loadTreeDetailPage(vlanId) {
            selectedTree = [];
            $("#divStpTree").html("");
            for (var i = 0; i < pvstTreeSet.length; i++) {
                if (vlanId == pvstTreeSet[i][13]) {
                    selectedTree.push(pvstTreeSet[i]);
                }
            }
            var treeCount = selectedTree.length;
            if (treeCount > 0) {
                html = ('');
                for (var i = 0; i < treeCount; i++) {
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
                    html += ('<hr size=1 style=" height:2px;border:none;background-color: green;">');
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

        $("#myTab").on('click', "li", function () {
            //清除所有li的默认样式
            for (var i = 0; i < list.length; i++) {
                $(list[i]).removeClass();
            }
            $(this).addClass("current");
            selectMode = parseInt($(this).val());
        });
        $("#tablePVST tbody").on('click', "tr td:not(:last-child)", function () {
            $("#vlanDetail").attr("style", "margin-top:20px;");
            var tmpId = parseInt($(this).parent().find("[name='txtValnId']").attr("value"));
            var spanList = document.getElementsByName("txtCursor");
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
            var options = $("#selVlan option:selected");
            var vlanId = parseInt(options.attr("value"));
            var vlanTxt = options.attr("txtvalue");
            var vlanStatus = parseInt(options.attr("statusvalue"));
            if (vlanId != -1) {
                $("#vlanDetail").attr("style", "margin-top:20px;");
                $("#titleVlan").attr("style", "margin-top:20px;");
                $("#txtVlanName").html(vlanTxt);
                $("#txtVlanStatus").html(statusTextArray[vlanStatus]);
                selectedValnId = vlanTxt;
                selectedVlanStatus = vlanStatus;
                loadTreeDetailPage(vlanId);
                loadEthPage(vlanId);
            }
            else {
                selectedValnId = "";
                selectedVlanStatus = 0;
                $("#vlanDetail").attr("style", "display:none;");
                $("#titleVlan").attr("style", "display:none;");
            }
        });

        $("#btnPvstEnalbe").on('click', function () {
            if (selectedVlanStatus == 1) {
                alert("当前状态使能");
            }
            else {
                $("[name='hId']").val(selectedValnId);
                $("[name='hEnable']").val(selectedVlanStatus);
            }
        });

        $("#btnPvstDisable").on('click', function () {
            if (selectedVlanStatus == 0) {
                alert("当前状态不使能");
            }
            else {
                $("[name='hId']").val(selectedValnId);
                $("[name='hEnable']").val(selectedVlanStatus);
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
                var spanList = document.getElementsByName("txtCursor");
                $.each(spanList, function () {
                    $(this).html("");
                });
            }
        };

        $("#btnMode").click(function () {
            $("#txtModeSpan").html(modeTextArray[mode - 1]);
            $("#modeModal").modal('show');
        });

        $(document).ready(function () {
            getData();
            //loadPage();
            loadSelect();
        });
    </script>
</body>

</html>
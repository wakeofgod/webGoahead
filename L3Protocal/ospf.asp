<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Ospf</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <style type=text/css>
        .mySelect {
            width: 100%;
            height: 25px;
            border: 1px solid;
            overflow: auto;
            max-width: 100px;
        }

        input[type=checkbox] {
            /* visibility: hidden;
            display: none; */
            opacity: 0;
            z-index: 9;

        }

        .mark::before {
            content: '\a0';
            display: inline-block;
            border: 1px solid silver;
            text-align: center;
            width: 20px;
            height: 20px;
            font-weight: bold;
        }

        input[type="checkbox"]:checked+.mark::before {
            content: '\2713';
            color: #FA8E53;
            background-color: #007FFF;
        }
    </style>
</head>

<body>
    <h3
        style="font-weight: bolder; text-align: center;background-color: rgb(241,241,241);height: 48px;line-height: 48px;">
        Ospf协议</h3>
    <br>
    <div style="height: 50px;">
        <button type="button" class="btn btn-primary" id="btnEnable" style="margin-left: 20px;">使能</button>
        <button type="button" class="btn btn-primary" id="btnDisable" style="margin-left: 20px;">不使能</button>
        <button type="button" class="btn btn-primary" id="btnAdd" style="margin-left: 20px;">新建</button>
    </div>
    <div class="row" id="ospfRedis" style="max-width: 98%;">
        <div id="ospfTable" class="col-md-offset-2 col-lg-offset-2 col-md-4 col-lg-4"
            style="transform: translateX(11%);">
            <h3 style="text-align: center;text-transform: uppercase;">ospf network</h3>
            <div id="netHead">
                <table class="table table-striped table-bordered">
                    <thead style="font-weight: bolder;">
                        <tr>
                            <td style="width:35%;">Network</td>
                            <td style="width:35%;">Area</td>
                            <td>操作</td>
                        </tr>
                    </thead>
                </table>
            </div>
            <div style="height: 300px;overflow-y: auto;overflow-x: hidden;margin-top: -22px;" id="networkTable">
                <table class="table table-striped table-bordered ">
                    <tbody id="ospfBody">

                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-md-offset-1 col-lg-offset-1 col-lg-1 col-md-1">
            <label>Redistributing:</label>
        </div>
        <div class="col-md-2">
            <div style="width:100%;height:28px;overflow:hidden;">
                <input type="text" id="selRedisGroup" onclick="myclick();" readonly="true"
                    style="width:100%;height:28px;">
            </div>
            <div id="selectdiv" style="display: none;" onmouseover="mousein()" onmouseout="mouseout()">
                <div>
                    <input name="mycheckbox" type="checkbox" onclick="mycheck(this)" value="0" id="checkboxFourInput0"
                        textvalue="connected">
                    <label for="checkboxFourInput0" name="mychecklabel" class="mark">connected</label>
                </div>
                <div>
                    <input name="mycheckbox" type="checkbox" onclick="mycheck(this)" value="1" id="checkboxFourInput1"
                        textvalue="static">
                    <label for="checkboxFourInput1" name="mychecklabel" class="mark">static</label>
                </div>
                <div>
                    <input name="mycheckbox" type="checkbox" onclick="mycheck(this)" value="2" id="checkboxFourInput2"
                        textvalue="rip">
                    <label for="checkboxFourInput2" name="mychecklabel" class="mark">rip</label>
                </div>
            </div>
        </div>
        <div class="col-md-1">
            <button type="button" class="btn btn-primary" id="btnSubmit" style="margin-left: 20px;">提交</button>
        </div>
    </div>
    <div class="container-fluid" id="ospfTableGroup">
        <div class="row" style="max-width: 1900px;">
            <div class="col-md-6 col-lg-6">
                <h3 style="text-align: center;text-transform: uppercase;">ospf route</h3>
                <div id="routeHead">
                    <table class="table table-striped table-bordered ">
                        <thead style="font-weight: bolder;">
                            <tr>
                                <td style="width: 25%;"></td>
                                <td style="width: 25%;">Route</td>
                                <td style="width: 15%;">Area</td>
                                <td>Description</td>
                            </tr>
                        </thead>
                    </table>
                </div>
                <div style="height:300px;overflow-y:auto;overflow-x: hidden;margin-top: -22px;" id="routeTable">
                    <table class="table table-striped table-bordered ">
                        <tbody id="routeBody">

                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <h3 style="text-align: center;text-transform: uppercase;">ospf database</h3>
                <div id="databaseHead">
                    <table class="table table-striped table-bordered ">
                        <thead style="font-weight: bolder;">
                            <tr>
                                <td style="width:15%;">Link ID</td>
                                <td style="width:20%;">ADV Router</td>
                                <td style="width:15%;">Age</td>
                                <td style="width:15%;">Seq#</td>
                                <td style="width:15%;">CkSum</td>
                                <td>Route</td>
                            </tr>
                        </thead>
                    </table>
                </div>
                <div style="height:300px;overflow-y:auto;overflow-x: hidden; margin-top: -22px;" id="databaseTable">
                    <table class="table table-striped table-bordered ">
                        <tbody id="databaseBody">
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-12 col-lg-12">
                <h3 style="text-align: center;text-transform: uppercase;">ospf neighbor</h3>
                <div id="neighborHead">
                    <table class="table table-striped table-bordered ">
                        <thead style="font-weight: bolder;">
                            <tr>
                                <td style="width: 15%;">Neighbor Id</td>
                                <td style="width: 10%;">Pri</td>
                                <td style="width: 10%;">State</td>
                                <td style="width: 10%;">Dead Time</td>
                                <td style="width: 15%;">Address</td>
                                <td style="width: 10%;">Interface</td>
                                <td style="width: 10%;">RXmtL</td>
                                <td style="width: 10%;">RqstL</td>
                                <td>DBsmL</td>
                            </tr>
                        </thead>
                    </table>
                </div>
                <div style="height:300px; overflow-y:auto;overflow-x: hidden;margin-top: -22px;" id="neighborTable">
                    <table class="table table-striped table-bordered ">
                        <tbody id="neighborBody">

                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>
    <div class="modal fade" id="modeModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">新增</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped table-bordered">
                        <tbody>
                            <tr>
                                <td>Network:</td>
                                <td>
                                    <input id="editNet" type="text" title="端口输入框" placeholder="xxx.xxx.xxx.xxx/xx"
                                        style="width: 100%;">
                                </td>
                            </tr>
                            <tr>
                                <td>Area:</td>
                                <td>
                                    <input id="editArea" type="text" title="区域输入框" placeholder="区域,默认0"
                                        style="width: 100%;">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="btnOspfSave">提交更改</button>
                </div>
            </div>
        </div>
    </div>
    <div>
        <form id="hPostForm" style="visibility: hidden; display: none;" method="post" action="/goform/ospfFormPost">
            <input name="hNetwork" value="" />
        </form>
        <form id="hDeleteForm" style="visibility: hidden; display: none;" method="post" action="/goform/ospfFormDelete">
            <input name="hDelete" value="" />
        </form>
        <form id="hEnableForm" style="visibility: hidden; display: none;" method="post" action="/goform/ospfFormEnable">
            <input name="hEnable" value="" />
        </form>
        <form id="hRedisForm" style="visibility: hidden; display: none;" method="post" action="/goform/ospfFormRedis">
            <input name="hRedis" value="" />
        </form>
    </div>
    <script>
        var currentStatus = 1;
        var dataSet = [];
        var dataInfo = [];
        var neighborSet = [];
        var routeSet = [];
        var databaseSet = [];
        var redisArray = ["connected", "static", "rip"];
        var currentRedis = [];
        var selectedlist = [];
        var selectednamelist = [];
        var indiv = false;
        var selecteddiv = document.getElementById("selectdiv");
        var html = ('');
        function getData() {
            let ospfStautsData = "<%ospfAspGetStatus();%>";
            let ospfInfoData = "<%ospfAspGetInfo();%>";
            let ospfNetData = "<%ospfAspGetNet();%>";
            let ospfNeighborData = "<%ospfAspGetNeighbor();%>";
            let ospfDatabaseData = "<%ospfAspGetDatabase();%>";
            let ospfRouteData = "<%ospfAspGetRoute();%>";
            if (ospfDatabaseData.trim() != "") {
                ospfDatabaseData = ospfDatabaseData.trim();
                if (ospfDatabaseData.lastIndexOf('|') == ospfDatabaseData.length - 1) {
                    ospfDatabaseData = ospfDatabaseData.substring(0, ospfDatabaseData.length - 1);
                }
                let tmpDatabase = ospfDatabaseData.split('|');
                let dCount = tmpDatabase.length;
                if (dCount > 0) {
                    databaseSet = [];
                    for (let i = 0; i < dCount; i++) {
                        if (tmpDatabase[i].trim() != "") {
                            let rowData = tmpDatabase[i].split(',');
                            databaseSet.push([rowData[0], rowData[1], rowData[2], rowData[3], rowData[4], rowData[5]]);
                        }
                    }
                }
            }

            if (ospfRouteData.trim() != "") {
                ospfRouteData = ospfRouteData.trim();
                if (ospfRouteData.lastIndexOf('|') == ospfRouteData.length - 1) {
                    ospfRouteData = ospfRouteData.substring(0, ospfRouteData.length - 1);
                }
                let tmpRouteData = ospfRouteData.split('|');
                let rCount = tmpRouteData.length;
                if (rCount > 0) {
                    routeSet = [];
                    for (let i = 0; i < rCount; i++) {
                        if (tmpRouteData[i].trim() != "") {
                            let rowData = tmpRouteData[i].split(',');
                            routeSet.push([rowData[0], rowData[1], rowData[2], rowData[3]]);
                        }
                    }
                }
            }

            if (ospfNeighborData.trim() != "") {
                ospfNeighborData = ospfNeighborData.trim();
                if (ospfNeighborData.lastIndexOf('|') == ospfNeighborData.length - 1) {
                    ospfNeighborData = ospfNeighborData.substring(0, ospfNeighborData.length - 1);
                }
                let tmpNeighborData = ospfNeighborData.split('|');
                let nCount = tmpNeighborData.length;
                if (nCount > 0) {
                    neighborSet = [];
                    for (let i = 0; i < nCount; i++) {
                        if (tmpNeighborData[i].trim() != "") {
                            let rowData = tmpNeighborData[i].split(',');
                            neighborSet.push([rowData[0], rowData[1], rowData[2], rowData[3], rowData[4], rowData[5], rowData[6], rowData[7], rowData[8]]);
                        }
                    }
                }
            }

            if (ospfInfoData.trim() != "") {
                selectednamelist = [];
                ospfInfoData = ospfInfoData.trim();
                if (ospfInfoData.lastIndexOf(',') == ospfInfoData.length - 1) {
                    ospfInfoData = ospfInfoData.substring(0, ospfInfoData.length - 1);
                }
                selectednamelist = ospfInfoData.split(',');
                for (let i = 0; i < selectednamelist.length; i++) {
                    selectednamelist[i] = selectednamelist[i].trim();
                    currentRedis.push(selectednamelist[i]);
                }
                document.getElementById("selRedisGroup").value = selectednamelist;
                resetDropDown(selectednamelist);
            }

            if(ospfNetData.trim()!=""){
                ospfNetData = ospfNetData.trim();
                if(ospfNetData.lastIndexOf('|')== ospfNetData.length-1){
                    ospfNetData = ospfNetData.substring(0,ospfNetData.length-1);
                }
                let tmpNetData = ospfNetData.split('|');
                let nCount = tmpNetData.length;
                if(nCount>0){
                    dataSet = [];
                    for(let i =0;i<nCount;i++){
                        let rowData = tmpNetData[i].split(',');
                        dataSet.push([rowData[0].trim(),rowData[1].trim()]);
                    }
                }
            }

            currentStatus = parseInt(ospfStautsData);
        }

        function loadPage() {
            if (!currentStatus) {
                $("#btnAdd").attr("disabled", "disabled");
                $("#btnDisable").attr("disabled", "disabled");
                $("#ospfInfo").attr("style", "display:none;");
                $("#ospfRedis").attr("style", "display:none;");
                $("#ospfTableGroup").attr("style", "display:none;");
            }
            else {
                $("#btnEnable").attr("disabled", "disabled");
                $("#btnAdd").removeAttr("disabled");
                $("#btnDisable").removeAttr("disabled");
                $("#ospfInfo").removeAttr("style");
                $("#ospfRedis").attr("style", "width:95%;");
                $("#ospfTableGroup").removeAttr("style");
            }
            let dCount = dataSet.length;
            if (currentStatus && dCount > 0) {
                html = ('');
                for (let i = 0; i < dCount; i++) {
                    html += ('<tr>');
                    html += ('<td style="width:35%;"><span name="txtNet" value="' + dataSet[i][0] + '">' + dataSet[i][0] + '</span></td>');
                    html += ('<td style="width:35%;"><span name="txtArea" value="' + dataSet[i][1] + '">' + dataSet[i][1] + '</span></td>');
                    html += ('<td>');
                    html += ('<button type="button" class="btn btn-primary" style="margin-left:30%;"  name="btnDelete" value="' + dataSet[i][0] + '">删除</button>');
                    html += ('</td');
                    html += ('</tr>');
                }
                $("#ospfBody").html(html);
            }
            let nCount = neighborSet.length;
            if (currentStatus && nCount > 0) {
                html = ('');
                for (let i = 0; i < nCount; i++) {
                    html += ('<tr>');
                    html += ('<td style="width: 15%;"><span name="txtNId" value="' + neighborSet[i][0] + '">' + neighborSet[i][0] + '</span></td>');
                    html += ('<td style="width: 10%;"><span name="txtPri" value="' + neighborSet[i][1] + '">' + neighborSet[i][1] + '</span></td>');
                    html += ('<td style="width: 10%;"><span name="txtState" value="' + neighborSet[i][2] + '">' + neighborSet[i][2] + '</span></td>');
                    html += ('<td style="width: 10%;"><span name="txtDead" value="' + neighborSet[i][3] + '">' + neighborSet[i][3] + '</span></td>');
                    html += ('<td style="width: 15%;"><span name="txtAddress" value="' + neighborSet[i][4] + '">' + neighborSet[i][4] + '</span></td>');
                    html += ('<td style="width: 10%;"><span name="txtInterface" value="' + neighborSet[i][5] + '">' + neighborSet[i][5] + '</span></td>');
                    html += ('<td style="width: 10%;"><span name="txtRXmtL" value="' + neighborSet[i][6] + '">' + neighborSet[i][6] + '</span></td>');
                    html += ('<td style="width: 10%;"><span name="txtRqstL" value="' + neighborSet[i][7] + '">' + neighborSet[i][7] + '</span></td>');
                    html += ('<td><span name="txtDBsmL" value="' + neighborSet[i][8] + '">' + neighborSet[i][8] + '</span></td>');
                    html += ('</tr>');
                }
                $("#neighborBody").html(html);
            }
            let rCount = routeSet.length;
            if (currentStatus && rCount > 0) {
                html = ('');
                for (let i = 0; i < rCount; i++) {
                    html += ('<tr>');
                    html += ('<td style="width: 25%;"><span name="txtNet" value="' + routeSet[i][0] + '">' + routeSet[i][0] + '</span></td>');
                    html += ('<td style="width: 25%;"><span name="txtHop" value="' + routeSet[i][1] + '">' + routeSet[i][1] + '</span></td>');
                    html += ('<td style="width: 15%;"><span name="txtMetric" value="' + routeSet[i][2] + '">' + routeSet[i][2] + '</span></td>');
                    // html += ('<td style="width: 20%;"><span name="txtTag" value="' + routeSet[i][3] + '">' + routeSet[i][3] + '</span></td>');
                    html += ('<td><span name="txtTime" value="' + routeSet[i][3] + '">' + routeSet[i][3] + '</span></td>');
                    html += ('</tr>');
                }
                $("#routeBody").html(html);
            }
            let bCount = databaseSet.length;
            if (currentStatus && bCount > 0) {
                html = ('');
                for (let i = 0; i < bCount; i++) {
                    html += ('<tr>');
                    html += ('<td style="width:15%;"><span name="txtLink" value="' + databaseSet[i][0] + '">' + databaseSet[i][0] + '</span></td>');
                    html += ('<td style="width: 20%;"><span name="txtAdv" value="' + databaseSet[i][1] + '">' + databaseSet[i][1] + '</span></td>');
                    html += ('<td style="width: 15%;"><span name="txtAge" value="' + databaseSet[i][2] + '">' + databaseSet[i][2] + '</span></td>');
                    html += ('<td style="width: 15%;"><span name="txtSeq" value="' + databaseSet[i][3] + '">' + databaseSet[i][3] + '</span></td>');
                    html += ('<td style="width: 15%;"><span name="txtCkSum" value="' + databaseSet[i][4] + '">' + databaseSet[i][4] + '</span></td>');
                    html += ('<td><span name="txtRoute" value="' + databaseSet[i][5] + '">' + databaseSet[i][5] + '</span></td>');
                    html += ('</tr>');
                }
                $("#databaseBody").html(html);
            }
        }

        function checkData(route, area) {
            let flag = true;
            let regRoute = /^(?:(?:[0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}(?:[0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\/([1-9]|[1-2]\d|3[0-2])$/;
            let regArea = /^[0-9]+$/;
            if (!regRoute.test(route)) {
                alert("输入地址不合法");
                flag = false;
            }
            else if (!regArea.test(area)) {
                alert("area必须为正整数");
                flag = false;
            }
            return flag;
        }

        //点击sel，展示多选框
        function myclick() {
            selecteddiv.style.display = "block";
        }

        //鼠标进入多选框的div【selectdiv】
        function mousein() {
            indiv = true;
        }

        //鼠标离开多选框的div【selectdiv】
        function mouseout() {
            indiv = false;
        }

        //checkbox的点击事件
        function mycheck(obj) {
            if (obj.checked) {
                selectedlist.push(obj.value);
                selectednamelist.push($(obj).attr("textValue"));
            } else {
                for (var i = 0; i < selectedlist.length; i++) {
                    if (selectedlist[i] == obj.value) {
                        selectedlist.splice(i, 1);
                        selectednamelist.splice(i, 1);
                    }
                }
            }
            document.getElementById("selRedisGroup").value = selectednamelist;
        }

        function resetDropDown(redisGroup) {
            selectedlist = [];
            var checkBoxList = document.getElementsByName("mycheckbox");
            var nCount = redisGroup.length;
            for (var i = 0; i < nCount; i++) {
                var tmpNum = redisArray.findIndex(value => value == redisGroup[i]);
                selectedlist.push(tmpNum);
            }

            for (var j = 0; j < checkBoxList.length; j++) {
                for (var k = 0; k < selectedlist.length; k++) {
                    if (j == selectedlist[k]) {
                        checkBoxList[j].setAttribute("checked", "checked");
                    }
                }
            }
        }


        $("#btnEnable").click(function () {
            $("[name='hEnable']").val(1);
            $("#hEnableForm").submit();
        });

        $("#btnDisable").click(function () {
            $("[name='hEnable']").val(0);
            $("#hEnableForm").submit();
        });

        $("#btnAdd").click(function () {
            $("#editNet").val("");
            $("#editArea").val("");
            $("#modeModal").modal('show');
        });

        $("#btnOspfSave").click(function () {
            let route = $("#editNet").val();
            let area = $("#editArea").val();
            if (area.trim() == "") {
                area = 0;
            }
            if (checkData(route, area)) {
                let network = route.concat(',', area);
                $("[name='hNetwork']").val(network);
                $("#hPostForm").submit();
            }
        });

        $("#btnSubmit").click(function () {
            if (currentRedis.toString() == selectednamelist.toString()) {
                alert("没有更改");
                return;
            }
            let tmpStr = selectednamelist.join(',');
            $("[name='hRedis']").val(tmpStr.trim());
            $("#hRedisForm").submit();
        });

        $("#ospfBody").on('click', '[name="btnDelete"]', function () {
            let network = $(this).parents("tr").find("[name='txtNet']").attr("value");
            let area = $(this).parents("tr").find("[name='txtArea']").attr("value");
            let route = network.concat(',',area);
            if (route.trim() != "") {
                $("[name='hDelete']").val(route);
                $("#hDeleteForm").submit();
            }
        });

        //检验是否有滚动条，有就把头部的div设置padding-right
        function isScroll() {
            let dHeight = $("#networkTable")[0].scrollHeight;
            let nHeight = $("#neighborTable")[0].scrollHeight;
            let bHeight = $("#databaseTable")[0].scrollHeight;
            let rHeight = $("#routeTable")[0].scrollHeight;
            if (dHeight > 300) {
                $("#netHead").attr("style", "padding-right:17px;");
            }
            if (nHeight > 300) {
                $("#neighborHead").attr("style", "padding-right:17px;");
            }
            if (rHeight > 300) {
                $("#routeHead").attr("style", "padding-right:17px;");
            }
            if (bHeight > 300) {
                $("#databaseHead").attr("style", "padding-right:17px;");
            }
        }

        $(document).ready(function () {
            getData();
            loadPage();
            isScroll();
        });

        //鼠标点击事件，如果点击在 selectedbutton，或者是在多选框div中的点击事件，不作处理。其他情况的点击事件，将多选空div隐藏
        document.onclick = function (event) {
            if (event.target.id == "selRedisGroup" || indiv) {
                return;
            }
            selecteddiv.style.display = "none";
        };

    </script>
</body>
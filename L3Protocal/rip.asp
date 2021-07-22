<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Rip</title>
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
        Rip协议</h3>
    <br>
    <div style="height: 50px;">
        <button type="button" class="btn btn-primary" id="btnEnable" style="margin-left: 20px;">使能</button>
        <button type="button" class="btn btn-primary" id="btnDisable" style="margin-left: 20px;">不使能</button>
        <button type="button" class="btn btn-primary" id="btnAdd" style="margin-left: 20px;">新建</button>
    </div>
    <div class="container-fluid" id="ripInfo">
        <div class="row" style="margin: 20px 0px;">
            <label class="col-md-offset-4 col-md-3 control-label" id="info1">

            </label>
            <label class="col-md-3 control-label" id="info2">

            </label>
        </div>
        <div class="row" style="margin: 20px 0px;">
            <label class="col-md-offset-4 col-md-3 control-label" id="info3">

            </label>
            <label class="col-md-3 control-label" id="info4">

            </label>
        </div>
        <div class="row" style="margin: 20px 0px;">
            <label class="col-md-offset-4 col-md-3 control-label" id="info5"></label>
            <label class="col-md-3 control-label" id="info6">

            </label>
        </div>
    </div>
    <div class="row" id="ripRedis">
        <div class="col-md-offset-3 col-md-4" id="ripTable">
            <table class="table table-striped table-bordered " style="max-width:600px;margin: 10px;">
                <thead style="font-weight: bolder;">
                    <tr>
                        <td width="20%">Routing for Networks</td>
                        <td width="10%">操作</td>
                    </tr>
                </thead>
                <tbody id="ripBody">
                </tbody>
            </table>
        </div>
        <div class="col-md-1">
            <label>Redistributing:</label>
        </div>
        <div class="col-md-3">
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
                        textvalue="ospf">
                    <label for="checkboxFourInput2" name="mychecklabel" class="mark">ospf</label>
                </div>
            </div>
        </div>
        <div class="col-md-1">
            <button type="button" class="btn btn-primary" id="btnSubmit" style="margin-left: 20px;">提交</button>
        </div>
    </div>




    <div id="ripRouteTable">
        <table class="table table-striped table-bordered " style="width: 95;margin: 10px;">
            <thead style="font-weight: bolder;">
                <tr>
                    <td width="20%">Network</td>
                    <td width="20%">Next Hop</td>
                    <td width="15%">Metric</td>
                    <td width="15%">From Tag</td>
                    <td width="15%">Time</td>
                </tr>
            </thead>
            <tbody id="ripRouteBody">

            </tbody>
        </table>
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
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="btnRipSave">提交更改</button>
                </div>
            </div>
        </div>
    </div>
    <div>
        <form id="hPostForm" style="visibility: hidden; display: none;" method="post" action="/goform/ripFormPost">
            <input name="hNetwork" value="" />
        </form>
        <form id="hDeleteForm" style="visibility: hidden; display: none;" method="post" action="/goform/ripFormDelete">
            <input name="hDelete" value="" />
        </form>
        <form id="hEnableForm" style="visibility: hidden; display: none;" method="post" action="/goform/ripFormEnable">
            <input name="hEnable" value="" />
        </form>
        <form id="hRedisForm" style="visibility: hidden; display: none;" method="post" action="/goform/ripFormRedis">
            <input name="hRedis" value="" />
        </form>
    </div>
    <script>
        var currentStatus = 1;
        var dataSet = [];
        var dataInfo = [];
        var dataRouteSet = [];
        var redisArray = ["connected", "static", "ospf"];
        var currentRedis = [];
        var selectedlist = [];
        var selectednamelist = [];
        var selectNet = "";
        var html = ('');
        var isCreateNew = false;
        var indiv = false;
        var selecteddiv = document.getElementById("selectdiv");
        function getData() {
            let ripData = "<%ripAspGetAll();%>";
            let ripInfoData = "<%ripAspGetInfo();%>";
            let ripStatus = "<%ripAspGetStatus();%>";
            let ripRouteData = "<%ripAspGetAllRoute();%>";
            currentStatus = parseInt(ripStatus.trim());
            if (ripData.trim() != "") {
                ripData = ripData.trim();
                if (ripData.lastIndexOf('|') == ripData.length - 1) {
                    ripData = ripData.substring(0, ripData.length - 1);
                }
                let tmpRipData = ripData.split('|');
                let tCount = tmpRipData.length;
                if (tCount > 0) {
                    dataSet = [];
                    for (let i = 0; i < tCount; i++) {
                        dataSet.push([tmpRipData[i]]);
                    }
                }
            }
            if (ripInfoData.trim() != "") {
                ripInfoData = ripInfoData.trim();
                if (ripInfoData.lastIndexOf(',') == ripInfoData.length - 1) {
                    ripInfoData = ripInfoData.substring(0, ripInfoData.length - 1);
                }
                tmpInfoData = ripInfoData.split(',');
                dataInfo.push(tmpInfoData[0].trim(), tmpInfoData[1].trim(), tmpInfoData[2].trim(), tmpInfoData[3].trim(), tmpInfoData[4].trim(), tmpInfoData[5].trim().concat(',', tmpInfoData[6].trim()));
            }
            if (ripRouteData.trim() != "") {
                if (ripRouteData.lastIndexOf('|') == ripRouteData.length - 1) {
                    ripRouteData = ripRouteData.substring(0, ripRouteData.length - 1);
                }
                let tmpRouteData = ripRouteData.split('|');
                let tCount = tmpRouteData.length;
                if (tCount > 0) {
                    dataRouteSet = [];
                    for (let i = 0; i < tCount; i++) {
                        let rowData = tmpRouteData[i].split(',');
                        dataRouteSet.push([rowData[0], rowData[1], rowData[2].trim(), rowData[3], rowData[4]]);
                    }
                }
            }
            if (dataInfo.length > 1) {
                selectednamelist = [];
                let tmpRedis = dataInfo[4];
                let index = tmpRedis.indexOf(':');
                //tirm去掉头尾空格，拆分以两个空格为准
                tmpRedis = tmpRedis.substring(index + 1).trim();
                if(tmpRedis!=""){
                    selectednamelist = tmpRedis.split('  ');
                }
                document.getElementById("selRedisGroup").value = selectednamelist;
                resetDropDown(selectednamelist);
            }
        }

        function loadPage() {
            if (!currentStatus) {
                $("#btnAdd").attr("disabled", "disabled");
                $("#btnDisable").attr("disabled", "disabled");
                $("#ripInfo").attr("style", "display:none;");
                $("#ripTable").attr("style", "display:none;");
                $("#ripRedis").attr("style", "display:none;");
            }
            else {
                $("#btnEnable").attr("disabled", "disabled");
                $("#btnAdd").removeAttr("disabled");
                $("#btnDisable").removeAttr("disabled");
                $("#ripInfo").removeAttr("style");
                $("#ripTable").removeAttr("style");
                $("#ripRedis").removeAttr("style");
            }
            if (currentStatus && dataSet.length > 0) {
                let dCount = dataSet.length;
                html = ('');
                for (let i = 0; i < dCount; i++) {
                    html += ('<tr>');
                    html += ('<td><span name="txtNet" value="' + dataSet[i][0] + '">' + dataSet[i][0] + '</span></td>');
                    html += ('<td>');
                    html += ('<button type="button" class="btn btn-primary" style="margin-left:20px;"  name="btnDelete" value="' + dataSet[i][0] + '">删除</button>');
                    html += ('</td');
                    html += ('</tr>');
                }
                $("#ripBody").html(html);
            }
            if (dataInfo.length > 1) {
                $("#info1").html(dataInfo[0]);
                $("#info2").html(dataInfo[1]);
                $("#info3").html(dataInfo[2]);
                $("#info4").html(dataInfo[3]);
                $("#info5").html(dataInfo[4]);
                $("#info6").html(dataInfo[5]);
            }
            if (currentStatus && dataRouteSet.length > 0) {
                let dCount = dataRouteSet.length;
                html = ('');
                for (let i = 0; i < dCount; i++) {
                    html += ('<tr>');
                    html += ('<td><span name="txtNet" value="' + dataRouteSet[i][0] + '">' + dataRouteSet[i][0] + '</span></td>');
                    html += ('<td><span name="txtHop" value="' + dataRouteSet[i][1] + '">' + dataRouteSet[i][1] + '</span></td>');
                    html += ('<td><span name="txtMetric" value="' + dataRouteSet[i][2] + '">' + dataRouteSet[i][2] + '</span></td>');
                    html += ('<td><span name="txtTag" value="' + dataRouteSet[i][3] + '">' + dataRouteSet[i][3] + '</span></td>');
                    html += ('<td><span name="txtTime" value="' + dataRouteSet[i][4] + '">' + dataRouteSet[i][4] + '</span></td>');
                    html += ('</tr>');
                }
                $("#ripRouteBody").html(html);
            }
        }

        function checkData(route) {
            var flag = true;
            let regRoute = /^(?:(?:[0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}(?:[0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\/([1-9]|[1-2]\d|3[0-2])$/;
            if (!regRoute.test(route)) {
                alert("输入地址不合法");
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
            $("#editRoute").val("");
            selectNet = "";
            isCreateNew = true;
            $("#myModalLabel").html("新增");
            $("#editNet").val("");
            $("#modeModal").modal('show');
        });

        $("#btnRipSave").click(function () {
            let route = $("#editNet").val();
            if (checkData(route)) {
                $("[name='hNetwork']").val(route);
                $("#hPostForm").submit();
            }
        });

        $("#ripBody").on('click', '[name="btnEdit"]', function () {
            isCreateNew = false;
            $("#myModalLabel").html("修改");
            selectNet = $(this).attr("value");
            let network = $(this).parents("tr").find("[name='txtNet']").attr("value");
            $("#editNet").val(network);
            $("#modeModal").modal('show');
        });

        $("#ripBody").on('click', '[name="btnDelete"]', function () {
            let route = $(this).attr("value");
            if (route.trim() != "") {
                $("[name='hDelete']").val(route);
                $("#hDeleteForm").submit();
            }
        });

        $("#btnSubmit").click(function(){
            let tmpStr = selectednamelist.join(',');
            $("[name='hRedis']").val(tmpStr.trim());
            $("#hRedisForm").submit();
        });

        $(document).ready(function () {
            getData();
            loadPage();
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
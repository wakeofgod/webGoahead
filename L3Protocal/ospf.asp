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
    <div class="container-fluid" id="ospfInfo">
        <div class="row" style="margin: 20px 0px;">
            <label class="col-md-offset-4 col-md-3 control-label" id="info1">
                info1
            </label>
            <label class="col-md-3 control-label" id="info2">
                info2
            </label>
        </div>
        <div class="row" style="margin: 20px 0px;">
            <label class="col-md-offset-4 col-md-3 control-label" id="info3">
                info3
            </label>
            <label class="col-md-3 control-label" id="info4">
                info4
            </label>
        </div>
        <div class="row" style="margin: 20px 0px;">
            <label class="col-md-offset-4 col-md-3 control-label" id="info5">info5</label>
            <label class="col-md-3 control-label" id="info6">
                info6
            </label>
        </div>
    </div>
    <div class="row" id="ospfRedis" style="max-width: 98%;">
        <div id="ospfTable" class="col-md-4 col-lg-4" style="height: 300px;overflow-y: auto;">
            <table class="table table-striped table-bordered " style="max-width: 500px; margin-left: 20px;">
            <thead style="font-weight: bolder;">
                <tr>
                        <td width="300">Network</td>
                        <td width="100">操作</td>
                    </tr>
                </thead>
                <tbody id="ospfBody">
                    <td>
                        <span name="txtNet" value="0.0.0.0/0">0.0.0.0/0</span>
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary" style="margin-left:20px;" name="btnDelete"
                            value="row1">删除</button>
                    </td>
                </tbody>
            </table>
        </div>
        <div class="col-md-offset-2 col-lg-offset-2 col-lg-1 col-md-1">
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
            <div class="col-md-6 col-lg-6" style="height:300px;overflow-y:auto;">
                <h3 style="text-align: center;text-transform: uppercase;">ospf route</h3>
                <table class="table table-striped table-bordered " style="margin: 10px;">
                    <thead>
                        <tr>
                            <td>Network</td>
                            <td>Next Hop</td>
                            <td>Metric</td>
                            <td>From Tag</td>
                            <td>Time</td>
                        </tr>
                    </thead>
                    <tbody id="routeBody">
                        <tr>
                            <td>Network</td>
                            <td>Next Hop</td>
                            <td>Metric</td>
                            <td>From Tag</td>
                            <td>Time</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="col-md-6 col-lg-6" style="height:300px;overflow-y:auto;margin-top: 20px;">
                <h3 style="text-align: center;text-transform: uppercase;">ospf database</h3>
                <table class="table table-striped table-bordered " style="margin: 10px;">
                    <thead>
                        <tr>
                            <td>Link ID</td>
                            <td>ADV Router</td>
                            <td>Age</td>
                            <td>Seq#</td>
                            <td>CkSum</td>
                            <td>Route</td>
                        </tr>
                    </thead>
                    <tbody id="databaseBody">
                        <tr>
                            <td><span name="txtLink" value="Link">Link ID</span></td>
                            <td><span name="txtAdv" value="ADV Router">ADV Router</span></td>
                            <td><span name="txtAge" value="Age">Age</span></td>
                            <td><span name="txtSeq" value="Seq">Seq</span></td>
                            <td><span name="txtCkSum" value="Link">CkSum</span></td>
                            <td><span name="txtRoute" value="Route">Route</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="col-md-12 col-lg-12" style="height:300px; overflow-y:auto;">
                <h3 style="text-align: center;text-transform: uppercase;">ospf neighbor</h3>
                <table class="table table-striped table-bordered " style="margin: 10px;">
                    <thead>
                        <tr>
                            <td>Neighbor Id</td>
                            <td>Pri</td>
                            <td>State</td>
                            <td>Dead Time</td>
                            <td>Address</td>
                            <td>Interface</td>
                            <td>RXmtL</td>
                            <td>RqstL</td>
                            <td>DBsmL</td>
                        </tr>
                    </thead>
                    <tbody id="neighborBody">
                        <tr>
                            <td><span name="txtNId">Neighbor Id</span></td>
                            <td><span name="txtPri">Pri</span></td>
                            <td><span name="txtState">State</span></td>
                            <td><span name="txtDead">Dead Time</span></td>
                            <td><span name="txtAddress">Address</span></td>
                            <td><span name="txtInterface">Interface </span></td>
                            <td><span name="txtRXmtL">RXmtL</span></td>
                            <td><span name="txtRqstL">RqstL</span></td>
                            <td><span name="txtDBsmL">DBsmL</span></td>
                        </tr>
                    </tbody>
                </table>
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
            let ospfInfoData ="<%ospfAspGetInfo();%>";
            let ospfNetData = "<%ospfAspGetNet();%>";
            let ospfNeighborData = "<%ospfAspGetNeighbor();%>";
            let ospfDatabaseData = "<%ospfAspGetDatabase();%>";
            let ospfRouteData = "<%ospfAspGetRoute();%>";
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
                $("#ospfRedis").attr("style","width:95%;");
                $("#ospfTableGroup").removeAttr("style");
            }
            let dCount = dataset.length;
            if (currentStatus && dCount > 0) {
                html = ('');
                for (let i = 0; i < dCount; i++) {
                    html += ('<tr>');
                    html += ('<td><span name="txtNet" value="' + dataset[i][0] + '">' + dataset[i][0] + '</span></td>');
                    html += ('<td>');
                    html += ('<button type="button" class="btn btn-primary" style="margin-left:20px;"  name="btnDelete" value="' + dataset[i][0] + '">删除</button>');
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
                    html += ('<td><span name="txtNId" value="' + neighborSet[i][0] + '">' + neighborSet[i][0] + '</span></td>');
                    html += ('<td><span name="txtPri" value="' + neighborSet[i][1] + '">' + neighborSet[i][1] + '</span></td>');
                    html += ('<td><span name="txtState" value="' + neighborSet[i][2] + '">' + neighborSet[i][2] + '</span></td>');
                    html += ('<td><span name="txtDead" value="' + neighborSet[i][3] + '">' + neighborSet[i][3] + '</span></td>');
                    html += ('<td><span name="txtAddress" value="' + neighborSet[i][4] + '">' + neighborSet[i][4] + '</span></td>');
                    html += ('<td><span name="txtInterface" value="' + neighborSet[i][5] + '">' + neighborSet[i][5] + '</span></td>');
                    html += ('<td><span name="txtRXmtL" value="' + neighborSet[i][6] + '">' + neighborSet[i][6] + '</span></td>');
                    html += ('<td><span name="txtRqstL" value="' + neighborSet[i][7] + '">' + neighborSet[i][7] + '</span></td>');
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
                    html += ('<td><span name="txtNet" value="' + routeSet[i][0] + '">' + routeSet[i][0] + '</span></td>');
                    html += ('<td><span name="txtHop" value="' + routeSet[i][1] + '">' + routeSet[i][1] + '</span></td>');
                    html += ('<td><span name="txtMetric" value="' + routeSet[i][2] + '">' + routeSet[i][2] + '</span></td>');
                    html += ('<td><span name="txtTag" value="' + routeSet[i][3] + '">' + routeSet[i][3] + '</span></td>');
                    html += ('<td><span name="txtTime" value="' + routeSet[i][4] + '">' + routeSet[i][4] + '</span></td>');
                    html += ('</tr>');
                }
                $("#routeBody").html(html);
            }
            let bCount= databaseSet.length;
            if(currentStatus && bCount>0){
                html = ('');
                for (let i = 0; i < rCount; i++) {
                    html += ('<tr>');
                    html += ('<td><span name="txtLink" value="' + databaseSet[i][0] + '">' + databaseSet[i][0] + '</span></td>');
                    html += ('<td><span name="txtAdv" value="' + databaseSet[i][1] + '">' + databaseSet[i][1] + '</span></td>');
                    html += ('<td><span name="txtAge" value="' + databaseSet[i][2] + '">' + databaseSet[i][2] + '</span></td>');
                    html += ('<td><span name="txtSeq" value="' + databaseSet[i][3] + '">' + databaseSet[i][3] + '</span></td>');
                    html += ('<td><span name="txtCkSum" value="' + databaseSet[i][4] + '">' + databaseSet[i][4] + '</span></td>');
                    html += ('<td><span name="txtRoute" value="' + databaseSet[i][5] + '">' + databaseSet[i][5] + '</span></td>');
                    html += ('</tr>');
                }
                $("#databaseBody").html(html);
            }
        }

        function checkData(route) {
            let flag = true;
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
            $("#modeModal").modal('show');
        });

        $("#btnOspfSave").click(function(){
            let route = $("#editNet").val();
            if (checkData(route)) {
                alert("输入合法");
            }
        });

        $("#btnSubmit").click(function () {
            alert(selectednamelist);
            let tmpStr = selectednamelist.join(',');
            $("[name='hRedis']").val(tmpStr.trim());
            $("#hRedisForm").submit();
        });

        $("#ospfBody").on('click', '[name="btnDelete"]', function () {
            alert($(this).attr("value"));
            let route = $(this).attr("value");
            if (route.trim() != "") {
                $("[name='hDelete']").val(route);
                $("#hDeleteForm").submit();
            }
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
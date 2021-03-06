<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>EAPS</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <style type=text/css>
        .mySelect {
            width: 100%;
            height: 25px;
            border: 1px solid;
            overflow: auto;
            max-width: 150px;
        }

        input[type=checkbox] {
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
    <script>

    </script>
</head>

<body>
    <h3
        style="font-weight: bolder; text-align: center;background-color: rgb(241,241,241);height: 48px;line-height: 48px;">
        EAPS</h3>
    <br>
    <div class="container-fluid">
        <div class="row">
            <label class="col-md-1" style="text-transform: uppercase;">ERRP状态:</label>
            <label class="col-md-1" style="color: #FFA07A;" id="txtStatus">不使能</label>
            <div class="col-md-4">
                <button type="button" id="btnErrpEnable" class="btn btn-primary" style="margin-left: 20px;">使能</button>
                <button type="button" id="btnErrpDiasabe" class="btn btn-primary"
                    style="margin-left: 20px;">不使能</button>
                <button type="button" id="btnAdd" class="btn btn-primary" style="margin-left: 20px;">新建</button>
            </div>
        </div>
        <div class="row">
            <div id="errpHead">
                <h3 style="text-align: center;text-transform: uppercase;">errp domain</h3>
                <table class="table table-striped table-bordered table-hover">
                    <thead style="font-weight: bolder;">
                        <tr>
                            <td width="5%">id</td>
                            <td width="5%">name</td>
                            <td width="5%">status</td>
                            <td width="8%">work mode</td>
                            <!-- <td width="8%">protocal mode</td>
                            <td width="5%">state</td> -->
                            <td width="8%">primary port</td>
                            <td width="8%">second port</td>
                            <td width="8%">control vlan</td>
                            <td width="10%">protect vlan</td>
                            <td width="8%">hello time</td>
                            <td width="8%">hello fail time</td>
                            <td width="8%">up flush fail time</td>
                            <td>操作</td>
                        </tr>
                    </thead>
                </table>
            </div>
            <div style="height:550px;overflow-y:auto;overflow-x: hidden;margin-top: -22px;" id="errpTable">
                <table id="myTable" class="table table-striped table-bordered table-hover">
                    <tbody id="tBody">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">添加</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped table-bordered">
                        <tbody>
                            <tr>
                                <td>Domain Id</td>
                                <td>
                                    <select id="editId" title="模式下拉框" class="mySelect">

                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Domain name</td>
                                <td>
                                    <input id="editName" maxlength="30" placeholder="请输入名称" type="text" title="端口输入框"
                                        style="width: 100%;">
                                </td>
                            </tr>
                            <tr>
                                <td>Domain mode</td>
                                <td>
                                    <select id="selMode" title="模式下拉框" class="mySelect">
                                        <option value="2">transit</option>
                                        <option value="1">master</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Domain protocol</td>
                                <td>
                                    <select id="selProtocal" title="协议下拉框" class="mySelect">
                                        <option value="0">errp</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Control vlan</td>
                                <td>
                                    <select id="selControl" title="control vlan" class="mySelect">

                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Protect vlan</td>
                                <td>
                                    <div style="width:100%;height:28px;overflow:hidden;">
                                        <input type="text" id="selProtect" onclick="myclick();" readonly="true"
                                            style="width:100%;height:28px;">
                                    </div>
                                    <div id="selectdiv"
                                        style="display:none;border:1px solid #A9A9A9;width:200px;z-index:2;position:absolute;overflow-y :scroll;height:100px;background-color:white;"
                                        onMouseOver="mousein()" onMouseOut="mouseout()">
                                        <br>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Primary port</td>
                                <td>
                                    <select id="selPriPort" title="primary port" class="mySelect">

                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Secondary port</td>
                                <td>
                                    <select id="selSecPort" title="secondary port" class="mySelect">

                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Hello time</td>
                                <td>
                                    <input id="helloTime" maxlength="30" placeholder="请输入1-50" type="text" title="端口输入框"
                                        style="width: 100%;">
                                </td>
                            </tr>
                            <tr>
                                <td>Hello fail time</td>
                                <td>
                                    <input id="helloFailTime" maxlength="30" placeholder="请输入1-50" type="text"
                                        title="端口输入框" style="width: 100%;">
                                </td>
                            </tr>
                            <tr>
                                <td>Up flush fail time</td>
                                <td>
                                    <input id="upFlushTime" maxlength="30" placeholder="请输入1-50" type="text"
                                        title="端口输入框" style="width: 100%;">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="btnSave">提交</button>
                </div>
            </div>
        </div>
    </div>
    <div>
        <form id="hPostForm" style="visibility: hidden; display: none;" method="post" action="/goform/errpFormPost">
            <input name="hId" value="" />
            <input name="hName" value="" />
            <input name="hMode" value="" />
            <input name="hProtocol" value="" />
            <input name="hControl" value="" />
            <input name="hProtect" value="" />
            <input name="hPrimary" value="" />
            <input name="hSecond" value="" />
            <input name="hHelloTime" value="" />
            <input name="hFailTime" value="" />
            <input name="hUpTime" value="" />
        </form>
        <form id="hEnableForm" style="visibility: hidden; display: none;" method="post" action="/goform/errpFormEnable">
            <input name="hEnable" value="" />
        </form>
        <form id="hSingalForm" style="visibility: hidden; display: none;" method="post" action="/goform/errpFormSingalEnable">
            <input name="hSId" value="" />
            <input name="hSName" value="" />
            <input name="hSEnable" value="" />
        </form>
        <form id="hDeleteForm" style="visibility: hidden; display: none;" method="post" action="/goform/errpFormDelete">
            <input name="hDId" value="" />
        </form>
    </div>
    <script>
        var currentStatus = 0;
        var currentDomainId = 1;
        var dataset = [];
        var ethPortSet = [];
        var vlanSet = [];
        var statusTextArray = ["不使能", "使能"];
        var modeTextArray = ["NAN", "master", "transit"];
        var protocalArray = ["errp", "eaps"];
        var existName = [];
        var html = "";
        var originId = [];
        var selectedlist = [];
        var selectednamelist = [];
        var protectDiv = document.getElementById("selectdiv");
        var indiv = false;
        function getData() {
            let vlanData = "<%errpAspGetVlan();%>";
            let ethPortData = "<%errpAspGetEth();%>";
            let errpData = "<%errpAspGetAll();%>";
            let statusData = "<%errpAspGetStatus();%>";
            for (let i = 0; i < 64; i++) {
                originId.push(i + 1);
            }
            if (statusData.trim() != "") {
                currentStatus = parseInt(statusData);
                $("#txtStatus").html(statusTextArray[currentStatus]);
            }
            //eth下拉框
            if (ethPortData.trim() != "") {
                ethPortData = ethPortData.trim();
                if (ethPortData.lastIndexOf('*') == ethPortData.length - 1) {
                    ethPortData = ethPortData.substring(0, ethPortData.length - 1);
                }
                ethPortSet = ethPortData.split('*');
            }
            //vlan下拉框
            if (vlanData.trim() != "") {
                vlanData = vlanData.trim();
                if (vlanData.lastIndexOf('|') == vlanData.length - 1) {
                    vlanData = vlanData.substring(0, vlanData.length - 1);
                }
                let tempVlanData = vlanData.split('|');
                let tCount = tempVlanData.length;
                if (tCount > 0) {
                    for (let i = 0; i < tCount; i++) {
                        if (tempVlanData[i].trim() != "") {
                            let rowData = tempVlanData[i].split(',');
                            if (rowData[0].trim() != "default") {
                                vlanSet.push(rowData[0]);
                            }
                        }
                    }
                }
            }
            //errp table
            if (errpData.trim() != "") {
                errpData = errpData.trim();
                if (errpData.lastIndexOf('|') == (errpData.length - 1)) {
                    errpData = errpData.substring(0, errpData.length - 1);
                }
                let tempErrpData = errpData.split('|');
                let eCount = tempErrpData.length;
                for (let i = 0; i < eCount; i++) {
                    let rowData = tempErrpData[i].split(',');
                    rowData[5] = "vlan" + rowData[5];
                    if (rowData[6].lastIndexOf('-') == rowData[6].length - 1) {
                        rowData[6] = rowData[6].substring(0, rowData[6].length - 1);
                    }
                    let tempArry = rowData[6].split('-');
                    if (tempArry.length > 0) {
                        debugger;
                        for (let j = 0; j < tempArry.length; j++) {
                            tempArry[j] = "vlan" + tempArry[j];
                        }
                    }
                    cleanId(rowData[0]);
                    dataset.push([rowData[0], rowData[1], rowData[2], rowData[3], rowData[4], rowData[5], tempArry, rowData[7], rowData[8], rowData[9], rowData[10]]);
                }
            }
        }

        function cleanId(id) {
            for (let i = 0; i < originId.length; i++) {
                if (originId[i] == id) {
                    originId.splice(i, 1);
                }
            }
        }

        function myclick() {
            protectDiv.style.display = "block";
        }

        function mousein() {
            indiv = true;
        }

        function mouseout() {
            indiv = false;
        }

        //保护vlan是多选
        function loadProtect() {
            $(protectDiv).html("");
            //动态创建protect vlan的checkbox
            for (let i = 0; i < vlanSet.length; i++) {
                let tmpdiv = document.createElement("div");
                let tmpinput = document.createElement("input");
                let tmpId = "checkboxProtect" + i;
                tmpinput.setAttribute("name", "protectCheckbox");
                tmpinput.setAttribute("type", "checkbox");
                tmpinput.setAttribute("onclick", "protectCheck(this)");
                tmpinput.setAttribute("value", vlanSet[i].substring(4));
                tmpinput.setAttribute("id", tmpId);
                tmpinput.setAttribute("textValue", vlanSet[i]);

                tmpdiv.appendChild(tmpinput);
                let tmplabel = document.createElement("label");
                tmplabel.setAttribute("for", tmpId);
                tmplabel.setAttribute("name", "protectChecklabel");
                tmplabel.innerHTML = vlanSet[i];
                tmplabel.setAttribute("class", "mark");
                tmpdiv.appendChild(tmplabel);

                protectDiv.appendChild(tmpdiv);
            }
        }

        function protectCheck(obj) {
            if (obj.checked) {
                var tmpId = $(obj).attr("id");
                selectedlist.push(obj.value);
                var tmpStr = $(obj).attr("textValue");
                selectednamelist.push(tmpStr.trim());
            } else {
                for (var i = 0; i < selectedlist.length; i++) {
                    if (selectedlist[i] == obj.value) {
                        selectedlist.splice(i, 1);
                        selectednamelist.splice(i, 1);
                    }
                }
            }
            document.getElementById("selProtect").value = selectednamelist;
        }

        function resetProtect() {
            loadProtect();
            selectednamelist = [];
            selectedlist = [];
        }

        function loadPage() {
            //按钮状态
            if (!currentStatus) {
                $("#btnAdd").attr("disabled", "disabled");
                $("#btnErrpDiasabe").attr("disabled", "disabled");
            }
            else {
                $("#btnErrpEnable").attr("disabled", "disabled");
                $("#btnAdd").removeAttr("disabled");
                $("#btnErrpDiasabe").removeAttr("disabled");
            }
            //加载id下拉框
            let oCount = originId.length;
            if (oCount > 0) {
                html = ('');
                html += ('<option value ="-1" selected>请选择</option>');
                for (let i = 0; i < originId.length; i++) {
                    html += ('<option value="' + originId[i] + '">' + originId[i] + '</option>');
                }
                $("#editId").html(html);
            }


            //加载vlan下拉框
            let vCount = vlanSet.length;
            if (vCount > 0) {
                html = ('');
                html += ('<option value ="-1" selected>请选择</option>');
                for (let i = 0; i < vCount; i++) {
                    // if (vlanSet[i][0] == "default") {
                    //     vlanSet[i][0] = "vlan1";
                    // }
                    html += ('<option value="' + vlanSet[i].substring(4) + '">' + vlanSet[i] + '</option>');
                }
                $("#selControl").html(html);
                //$("#selProtect").html(html);
            }
            //加载eth端口下拉框
            let eCount = ethPortSet.length;
            if (eCount > 0) {
                html = ('');
                html += ('<option value="-1" selected>请选择</option>');
                for (let i = 0; i < eCount; i++) {
                    html += ('<option value="' + ethPortSet[i] + '">' + ethPortSet[i] + '</option>');
                }
                $("#selPriPort").html(html);
                $("#selSecPort").html(html);
            }
            //加载主页面table
            let dCount = dataset.length;
            if (currentStatus && dCount > 0) {
                html = ('');
                for (let i = 0; i < dCount; i++) {
                    html += ('<tr>');
                    html += ('<td width="5%"><span name="txtId" value="' + dataset[i][0] + '">' + dataset[i][0] + '</span></td>');
                    html += ('<td width="5%"><span name="txtName" value="' + dataset[i][1] + '">' + dataset[i][1] + '</span></td>');
                    html += ('<td width="5%"><span name="txtStatus" value="' + dataset[i][10] + '">' + statusTextArray[dataset[i][10]] + '</span></td>');
                    html += ('<td width="8%"><span name="txtMode" value="' + dataset[i][2] + '">' + modeTextArray[dataset[i][2]] + '</span></td>');
                    //html += ('<td width="8%"><span name="txtProtocal" value="' + dataset[i][4] + '">' + protocalArray[dataset[i][4]] + '</span></td>');
                    //html += ('<td width="5%"><span name="txtState" value="' + dataset[i][5] + '">' + dataset[i][5] + '</span></td>');
                    html += ('<td width="8%"><span name="txtPrimary" value="' + dataset[i][3] + '">' + dataset[i][3] + '</span></td>');
                    html += ('<td width="8%"><span name="txtSecond" value="' + dataset[i][4] + '">' + dataset[i][4] + '</span></td>');
                    html += ('<td width="8%"><span name="txtControl" value="' + dataset[i][5] + '">' + dataset[i][5] + '</span></td>');
                    html += ('<td width="10%"><span name="txtProtect" value="' + dataset[i][6] + '">' + dataset[i][6] + '</span></td>');
                    html += ('<td width="8%"><span name="txtHelloTime" value="' + dataset[i][7] + '">' + dataset[i][7] + '</span></td>');
                    html += ('<td width="8%"><span name="txtFailTime" value="' + dataset[i][8] + '">' + dataset[i][8] + '</span></td>');
                    html += ('<td width="8%"><span name="txtUpTime" value="' + dataset[i][9] + '">' + dataset[i][9] + '</span></td>');
                    html += ('<td>');
                    //html += ('<button type="button" class="btn btn-primary" data-toggle="modal"name="btnEdit">编辑</button>');
                    if (parseInt(dataset[i][10])) {
                        html += ('<button type="button" style="margin-left:5%;" class="btn btn-primary" disabled="disabled" myid=' + dataset[i][0] + ' myname=' + dataset[i][1] + '  name="btnEnable">使能</button>');
                        html += ('<button type="button" style="margin-left:5%;" class="btn btn-primary" myid=' + dataset[i][0] + ' myname=' + dataset[i][1] + '  name="btnDisable">不使能</button>');
                        html += ('<button type ="button" style="margin-left:5%;" class="btn btn-primary" myid=' + dataset[i][0] + ' myname=' + dataset[i][1] + ' name="btnDelete">删除</button>');
                    }
                    else {
                        html += ('<button type="button" style="margin-left:5%;" class="btn btn-primary" myid=' + dataset[i][0] + ' myname=' + dataset[i][1] + '  name="btnEnable">使能</button>');
                        html += ('<button type="button" style="margin-left:5%;" class="btn btn-primary" disabled="disabled" myid=' + dataset[i][0] + ' myname=' + dataset[i][1] + '  name="btnDisable">不使能</button>');
                        html += ('<button type ="button" style="margin-left:5%;" class="btn btn-primary" myid=' + dataset[i][0] + ' myname=' + dataset[i][1] + ' name="btnDelete">删除</button>');
                    }
                    html += ('</td>');
                    html += ('</tr>');
                }
                $("#tBody").html(html);
            }

        }

        $("#btnErrpEnable").on('click', function () {
            $("[name='hEnable']").val(1);
            $("#hEnableForm").submit();
        });

        $("#btnErrpDiasabe").on('click', function () {
            $("[name='hEnable']").val(0);
            $("#hEnableForm").submit();
        });

        $("#btnAdd").on('click', function () {
            if (dataset.length >= 64) {
                alert("没有可用id");
                return;
            }
            resetProtect();
            $("#myModalLabel").html("新建");
            //currentDomainId = dataset.length + 1;
            //$("#editId").html(currentDomainId);
            $("#editName").val("");
            $("#selMode").val(0);
            $("#selProtocal").val(0);
            $("#selControl").val(-1);
            $("#selProtect").val("");
            $("#selPriPort").val(-1);
            $("#selSecPort").val(-1);
            $("#helloTime").val("");
            $("#helloFailTime").val("");
            $("#upFlushTime").val("");
            $("#myModal").modal({ backdrop: 'static', keyboard: false });
        });

        $("#tBody").on('click', '[name="btnEdit"]', function () {
            $("#myModalLabel").html("编辑");
            let id = $(this).parents("tr").find("[name='txtId']").attr("value");
            let name = $(this).parents("tr").find("[name='txtName']").attr("value");
            let mode = $(this).parents("tr").find("[name='txtMode']").attr("value");
            let protocal = $(this).parents("tr").find("[name='txtState']").attr("value");
            let control = $(this).parents("tr").find("[name='txtControl']").attr("value");
            let protect = $(this).parents("tr").find("[name='txtProtect']").attr("value");
            let primary = $(this).parents("tr").find("[name='txtPrimary']").attr("value");
            let second = $(this).parents("tr").find("[name='txtSecond']").attr("value");
            let helloTime = $(this).parents("tr").find("[name='txtHelloTime']").attr("value");
            let failTime = $(this).parents("tr").find("[name='txtFailTime']").attr("value");
            let upTime = $(this).parents("tr").find("[name='txtUpTime']").attr("value");
            //$("#editId").html(id);
            $("#editName").val(name);
            $("#selMode").val(mode);
            $("#selProtocal").val(protocal);
            $("#selControl").val(control);
            $("#selProtect").val(protect);
            $("#selPriPort").val(primary);
            $("#selSecPort").val(second);
            $("#helloTime").val(helloTime);
            $("#helloFailTime").val(failTime);
            $("#upFlushTime").val(upTime);
            $("#myModal").modal({ backdrop: 'static', keyboard: false });
        });

        $("#tBody").on('click', '[name="btnEnable"]', function () {
            let id = $(this).attr("myid");
            let name = $(this).attr("myname");
            $("[name='hSId']").val(id);
            $("[name='hSName']").val(name);
            $("[name='hSEnable']").val(1);
            $("#hSingalForm").submit();
        });

        $("#tBody").on('click', '[name="btnDisable"]', function () {
            let id = $(this).attr("myid");
            let name = $(this).attr("myname");
            $("[name='hSId']").val(id);
            $("[name='hSName']").val(name);
            $("[name='hSEnable']").val(0);
            $("#hSingalForm").submit();
        });

        $("#tBody").on('click', '[name="btnDelete"]', function () {
            let id = $(this).attr("myid");
            $("[name='hDId']").val(id);
            $("#hDeleteForm").submit();
        });

        $("#btnSave").on('click', function () {
            let id = $("#editId").val();
            let name = $("#editName").val();
            let mode = $("#selMode").val();
            let protocal = $("#selProtocal").val();
            let control = $("#selControl").val();
            //保护vlan可多选，传给后台只要数字，不要vlan字符
            //let protect = $("#selProtect").val();
            let protect = selectedlist.toString();
            let primary = $("#selPriPort").val();
            let second = $("#selSecPort").val();
            let helloTime = $("#helloTime").val();
            let failTime = $("#helloFailTime").val();
            let upTime = $("#upFlushTime").val();
            if (!checkData(name, control, protect, primary, second, helloTime, failTime, upTime)) {
                return;
            }
            else {
                $("[name='hId']").val(id);
                $("[name='hName']").val(name);
                $("[name='hMode']").val(mode);
                $("[name='hProtocol']").val(protocal);
                $("[name='hControl']").val(control);
                $("[name='hProtect']").val(protect);
                $("[name='hPrimary']").val(primary);
                $("[name='hSecond']").val(second);
                $("[name='hHelloTime']").val(helloTime);
                $("[name='hFailTime']").val(failTime);
                $("[name='hUpTime']").val(upTime);
                $("#hPostForm").submit();
            }
        });

        function checkData(name, control, protect, primary, second, helloTime, failTime, upTime) {
            var flag = true;
            var regTime = /^\d{1,2}$/;
            if (selectedlist.length > 0) {
                for (let i = 0; i < selectedlist.length; i++) {
                    if (selectedlist[i] == control) {
                        flag = false;
                        alert("控制vlan和保护vlan不能相同");
                        break;
                    }
                }
            }
            // if (control == protect) {
            //     flag = false;
            //     alert("控制vlan和保护vlan不能相同");
            // }
            if (primary == second) {
                flag = false;
                alert("主节点和传输节点不能相同");
            }
            else if (!regTime.test(helloTime) || helloTime > 50 || helloTime < 0) {
                flag = false;
                alert("hello time 输入错误");
            }
            else if (!regTime.test(failTime) || failTime > 50 || failTime < 0) {
                flag = false;
                alert("hello fail time 输入错误");
            }
            else if (!regTime.test(upTime) || upTime > 50 || upTime < 0) {
                flag = false;
                alert("up flush fail time 输入错误");
            }
            return flag;
        }

        function isScroll() {
            let eHeight = $("#errpTable")[0].scrollHeight;
            if (eHeight > 650) {
                $("#errpHead").attr("style", "padding-right:17px;");
            }

        }

        $(document).ready(function () {
            getData();
            loadPage();
            loadProtect();
            isScroll();
        });

        document.onclick = function (event) {
            if (event.target.id == "selProtect" || indiv) {
                return;
            }
            protectDiv.style.display = "none";
        };
    </script>
</body>

</html>
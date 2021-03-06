<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>TRUNk</title>
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
        TRUNK配置</h3>
    <br>
    <div style="height: 50px;">
        <button type="button" class="btn btn-primary" style="float: left !important;margin-left: 5%;" id="btnCreate">新建</button>
    </div>
    <div class="container-fluid" style="width: 95%;">
        <div class="row">
            <div id="trunkHead">
                <table class="table table-striped table-bordered table-hover">
                    <thead style="font-weight: bolder;">
                        <tr>
                            <td width="10%">TRUNK名称</td>
                            <td width="10%">TRUNK描述</td>
                            <td width="10%">管理状态</td>
                            <td width="10%">操作状态</td>
                            <td width="10%">调度策略</td>
                            <td width="10%">PVID</td>
                            <td width="10%">MTU</td>
                            <td width="20%">ETH成员</td>
                            <td>操作</td>
                        </tr>
                    </thead>
                </table>
            </div>
            <div id="trunkTable" style="height:650px;overflow-y:auto;overflow-x: hidden;margin-top: -22px;">
                <table class="table table-striped table-bordered table-hover">
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
                    <h4 class="modal-title" id="myModalLabel">修改</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped table-bordered">
                        <tbody>
                            <tr>
                                <td>名称</td>
                                <td>
                                    <input id="editTrunkNo" title="trunk输入框" type="text" placeholder="请输入trunk编号"
                                        style="width: 100%;">
                                    <span id="txtEditTrunkNo"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>描述</td>
                                <td>
                                    <input id="editTrunkDes" maxlength="30" type="text" title="描述输入框"
                                        style="width: 100%;">
                                </td>
                            </tr>
                            <tr>
                                <td>管理状态</td>
                                <td>
                                    <select id="editManStatus" title="管理状态下拉框" class="mySelect">
                                        <option value="0">down</option>
                                        <option value="1">up</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>操作状态</td>
                                <td>
                                    <span id="txtOperStatus"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>调度策略</td>
                                <td>
                                    <select id="editStrategy" title="策略下拉框" class="mySelect">
                                        <option value="1">port-based</option>
                                        <option value="2">mac-based</option>
                                        <option value="3">other</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Pvid</td>
                                <td>
                                    <input id="editPvid" title="PVID输入框" placeholder="请输入2至4094间的数字" min="2" max="4094"
                                        style="width: 100%;">
                                </td>
                            </tr>
                            <tr>
                                <td>MTU</td>
                                <td><input title="MTU输入框" placeholder="请输入1000至3000的数字" id="editMtu" min="1000"
                                        max="3000" style="width: 100%;"></td>
                            </tr>
                            <tr>
                                <td>ETH成员</td>
                                <td>
                                    <div style="width:100%;height:28px;overflow:hidden;">
                                        <input type="text" id="selEthGroup" onclick="myclick();" readonly="true"
                                            style="width:100%;height:28px;">
                                    </div>
                                    <div id="selectdiv"
                                        style="display:none;border:1px solid #A9A9A9;width:200px;z-index:2;position:absolute;overflow-y :scroll;height:100px;background-color:white;"
                                        onMouseOver="mousein()" onMouseOut="mouseout()">
                                        <br>
                                    </div>
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
        <form id="hPostForm" style="display: none; visibility:hidden;" method="post" action="/goform/trunkFormPost">
            <input name="hNo" value="" />
            <input name="hDes" value="" />
            <input name="hManStatus" value="" />
            <input name="hOperStatus" value="" />
            <input name="hPvid" value="" />
            <input name="hStrategy" value="" />
            <input name="hMtu" value="" />
            <input name="hGroup" value="" />
        </form>
    </div>
    <div>
        <form id="hDeleteForm" style="display: none; visibility:hidden;" method="post" action="/goform/trunkFormDelete">
            <input name="hId" value="" />
        </form>
    </div>
    <script>
        //模拟数据
        var dataset = [];
        var ethPortSet = [];
        var strategyArray = ["N/A", "port-based", "mac-based", "other"];
        var statusArray = ["down", "up"];
        //多选下拉框所在的div
        var selecteddiv = document.getElementById("selectdiv");
        //单行选中的值（数字）
        var selectedlist = [];
        //单行选中的名称（显示文字在文本框内）
        var selectednamelist = [];
        //所有行
        var selectedAllList = [];
        //主键
        var existID = [];
        //判断是否是新建
        var isCreateNew = false;
        //
        var oldRowData = "";

        //鼠标是否在【多选下拉框div】上面（如果在div上面，需要控制鼠标的点击事件，不让div隐藏；否则要让该div隐藏）
        var indiv = false;
        function getData() {
            dataset = [];
            selectedAllList = [];
            var trunkData = "<%trunkAspGetALl();%>";
            var portData = "<%trunkAspGetEth();%>";
            var tmpTrunkData = trunkData.split('|');
            var tCount = tmpTrunkData.length;
            if (portData.trim() != "") {
                if (portData.lastIndexOf('*') == portData.length - 1) {
                    portData = portData.substring(0, portData.length - 1);
                }
                ethPortSet = portData.split('*');
            }
            if (trunkData.trim() != "" && tCount > 0) {
                for (var i = 0; i < tCount; i++) {
                    if (tmpTrunkData[i].trim() != "") {
                        var rowData = tmpTrunkData[i].split(',');
                        if (rowData[2].trim() != "1") {
                            rowData[2] = "0";
                        }
                        if (rowData[3].trim() != "1") {
                            rowData[3] = "0";
                        }
                        if (rowData[7].trim() != "") {
                            if (rowData[7].lastIndexOf('*') == rowData[7].length - 1) {
                                rowData[7] = rowData[7].substring(0, rowData[7].length - 1);
                            }
                            rowData[7] = rowData[7].replace(/\*/g, ',');
                            var tmpRowArray = rowData[7].split(',');
                            var tRCount = tmpRowArray.length;
                            if (tRCount > 0) {
                                for (var index = 0; index < tRCount; index++) {
                                    selectedAllList.push(tmpRowArray[index].trim());
                                }
                            }
                        }
                        dataset.push([rowData[0], rowData[1], rowData[2].trim(), rowData[3].trim(), rowData[4].trim(), rowData[5].trim(), rowData[6].trim(), rowData[7]]);
                        existID.push(rowData[0].trim().substring(5));
                    }
                }
            }
        }
        function loadPage() {
            var count = dataset.length;
            if (count > 0) {
                var html = ('');
                for (var i = 0; i < count; i++) {
                    html += ('<tr>');
                    html += ('<td width="10%" id="row' + dataset[i][0] + '" name="txtTrunkNo" value="' + dataset[i][0] + '">' + dataset[i][0] + '</td>');
                    html += ('<td width="10%"><span name="txtDes" value="' + dataset[i][1] + '">' + dataset[i][1] + '</span></td>');
                    html += ('<td width="10%"><span name="txtManStatus"value="' + dataset[i][2] + '" >' + statusArray[dataset[i][2]] + '</span> </td>');
                    html += ('<td width="10%"><span name="txtOperStatus"value="' + dataset[i][3] + '" >' + statusArray[dataset[i][3]] + '</span></td>');
                    html += ('<td width="10%"><span name="txtStrategy" value="' + dataset[i][4] + '">' + strategyArray[dataset[i][4]] + '</span></td>');
                    html += ('<td width="10%"> <span name="txtPvid" value="' + dataset[i][5] + '">' + dataset[i][5] + '</span> </td>');
                    html += ('<td width="10%"><span name="txtMtu" value="' + dataset[i][6] + '">' + dataset[i][6] + '</span></td>');
                    html += ('<td width="20%"><span name="txtEthGroup" value="' + dataset[i][7] + '">' + dataset[i][7] + '</span></td>');
                    html += ('<td>');
                    html += ('<button type="button" class="btn btn-primary" data-toggle="modal" name="btnEdit" style="margin-left:10%;" value="row' + dataset[i][0] + '">修改</button>');
                    html += ('<button type="button" class="btn btn-primary" name="btnDelete"  style="margin-left:10%;" value="' + dataset[i][0] + '">删除</button>');
                    html += ('</td>');
                    html += ('</tr>');
                }
                $("#tBody").html(html);
                isScroll();
            }
        }
        function loadDropDown() {
            $(selecteddiv).html("");
            //动态创建所有的checkbox元素
            for (var i = 0; i < ethPortSet.length; i++) {
                var tmpdiv = document.createElement("div");
                var tmpinput = document.createElement("input");
                var tmpId = "checkboxFourInput" + i;
                tmpinput.setAttribute("name", "mycheckbox");
                tmpinput.setAttribute("type", "checkbox");
                tmpinput.setAttribute("onclick", "mycheck(this)");
                tmpinput.setAttribute("value", i);
                tmpinput.setAttribute("id", tmpId);
                tmpinput.setAttribute("textValue", ethPortSet[i]);

                tmpdiv.appendChild(tmpinput);
                var tmplabel = document.createElement("label");
                tmplabel.setAttribute("for", tmpId);
                tmplabel.setAttribute("name", "mychecklabel");
                tmplabel.innerHTML = ethPortSet[i];
                tmplabel.setAttribute("class", "mark");

                tmpdiv.appendChild(tmplabel);
                selecteddiv.appendChild(tmpdiv);
            }
        }
        //点击selEthGroup，展示多选框
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
            document.getElementById("selEthGroup").value = selectednamelist;
        }
        function resetDropDown(ethGroup) {
            loadDropDown();
            //行编辑时，更改下拉框不保存，重新点击新建或者其他行，下拉框选中显示错误，但是值是对的，不能通过js修改伪类，这里只好重新加载下拉框，待优化
            selectedlist = [];
            selectednamelist = [];
            var checkBoxList = document.getElementsByName("mycheckbox");
            var tmpList = ethGroup.trim().split(',');
            var nCount = tmpList.length;
            if (ethGroup.trim() != "") {
                selectednamelist = tmpList;
                for (var i = 0; i < nCount; i++) {
                    var tmpNum = ethPortSet.findIndex(value => value == tmpList[i]);
                    selectedlist.push(tmpNum);
                }
            }
            for (var j = 0; j < checkBoxList.length; j++) {
                for (var k = 0; k < selectedlist.length; k++) {
                    if (j == selectedlist[k]) {
                        checkBoxList[j].setAttribute("checked", "checked");
                    }
                }
            }
        }
        function checkData(trunkNo, trunDes, pvid, strategy, mtu, ethGroup) {
            var flag = true;
            var regPvid = /^\d{1,4}$/;
            var regMtu = /^\d{4}$/;
            if (!trunkNo || trunkNo == "") {
                flag = false;
                alert("编号输入错误");
            }
            else if (existID.includes(trunkNo) && isCreateNew) {
                flag = false;
                alert("编号已存在");
            }
            else if (!regPvid.test(pvid) || pvid == "" || pvid > 4094) {
                flag = false;
                alert("Pvid格式错误，2至4094的数字");
            }
            else if (!regMtu.test(mtu) || mtu > 3000) {
                flag = false;
                alert("mtu格式错误，1000至3000的数字");
            }
            else if (ethGroup.trim() != "") {
                var tmpRowArray = ethGroup.trim().split(',');
                var tRCount = tmpRowArray.length;
                if (tRCount > 8) {
                    flag = false;
                    alert("eth最多选择8个");
                }
                for (var index = 0; index < tmpRowArray.length; index++) {
                    if (oldRowData.trim() != "" && oldRowData.findIndex(value => value == tmpRowArray[index]) >= 0) {
                        continue;
                    }
                    else if (selectedAllList.findIndex(value => value == tmpRowArray[index]) >= 0) {
                        flag = false;
                        alert("eth不能被多个trunk使用");
                        break;
                    }
                }
            }
            return flag;
        }

        function isScroll() {
            let eHeight = $("#trunkTable")[0].scrollHeight;
            if (eHeight > 650) {
                $("#trunkHead").attr("style", "padding-right:17px;");
            }
        }

        //新建按钮点击事件
        $("#btnCreate").click(function () {
            isCreateNew = true;
            $("#myModalLabel").html("新建");
            //清空赋值
            $("#editTrunkNo").val("").attr("style", "width:100%");
            $("#txtEditTrunkNo").html("trunk").attr("style", "display:none");
            $("#editTrunkDes").val("");
            $("#editPvid").val("");
            $("#editStrategy").val(1);
            $("#editManStatus").val(0);
            $("#txtOperStatus").attr("value", 0).html("");
            $("#editMtu").val("");
            $("#selEthGroup").val("");
            //重置复选框状态
            resetDropDown("");
            oldRowData = "";
            $("#myModal").modal('show');
        });
        //修改按钮点击事件 每行
        $("#tBody").on('click', '[name="btnEdit"]', function () {
            isCreateNew = false;
            $("#myModalLabel").html("修改");
            //取值
            var trunkNo = $(this).parents("tr").find("[name='txtTrunkNo']").attr("value");
            var trunDes = $(this).parents("tr").find("[name='txtDes']").attr("value");
            var pvid = $(this).parents("tr").find("[name='txtPvid']").attr("value");
            var strategy = $(this).parents("tr").find("[name='txtStrategy']").attr("value");
            var mtu = $(this).parents("tr").find("[name='txtMtu']").attr("value");
            var ethGroup = $(this).parents("tr").find("[name='txtEthGroup']").attr("value");
            var manStatus = $(this).parents("tr").find("[name='txtManStatus']").attr("value");
            var operStatus = $(this).parents("tr").find("[name='txtOperStatus']").attr("value");

            //赋值
            //$("#editTrunkNo").html("trunk" + trunkNo);
            $("#editTrunkNo").val(trunkNo).attr("style", "width:100%;display:none");
            $("#txtEditTrunkNo").html(trunkNo).removeAttr("style");
            $("#editTrunkDes").val(trunDes);
            $("#editPvid").val(pvid);
            $("#editStrategy").val(strategy);
            $("#editMtu").val(mtu);
            $("#selEthGroup").val(ethGroup);
            $("#editManStatus").val(manStatus);
            $("#txtOperStatus").attr("value", operStatus).html(statusArray[operStatus]);
            oldRowData = ethGroup;
            //更新复选框状态
            resetDropDown(ethGroup);
            $("#myModal").modal('show');
        });
        $("#tBody").on('click', '[name="btnDelete"]', function () {
            var deleteId = $(this).attr("value").trim();
            $("[name='hId']").val(deleteId);
            $("#hDeleteForm").submit();
        });

        $("#btnSave").click(function () {
            var trunkNo = $("#editTrunkNo").val().trim();
            if (isCreateNew) {
                trunkNo = "trunk" + trunkNo;
            }
            var trunDes = $("#editTrunkDes").val().trim();
            var pvid = $("#editPvid").val().trim();
            var strategy = $("#editStrategy").val().trim();
            var mtu = $("#editMtu").val().trim();
            var ethGroup = $("#selEthGroup").val().trim();
            var manStatus = $("#editManStatus").val();
            var operStatus = $("#txtOperStatus").attr("value");
            if (!checkData(trunkNo, trunDes, pvid, strategy, mtu, ethGroup)) {
                return;
            }
            $("[name='hNo']").val(trunkNo);
            $("[name='hDes']").val(trunDes);
            $("[name='hManStatus']").val(manStatus);
            $("[name='hOperStatus']").val(operStatus);
            $("[name='hPvid']").val(pvid);
            $("[name='hStrategy']").val(strategy);
            $("[name='hMtu']").val(mtu);
            $("[name='hGroup']").val(ethGroup);
            $("#hPostForm").submit();
        });

        //页面加载
        $(document).ready(function () {
            getData();
            loadPage();
            loadDropDown();
        });
        //鼠标点击事件，如果点击在 selectedbutton，或者是在多选框div中的点击事件，不作处理。其他情况的点击事件，将多选空div隐藏
        document.onclick = function (event) {
            if (event.target.id == "selEthGroup" || indiv) {
                return;
            }
            selecteddiv.style.display = "none";
        };
    </script>
</body>

</html>
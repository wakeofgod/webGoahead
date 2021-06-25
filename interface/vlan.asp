<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>vlan</title>
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

        .table-hover>tbody>tr:hover {
            background-color: #33ccff;
        }
    </style>
    <script>

    </script>
</head>

<body>
    <h3
        style="font-weight: bolder; text-align: center;background-color: rgb(241,241,241);height: 48px;line-height: 48px;">
        设备VLAN配置</h3>
    <br>
    <div style="height: 50px;">
        <button type="button" class="btn btn-primary" style="float: left !important;" id="btnCreate">新建</button>
    </div>
    <form>
        <table id="myTable" class="table table-striped table-bordered table-hover" style="width: 95%;">
            <thead style="font-weight: bolder;">
                <tr>
                    <td width="10%">VLAN名称</td>
                    <td width="10%">VLAN 类型</td>
                    <td width="20%">VLAN 描述</td>
                    <td width="10%">VLAN 状态</td>
                    <td width="20%">ETH成员</td>
                    <td width="20%">TRUNK成员</td>
                    <td>操作</td>
                </tr>
            </thead>
            <tbody id="tBody">
                <tr>
                    <td id="row1" name="txtVlanName" value="1">trunk1</td>
                    <td>
                        <span name="txtVlanType" value="1">Static</span>
                    </td>
                    <td>
                        <span name="txtVlanDes" value="test vlan">test vlan</span>
                    </td>
                    <td>
                        <span name="txtVlanStatus" value="1">up</span>
                    </td>
                    <td>
                        <span name="txtEthGroup" value="eth0/7 eth0/8">eth0/7 eth0/8</span>
                    </td>
                    <td>
                        <span name="txtTrunkGroup" value="trunk1">trunk1</span>
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary" data-toggle="modal" name="btnEdit" value="row1">修改
                        </button>
                        <button type="button" class="btn btn-primary" name="btnDelete" value="row1">删除
                        </button>
                    </td>
                </tr>
                <tr>
                    <td id="row2" name="txtVlanName" value="2">trunk2</td>
                    <td>
                        <span name="txtVlanType" value="2">Dynamic</span>
                    </td>
                    <td>
                        <span name="txtVlanDes" value="test vlan2">test vlan2</span>
                    </td>
                    <td>
                        <span name="txtVlanStatus" value="0">down</span>
                    </td>
                    <td>
                        <span name="txtEthGroup" value="eth0/1 eth0/2">eth0/1 eth0/2</span>
                    </td>
                    <td>
                        <span name="txtTrunkGroup" value="trunk3">trunk3</span>
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary" data-toggle="modal" name="btnEdit" value="row2">修改
                        </button>
                        <button type="button" class="btn btn-primary" name="btnDelete" value="row2">删除
                        </button>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
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
                                <td><span id="txtName">VLAN 名称</span></td>
                                <td>
                                    <input id="editVlanID" title="trunk输入框" type="text" placeholder="请输入vlan编号"
                                        style="width: 100%;">
                                    <span id="txtEditVlanID"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>VLAN类型</td>
                                <td>
                                    <span id="txtEditVlanType"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>描述</td>
                                <td>
                                    <input id="editVlanDes" maxlength="30" type="text" title="描述输入框"
                                        style="width: 100%;">
                                </td>
                            </tr>
                            <tr>
                                <td>VLAN状态</td>
                                <td>
                                    <select id="editStatus" title="Vlan状态下拉框" class="mySelect">
                                        <option value="0">down</option>
                                        <option value="1">up</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>ETH成员</td>
                                <td>
                                    <div style="width:100%;height:28px;overflow:hidden;">
                                        <input type="text" id="selEthGroup" onclick="ethclick();" readonly="true"
                                            style="width:100%;height:28px;">
                                    </div>
                                    <div id="selectEthDiv"
                                        style="display:none;border:1px solid #A9A9A9;width:200px;z-index:2;position:absolute;overflow-y :scroll;height:100px;background-color:white;"
                                        onMouseOver="mouseinEth()" onMouseOut="mouseoutEth()">
                                        <br>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>TRUNK成员</td>
                                <td>
                                    <div style="width:100%;height:28px;overflow:hidden;">
                                        <input type="text" id="selTrunkGroup" onclick="trunkclick();" readonly="true"
                                            style="width:100%;height:28px;">
                                    </div>
                                    <div id="selectTrunkDiv"
                                        style="display:none;border:1px solid #A9A9A9;width:200px;z-index:2;position:absolute;overflow-y :scroll;height:100px;background-color:white;"
                                        onMouseOver="mouseinTrunk()" onMouseOut="mouseoutTrunk()">
                                        <br>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="btnSave">提交更改</button>
                </div>
            </div>
        </div>
    </div>
    <table width="60%" align="right">
        <tr>
            <td>
                <div id="barcon" name="barcon"></div>
            </td>
        </tr>
    </table>
    <br>
    <div>
        <form id="hPostForm"  method="post" action="/goform/vlanFormPost">
            <input name="hId" value="" />
            <input name="hType" value="" />
            <input name="hDes" value="" />
            <input name="hStatus" value="" />
            <input name="hEthGroup" value="" />
            <input name="hTrunkGroup" value="" />
        </form>
    </div>
    <div>
        <form id="hDeleteForm"  method="post" action="/goform/vlanFormDelete">
            <input name="hId" value="" />
        </form>
    </div>
    <script>
        var dataset = [];
        var ethPortSet = [];
        var trunkSet = [];
        var statusArray = ["down", "up"];
        var typeArray = ["N/A","Static","Dynamic"];
        //多选下拉框所在的div
        var ethDiv = document.getElementById("selectEthDiv");
        var trunkDIv = document.getElementById("selectTrunkDiv");
        //单行选中的值（数字）
        var selectedEthList = [];
        var selectedTrunkList = [];
        //单行选中的名称（显示文字在文本框内）
        var selectedEthNameList = [];
        var selectedTrunkNameList = [];
        //鼠标是否在【多选下拉框div】上面（如果在div上面，需要控制鼠标的点击事件，不让div隐藏；否则要让该div隐藏）
        var inEthDiv = false;
        var inTrunkDiv = false;
        //分页
        var totalNum = 0;
        var totalPage = 0;
        var pageSize = 10;
        var currentPage = 1;
        var startRow = 1;
        var endRow = 10;
        var pageDataSet = [];
        function getData() {
            dataset = [
                ["vlan1", "1", "test vlan1", "1", "eth0/0,eth0/1", "trunk1"],
                ["vlan2", "2", "test vlan2", "0", "eth0/3,eth0/5", "trunk2"],
                ["vlan4", "2", "test vlan4", "1", "eth0/2,eth0/4", "trunk4"],
                ["vlan6", "1", "test vlan6", "0", "eth0/6,eth0/8", "trunk6"]
            ];
            totalNum = dataset.length;
            if (totalNum / pageSize > parseInt(totalNum / pageSize)) {
                totalPage = parseInt(totalNum / pageSize) + 1;
            } else {
                totalPage = parseInt(totalNum / pageSize);
            }
            ethPortSet = ["eth0/0", "eth0/1", "eth0/2", "eth0/3", "eth0/4", "eth0/5", "eth0/6", "eth0/7", "eth0/8"];
            trunkSet = ["trunk1", "trunk2", "trunk3", "trunk4"];
        }
        function loadPage(pno) {
            currentPage = pno;
            startRow = (currentPage - 1) * pageSize + 1;
            endRow = currentPage * pageSize;
            endRow = (endRow > totalNum) ? totalNum : endRow;
            pageDataSet = dataset.slice(startRow - 1, endRow);
            var tempStr = "<span>共" + totalPage + "页</span>";
            if (currentPage >= 1) {
                tempStr += ('<span class="btn" name="btnShowPage" href="#" value="1">首页</span>');
                tempStr += ('<span class="btn" name="btnShowPage" href="#" value="' + (currentPage - 1) + '">上一页</span>');
                tempStr += ('<span>当前第' + currentPage + '页</span>')
            } else {
                tmpList += ('<span class="btn" name="btnShowPage" href="#" value="0">首页</span>');
                tmpList += ('<span class="btn" name="btnShowPage" href="#" value="0">上一页</span>');
            }

            if (currentPage < totalPage) {
                tempStr += ('<span class="btn" name="btnShowPage" href="#" value="' + (currentPage + 1) + '">下一页</span>');
                tempStr += ('<span class="btn" name="btnShowPage" href="#" value="' + totalPage + '">尾页</span>');
            } else {
                tempStr += ('<span class="btn" name="btnShowPage" href="#" value="' + totalPage + '">下一页</span>');
                tempStr += ('<span class="btn" name="btnShowPage" href="#" value="' + totalPage + '">尾页</span>');
            }

            document.getElementById("barcon").innerHTML = tempStr;
            var count = pageDataSet.length;
            if (count > 0) {
                var html = ('');
                for (var i = 0; i < count; i++) {
                    html += ('<tr>');
                    html += ('<td id="row1" name="txtVlanName" value="' + pageDataSet[i][0] + '">' + pageDataSet[i][0] + '</td>');
                    html += ('<td><span name="txtVlanType" value="' + pageDataSet[i][1] + '">' + typeArray[pageDataSet[i][1]] + '</span></td>');
                    html += ('<td><span name="txtVlanDes" value="' + pageDataSet[i][2] + '">' + pageDataSet[i][2] + '</span></td>');
                    html += ('<td><span name="txtVlanStatus" value="' + pageDataSet[i][3] + '">' + pageDataSet[i][3] + '</span></td>');
                    html += ('<td><span name="txtEthGroup" value="' + pageDataSet[i][4] + '">' + pageDataSet[i][4] + '</span></td>');
                    html += ('<td><span name="txtTrunkGroup" value="' + pageDataSet[i][5] + '">' + pageDataSet[i][5] + '</span></td>');
                    html += ('<td>');
                    html += ('<button type="button" class="btn btn-primary" data-toggle="modal" name="btnEdit" value="' + pageDataSet[i][1] + '">修改</button>');
                    html += ('<button type="button" class="btn btn-primary" name="btnDelete" value="' + pageDataSet[i][0] + '">删除</button>');
                    html += ('</td>');
                    html += ('</tr>');
                }
                $("#tBody").html(html);
            }
        }
        $("#barcon").on('click', '[name="btnShowPage"]', function () {
            var tmpPage = parseInt($(this).attr("value").trim());
            if (tmpPage > 0 && tmpPage <= totalPage) {
                loadPage(tmpPage);
            }
        });
        //点击selEthGroup，展示多选框
        function ethclick() {
            ethDiv.style.display = "block";
        }

        function mouseinEth() {
            inEthDiv = true;
        }

        function mouseoutEth() {
            inEthDiv = false;
        }
        //点击selTrunkGroup,展示多选框
        function trunkclick() {
            trunkDIv.style.display = "block";
        }

        function mouseinTrunk() {
            inTrunkDiv = true;
        }

        function mouseoutTrunk() {
            inTrunkDiv = false;
        }

        //加载eth下拉框数据
        function loadEthDropDown() {
            $(ethDiv).html("");
            //动态创建所有的checkbox元素
            for (var i = 0; i < ethPortSet.length; i++) {
                var tmpdiv = document.createElement("div");
                var tmpinput = document.createElement("input");
                var tmpId = "checkboxEth" + i;
                tmpinput.setAttribute("name", "ethCheckbox");
                tmpinput.setAttribute("type", "checkbox");
                tmpinput.setAttribute("onclick", "ethCheck(this)");
                tmpinput.setAttribute("value", i);
                tmpinput.setAttribute("id", tmpId);
                tmpinput.setAttribute("textValue", ethPortSet[i]);

                tmpdiv.appendChild(tmpinput);
                var tmplabel = document.createElement("label");
                tmplabel.setAttribute("for", tmpId);
                tmplabel.setAttribute("name", "ethChecklabel");
                tmplabel.innerHTML = ethPortSet[i];
                tmplabel.setAttribute("class", "mark");
                //加载单选框
                var tmplabel2 = document.createElement("label");
                var tmpinput2 = document.createElement("input");
                tmpinput2.setAttribute("name", tmpId);
                tmpinput2.setAttribute("type", "radio");
                tmpinput2.setAttribute("onclick", "ethRadio(this)");
                tmpinput2.setAttribute("value", i);
                tmpinput2.setAttribute("textvalue", "U");
                tmpinput2.setAttribute("checked","checked");
                tmpinput2. setAttribute("fullvalue", ethPortSet[i] + "-U");
                tmplabel2.appendChild(tmpinput2);
                tmplabel2.append("U");
                var tmplabel3 = document.createElement("label");
                var tmpinput3 = document.createElement("input");
                tmpinput3.setAttribute("name", tmpId);
                tmpinput3.setAttribute("type", "radio");
                tmpinput3.setAttribute("onclick", "ethRadio(this)");
                tmpinput3.setAttribute("value", i);
                tmpinput3.setAttribute("textvalue", "T");
                tmpinput3. setAttribute("fullvalue", ethPortSet[i] + "-T");
                tmplabel3.appendChild(tmpinput3);
                tmplabel3.append("T");


                tmpdiv.appendChild(tmplabel);
                tmpdiv.appendChild(tmplabel2);
                tmpdiv.appendChild(tmplabel3);
                ethDiv.appendChild(tmpdiv);
            }
        }
        //加载trunk下拉框数据
        function loadTrunkDropDown() {
            $(trunkDIv).html("");
            //动态创建所有的checkbox元素
            for (var i = 0; i < trunkSet.length; i++) {
                var tmpdiv = document.createElement("div");
                var tmpinput = document.createElement("input");
                var tmpId = "checkboxTrunk" + i;
                tmpinput.setAttribute("name", "trunkCheckbox");
                tmpinput.setAttribute("type", "checkbox");
                tmpinput.setAttribute("onclick", "trunkCheck(this)");
                tmpinput.setAttribute("value", i);
                tmpinput.setAttribute("id", tmpId);
                tmpinput.setAttribute("textValue", trunkSet[i]);

                tmpdiv.appendChild(tmpinput);
                var tmplabel = document.createElement("label");
                tmplabel.setAttribute("for", tmpId);
                tmplabel.setAttribute("name", "trunkChecklabel");
                tmplabel.innerHTML = trunkSet[i];
                tmplabel.setAttribute("class", "mark");

                tmpdiv.appendChild(tmplabel);
                trunkDIv.appendChild(tmpdiv);
            }
        }
        //checkbox点击事件
        //eth
        function ethCheck(obj) {
            if (obj.checked) {
                var tmpId = $(obj).attr("id");
                selectedEthList.push(obj.value);
                var tmpStr = $(obj).attr("textValue");
                var textValue = $("input:radio[name=" + tmpId + "]:checked").attr("textValue");
                tmpStr = tmpStr + "-" + textValue ;
                selectedEthNameList.push(tmpStr.trim());
            } else {
                for (var i = 0; i < selectedEthList.length; i++) {
                    if (selectedEthList[i] == obj.value) {
                        selectedEthList.splice(i, 1);
                        selectedEthNameList.splice(i, 1);
                    }
                }
            }
            document.getElementById("selEthGroup").value = selectedEthNameList;
        }
        function ethRadio(obj) {
            if (obj.checked) {
                for (var i = 0; i < selectedEthList.length; i++) {
                    if (selectedEthList[i] == obj.value) {
                        selectedEthNameList[i] = $(obj).attr("fullvalue");
                    }
                }
                document.getElementById("selEthGroup").value = selectedEthNameList;
            }
        }
        //trunk
        function trunkCheck(obj) {
            if (obj.checked) {
                selectedTrunkList.push(obj.value);
                selectedTrunkNameList.push($(obj).attr("textValue"));
            } else {
                for (var i = 0; i < selectedTrunkList.length; i++) {
                    if (selectedTrunkList[i] == obj.value) {
                        selectedTrunkList.splice(i, 1);
                        selectedTrunkNameList.splice(i, 1);
                    }
                }
            }
            document.getElementById("selTrunkGroup").value = selectedTrunkNameList;
        }
        //
        function resetEthDropDown(ethGroup) {
            loadEthDropDown();
            selectedEthList = [];
            selectedEthNameList = [];
            var checkBoxList = document.getElementsByName("ethCheckbox");
            var tmpList = ethGroup.trim().split(',');
            var nCount = tmpList.length;
            if (ethGroup.trim() != "") {
                selectedEthNameList = tmpList;
                for (var i = 0; i < nCount; i++) {
                    var tmpStr = tmpList[i].substring(0,tmpList[i].length-2);
                    var tmpNum = ethPortSet.findIndex(value => value == tmpStr);
                    selectedEthList.push(tmpNum);
                }
            }
            for (var j = 0; j < checkBoxList.length; j++) {
                for (var k = 0; k < selectedEthList.length; k++) {
                    if (j == selectedEthList[k]) {
                        checkBoxList[j].setAttribute("checked", "checked");
                    }
                }
            }
        }
        function resetTrunkDropDown(trunkGroup) {
            loadTrunkDropDown();
            selectedTrunkList = [];
            selectedTrunkNameList = [];
            var checkBoxList = document.getElementsByName("trunkCheckbox");
            var tmpList = trunkGroup.trim().split(',');
            var nCount = tmpList.length;
            if (trunkGroup.trim() != "") {
                selectedTrunkNameList = tmpList;
                for (var i = 0; i < nCount; i++) {
                    var tmpNum = trunkSet.findIndex(value => value == tmpList[i]);
                    selectedTrunkList.push(tmpNum);
                }
            }
            for (var j = 0; j < checkBoxList.length; j++) {
                for (var k = 0; k < selectedTrunkList.length; k++) {
                    if (j == selectedTrunkList[k]) {
                        checkBoxList[j].setAttribute("checked", "checked");
                    }
                }
            }
        }
        function checkData(vlanId,vlanDes,vlanStatus,ethGroup,trunkGroup){
            var flag = true;

            return flag;
        }
        //按钮点击 新建
        $("#btnCreate").click(function () {
            isCreateNew = true;
            $("#myModalLabel").html("新建");
            $("#txtName").html("VLAN ID");
            //清空赋值
            $("#editVlanID").val("").attr("style", "width:100%;");
            $("#txtEditVlanID").html("").attr("style", "display:none");
            $("#txtEditVlanType").val(1).html(typeArray[1]);
            $("#editVlanDes").val("");
            $("#selEthGroup").val("");
            $("#selTrunkGroup").val("");
            //重置复选框状态
            resetEthDropDown("");
            resetTrunkDropDown("");
            $("#myModal").modal('show');
        });
        //行点击 修改
        $("#tBody").on('click', '[name="btnEdit"]', function () {
            isCreateNew = false;
            $("#myModalLabel").html("修改");
            $("#txtName").html("VLAN名称");
            //取值
            var vlanName = $(this).parents("tr").find("[name='txtVlanName']").attr("value");
            var vlanId = vlanName.substring(4);
            var vlanType =$(this).parents("tr").find("[name='txtVlanType']").attr("value");
            var vlanDes = $(this).parents("tr").find("[name='txtVlanDes']").attr("value");
            var vlanStatus = $(this).parents("tr").find("[name='txtVlanStatus']").attr("value");
            var ethGroup = $(this).parents("tr").find("[name='txtEthGroup']").attr("value");
            var trunkGroup = $(this).parents("tr").find("[name='txtTrunkGroup']").attr("value");
            //赋值
            $("#editVlanID").val(vlanId).attr("style", "width:100%;display:none");
            $("#txtEditVlanID").html(vlanName).removeAttr("style");
            $("#txtEditVlanType").attr("value",vlanType).html(typeArray[vlanType]);
            $("#editVlanDes").val(vlanDes);
            $("#editStatus").val(vlanStatus);
            $("#selEthGroup").val(ethGroup);
            $("#selTrunkGroup").val(trunkGroup);
            resetEthDropDown(ethGroup);
            resetTrunkDropDown(trunkGroup);
            $("#myModal").modal('show');
        });
        //行点击 删除
        $("#tBody").on('click', '[name="btnDelete"]', function () {
            var deleteId = $(this).attr("value");
            $("[name='hId']").val(deleteId);
            $("#hDeleteForm").submit();
        });
        //
        $("#btnSave").click(function () {
            var vlanId = $("#editVlanID").val().trim();
            var vlanDes = $("#editVlanDes").val();
            var vlanType =$("#txtEditVlanType").attr("value");
            var vlanStatus = $("#editStatus").val();
            var ethGroup = $("#selEthGroup").val().trim();
            var trunkGroup = $("#selTrunkGroup").val().trim();
            debugger;
            if(!checkData(vlanId,vlanDes,vlanStatus,ethGroup,trunkGroup)){
                return;
            }
            $("[name='hId']").val("valn"+vlanId);
            $("[name='hDes']").val(vlanDes);
            $("[name='hType']").val(vlanType);
            $("[name='hStatus']").val(vlanStatus);
            $("[name='hEthGroup']").val(ethGroup);
            $("[name='hTrunkGroup']").val(trunkGroup);
            $("#hPostForm").submit();
        });
        $(document).ready(function () {
            getData();
            loadPage(1);
            loadEthDropDown();
            loadTrunkDropDown();
        });
        //鼠标点击事件，如果点击在 selectedbutton，或者是在多选框div中的点击事件，不作处理。其他情况的点击事件，将多选空div隐藏
        document.onclick = function (event) {
            if (event.target.id == "selEthGroup" || inEthDiv) {
                trunkDIv.style.display = "none";
            }
            else if (event.target.id == "selTrunkGroup" || inTrunkDiv) {
                ethDiv.style.display = "none";
            }
            else {
                ethDiv.style.display = "none";
                trunkDIv.style.display = "none";
            }
        };
    </script>
</body>

</html>
<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>以太</title>
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
    </style>
    <script>

    </script>
</head>

<body>
    <h3
        style="font-weight: bolder; text-align: center;background-color: rgb(241,241,241);height: 48px;line-height: 48px;">
        ETH配置</h3>
    <br>
    <div style="height: 50px;">
        <button type="button" class="btn" style="float: right !important; margin-right: 5%; background-color: #6B8E23;color: #fff;"
            id="btnRefresh">刷新</button>
    </div>
    <form>
        <table id="myTable" class="table table-striped table-bordered table-hover" style="width: 95%;">
            <thead style="font-weight: bolder;">
                <tr>
                    <td width="10%">端口编号</td>
                    <td width="15%">端口描述</td>
                    <td width="10%">管理状态</td>
                    <td width="10%">物理状态</td>
                    <td width="10%">Pvid</td>
                    <td width="10%">配置速率</td>
                    <td width="10%">实际速率</td>
                    <td width="10%">流控使能</td>
                    <td width="15%">MTU</td>
                    <td>操作</td>
                </tr>
            </thead>
            <tbody id="tBody">
                
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
                                <td>端口编号</td>
                                <td id="editPortNo">eth0/0</td>
                            </tr>
                            <tr>
                                <td>端口描述</td>
                                <td>
                                    <input id="editPort" maxlength="30" type="text" title="端口输入框" style="width: 100%;">
                                </td>
                            </tr>
                            <tr>
                                <td>管理状态</td>
                                <td>
                                    <select id="editStatus" title="状态下拉框" class="mySelect">
                                        <option value="1">up</option>
                                        <option value="0">down</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>物理状态</td>
                                <td id="eidtStatusTxt">down</td>
                            </tr>
                            <tr>
                                <td>PVid</td>
                                <td>
                                    <input id="editPvid" title="PVID输入框" placeholder="请输入2至4094间的数字" min="2" max="4094"
                                        style="width: 100%;">
                                </td>
                            </tr>
                            <tr>
                                <td>配置速率</td>
                                <td>
                                    <select id="editRate" title="速率下拉框" class="mySelect">
                                        <option value="1"> auto</option>
                                        <option value="3">full-10</option>
                                        <option value="5">full-100</option>
                                        <option value="7">full-1000</option>
                                        <option value="8">full-10000</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>实际速率</td>
                                <td id="editRateTxt">full-1000</td>
                            </tr>
                            <tr>
                                <td>流控使能</td>
                                <td>
                                    <select id="editFlow" title="使能下拉框" class="mySelect">
                                        <option value="1">enable</option>
                                        <option value="0">disable</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>MTU</td>
                                <td><input title="MTU输入框" placeholder="请输入1000至3000的数字" id="editMtu" min="1000"
                                        max="3000" style="width: 100%;"></td>
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
    <div>
        <form id="hForm" style="visibility: hidden; display: none;" method="post" action="/goform/ethFormPost">
            <input name="hNo" value="" />
            <input name="hDes" value="" />
            <input name="hStatus" value="" />
            <input name="hStatusTxt" value="" />
            <input name="hPvid" value="" />
            <input name="hRate" value="" />
            <input name="hRateTxt" value="" />
            <input name="hFlow" value="" />
            <input name="hMtu" value="" />
        </form>
    </div>
    <script>
        //模拟数据
        //可能会出现的问题，webserver获取的数据和下拉框模拟的不一致

        var dataset = [];
        var statusArray = ["down", "up"];
        var rateArray = ["auto", "half-10", "full-10", "half-100", "full-100", "half-1000", "full-1000", "full-10000"];
        var rateTxtArray = ["N/A","auto" ,"half-10", "full-10", "half-100", "full-100", "half-1000", "full-1000", "full-10000"];
        var flowArray = ["disable", "enable"];
        function getData() {
            var ethData = "<%ethAspGetAll();%>";
            var tempdata = ethData.split('|');
            var tCount = tempdata.length;
            if (tCount > 0) {
                dataset = [];
                for (var i = 0; i < tCount; i++) {
                    if (typeof (tempdata[i]) == "undefined" || tempdata[i].trim() == "" || !tempdata[i]) {
                        console.log("该行数据为空!");
                        continue;
                    }
                    else {
                        var rowData = tempdata[i].split(',');
                        if (rowData[7].trim() != "1") {
                            rowData[7] = "0";
                        }
                        if(rowData[2].trim()!="1")
                        {
                            rowData[2] = "0";
                        }
                        if(rowData[3].trim()!="1")
                        {
                            rowData[3] = "0";
                        }
                        dataset.push([rowData[0], rowData[1], rowData[2].trim(), rowData[3].trim(), rowData[4].trim(), rowData[5].trim(), rowData[6].trim(), rowData[7].trim(), rowData[8].trim()]);
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
                    html += ('<td id="row' + i + '"  name="txtPortNo" value ="' + dataset[i][0] + '">' + dataset[i][0] + '</td>');
                    html += ('<td> <span name="txtPort" value="' + dataset[i][1] + '">' + dataset[i][1] + '</span></td>');
                    html += ('<td><span name="selStatus" value="' + dataset[i][2] + '">' + statusArray[dataset[i][2]] + '</span></td>');
                    html += ('<td name="txtStatus" value="' + dataset[i][3] + '" >' + statusArray[dataset[i][3]] + '</td>');
                    html += ('<td><span name="txtPvid" value="' + dataset[i][4] + '">' + dataset[i][4] + '</span></td>')
                    html += ('<td><span name="selRate" value="' + dataset[i][5] + '">' + rateArray[dataset[i][5] - 1] + '</span></td>')
                    html += ('<td name="txtRate" value="' + dataset[i][6] + '">' + rateTxtArray[dataset[i][6]]+ '</td>');
                    html += ('<td><span name="selFlow" value="' + dataset[i][7] + '">' + flowArray[dataset[i][7]] + '</span></td>');
                    html += ('<td><span name="txtMtu" value="' + dataset[i][8] + '">' + dataset[i][8] + '</span></td>');
                    html += ('<td><button type="button" class="btn btn-primary" data-toggle="modal" name="btnEdit" value="row' + i + '">编辑</button></td>');
                    html += ('</tr>');
                }
                $("#tBody").html(html);
            }
        }
        var selectRow;
        $("#tBody").on('click', '[name="btnEdit"]', function () {
            selectRow = $(this).attr("value");
            //先清空模态框的值
            $("#editPort").val();
            $("#editMtu").val();
            $("#editStatus").val();
            $("#editNego").val();
            $("#editRate").val();

            //  展示页面统一用span不显示下拉框和文本，只有编辑页面显示
            var port = $(this).parents("tr").find("[name='txtPort']").attr("value");
            var portNo = $(this).parents("tr").find("[name='txtPortNo']").attr("value");
            var status = $(this).parents("tr").find("[name='selStatus']").attr("value");
            var statusTxt = $(this).parents("tr").find("[name='txtStatus']").attr("value");
            var pvid = $(this).parents("tr").find("[name='txtPvid']").attr("value");
            var rate = $(this).parents("tr").find("[name='selRate']").attr("value");
            var rateTxt = $(this).parents("tr").find("[name='txtRate']").attr("value");
            var mtu = $(this).parents("tr").find("[name='txtMtu']").attr("value");
            var flow = $(this).parents("tr").find("[name='selFlow']").attr("value");
            //赋值
            $("#editPort").val(port);
            $("#editPortNo").html(portNo);
            $("#editMtu").val(mtu);
            $("#editStatus").val(status);
            $("#eidtStatusTxt").html(statusTxt);
            //asp不支持h5 文本框type=number属性
            $("#editPvid").val(pvid);
            $("#editRate").val(rate);
            $("#editRateTxt").html(rateTxt);
            $("#editFlow").val(flow);
            $("#myModal").modal('show');
        });

        function checkData(port, pvid, mtu) {
            var flag = true;
            var regPort = /^[a-zA-Z][a-zA-Z0-9]{0,29}$/;
            var regPvid = /^\d{1,4}$/;
            var regMtu = /^\d{4}$/;
            if (!regPort.test(port)&&port.trim()!="") {
                flag = false;
                alert("端口格式错误，以字母开头最长30位");
            }
            else if (!regPvid.test(pvid) || pvid > 4094|| pvid<2) {
                flag = false;
                alert("Pvid格式错误，2至4094的数字");
            }
            else if (!regMtu.test(mtu) || mtu > 3000) {
                flag = false;
                alert("mtu格式错误，1000至3000的数字");
            }
            return flag;
        }
        $("#btnSave").click(function () {
            if (selectRow) {
                var portNo = $("#editPortNo").html().trim();
                var port = $("#editPort").val();
                var status = $("#editStatus").val().trim();
                var statusTxt = $("#eidtStatusTxt").html().trim();
                var pvid = $("#editPvid").val().trim();
                var rate = $("#editRate").val().trim();
                var rateTxt = $("#editRateTxt").html().trim();
                var mtu = $("#editMtu").val().trim();
                var flow = $("#editFlow").val().trim();
                if (!checkData(port, pvid, mtu)) {
                    return;
                }
                //检查数据是否更改，如果没有任何更改，添加提示弹窗,待完成
                $("#" + selectRow).parents("tr").find("[name='txtPort']").attr("value", port).text(port);
                $("#" + selectRow).parents("tr").find("[name='selStatus']").attr("value", status).text(statusArray[status]);
                $("#" + selectRow).parents("tr").find("[name='txtPvid']").attr("value", pvid).text(pvid);
                $("#" + selectRow).parents("tr").find("[name='selRate']").attr("value", rate).text(rateArray[rate - 1]);
                $("#" + selectRow).parents("tr").find("[name='txtMtu']").attr("value", mtu).text(mtu);
                $("#" + selectRow).parents("tr").find("[name='selFlow']").attr("value", flow).text(flowArray[flow]);
                $("#myModal").modal('hide');

                //赋值给隐藏的form
                $("[name='hNo']").val(portNo);
                $("[name='hDes']").val(port);
                $("[name='hStatus']").val(status);
                $("[name='hStatusTxt']").val(statusTxt);
                $("[name='hPvid']").val(pvid);
                $("[name='hRate']").val(rate);
                $("[name='hRateTxt']").val(rateTxt);
                $("[name='hFlow']").val(flow);
                $("[name='hMtu']").val(mtu);
                var url = window.location.href;
                $("#hForm").submit();
            }
        });
        $("#btnRefresh").click(function () {
            window.location.reload();
        });
        $(document).ready(function () {
             getData();
             loadPage();
        });
    </script>
</body>
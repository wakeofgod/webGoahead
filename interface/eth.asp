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
    <div class="container-fluid" style="width: 95%;">
        <div class="row">
            <div id="ethHead">
                <table class="table table-striped table-bordered table-hover">
                    <thead style="font-weight: bolder;">
                        <tr>
                            <td width="10%">端口编号</td>
                            <td width="10%">端口描述</td>
                            <td width="10%">管理状态</td>
                            <td width="10%">物理状态</td>
                            <td width="10%">Pvid</td>
                            <td width="10%">配置速率</td>
                            <td width="10%">实际速率</td>
                            <td width="10%">流控使能</td>
                            <td width="10%">MTU</td>
                            <td>操作</td>
                        </tr>
                    </thead>
                </table>
            </div>
            <div style="height:650px;overflow-y:auto;overflow-x: hidden;margin-top: -22px;" id="ethTable">
                <table id="myTable" class="table table-striped table-bordered table-hover">
                    <tbody id="tBody">
                        <tr>
                            <td id="row1" name="txtPortNo" value="eth0/0">eth0/0</td>
                            <td>
                                <span name="txtPort" value="0101">0101</span>
                            </td>
                            <td>
                                <span name="selStatus" value="0">down</span>
                            </td>
                            <td name="txtStatus" value="down">down</td>
                            <td>
                                <span name="txtPvid" value="100">100</span>
                            </td>
                            <td>
                                <span name="selRate" value="3">200</span>
                            </td>
                            <td name="txtRate" value="full-1000">full-1000</td>
                            <td>
                                <span name="selFlow" value="1">enable</span>
                            </td>
                            <td>
                                <span name="txtMtu" value="1010">1010</span>
                            </td>
                            <td>
                                <button type="button" class="btn btn-primary" data-toggle="modal" name="btnEdit"
                                    value="row1">编辑</button>
                            </td>
                        </tr>
                        <tr>
                            <td id="row2" name="txtPortNo" value="eth0/1">eth0/1</td>
                            <td>
                                <span name="txtPort" value="0202">0202</span>
                            </td>
                            <td>
                                <span name="selStatus" value="0">down</span>
                            </td>
                            <td name="txtStatus">down</td>
                            <td>
                                <span name="txtPvid" value="100">100</span>
                            </td>
                            <td>
                                <span name="selRate" value="3">100</span>
                            </td>
                            <td>full-1000</td>
                            <td>
                                <span name="selFlow" value="1">enable</span>
                            </td>
                            <td>
                                <span name="txtMtu" value="2020">2020</span>
                            </td>
                            <td>
                                <button type="button" class="btn btn-primary" data-toggle="modal" name="btnEdit"
                                    value="row1">编辑</button>
                            </td>
                        </tr>
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

        let dataset = [];
        let statusArray = ["down", "up"];
        let rateArray = ["auto", "half-10", "full-10", "half-100", "full-100", "half-1000", "full-1000", "full-10000"];
        let rateTxtArray = ["N/A","auto" ,"half-10", "full-10", "half-100", "full-100", "half-1000", "full-1000", "full-10000"];
        let flowArray = ["disable", "enable"];
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
            let count = dataset.length;
            if (count > 0) {
                let html = ('');
                for (let i = 0; i < count; i++) {
                    html += ('<tr>');
                    html += ('<td width="10%" id="row' + i + '"  name="txtPortNo" value ="' + dataset[i][0] + '">' + dataset[i][0] + '</td>');
                    html += ('<td width="10%"> <span name="txtPort" value="' + dataset[i][1] + '">' + dataset[i][1] + '</span></td>');
                    html += ('<td width="10%"><span name="selStatus" value="' + dataset[i][2] + '">' + statusArray[dataset[i][2]] + '</span></td>');
                    html += ('<td width="10%" name="txtStatus" value="' + dataset[i][3] + '" >' + statusArray[dataset[i][3]] + '</td>');
                    html += ('<td width="10%"><span name="txtPvid" value="' + dataset[i][4] + '">' + dataset[i][4] + '</span></td>')
                    html += ('<td width="10%"><span name="selRate" value="' + dataset[i][5] + '">' + rateArray[dataset[i][5] - 1] + '</span></td>')
                    html += ('<td width="10%" name="txtRate" value="' + dataset[i][6] + '">' + rateTxtArray[dataset[i][6]] + '</td>');
                    html += ('<td width="10%"><span name="selFlow" value="' + dataset[i][7] + '">' + flowArray[dataset[i][7]] + '</span></td>');
                    html += ('<td width="10%"><span name="txtMtu" value="' + dataset[i][8] + '">' + dataset[i][8] + '</span></td>');
                    html += ('<td><button type="button" class="btn btn-primary" data-toggle="modal" name="btnEdit" value="row' + i + '">编辑</button></td>');
                    html += ('</tr>');
                }
                $("#tBody").html(html);
            }
        }
        let selectRow;
        $("#tBody").on('click', '[name="btnEdit"]', function () {
            selectRow = $(this).attr("value");
            //先清空模态框的值
            $("#editPort").val();
            $("#editMtu").val();
            $("#editStatus").val();
            $("#editNego").val();
            $("#editRate").val();

            //  展示页面统一用span不显示下拉框和文本，只有编辑页面显示
            let port = $(this).parents("tr").find("[name='txtPort']").attr("value");
            let portNo = $(this).parents("tr").find("[name='txtPortNo']").attr("value");
            let status = $(this).parents("tr").find("[name='selStatus']").attr("value");
            let statusTxt = $(this).parents("tr").find("[name='txtStatus']").attr("value");
            let pvid = $(this).parents("tr").find("[name='txtPvid']").attr("value");
            let rate = $(this).parents("tr").find("[name='selRate']").attr("value");
            let rateTxt = $(this).parents("tr").find("[name='txtRate']").attr("value");
            let mtu = $(this).parents("tr").find("[name='txtMtu']").attr("value");
            let flow = $(this).parents("tr").find("[name='selFlow']").attr("value");
            //赋值
            $("#editPort").val(port);
            $("#editPortNo").html(portNo);
            $("#editMtu").val(mtu.trim());
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
            let flag = true;
            let regPort = /^[a-zA-Z][a-zA-Z0-9]{0,29}$/;
            let regPvid = /^\d{1,4}$/;
            let regMtu = /^\d{4}$/;
            if (!regPort.test(port) && port.trim() != "") {
                flag = false;
                alert("端口格式错误，以字母开头最长30位");
            }
            else if (!regPvid.test(pvid) || pvid > 4094 || pvid < 2) {
                flag = false;
                alert("Pvid格式错误，2至4094的数字");
            }
            else if (!regMtu.test(mtu) || mtu > 3000) {
                flag = false;
                alert("mtu格式错误，1000至3000的数字");
            }
            return flag;
        }

        function isScroll() {
            let eHeight = $("#ethTable")[0].scrollHeight;
            if (eHeight > 650) {
                $("#ethHead").attr("style", "padding-right:17px;");
            }
        }

        $("#btnSave").click(function () {
            if (selectRow) {
                let portNo = $("#editPortNo").html().trim();
                let port = $("#editPort").val();
                let status = $("#editStatus").val().trim();
                let statusTxt = $("#eidtStatusTxt").html().trim();
                let pvid = $("#editPvid").val().trim();
                let rate = $("#editRate").val().trim();
                let rateTxt = $("#editRateTxt").html().trim();
                let mtu = $("#editMtu").val().trim();
                let flow = $("#editFlow").val().trim();
                if (!checkData(port, pvid, mtu)) {
                    return;
                }

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
                let url = window.location.href;
                $("#hForm").submit();
            }
        });
        $("#btnRefresh").click(function () {
            window.location.reload();
        });
        $(document).ready(function () {
            getData();
            loadPage();
            isScroll();
        });
    </script>
</body>

</html>
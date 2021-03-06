<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>静态路由</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
</head>

<body>
    <h3
        style="font-weight: bolder; text-align: center;background-color: rgb(241,241,241);height: 48px;line-height: 48px;">
        静态路由</h3>
    <br>
    <div style="height: 50px;">
        <button type="button" class="btn btn-primary" id="btnAdd" style="margin-left: 20px;">新建</button>
    </div>
    <div>
        <table class="table table-striped table-bordered " style="width: 95%;margin-top: 10px;" id="staticTable">
            <thead style="font-weight: bolder;">
                <tr>
                    <td width="20%">desk/mask</td>
                    <td width="15%">type</td>
                    <td width="15%">[d/m]</td>
                    <td width="20%">gateway</td>
                    <td width="15%">status</td>
                    <td>操作</td>
                </tr>
            </thead>
            <tbody id="staticBody">

            </tbody>
        </table>
    </div>
    <div class="modal fade" id="modeModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">编辑</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped table-bordered">
                        <tbody>
                            <tr>
                                <td>Desk/Mask:</td>
                                <td>
                                    <input id="editDesk" type="text" title="ip输入框" placeholder="xxx.xxx.xxx.xxx/xx"
                                        style="width: 100%;">
                                </td>
                            </tr>
                            <tr>
                                <td>Next Hop:</td>
                                <td>
                                    <input id="editHop" type="text" title="下一跳输入框" placeholder="xxx.xxx.xxx.xxx"
                                        style="width: 100%;">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="btnStaticSave">提交更改</button>
                </div>
            </div>
        </div>
    </div>
    <div>
        <form id="hPostForm" style="visibility: hidden; display: none;" method="post" action="/goform/staticFormPost">
            <input name="hAdd" value="" />
        </form>
        <form id="hDeleteForm" style="visibility: hidden; display: none;" method="post" action="/goform/staticFormDelete">
            <input name="hDelete" value="" />
        </form>
    </div>
    <script>
        var dataset = [];
        var selectNet = "";
        var html = ('');
        var typeArray = ["static", "connected"];
        var statusArray = ["pending", "active"];
        function getData() {
            let staticData = "<%staticAspGetAll();%>";
            if (staticData.trim() != "") {
                staticData = staticData.trim();
                if (staticData.lastIndexOf('|') == staticData.length - 1) {
                    staticData = staticData.substring(0, staticData.length - 1);
                }
                let tmpStatic = staticData.split('|');
                let sCount = tmpStatic.length;
                if (sCount > 0) {
                    dataset = [];
                    for (let i = 0; i < sCount; i++) {
                        let rowData = tmpStatic[i].split(',');
                        dataset.push([rowData[0].trim(), rowData[1].trim(), rowData[2].trim(), rowData[3].trim(), rowData[4].trim()]);
                    }
                }
            }
        }

        function loadPage() {
            let dCount = dataset.length;
            if (dCount > 0) {
                html = ('');
                let tmpStr = "";
                for (let i = 0; i < dCount; i++) {
                    html += ('<tr>');
                    if (dataset[i][0].trim() != "") {
                        tmpStr = dataset[i][0].trim();
                        html += ('<td><span name="txtDesk" value="' + dataset[i][0] + '">' + dataset[i][0] + '</span></td>');
                    }
                    else {
                        html += ('<td></td>');
                    }
                    html += ('<td><span name="txtType" value="' + dataset[i][1] + '">' + dataset[i][1] + '</span></td>');
                    html += ('<td><span name="txtDm" value="' + dataset[i][2] + '">' + dataset[i][2] + '</span></td>');
                    html += ('<td><span name="txtGateway" value="' + dataset[i][3] + '">' + dataset[i][3] + '</span></td>');
                    html += ('<td><span name="txtStatus" value="' + dataset[i][4] + '">' + dataset[i][4] + '</span></td>');
                    html += ('<td>');
                    if (dataset[i][0].trim() != "") {
                        html += ('<button type="button" class="btn btn-primary" style="margin-left:20px;"  name="btnDelete" maskvalue="' + dataset[i][0] + '" hopvalue ="' + dataset[i][3] + '">删除</button>');
                    }
                    else {
                        html += ('<button type="button" class="btn btn-primary" style="margin-left:20px;"  name="btnDelete" maskvalue="' + tmpStr + '" hopvalue ="' + dataset[i][3] + '">删除</button>');
                    }

                    html += ('</td');
                    html += ('</tr>');
                }
                $("#staticBody").html(html);
                mergeTable();
            }
        }

        function mergeTable() {
            let tab = document.getElementById("staticTable");
            let nRow = tab.rows.length;
            let nCol = tab.rows[0].cells.length;
            let start = 1, count = 0, current = 1;
            let tmpStr = "";
            for (let i = 1; i < nRow; i++) {
                tmpStr = tab.rows[i].cells[0].innerHTML;
                //排除第一行
                if (tmpStr.trim() != "" && ((start + count) == i)) {
                    continue;
                }
                else if (tmpStr.trim() != "" && ((start + count) != i)) {
                    if (count >= 1) {
                        $(tab.rows[start].cells[0]).attr("rowspan", count + 1);
                        for (let j = start + 1; j < i; j++) {
                            $(tab.rows[j].cells[0]).attr("style", "display:none");
                        }
                    }
                    //重新赋值
                    start = i;
                    count = 0;
                }
                else if (tmpStr.trim() == "") {
                    count++;
                }
                //最后一行
                if (i == nRow - 1) {
                    if (count >= 1) {
                        $(tab.rows[start].cells[0]).attr("rowspan", count + 1);
                        for (let j = start + 1; j <= i; j++) {
                            $(tab.rows[j].cells[0]).attr("style", "display:none");
                        }
                    }
                }
            }
        }

        function checkData(network, nexthop) {
            var flag = true;
            let regNetwork = /^(?:(?:[0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}(?:[0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\/([1-9]|[1-2]\d|3[0-2])$/;
            let regHop = /^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$/;
            if (!regNetwork.test(network)) {
                alert("地址输入不合法");
                flag = false;
            }
            else if (!regHop.test(nexthop)) {
                alert("下一跳输入不合法");
                flag = false;
            }
            return flag;
        }


        $("#staticBody").on('click', '[name="btnDelete"]', function () {
            let mask = $(this).attr("maskvalue");
            let hop = $(this).attr("hopvalue");
            let type = $(this).parents("tr").find("[name='txtType']").attr("value");
            if (type == "static") {
                let route = mask.concat(",", hop);
                $("[name='hDelete']").val(route);
                $("#hDeleteForm").submit();
            }
            else {
                alert("非静态路由,不能删除");
            }
        });

        $("#btnAdd").click(function () {
            $("#modeModal").modal('show');
        });

        $("#btnStaticSave").click(function () {
            let mask = $("#editDesk").val();
            let nexthop = $("#editHop").val();
            if (checkData(mask, nexthop)) {
                let route = mask.concat(",", nexthop);
                $("[name='hAdd']").val(route);
                $("#hPostForm").submit();
            }
        });

        $(document).ready(function () {
            getData();
            loadPage();
        });
    </script>
</body>
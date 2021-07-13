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
        <table class="table table-striped table-bordered " style="width: 95%;margin-top: 10px;">
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
                <tr>
                    <td>
                        <span name="txtDesk" value="0.0.0.0/0">0.0.0.0/0</span>
                    </td>
                    <td>
                        <span name="txtType" value="static">static</span>
                    </td>
                    <td>
                        <span name="txtDm" value="static">[1/1]</span>
                    </td>
                    <td>
                        <span name="txtGateway" value="1.1.1.221">1.1.1.221</span>
                    </td>
                    <td>
                        <span name="txtStatus" value="1.1.1.221">pending</span>
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary" name="btnEdit" value="row1">编辑</button>
                        <button type="button" class="btn btn-primary" style="margin-left:20px;" name="btnDelete"
                            value="row1">删除</button>
                    </td>
                </tr>
                <tr>
                    <td>1.1.1.111/24</td>
                    <td>connected</td>
                    <td>[0/0]</td>
                    <td>1.1.1.111</td>
                    <td>active</td>
                    <td>
                        <button type="button" class="btn btn-primary" style="margin-left:20px;" name="btnDelete"
                            value="row1">删除</button>
                    </td>
                </tr>
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
        <form id="hPostForm" method="post" action="/goform/staticFormPost">
            <input name="hDesk" value="" />
            <input name="hHop" value="" />
        </form>
        <form id="hDeleteForm" method="post" action="/goform/staticFormDelete">
            <input name="hDesk" value="" />
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
            dataset = [
                ["0.0.0.0/0", "static", "[1/1]", "1.1.1.221", "pending"],
                ["1.1.1.111/24", "connected", "[0/0]", "1.1.1.111", "active"]
            ];
        }

        function loadPage() {
            let dCount = dataset.length;
            if (dCount > 0) {
                html = ('');
                for (let i = 0; i < dCount; i++) {
                    html += ('<tr>');
                    html += ('<td><span name="txtDesk" value="' + dataset[i][0] + '">' + dataset[i][0] + '</span></td>');
                    html += ('<td><span name="txtType" value="' + dataset[i][1] + '">' + dataset[i][1] + '</span></td>');
                    html += ('<td><span name="txtDm" value="' + dataset[i][2] + '">' + dataset[i][2] + '</span></td>');
                    html += ('<td><span name="txtGateway" value="' + dataset[i][3] + '">' + dataset[i][3] + '</span></td>');
                    html += ('<td><span name="txtStatus" value="' + dataset[i][4] + '">' + dataset[i][4] + '</span></td>');
                    html += ('<td>');
                    html += ('<button type="button" class="btn btn-primary" style="margin-left:20px;"  name="btnDelete" value="' + dataset[i][0] + '">删除</button>');
                    html += ('</td');
                    html += ('</tr>');
                }
                $("#staticBody").html(html);
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
            alert("delete");
        });

        $("#btnAdd").click(function () {
            $("#modeModal").modal('show');
        });

        $("#btnStaticSave").click(function () {
            let network = $("#editDesk").val();
            let nexthop = $("#editHop").val();
            if (checkData(network, nexthop)) {
                alert("输入合法");
            }
        });

        $(document).ready(function () {
            getData();
            loadPage();
        });
    </script>
</body>
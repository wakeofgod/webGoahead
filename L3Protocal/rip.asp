<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Info</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
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
        <div class="row" style="margin-top: 20px;">
            <label class="col-md-offset-4 col-md-1 control-label" style="text-transform: uppercase;">Redistributing:</label>
            <label class="col-md-1 control-label" style="color: red;">static</label>
            <label class="col-md-2 control-label" style="text-transform: uppercase;">Default redistribution metric:</label>
            <label class="col-md-1 control-label" style="color: red;">1</label>
        </div>
        <div class="row" style="margin-top: 20px;">
            <label class="col-md-offset-4 col-md-2 control-label" style="text-transform: uppercase;">Default version control:</label>
            <label class="col-md-2 control-label" style="color: red;">send version 2, receive any version</label>
        </div>
    </div>
    <div id="ripTable">
        <table class="table table-striped table-bordered " style="max-width:600px;margin: 10px auto;">
            <thead style="font-weight: bolder;">
                <tr>
                    <td width="20%">Network</td>
                    <td width="10%">操作</td>
                </tr>
            </thead>
            <tbody id="ripBody">
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
                                    <input id="editNet" type="text" title="端口输入框" placeholder="xxx.xxx.xxx.xxx/xx" style="width: 100%;">
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
    </div>
    <script>
        var currentStatus = 1;
        var dataset = [];
        var datainfo = [];
        var selectNet = "";
        var html = ('');
        var isCreateNew = false;
        function getData() {
            let ripData= "<%ripAspGetAll();%>";
            let ripInfoData = "<%ripAspGetInfo();%>";
            dataset = [
                ["1.1.1.0/24", "2.1.1.1", "1 self", "0", "01:48"],
                ["2.1.1.0/24", "3.1.1.1", "1 self", "0", "01:05"]
            ];
        }

        function loadPage() {
            if (!currentStatus) {
                $("#btnAdd").attr("disabled", "disabled");
                $("#btnDisable").attr("disabled", "disabled");
                $("#ripInfo").attr("style","display:none;");
                $("#ripTable").attr("style","display:none;");
            }
            else {
                $("#btnEnable").attr("disabled", "disabled");
                $("#btnAdd").removeAttr("disabled");
                $("#btnDisable").removeAttr("disabled");
                $("#ripInfo").removeAttr("style");
                $("#ripTable").removeAttr("style");
            }
            if (currentStatus && dataset.length > 0) {
                let dCount = dataset.length;
                html = ('');
                for (let i = 0; i < dCount; i++) {
                    html += ('<tr>');
                    html += ('<td><span name="txtNet" value="' + dataset[i][0] + '">' + dataset[i][0] + '</span></td>');
                    html += ('<td>');
                    html += ('<button type="button" class="btn btn-primary" style="margin-left:20px;"  name="btnDelete" value="' + dataset[i][0] + '">删除</button>');
                    html += ('</td');
                    html += ('</tr>');
                }
                $("#ripBody").html(html);
            }
        }

        function checkData(route) {
            let regRoute = /^(?:(?:[0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}(?:[0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\/([1-9]|[1-2]\d|3[0-2])$/;
            if (!regRoute.test(route)) {
                alert("输入地址不合法");
                return false;
            }
            return true;
        }

        $("#btnEnable").click(function () {
            alert("111");
        });

        $("#btnDisable").click(function () {
            alert("222");
        });

        $("#btnAdd").click(function () {
            $("#editRoute").val("");
            selectNet = "";
            isCreateNew = true;
            $("#myModalLabel").html("新增");
            $("#editNet").val("");
            $("#editHop").html("");
            $("#editMetric").html("");
            $("#editTag").html("");
            $("#editTime").html("");
            $("#modeModal").modal('show');
        });

        $("#btnRipSave").click(function () {
            let route = $("#editNet").val();
            if (checkData(route)) {
                alert("输入合法");
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
            alert($(this).attr("value"));
        });

        $(document).ready(function () {
            getData();
            loadPage();
        });
    </script>
</body>
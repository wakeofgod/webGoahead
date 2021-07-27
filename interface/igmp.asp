<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>IGMP</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
</head>

<body>
    <h3
        style="font-weight: bolder; text-align: center;background-color: rgb(241,241,241);height: 48px;line-height: 48px;">
        IGMP Snooping</h3>
    <div class="container-fluid">
        <div class="row" style="margin-top: 20px;">
            <label class="col-md-offset-4 col-md-1" style="text-transform: uppercase;">IGMP状态:</label>
            <label class="col-md-1" style="color: #FFA07A;" id="txtIgmpStatus">不使能</label>
            <div class="col-md-2">
                <button type="button" id="btnIgmpEnable" class="btn btn-primary">使能</button>
                <button type="button" id="btnIgmpDiasabe" class="btn btn-primary">不使能</button>
            </div>
        </div>
        <div class="row" style="margin-top: 20px;">
            <label class="col-md-offset-4 col-md-1 control-label" style="text-transform: uppercase;">AGING TIME:</label>
            <label class="col-md-1 control-label" style="color:#FFA07A;" id="txtAgingOld">oldvalue</label>
            <input id="txtAging" placeholder="输入后按enter键保存" />
        </div>
        <div class="row" style="margin-top: 20px;">
            <label class="col-md-offset-4 col-md-1 control-label" style="text-transform: uppercase;">fast-leave:</label>
            <label class="col-md-1 control-label" style="color:#FFA07A;" id="txtFast">使能</label>
            <div class="col-md-2">
                <button type="button" id="btnFastEnable" class="btn btn-primary">使能</button>
                <button type="button" id="btnFastDisable" class="btn btn-primary">不使能</button>
            </div>
        </div>
    </div>
    <div class="container-fluid" style="width: 95%;">
        <div style="margin-top: 20px;" id="igmpHead">
            <table class="table table-striped table-bordered table-hover">
                <thead>
                    <tr>
                        <td width="10%">vlan</td>
                        <td width="40%">mac-group</td>
                        <td>port-list</td>
                    </tr>
                </thead>
            </table>
        </div>
        <div style="height: 550px;overflow-y: auto;overflow-x: hidden;margin-top: -22px;" id="igmpTable">
            <table class="table table-striped table-bordered table-hover">
                <tbody id="bodyIgmp">
                </tbody>
            </table>
        </div>
    </div>
    <div>
        <form id="hForm" style="display: none; visibility:hidden;" method="post" action="/goform/igmpFormPost">
            <input name="hStatus" value="" />
            <input name="hAging" value="" />
            <input name="hFast" value="" />
        </form>
    </div>
    <script>
        var dataset = [];
        var igmpInfo = [];
        var currentStatus = 0;
        var currentAging = 0;
        var currentFast = 0;
        var selectedStatus = 0;
        var selectedFast = 0;
        var html = '';
        var statusTextArray = ["不使能", "使能"]
        function getData() {
            var igmpData = "<%igmpAspGetAll();%>";
            var ethData = "<%igmpAspGetEth();%>";
            if (igmpData.trim() != "") {
                igmpInfo = igmpData.split(',');
                currentStatus = parseInt(igmpInfo[0]);
                currentAging = parseInt(igmpInfo[1]);
                currentFast = parseInt(igmpInfo[2]);
                selectedStatus = currentStatus;
                selectedFast = currentFast;
            }
            if(ethData.trim()!=""){
                ethData=ethData.trim();
                if(ethData.lastIndexOf('|') == (ethData.length - 1)){
                    ethData = ethData.substring(0, ethData.length - 1);
                }
                let tmpEthData = ethData.split('|');
                let tCount =tmpEthData.length;
                for(let i =0;i<tCount;i++){
                    let rowData = tmpEthData[i].split(",");
                    rowData[2]=rowData[2].trim();
                    if(rowData[2].lastIndexOf('*')==(rowData[2].length-1)){
                        rowData[2] = rowData[2].substring(0,rowData[2].length-1);  
                    }
                    rowData[2]= rowData[2].replace(/\*/g, ',');
                    dataset.push([rowData[0],rowData[1],rowData[2]]);
                }
            }
        }

        function loadPage() {
            let tCount = dataset.length;
            if (tCount > 0) {
                html = ('');
                for (let i = 0; i < tCount; i++) {
                    html += ('                <tr>');
                    html += ('<td width="10%">' + dataset[i][0] + '</td>');
                    html += ('<td width="40%">' + dataset[i][1] + '</td>');
                    html += ('<td>' + dataset[i][2] + '</td>');
                    html += ('</tr>');
                }
                $("#bodyIgmp").html(html);
            }
            if (igmpInfo.length > 1) {
                $("#txtIgmpStatus").html(statusTextArray[igmpInfo[0]]);
                $("#txtAgingOld").html(igmpInfo[1]);
                $("#txtFast").html(statusTextArray[igmpInfo[2]]);
            }
        }

        function checkData(aging) {
            var regMtu = /^\d{1,4}$/;
            if(!regMtu.test(aging)||parseInt(aging)>3600||parseInt(aging)<30)
            {
                alert("请检查数字，30-3600");
                return false;
            }
            else if(parseInt(aging)== currentAging)
            {
                alert("数字未修改");
                return false;
            }
            return true;
        }

        function isScroll() {
            let eHeight = $("#igmpTable")[0].scrollHeight;
            if (eHeight > 550) {
                $("#igmpHead").attr("style", "padding-right:17px;margin-top:20px;");
            }
        } 

        $("#txtAging").on("keyup", function (event) {
            event.preventDefault();
            if (event.keyCode === 13) {
                let tmpValue = $(this).val();
                if(checkData(tmpValue)){
                    submit(currentStatus,tmpValue,currentFast);
                }
            }
        });

        $("#btnIgmpEnable").click(function () {
            selectedStatus = 1;
            if (selectedStatus == currentStatus) {
                alert("当前使能");
            }
            else {
                submit(selectedStatus, currentAging, currentFast);
            }
        });

        $("#btnIgmpDiasabe").click(function () {
            selectedStatus = 0;
            if (selectedStatus == currentStatus) {
                alert("当前不使能");
            }
            else {
                submit(selectedStatus, currentAging, currentFast);
            }
        });

        $("#btnFastEnable").click(function () {
            selectedFast = 1;
            if (selectedFast == currentFast) {
                alert("当前使能");
            }
            else {
                submit(currentStatus, currentAging, selectedFast);
            }
        });

        $("#btnFastDisable").click(function () {
            selectedFast = 0;
            if (selectedFast == currentFast) {
                alert("当前不使能");
            }
            else {
                submit(currentStatus, currentAging, selectedFast);
            }
        });

        function submit(selectedStatus, aging, selectedFast) {
            $("[name='hStatus']").val(selectedStatus);
            $("[name='hAging']").val(aging);
            $("[name='hFast']").val(selectedFast);
            $("#hForm").submit();
        }

        $(document).ready(function () {
            getData();
            loadPage();
            isScroll();
        });
    </script>
</body>

</html>
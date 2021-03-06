<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>设备</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <style>
        .mylabel {
            font-size: 20px;
            text-transform: uppercase;
            font-weight: bolder;
        }
    </style>
</head>

<body>
    <h3
        style="font-weight: bolder; text-align: center;background-color: rgb(241,241,241);height: 48px;line-height: 48px;">
        基本信息</h3>
    <br>
    <div class="container-fluid" style="margin: auto;">
        <div id="devInfo" style="margin: auto;width: 800px;">
            <table class="table table-striped table-bordered">
                <tr>
                    <td width="30%"><label class="mylabel">up time:</label></td>
                    <td width="20%"><label id="info1"></label></td>
                    <td width="30%"><label class="mylabel">mac aging:</label></td>
                    <td width="20%"><label id="info2"></label></td>
                </tr>
                <tr>
                    <td><label class="mylabel">l2 mac:</label></td>
                    <td><label id="info3"></label></td>
                    <td><label class="mylabel">l3 mac:</label></td>
                    <td><label id="info4"></label></td>
                </tr>
                <tr>
                    <td><label class="mylabel">hardware version:</label></td>
                    <td><label id="info5"></label></td>
                    <td><label class="mylabel">platform version:</label></td>
                    <td><label id="info6"></label></td>
                </tr>
                <tr>
                    <td><label class="mylabel">product version:</label></td>
                    <td><label id="info7"></label></td>
                    <td><label class="mylabel">build time:</label></td>
                    <td><label id="info8"></label></td>
                </tr>
            </table>
        </div>
    </div>
    <script>
        var dataSet = [];
        function getData() {
            let basicData = "<%deviceAspGetBasic();%>";
            if (basicData.trim() != "") {
                basicData = basicData.trim();
                if (basicData.lastIndexOf(',') == basicData.length - 1) {
                    basicData = basicData.substring(0, basicData.length - 1);
                }
                dataSet = basicData.split(',');
            }
        }

        function loadPage() {
            let nCount = dataSet.length;
            if (nCount > 1) {
                $("#info1").html(dataSet[0]);
                $("#info2").html(dataSet[1]);
                $("#info3").html(dataSet[2]);
                $("#info4").html(dataSet[3]);
                $("#info5").html(dataSet[4]);
                $("#info6").html(dataSet[5]);
                $("#info7").html(dataSet[6]);
                $("#info8").html(dataSet[7]);
            }
        }

        $(document).ready(function () {
            getData();
            loadPage();
        });
    </script>
</body>

</html>
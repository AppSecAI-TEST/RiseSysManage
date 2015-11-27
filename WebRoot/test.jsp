<%@ page language="java" import="java.util.*,net.sf.json.*"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="com.rise.pub.util.*"%>
<%
	String path = request.getContextPath();
	String studentId = request.getParameter("studentId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<%@ include file="common/head.jsp" %>
		<%@ include file="common/formvalidator.jsp" %>
	</head>
	<body>
	
		<table id="test">
			<tr><td>11111111111111</td><td>222222222222</td><td>333333333333333</td><td>444444444444</td></tr>
			<tr><td>11111111111111</td><td>222222222222</td><td>333333333333333</td><td>444444444444</td></tr>
			<tr><td>11111111111111</td><td>222222222222</td><td>333333333333333</td><td>444444444444</td></tr>
			<tr><td>11111111111111</td><td>222222222222</td><td>333333333333333</td><td>444444444444</td></tr>
			<tr><td>11111111111111</td><td>222222222222</td><td>333333333333333</td><td>444444444444</td></tr>
			<tr><td>11111111111111</td><td>222222222222</td><td>333333333333333</td><td>444444444444</td></tr>	
			<tr><td>11111111111111</td><td>222222222222</td><td>333333333333333</td><td>444444444444</td></tr>	
			<tr><td>11111111111111</td><td>222222222222</td><td>333333333333333</td><td>444444444444</td></tr>	
			<tr><td>11111111111111</td><td>222222222222</td><td>333333333333333</td><td>444444444444</td></tr>		
		</table>
	</div>	
		<input type="button" value="click me" onclick ="test()">
	</body>
</html>
<script>
FixTable("test",1,200,200);
function FixTable(TableID, FixColumnNumber, width, height) { 
    if ($("#" + TableID + "_tableLayout").length != 0) { 
        $("#" + TableID + "_tableLayout").before($("#" + TableID)); 
        $("#" + TableID + "_tableLayout").empty(); 
    } 
    else { 
        $("#" + TableID).after("<div id='" + TableID + "_tableLayout' style='overflow:hidden;height:" + height + "px; width:" + width + "px;'></div>"); 
    } 
  
    $('<div id="' + TableID + '_tableFix"></div>'
    + '<div id="' + TableID + '_tableHead"></div>'
    + '<div id="' + TableID + '_tableColumn"></div>'
    + '<div id="' + TableID + '_tableData"></div>').appendTo("#" + TableID + "_tableLayout"); 
  
  
    var oldtable = $("#" + TableID); 
  
    var tableFixClone = oldtable.clone(true); 
    tableFixClone.attr("id", TableID + "_tableFixClone"); 
    $("#" + TableID + "_tableFix").append(tableFixClone); 
    var tableHeadClone = oldtable.clone(true); 
    tableHeadClone.attr("id", TableID + "_tableHeadClone"); 
    $("#" + TableID + "_tableHead").append(tableHeadClone); 
    var tableColumnClone = oldtable.clone(true); 
    tableColumnClone.attr("id", TableID + "_tableColumnClone"); 
    $("#" + TableID + "_tableColumn").append(tableColumnClone); 
    $("#" + TableID + "_tableData").append(oldtable); 
  
    $("#" + TableID + "_tableLayout table").each(function () { 
        $(this).css("margin", "0"); 
    }); 
  
  
    var HeadHeight = $("#" + TableID + "_tableHead thead").height(); 
    HeadHeight += 2; 
    $("#" + TableID + "_tableHead").css("height", HeadHeight); 
    $("#" + TableID + "_tableFix").css("height", HeadHeight); 
  
  
    var ColumnsWidth = 0; 
    var ColumnsNumber = 0; 
    $("#" + TableID + "_tableColumn tr:last td:lt(" + FixColumnNumber + ")").each(function () { 
        ColumnsWidth += $(this).outerWidth(true); 
        ColumnsNumber++; 
    }); 
    ColumnsWidth += 2; 
    $("#" + TableID + "_tableColumn").css("width", ColumnsWidth); 
    $("#" + TableID + "_tableFix").css("width", ColumnsWidth); 
  
  
    $("#" + TableID + "_tableData").scroll(function () { 
        $("#" + TableID + "_tableHead").scrollLeft($("#" + TableID + "_tableData").scrollLeft()); 
        $("#" + TableID + "_tableColumn").scrollTop($("#" + TableID + "_tableData").scrollTop()); 
    }); 
  
    $("#" + TableID + "_tableFix").css({ "overflow": "hidden", "position": "relative", "z-index": "50" }); 
    $("#" + TableID + "_tableHead").css({ "overflow": "hidden", "width": width - 17, "position": "relative", "z-index": "45"}); 
    $("#" + TableID + "_tableColumn").css({ "overflow": "hidden", "height": height - 17, "position": "relative", "z-index": "40"}); 
    $("#" + TableID + "_tableData").css({ "overflow": "scroll", "width": width, "height": height, "position": "relative", "z-index": "35" }); 
  
    if ($("#" + TableID + "_tableHead").width() > $("#" + TableID + "_tableFix table").width()) { 
        $("#" + TableID + "_tableHead").css("width", $("#" + TableID + "_tableFix table").width()); 
        $("#" + TableID + "_tableData").css("width", $("#" + TableID + "_tableFix table").width() + 17); 
    } 
    if ($("#" + TableID + "_tableColumn").height() > $("#" + TableID + "_tableColumn table").height()) { 
        $("#" + TableID + "_tableColumn").css("height", $("#" + TableID + "_tableColumn table").height()); 
        $("#" + TableID + "_tableData").css("height", $("#" + TableID + "_tableColumn table").height() + 17); 
    } 
  
    $("#" + TableID + "_tableFix").offset($("#" + TableID + "_tableLayout").offset()); 
    $("#" + TableID + "_tableHead").offset($("#" + TableID + "_tableLayout").offset()); 
    $("#" + TableID + "_tableColumn").offset($("#" + TableID + "_tableLayout").offset()); 
    $("#" + TableID + "_tableData").offset($("#" + TableID + "_tableLayout").offset()); 
}
</script>
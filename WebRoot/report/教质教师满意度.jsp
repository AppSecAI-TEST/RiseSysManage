<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
  	</head>
  	<body>
  		<div style="margin-right:5px;">
  			<input type="hidden" id="resourceId" value="721">
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId}"/>
  			<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" style="min-width: 40px"><span>校区：</span></td>
	  					<td align="left" style="min-width: 100px;">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        	</select>
	  					</td>
	  					<td align="right" style="min-width: 130px"><span>开班典礼满意度：</span></td>
	  					<td align="left" style="min-width: 130px;">
	  						<input class="easyui-numberbox" name="min1" id="min1"  style="width:45px;height:25px;" data-options="min:0,max:99,precision:0" />%至
	  						<input class="easyui-numberbox" name="max1" id="max1"  style="width:45px;height:25px;" data-options="min:1,max:100,precision:0" />%
	  					</td>
	  					<td align="right" style="min-width: 130px"><span>家长会满意度：</span></td>
	  					<td align="left" style="min-width: 130px;">
	  						<input class="easyui-numberbox" name="min2" id="min2"  style="width:45px;height:25px;" data-options="min:0,max:99,precision:0" />%至
	  						<input class="easyui-numberbox" name="max2" id="max2"  style="width:45px;height:25px;" data-options="min:1,max:100,precision:0" />%
	  					</td>
	  					<td align="left" style="min-width: 230px;">&nbsp;</td>
	  				</tr>
	  				<tr>
	  					<td align="right" style="min-width: 40px"><span>教师：</span></td>
	  					<td align="left" style="min-width: 100px;">
	  						<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:100px;height:25px;" editable="false"
	  							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'">
	  						</select>
	  					</td>
	  					<td align="right" style="min-width: 130px"><span>公开课满意度：</span></td>
	  					<td align="left" style="min-width: 130px;">
	  						<input class="easyui-numberbox" name="min3" id="min3"  style="width:45px;height:25px;" data-options="min:0,max:99,precision:0" />%至
	  						<input class="easyui-numberbox" name="max3" id="max3"  style="width:45px;height:25px;" data-options="min:1,max:100,precision:0" />%
	  					</td>
	  					<td align="right" style="min-width: 130px"><span>毕业典礼满意度：</span></td>
	  					<td align="left" style="min-width: 130px;">
	  						<input class="easyui-numberbox" name="min4" id="min4"  style="width:45px;height:25px;" data-options="min:0,max:99,precision:0" />%至
	  						<input class="easyui-numberbox" name="max4" id="max4"  style="width:45px;height:25px;" data-options="min:1,max:100,precision:0" />%
	  					</td>
	  					<td align="left" style="min-width: 230px;">&nbsp;</td>
	  				</tr>	
	  				<tr>
	  					<td align="right" style="min-width: 40px"><span>时间：</span></td>
	  					<td align="left" style="min-width: 100px;">
	  						<input class="easyui-datebox"  type="text" style="width:100px; height: 25px;" id="month" name="month" editable="false" data-options="formatter:myformatter, parser:myparser"/>
	  					</td>
	  					<td align="right" style="min-width: 130px"><span>综合满意度：</span></td>
	  					<td align="left" style="min-width: 130px;" colspan="3">
	  						<input class="easyui-numberbox" name="min5" id="min5"  style="width:45px;height:25px;" data-options="min:0,max:99,precision:0" />%至
	  						<input class="easyui-numberbox" name="max5" id="max5"  style="width:45px;height:25px;" data-options="min:1,max:100,precision:0" />%
	  					</td>
	  					<td align="left" style="min-width: 230px;">
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:100px" id="qryBtn" funcNodeId ="60345"><span>查询</a>
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" style="width:100px" id="resetBtn"><span>重置</a>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
			<table class="easyui-datagrid" style="height:450px;" id="list_data"
				title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true">
				<thead>
					<tr>
						<th data-options="field:'schoolName',width:100,align:'center'">校区</th>
						<th data-options="field:'teacherName',width:120,align:'center'">教师中文名称</th>
						<th data-options="field:'byname',width:100,align:'center'">教师</th>
						<th data-options="field:'strativeCsiVal',width:120,align:'center'">开班典礼满意度</th>
						<th data-options="field:'meetingCsiVal',width:120,align:'center'">家长会满意度</th>
						<th data-options="field:'openCsiVal',width:120,align:'center'">公开课满意度</th>
						<th data-options="field:'gradCsiVal',width:120,align:'center'">毕业典礼满意度</th>
						<th data-options="field:'csiPerVal',width:120,align:'center'">综合满意度</th>
					</tr>
				</thead>
			</table>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
			</div>
  		</div>
  	</body>
</html>
<script>
$(document).ready(function(){
	 $('#month').datebox({
     	onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
        	var p = $('#month').datebox('panel'), //日期选择对象
            span = p.find('span.calendar-text'); //显示月份层的触发控件
            p.find(".calendar-menu-year").attr("readOnly","true");
            span.click(function(){
            	p.find('div.calendar-menu').hide();
            });
            span.get(0).click(); //触发click事件弹出月份层
            p.find("div.datebox-button").find("td:eq(0)").css("visibility","hidden");//隐藏今天按钮
            var months = p.find(".calendar-menu-month-inner").find(".calendar-menu-month");
            months.unbind();
            months.click(function(){
	            var year = /\d{4}/.exec(span.html())[0]//得到年份
	            , month = parseInt($(this).attr('abbr'))+1;
	            if(month < 10) {
	            	month = "0" + month;
				}
				var val = year + '-' + month + "-00";
				$('#month').datebox('setValue',val).datebox('hidePanel'); //设置日期的值
			});
       	}
	});
	initReportButton("resetBtn","qryFm","schoolId");
	$("#qryBtn").click(function() {
		var object = $("#qryFm").serializeObject();
		if(object.month == '') {
			$.messager.alert('提示', "请选择时间");
			return;
		}
    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
    	object.funcNodeId = funcNodeId;
    	var obj = JSON.stringify(object);
    	$('#list_data').datagrid({
    		url : "/sys/pubData/qryDataListByPage.do",
    		queryParams:{
    			param : obj
    		},
			onLoadSuccess: function() {
				onLoadSuccess();
			}
    	});
    });
	$("#schoolId").combobox({
		onChange:function(){
			$("#teacherId").combobox({
				url : "/sys/pubData/getTeacherBySchoolId.do?schoolId="+$("#schoolId").combobox('getValue')
			});
		}
	});
	exportMergeLink("export", "list_data", "schoolId", "0");
});

function onLoadSuccess() {
	mergeCellsByField("list_data", "schoolName");
}

function myformatter(date) {
	var y = date.getFullYear();
	var m = date.getMonth() + 1;
	var d = date.getDate();
	return y + '-' + (m < 10 ? ('0' + m) : m);
}

function myparser(s) {
	if (!s) return new Date();
	var ss = (s.split('-'));
	var y = parseInt(ss[0],10);
	var m = parseInt(ss[1],10);
	var d = parseInt(ss[2],10);
	if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
		return new Date(y,m-1,d);
	} else {
		return new Date();
	}
}

function mergeCellsByField(tableId, colList) {
    var rowspan;
    var megerIndex;
    var before = "";
    var after = "";
    var target = $("#" + tableId);
    var colunms = colList.split(",");
    var rows = target.datagrid("getRows").length;
    for (var j = colunms.length - 1; j >= 0; j--) {
    	var field = colunms[j];
    	before = "";
        rowspan = 1;
        megerIndex = 0;
        for (var i = 0; i <= rows; i++) {
            if (i == rows) {
            	after = "";
            } else {
            	after = target.datagrid("getRows")[i][field];
            }
            if (before == after) {
            	rowspan += 1;
            } else {
            	target.datagrid("mergeCells", {
        			index: i - rowspan,
        			field: field,　　// 合并字段
        			rowspan: rowspan
        		});
            	rowspan = 1;
            }
            before = after;
        }
    }
}
</script>
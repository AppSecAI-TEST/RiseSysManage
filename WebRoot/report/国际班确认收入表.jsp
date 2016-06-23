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
	  		<input id="staffId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
	  		<input type="hidden" id="resourceId" value="727">
  			<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" width="80px"><span>校区：</span></td>
	  					<td align="left"  width="110px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
					      		
				        	</select>
	  					</td>
	  					<td width="60px" align="right"><span>月份：</span></td>
						<td width="110px">
							<input class="easyui-datebox"  type="text" style="width:100px; height: 25px;" id="month" name="month" editable="false" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td width="50px" align="right"><span>班级：</span></td>
						<td width="100px">
							 <input class="easyui-textbox" id="className" name="className" style="width:100px;"></td>
						</td>
						<td width="70px" align="right"><span>学员姓名：</span></td>
						<td width="100px">
							 <input class="easyui-textbox" id="name" name="name" style="width:100px;"></td>
						</td>
						<td align="left">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId ="3706">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>	
	  			</table>
  			</form>
				<table class="easyui-datagrid" style="height:435px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th field="schoolName" align="center" width="8%">校区</th>
							<th field="name" align="center" width="8%">姓名</th>
							<th field="classType" align="center" width="8%">国际班类型</th>
							<th field="className" align="center" width="8%">班级</th>
							<th field="adviserTeacherName" align="center" width="8%">业绩老师</th>
							<th field="adviserName" align="center" width="8%">业绩顾问</th>
							<th field="shortClassName" align="center" width="8%">国际班班级</th>
							<th field="payDate" align="center" width="8%">缴费日期</th>
							<th field="amount" align="center" width="8%">实收金额</th>
							<th field="favorName" align="center" width="8%">优惠方式</th>
							<th field="attendDate" align="center" width="8%">确认收入月份</th>
							<th field="planHours" align="center" width="8%">总课时数</th>
							<th field="monthRealHours" align="center" width="8%">本月课时</th>
							<th field="monthIncome" align="center" width="8%">本月确认收入</th>
							<th field="totalRealHours" align="center" width="8%">累计课时</th>
							<th field="totalIncome" align="center" width="8%">累计确认收入</th>
							<th field="remainIncome" align="center" width="8%">未确认收入余额</th>
						</tr>
					</thead>
				</table>
			</div>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
				<a href="javascript:void(0)" id="tieOffBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;" onclick="tieOffFunc()">扎帐管理</a>
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
                	if(month<10)
                	{
                		month="0"+month;
                	}
                	var val =year + '-' + month+"-00";
                    $('#month').datebox('setValue',val).datebox('hidePanel'); //设置日期的值
             	});
            }
    	});
	 	initReportButton("reset","qryFm","schoolId");
	 	$("#qryBtn").click(function() {
			var object = $("#qryFm").serializeObject();
	    	var obj = JSON.stringify(object);
	    	obj = obj.substring(0, obj.length - 1);
	    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
	    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
	    	$('#list_data').datagrid({
	    		url : "/sys/pubData/qryDataListByPage.do",
	    		queryParams:{
	    			param : obj
	    		}
	    	});
    	});
		exportLink("export","list_data");
});


function myformatter(date){
            var y = date.getFullYear();
            var m = date.getMonth()+1;
            var d = date.getDate();
            return y+'-'+(m<10?('0'+m):m);
        }

  function myparser(s){
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

function tieOffFunc()
{
	ajaxLoading("正在处理，请稍待。。。");
	window.location.href = "/sys/tieOff/interTieOffPage.jsp";
}
</script>
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
  		<div style="padding:5px 0;">
  			<form id="qryFm" style="margin:0 auto;">
	  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
	  				<tr>
	  					<td align="right"><span>校区：</span></td>
	  					<td align="left"  width="120px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
					      		url="<%=path %>/pubData/qrySchoolList.do?">
				        	</select>
	  					</td>
	  					<td width="100px" align="right"><span>日期：</span></td>
						<td width="114px">
							<input class="easyui-datebox"  type="text" style="width:114px; height: 25px;" id="month" name="month" editable="false" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="center">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId ="3707">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>	
	  			</table>
  			</form>
			<div style="padding:5px 0;min-width:1100px; width:100%;">
				<table class="easyui-datagrid" style="height:435px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th field="schoolName" align="center" width="8%">校区</th>
							<th field="name" align="center" width="8%">姓名</th>
							<th field="classType" align="center" width="8%">课程类型</th>
							<th field="identityId" align="center" width="10%">证件号码</th>
							<th field="className" align="center" width="8%">班级</th>
							<th field="adviserTeacherName" align="center" width="8%">业绩老师</th>
							<th field="adviserName" align="center" width="8%">业绩顾问</th>
							<th field="normalClassName" align="center" width="8%">游学班级</th>
							<th field="payDate" align="center" width="8%">游学缴费日期</th>
							<th field="amount" align="center" width="7%">实收金额</th>
							<th field="favorName" align="center" width="8%">优惠方式</th>
							<th field="startDate" align="center" width="8%">游学出发日期</th>
							<th field="finishDate" align="center" width="8%">游学返回日期</th>
							<th field="attendDate" align="center" width="8%">确认收入月份</th>
							<th field="amount" align="center" width="7%">确认收入</th>
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
	 	initQryButton("qryBtn","resetBtn","qryFm","list_data");
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
	ajaxLoading("加载中...");
	window.location.href = "/sys/tieOff/tourismTieOffPage.jsp";
}
</script>
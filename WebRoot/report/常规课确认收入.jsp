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
  		<input id="staffId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<input type="hidden" id="resourceId" value="728">
  		<div style="margin-right:5px;">
  			<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" width="80px"><span>校区：</span></td>
	  					<td align="left"  width="110px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
					      		
				        	</select>
	  					</td>
	  					<td align="right" width="50px"><span>月份：</span></td>
	  					<td align="left"  width="130px">
	  						<input class="easyui-datebox"  type="text" style="width:120px; height: 25px;" id="attendMonth" name="attendMonth" editable="false" data-options="formatter:myformatter, parser:myparser"/>
	  					</td>
	  					<td width="70px" align="right"><span>业绩类型：</span></td>
						<td width="110px">
							<select name="feeType" editable='false' class="easyui-combobox" id="feeType" style="width: 100px; height: 25px;"
								 data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
			      				 url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=FEE_TYPE" >
							</select>
						</td>
						<td width="50px" align="right"><span>班级：</span></td>
						<td width="110px">
							 <input class="easyui-textbox" id="className" name="className" style="width:100px;"></td>
						</td>
						<td width="70px" align="right"><span>学员姓名：</span></td>
						<td width="110px">
							 <input class="easyui-textbox" id="name" name="name" style="width:100px;"></td>
						</td>
						<td align="left">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="5006">查询</a>
							&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>	
	  			</table>
  			</form>
			<table class="easyui-datagrid" style="height:535px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false"  fitColumns="true">
					<thead>
						<tr>
							<th field="schoolName" align="center" width="8%">校区</th>
							<th field="courseStateText" align="center" width="8%">状态</th>
							<th field="className" align="center" width="8%">班级名称</th>
							<th field="name" align="center" width="8%">学员姓名</th>
							<th field="stageId" align="center" width="8%">在读阶段</th>
							<th field="feeTypeText" align="center" width="8%">业绩类型</th>
							<th field="byname" align="center" width="8%">带班老师</th>
							<th field="openDate" align="center" width="8%">开课日期</th>
							<th field="finishDate" align="center" width="8%">结课日期</th>
							<th field="payDate" align="center" width="8%">全费日期</th>
							<th field="attendMonth" align="center" width="8%">确认<br>收入月份</th>
							<th field="feeA" align="center" width="8%">学费</th>
							<th field="feeB" align="center" width="8%">材料费</th>
							<th field="feeC" align="center" width="8%">保育费<br>和餐费</th>
							<th field="feeD" align="center" width="8%">总部提成</th>
							<th field="feeE" align="center" width="8%">其他</th>
							<th field="amount" align="center" width="8%">总费用</th>
							<th field="hours" align="center" width="8%">总课时数</th>
							<th field="monthRealHours" align="center" width="8%">本月课时</th>
							<th field="financialConfirmFee" align="center" width="8%">退费金额</th>
							<th field="refundIncome" align="center" width="8%">由于退费<br>产生收益</th>
							<th field="allMonthIncome" align="center" width="8%">本月确认收入</th>
							<th field="normalAllRealHours" align="center" width="8%">累计课时</th>
							<th field="normalTotalIncome" align="center" width="8%">累计<br>确认收入</th>
							<th field="remainIncome" align="center" width="8%">未确认<br>收入余额</th>
						</tr>
					</thead>
			</table>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
	   			<a href="javascript:void(0)" id="tieOffBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;" onclick="tieOffFunc()">扎帐管理</a>
			</div>
  		</div>
  	</body>
</html>
<script>
	$(document).ready(function(){
		$('#attendMonth').datebox({
            onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
        		var p = $('#attendMonth').datebox('panel'), //日期选择对象
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
                    $('#attendMonth').datebox('setValue',val).datebox('hidePanel'); //设置日期的值
             	});
            }
		});
		var now =new Date();
		$('#attendMonth').datebox("setValue",now.getFullYear()+"-"+(now.getMonth()+1));
		initReportButton("reset","qryFm","schoolId");
	 	$("#qryBtn").click(function() {
			var object = $("#qryFm").serializeObject();
			attendMonth=object.attendMonth.replace("-","_");
			object.tableName="income_"+attendMonth;
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
	 	$("#reset").click(function(){
	 		var now =new Date();
			$('#attendMonth').datebox("setValue",now.getFullYear()+"-"+(now.getMonth()+1));
	 	});
		exportLink("export","list_data");
	})

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
		window.location.href = "/sys/tieOff/regularTieOffPage.jsp";
	}
</script>
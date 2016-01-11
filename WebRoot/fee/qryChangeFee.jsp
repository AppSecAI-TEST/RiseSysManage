<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/courseFee/qryCourseFee.js"></script>
  	</head>
  	<body>
  		<div style="margin-right:5px;">
 		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td align="right"><span>校区：</span></td>
  					<td>
  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:100px;height:25px;"
  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
  						</select>
  					</td>
  					<td align="right"><span>学员姓名：</span></td>
  					<td>
  						<input class="easyui-textbox" name="name" id="name" style="width:100px;height:25px;" />
  					</td>
  					<td align="right"><span>联系电话：</span></td>
  					<td>
  						<input class="easyui-textbox" name="phone" id="phone" style="width:120px;height:25px;" />
  					</td>
  					<td align="right"><span>缴费日期：</span></td>
  					<td>
  						<input class="easyui-datebox" name="startTime" id="startTime"  style="width:100px;height:25px;" />
	  					至
  						<input class="easyui-datebox" name="endTime" id="endTime"  style="width:100px;height:25px;" />
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>业绩顾问：</span></td>
  					<td>
  						<select name="adviser" class="easyui-combobox" id="adviser" style="width: 100px;height:25px;"
							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'">
						</select>
  					</td>
  					<td align="right"><span>业绩老师：</span></td>
  					<td>
  						<select name="adviserTeacher" class="easyui-combobox" id="adviserTeacher" style="width: 100px;height:25px;"
							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'">
						</select>
  					</td>
  					<td align="right"><span>VIP学员：</span></td>
  					<td>
  						<input type="radio" name="vip" value="Y"><span>是</span>
  						<input type="radio" name="vip" value="N"><span>否</span>
  					</td>
  					<td align="right"><span>课程类型：</span></td>
  					<td>
  						<select class="easyui-combobox" name="state" id="state" style="width:100px;height:25px;"
  							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'">
  						</select>
  						&nbsp;&nbsp;&nbsp;
  						<select class="easyui-combobox" name="classType" id="classType" style="width:100px;height:25px;"
  						</select>
  					</td>
  					<td align="left">
	  					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:100px" id="qryBtn" funcNodeId="3801"><span>查询</span></a>
	  					&nbsp;&nbsp;&nbsp;
	  					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:100px" id="resetBtn" ><span>重置</span></a>
  					</td>
  				</tr>
  			</table>
 		</form>
 		
 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:400" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true">
			<thead>
				<tr>
					<th field="schoolName" align="center" width="5%">校区</th>
					<th field="name" align="center" width="10%">学员姓名</th>
					<th field="byName" align="center" width="10%">英文名</th>
					<th field="feeTypeVal" align="center" width="10%">业绩类型</th>
					<th field="classType" align="center" width="10%">班级类型</th>
					<th field="payTime" align="center" width="10%">缴费日期</th>
					<th field="courseStateVal" align="center" width="10%">课程状态</th>
					<th field="className" align="center" width="10%">当前班级</th>
					<th field="totalAmount" align="center" width="10%">课程总价</th>
					<th field="amount" align="center" width="10%">实收金额</th>
					<th field="beforeAmount" align="center" width="13%">调整前实收金额</th>
					<th field="afterAmount" align="center" width="13%">调整后实收金额</th>
					<th field="handlerName" align="center" width="10%">调整人</th>
					<th field="changeTime" align="center" width="13%">调整时间</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;">返回</a>
 		</div>
 		</div>
  	</body>
</html>
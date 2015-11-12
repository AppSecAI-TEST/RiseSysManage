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
 		<form id="qryFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="15">
  				<tr>
  					<td align="right"><span>校区：</span></td>
  					<td>
  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;height: 28px;"
  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
  							url="<%=path%>/pubData/qrySchoolList.do?schoolId=">
  						</select>
  					</td>
  					<td align="right"><span>学员姓名：</span></td>
  					<td>
  						<input class="easyui-textbox" name="name" id="name" style="width:150px;" />
  					</td>
  					<td align="right"><span>联系电话：</span></td>
  					<td>
  						<input class="easyui-textbox" name="phone" id="phone" style="width:150px;" />
  					</td>
  					<td align="right"><span>缴费日期：</span></td>
  					<td>
  						<input class="easyui-datebox" name="startTime" id="startTime"  style="width:150px;" />
  					</td>
  					<td align="center"><span>至：</span></td>
  					<td>
  						<input class="easyui-datebox" name="endTime" id="endTime"  style="width:150px;" />
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>业绩顾问：</span></td>
  					<td>
  						<select name="adviser" class="easyui-combobox" id="adviser" style="width: 150px; height: 28px;"
							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"
		      				url="<%=path %>/pubData/qryTeacherList.do?schoolId=${sessionScope.StaffT.schoolId}">
						</select>
  					</td>
  					<td align="right"><span>业绩老师：</span></td>
  					<td>
  						<select name="adviserTeacher" class="easyui-combobox" id="adviserTeacher" style="width: 150px; height: 28px;"
							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"
		      				url="<%=path %>/pubData/qryTeacherList.do?schoolId=${sessionScope.StaffT.schoolId}">
						</select>
  					</td>
  					<td align="right"><span>VIP学员：</span></td>
  					<td>
  						<input type="radio" name="vip" value="Y"><span>是</span>
  						<input type="radio" name="vip" value="N"><span>否</span>
  					</td>
  					<td align="right"><span>课程类型：</span></td>
  					<td>
  						<select class="easyui-combobox" name="state" id="state" style="width:150px;height: 28px;"
  							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'">
  						</select>
  					</td>
  					<td align="center"></td>
  					<td>
  						<select class="easyui-combobox" name="classType" id="classType" style="width:150px;height: 28px;"
  						</select>
  					</td>
  				</tr>
  				<tr>	
  					<td colspan="7">
  					</td>
  					<td>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn" funcNodeId="3800"><span>查询</span></a>
  					</td>
  					<td>&nbsp;</td>
  					<td>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:150px" id="resetBtn" ><span>重置</span></a>
  					</td>	
  				</tr>
  			</table>
 		</form>
 		
 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:500" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
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
					<th field="lastAmount" align="center" width="13%">调整后实收金额</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" id="changeFee" class="easyui-linkbutton" iconCls="icon-edit" plain="true">调整费用</a>
   			<a href="javascript:void(0)" id="viewFee" class="easyui-linkbutton" iconCls="icon-redo" plain="true">浏览</a>
   			<a href="javascript:void(0)" id="qryChange" class="easyui-linkbutton" iconCls="icon-search" plain="true">调整记录查询</a>
 		</div>
  	</body>
</html>

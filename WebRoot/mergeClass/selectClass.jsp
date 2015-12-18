<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String isHead =request.getParameter("isHead");
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/mergeClass/selectClass.js"></script>
		<style>
			#classList a
			{
				display:inline-block;
				padding:5px 20px 5px 0px;
				color:blue;
				text-decoration:underline;
				cursor:pointer;
			}
		</style>
  	</head>
  	<body>
 		<form id="qryFm">
 			<input type="hidden" id="isHead" name="isHead" value="<%=isHead%>"/>
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="15">
  				<tr>
  					<td align="right">校区：</td>
  					<td>
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 150px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
			      			onLoadSuccess:function(data){$('#schoolId').combobox('setValue',data[0].schoolId);}"
			      			url="<%=path %>/pubData/qrySchoolList.do?schoolId=${sessionScope.StaffT.schoolId}">
		        		</select>
  					</td>
  					<td align="right">课时进度：</td>
  					<td>
  						<input class="easyui-datebox" name="minTime" id="minTime" style="width:150px;" />
  					</td>
  					<td align="center"  width="10px">至：</td>
  					<td>
  						<input class="easyui-datebox" name="maxTime" id="maxTime" style="width:150px;" />
  					</td>
  					<td></td>
  				</tr>
  				<tr>
  					<td align="right">课程阶段：</td>
  					<td>
  						<select id="stageId" name="stageId" class="easyui-combobox" style="width: 150px;"
							data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'"
			      			url="<%=path %>/pubData/qryStage.do?">
		        		</select>
  					</td>
  					<td align="right">开课日期：</td>
  					<td>
  						<input class="easyui-datebox" name="startTime" id="startTime" style="width:150px;" />
  					</td>
  					<td align="center">至：</td>
  					<td>
  						<input class="easyui-datebox" name="endTime" id="endTime" style="width:150px;" />
  					</td>
  					<td>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn" funcNodeId="3110">查询</a>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:150px" id="resetBtn" >重置</a>
  					</td>
  				</tr>
  			</table>
 		</form>
 		
 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:450" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="schoolName" align="center" width="5%">校区</th>
					<th field="className" align="center" width="8%">班级名称</th>
					<th field="startDate" align="center" width="10%">开课日期</th>
					<th field="teacherName" align="center" width="10%">带班老师</th>
					<th field="finishDate" align="center" width="10%">结课日期</th>
					<th field="classProgress" align="center" width="7%">课时进度</th>
					<th field="progressRate" align="center" width="10%">课时进度%</th>
					<th field="classTime" align="center" width="18%">上课时间段</th>
					<th field="readNum" align="center" width="10%">在读人数</th>
					<th field="graduteNum" align="center" width="10%">已升学人数</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
			<table>	
				<tr>
					<td>
			   			<a href="javascript:void(0)" id="addClass" class="easyui-linkbutton" style="width: 100px;" iconCls="icon-add">添加</a>
			   			<a href="javascript:void(0)" id="subClass" class="easyui-linkbutton" style="width: 100px;"iconCls="icon-ok">提交</a>
			   			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" style="width: 100px;" iconCls="icon-back">返回</a>
	   				</td>
	   				<td>
	   					<div id="classList">已添加班级：</div>
	   				</td>
	   			</tr>
	   		</table>
 		</div>
  	</body>
</html>

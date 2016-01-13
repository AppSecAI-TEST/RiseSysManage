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
			#classList{margin-left:10px;}
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
  			<table class="search_tab">
  				<tr>
  					<td width="80px;" align="right"><span>校区：</span></td>
  					<td width="110px;">
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px;height:25px" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
			      			onLoadSuccess:function(data){$('#schoolId').combobox('setValue',data[0].schoolId);}"
			      			url="<%=path %>/pubData/qrySchoolList.do?schoolId=${sessionScope.StaffT.schoolId}">
		        		</select>
  					</td>
  					<td  width="80px;" align="right"><span>课时进度：</span></td>
  					<td  width="230px;">
  						<input class="easyui-datebox" name="minTime" id="minTime" style="width: 100px;height:25px" />
  						至
  						<input class="easyui-datebox" name="maxTime" id="maxTime" style="width: 100px;height:25px" />
  					</td>
  					<td></td>
  				</tr>
  				<tr>
  					<td align="right"><span>课程阶段：</span></td>
  					<td>
  						<select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px;height:25px"
							data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'"
			      			url="<%=path %>/pubData/qryStage.do?">
		        		</select>
  					</td>
  					<td align="right"><span>开课日期：</span></td>
  					<td>
  						<input class="easyui-datebox" name="startTime" id="startTime" style="width: 100px;height:25px" />
  						至
  						<input class="easyui-datebox" name="endTime" id="endTime" style="width: 100px;height:25px" />
  					</td>
  					<td>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:100px" id="qryBtn" funcNodeId="3110">查询</a>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:100px" id="resetBtn" >重置</a>
  					</td>
  				</tr>
  			</table>
 		</form>
 		
 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:450" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="schoolName" align="center" width="5%"><span>校区</span></th>
					<th field="className" align="center" width="8%"><span>班级名称</span></th>
					<th field="startDate" align="center" width="10%"><span>开课日期</span></th>
					<th field="teacherName" align="center" width="10%"><span>带班老师</span></th>
					<th field="finishDate" align="center" width="10%"><span>结课日期</span></th>
					<th field="classProgress" align="center" width="7%"><span>课时进度</span></th>
					<th field="progressRate" align="center" width="10%"><span>课时进度%</span></th>
					<th field="classTime" align="center" width="18%"><span>上课时间段</span></th>
					<th field="readNum" align="center" width="10%"><span>在读人数</span></th>
					<th field="graduteNum" align="center" width="10%"><span>已升学人数</span></th>
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

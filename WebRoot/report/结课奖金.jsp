<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/exceptionOpenClass.js"></script>
  	</head>
  
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm" style="margin:0 auto;">
  				<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
  					<tr>
  						<td align="right" width="100px"><span>校区：</span></td>
	  					<td width="114px">
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
					      		url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
				        	</select>
						</td>
						<td align="right" width="100px"><span>课程阶段：</span></td>
	  					<td width="114px">
							<select id="stageId" name="stageId" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
			      				url="<%=path %>/pubData/qryStage.do">
				        	</select>
						</td>
						<td align="right" width="150px"><span>已结课班级：</span></td>
	  					<td width="114px">
							<select id="classInstId" name="classInstId" class="easyui-combobox" style="width: 114px; height: 25px;">
				        	</select>
						</td>
						<td align="right" width="100px"><span>结课日期：</span></td>
	  					<td width="100px">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeFinish" name="startTimeFinish" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="center" width="14px"><span>至</span></td>
						<td width="100px">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeFinish" name="endTimeFinish" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td width="150px">&nbsp;</td>
  					</tr>
  					<tr>
  						<td align="right" width="100px"><span>升学率：</span></td>
	  					<td width="130px">
	  						<input name="minHigherRate" id="minHigherRate" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
							<span style="display: inline-block; text-align: center; width: 14px;">至</span>
							<input name="maxHigherRate" id="maxHigherRate" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
	  					</td>
						<td align="right" width="100px"><span>带班老师：</span></td>
	  					<td width="114px">
							<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 114px; height: 25px;">
				        	</select>
						</td>
						<td align="right" width="150px"><span>是否已申请奖金：</span></td>
						<td width="130px">
							<input type="checkbox" name="isApplyBonus" value="'Y'"/><span>是</span>
							&nbsp;&nbsp;<input type="checkbox" name="isApplyBonus" value="'N'"/><span>否</span>
						</td>
						<td align="left" colspan="4">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1060">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
						<td width="150px">&nbsp;</td>
  					</tr>
  				</table>
  			</form>
  			<div style="padding:5px 0;min-width:1100px; width:100%;">
  				<table class="easyui-datagrid" style="height:435px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'schoolName',width:'6%',align:'center'">校区</th>
							<th data-options="field:'stageId',width:'7%',align:'center'">课程阶段</th>
							<th data-options="field:'className',width:'7%',align:'center'">班级</th>
							<th data-options="field:'finishDate',width:'8%',align:'center'">结课日期</th>
							<th data-options="field:'isTwoHand',width:'7%',align:'center'">是否二手班</th>
							<th data-options="field:'byname',width:'10%',align:'center'">带班老师</th>
							<th data-options="field:'openClassNum',width:'7%',align:'center'">开班人数</th>
							<th data-options="field:'higherBaseNum',width:'7%',align:'center'">升学基数</th>
							<th data-options="field:'higherNum',width:'7%',align:'center'">已升学人数</th>
							<th data-options="field:'higherRate',width:'7%',align:'center'">升学率</th>
							<th data-options="field:'changeTeacherRemark',width:'20%',align:'center'">中途更换老师情况</th>
							<th data-options="field:'teacherHours',width:'12%',align:'center'">授课课时比例</th>
							<th data-options="field:'isApplyBonusText',width:'9%',align:'center'">是否已申请奖金</th>
							<th data-options="field:'option', width:'6%', align:'center', formatter:formatFinishBonus">操作</th>
						</tr>
					</thead>
				</table>
  			</div>
  			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
			</div>
  		</div>
  	</body>
</html>
<script>
exportLink("export","list_data");
</script>

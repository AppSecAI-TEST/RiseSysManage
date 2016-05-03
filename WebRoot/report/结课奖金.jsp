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
  		<div style="margin-right:5px;">
	  		<input type="hidden" id="resourceId" value="746">
	  		<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId }"/>
  			<form id="qryFm">
  				<table class="search_tab">
  					<tr>
  						<td align="right" style="width: 70px"><span>校区：</span></td>
	  					<td width="100px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false" 
									data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
					        </select>
						</td>
						<td align="right" width="70px"><span>课程阶段：</span></td>
	  					<td width="100px">
							<select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px; height: 25px;"
								data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
			      				url="<%=path %>/pubData/qryStage.do">
				        	</select>
						</td>
						<td align="right" width="90px"><span>已结课班级：</span></td>
	  					<td width="100px">
	  						<input id="classInstId" name="classInstId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
						</td>
						<td align="right" width="90px"><span>结课日期：</span></td>
	  					<td width="225px">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeFinish" name="startTimeFinish" data-options="formatter:myformatter, parser:myparser"/>
							至
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeFinish" name="endTimeFinish" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td style="min-width:100px;"></td>
  					</tr>
  					<tr>
  						<td align="right"><span>升学率：</span></td>
	  					<td>
	  						<input name="minHigherRate" id="minHigherRate" type="text" class="easyui-numberbox" style="width: 40px; height: 25px;"/>
							<span style="display: inline-block; text-align: center; width: 14px;">至</span>
							<input name="maxHigherRate" id="maxHigherRate" type="text" class="easyui-numberbox" style="width: 40px; height: 25px;"/>
	  					</td>
						<td align="right"><span>带班老师：</span></td>
	  					<td>
							<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 100px; height: 25px;">
				        	</select>
						</td>
						<td align="right"><span>是否已申请奖金：</span></td>
						<td colspan="2">
							<input type="checkbox" name="isApplyBonus" value="'Y'"/><span>是</span>
							&nbsp;&nbsp;<input type="checkbox" name="isApplyBonus" value="'N'"/><span>否</span>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1060">查询</a>
							&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
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
							<th data-options="field:'option', width:'10%', align:'center', formatter:formatFinishBonus">操作</th>
						</tr>
					</thead>
				</table>
  			</div>
  			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
			</div>
  		</div>
  		<div id="dlg" class="easyui-dialog" closed="true" modal="true">
			<table class="easyui-datagrid" style="width:900px;height:500px" id="detail_list_data" fitColumns="true">
				<thead>
					<tr>
						<th field="rownum" align="center" width="100px">序号</th>
						<th field="name" align="center" width="200px">中文名</th>
						<th field="byName" align="center" width="200px">英文名</th>
						<th field="isHigherText" align="center" width="150px">是否升学</th>
						<th field="className" align="center" width="150px">现在读班级</th>
						<th field="classProgress" align="center" width="150px">学员课时进度</th>
						<th field="payDate" align="center" width="150px">缴费日期</th>
						<th field="higherBaseNum" align="center" width="150px">升学基数</th>
					</tr>
				</thead>
			</table>
		</div>
  	</body>
</html>
<script>
exportLink("export","list_data");

$("#list_data").datagrid({
	onClickRow : function(index, row) {
		var classInstId = row.classInstId;
		var obj = "{queryCode:\"qryFinishClassHigherDetail\",classInstId:\""+classInstId+"\"}";
		$("#detail_list_data").datagrid({
			url : "/sys/pubData/qryDataListByPage.do",
			queryParams:{
				param : obj
			}
		});
		$("#dlg").form("clear");//清空窗体数据 
		$("#dlg").dialog("open").dialog("setTitle", "结课班级学员升学明细");//设定表头  
	}
});
</script>

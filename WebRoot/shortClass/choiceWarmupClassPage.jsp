<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<style type="text/css">
			td{
				font-size:14px;
				font-family:"微软雅黑";
			}
		</style>
		<script type="text/javascript">
			ajaxLoadEnd();
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE",function(data){
				data = $.grep(data , function(node){
					if(node.codeFlag != '002' && node.codeFlag != '004' && node.codeFlag != '005')
					{
						return true;
					}
					return false;
				});
				$("#classState").combobox("loadData",data);
			},"json");
			$(document).ready(function(){
				$("#classState").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
				$("#stageId").combobox({
					url : "/sys/pubData/qryStage.do",
			    	valueField : "stageId",
			    	textField : "stageId",
			    	panelHeight : "auto",
			    	formatter : function(data) {
			    		return "<span>" + data.stageId + "</span>";
			    	}
				});
			});
			function queryFunc()
			{
				var obj = $("#manFm").serializeObject();
				obj["queryCode"] = "qryWarmupChoiceClassList";
				obj["funcNodeId"] = "38134";
				obj = JSON.stringify(obj);
				$("#studentList").datagrid({
					url:"/sys/pubData/qryDataListByPage.do",
					queryParams:{
						param : obj
					}
				});
			}
			function resetFunc()
			{
				$("#stageId").combobox("setValue","");
				$("#classInstId").textbox("setValue","");
				$("#classState").combobox("setValue","");
				$("#payStartManTime").datebox("setValue","");
				$("#payEndManTime").datebox("setValue","");
				$("#studentName").textbox("setValue","");
				$("#phoneNum").textbox("setValue","");
			}
			function manFunc()
			{
				var rows = $("#studentList").datagrid('getChecked');
				if (rows && rows.length >0)
				{
					var arr = [];
					for(var i = 0,n = rows.length;i < n;i++)
					{
						var json = {
							shortClassInstId:"${param.shortClassInstId}",
							studentId:rows[i].studentId,
							studentCourseId:rows[i].studentCourseId,
							schoolId:rows[i].schoolId,
							handlerId:${sessionScope.StaffT.staffId}
						}
						arr.push(json);
					}
					ajaxLoading("正在处理，请稍待。。。");
					$.post("/sys/shortBus/addShortStudentTInfo.do",{json:JSON.stringify(arr),classType:encodeURI("热身课"),shortClassInstId:"${param.shortClassInstId}"},function(data){
						ajaxLoadEnd();
						if(data == "success")
						{
							backFunc();
						}
						else
						{
							$.messager.alert('提示',"学员选课失败:"+data,"error");		
						}
					});
				}
				else
				{
					$.messager.alert('提示',"请先选择要选课的学员");
				}
			}
			function backFunc()
			{
				ajaxLoading("返回中...");
				if("游学" == "${param.classType}")
				{
					window.location.href = "/sys/shortBus/accessShortClassPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId=${param.shortClassInstId}&pageName=${param.pageName}&classType="+encodeURI("${param.classType}");
				}
				else
				{
					window.location.href = "/sys/shortBus/shortClassManInfo.do?funcNodeId=${param.funcNodeId}&shortClassInstId=${param.shortClassInstId}&pageName=${param.pageName}";
				}
			}
		</script>
  	</head>
  	<body>
		<form id="manFm" style="margin:0 auto;">
			<input type="hidden" name="classType" id="classType" value="${param.classType}" />
			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:80px;" cellspacing="2">
				<tr>
					<td align="right">
						学员姓名：
					</td>
					<td>
						<input name="studentName" id="studentName" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" />								
					</td>
					<td align="right" width="8%">	
						联系电话：
					</td>
					<td width="22%">
						<input name="phoneNum" id="phoneNum" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" />
					</td>
					<td align="right" width="8%">
						缴费日期：
					</td>
					<td width="22%">
						<input name="payStartManTime" id="payStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="payEndManTime" id="payEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
				</tr>
				<tr>
					<td align="right">	
						课程阶段：
					</td>
					<td>
						<select id="stageId" name="stageId" style="width:150px"></select>
					</td>
					<td align="right">
						班级：
					</td>
					<td>
						<input name="classInstId" id="classInstId" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" />
					</td>
					<td align="right">
						课程状态：
					</td>
					<td>
						<select id="classState" name="classState" style="width:100px;height:25px;" ></select>										
					</td>
					<td colspan="2" align="center">
						<a href="javascript:void(0)" id="queryManBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetManBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%">
			<table class="easyui-datagrid" title="学员列表" style="height:390px" id="studentList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th data-options="field:'studentId',checkbox:true"></th>
						<th width="9%" field="name">学员姓名</th>
						<th width="9%" field="byName">英文名</th>
						<th width="9%" field="identityId">证件号码</th>
						<th width="9%" field="feeTypeName">业绩类型</th>
						<th width="9%" field="classType">班级类型</th>
						<th width="9%" field="payDate">缴费日期</th>
						<th width="9%" field="adviserName">业绩顾问</th>
						<th width="9%" field="dutyAdvister">责任顾问</th>
						<th width="9%" field="classStateName">课程状态</th>
						<th width="9%" field="className">当前班级</th>
						<th width="9%" field="studentPhone">联系电话</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="toolManbar" style="padding: 2px; height: auto">
			<a href="javascript:void(0)" id="manBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="manFunc()">确定</a>
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="backFunc()">返回</a>
		</div>
 	</body>
</html>
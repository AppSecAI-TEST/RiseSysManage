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
  	</head>
  	<body>
		<form id="manFm" style="margin:0 auto;">
			<input type="hidden" name="classType" id="classType" value="${param.classType}" />
			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:80px;" cellspacing="2">
				<tr>
					<td align="right" width="8%">
						所属校区：
					</td>
					<td width="12%">
						<select id="schoolManId" name="schoolManId" style="width:150px" ></select>
					</td>
					<td align="right" width="8%">
						学员姓名：
					</td>
					<td width="22%">
						<input name="studentName" id="studentName" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" />								
					</td>
					<td align="right">	
						联系电话：
					</td>
					<td colspan="2">
						<input name="phoneNum" id="phoneNum" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" />
					</td>
				</tr>
				<tr>
					<td align="right">
						赠课类型：
					</td>
					<td>
						<select id="shortClassType" name="shortClassType" style="width:150px" ></select>										
					</td>
					<td align="right">
						赠课状态：
					</td>
					<td>
						<select id="shortClassState" name="shortClassState" style="width:150px" ></select>										
					</td>
					<td align="right" width="8%">
						缴费日期：
					</td>
					<td width="22%">
						<input name="payStartManTime" id="payStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="payEndManTime" id="payEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
					<td align="center">
						<a href="javascript:void(0)" id="queryManBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetManBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%">
			<table class="easyui-datagrid" title="学员列表" style="height:390px" id="studentList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'studentId',checkbox:true"></th>
						<th width="6%" field="schoolName">校区</th>
						<th width="6%" field="name">学员姓名</th>
						<th width="6%" field="byName">英文名</th>
						<th width="7%" field="studentPhone">联系电话</th>
						<th width="7%" field="giftChannelDesc">赠课来源</th>
						<th width="7%" field="payDate">关联课缴费日期</th>
						<th width="7%" field="courseStateName">关联课程状态</th>
						<th width="6%" field="typeName">赠课类型</th>
						<th width="6%" field="className">赠课班级</th>
						<th width="6%" field="giftStateName">赠课状态</th>
						<th width="6%" field="giftNum">赠送课时</th>
						<th width="6%" field="giftJoinNum">已消耗课时</th>
						<th width="7%" field="effDate">有效期开始日期</th>
						<th width="7%" field="expDate">有效期结束日期</th>
						<th width="7%" field="disExpDate">距过期天数</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="toolManbar" style="padding: 2px; height: auto">
			<a href="javascript:void(0)" id="manBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="manFunc()">确定</a>
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="backFunc()">返回</a>
		</div>
		<script type="text/javascript">
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=813&fieldId=schoolId",function(data){
				$("#schoolManId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/shortBus/getGiftTypeList.do",function(data){
				$("#shortClassType").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_GIFT_T&codeType=COURSE_STATE",function(data){
				$("#shortClassState").combobox("loadData",data);
			},"json");
			$(document).ready(function(){
				$("#schoolManId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto'
				});
				$("#shortClassType").combobox({
					formatter:function(data){
						return '<span>'+data.typeName+'</span>';
					}, 
					valueField: 'giftType', 
					textField: 'typeName',
					panelHeight: 'auto'
				});
				$("#shortClassState").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
			});
			function queryFunc()
			{
				var obj = $("#manFm").serializeObject();
				obj["queryCode"] = "qrySummerChoiceClassList";
				obj["funcNodeId"] = "38135";
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
				$("#schoolManId").combobox("setValue","");
				$("#shortClassType").combobox("setValue","");
				$("#shortClassState").combobox("setValue","");
				$("#schoolManId").combobox("setValue","");
				$("#payStartManTime").datebox("setValue","");
				$("#payEndManTime").datebox("setValue","");
				$("#studentName").textbox("setValue","");
				$("#phoneNum").textbox("setValue","");
			}
			function manFunc()
			{
				var row = $("#studentList").datagrid('getSelected');
				if (row)
				{
					var json = {
						shortClassInstId:"${param.shortClassInstId}",
						studentId:row.studentId,
						studentCourseId:row.studentCourseId,
						schoolId:row.schoolId,
						handlerId:${sessionScope.StaffT.staffId}
					}
					$.post("/sys/shortBus/addShortStudentTInfo.do",{json:JSON.stringify(json),classType:encodeURI("小拼暑类班")},function(data){
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
 	</body>
</html>
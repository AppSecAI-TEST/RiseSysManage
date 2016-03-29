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
				font-size:12px;
				font-family:"微软雅黑";
			}
		</style>
		<script type="text/javascript">
			ajaxLoadEnd();
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=811&fieldId=schoolId",function(data){
				$("#schoolManId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_GIFT_T&codeType=COURSE_STATE",function(data){
				$("#shortClassState").combobox("loadData",data);
			},"json");
			$(document).ready(function(){
				$("#schoolManId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto',
					onLoadSuccess:function(data){
						if(data.length > 0)
						{
							$("#schoolManId").combobox("setValue",data[0].schoolId);
						}
					}
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
				var payStartManTime = $("#payStartManTime").datebox("getValue");
				var payEndManTime = $("#payEndManTime").datebox("getValue");
				if(payStartManTime != "" && payEndManTime == "")
				{
					obj["payEndManTime"] = "3000-12-31";
				}
				else if(payStartManTime == "" && payEndManTime != "")
				{
					obj["payStartManTime"] = "1900-01-01";
				}
				obj["queryCode"] = "qryForeignChoiceClassList";
				obj["funcNodeId"] = "38140";
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
				var schoolData = $("#schoolManId").combobox("getData");
				if(schoolData != null && schoolData.length > 0)
				{
					$("#schoolManId").combobox("setValue",schoolData[0].schoolId);
				}
				$("#shortClassState").combobox("setValue","");
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
					$.post("/sys/shortBus/addShortStudentTInfo.do",{json:JSON.stringify(arr),classType:encodeURI("外教课"),shortClassInstId:"${param.shortClassInstId}"},function(data){
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
				window.location.href = "/sys/shortBus/accessShortClassPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId=${param.shortClassInstId}&classType=外教课&pageName=shortAttenceForeignDetail";
			}
		</script>
  	</head>
  	<body>
		<form id="manFm" style="margin:0 auto;">
			<input type="hidden" name="classType" id="classType" value="${param.classType}" />
			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:80px;" cellspacing="2">
				<tr>
					<td align="right" width="10%">
						所属校区：
					</td>
					<td width="15%">
						<select id="schoolManId" name="schoolManId" style="width:150px" ></select>
					</td>
					<td align="right" width="16%">
						学员姓名：
					</td>
					<td width="15%">
						<input name="studentName" id="studentName" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" />								
					</td>
					<td align="right">	
						联系电话：
					</td>
					<td>
						<input name="phoneNum" id="phoneNum" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" />
					</td>
				</tr>
				<tr>
					<td align="right">
						外教课状态：
					</td>
					<td>
						<select id="shortClassState" name="shortClassState" style="width:150px" ></select>										
					</td>
					<td align="right" width="8%">
						关联课缴费日期：
					</td>
					<td width="22%">
						<input name="payStartManTime" id="payStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="payEndManTime" id="payEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
					<td align="center" colspan="2">
						<a href="javascript:void(0)" id="queryManBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetManBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:0 0;min-width:1100px;width:99%;margin:5px auto">
			<table class="easyui-datagrid" title="学员列表" style="height:390px" id="studentList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th data-options="field:'studentId',checkbox:true"></th>
						<th width="7%" field="schoolName">校区</th>
						<th width="7%" field="name">学员姓名</th>
						<th width="7%" field="byName">英文名</th>
						<th width="8%" field="studentPhone">联系电话</th>
						<th width="7%" field="giftChannelDesc">赠课来源</th>
						<th width="8%" field="payDate">关联课缴费日期</th>
						<th width="7%" field="courseStateName">关联课程状态</th>
						<th width="7%" field="giftStateName">外教课状态</th>
						<th width="7%" field="giftNum">赠送课时</th>
						<th width="7%" field="giftJoinNum">已消耗课时</th>
						<th width="8%" field="effDate">有效期开始日期</th>
						<th width="8%" field="expDate">有效期结束日期</th>
						<th width="7%" field="disExpDate">距过期天数</th>
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
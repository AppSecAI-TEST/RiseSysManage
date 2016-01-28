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
			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:80px;" cellspacing="2">
				<tr>
					<td align="right" width="12%">
						校区：
					</td>
					<td width="12%">
						<select id="schoolId" name="schoolId" style="width:100px;height:25px;" ></select>
					</td>
					<td align="right" width="8%">	
						学员姓名：
					</td>
					<td width="12%">
      					<input name="staffName" id="staffName" type="text" class="easyui-textbox" style="width:100px;height:25px;"/>
					</td>
					<td align="right" width="8%">
						缴费日期：
					</td>
					<td width="22%">
						<input name="feeStartTime" id="feeStartTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="feeEndTime" id="feeEndTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
					<td align="right" width="8%">
						联系电话：
					</td>
					<td>
						<input name="contactPhone" id="contactPhone" type="text" class="easyui-textbox" style="width:100px; height: 25px;"/>
					</td>
				</tr>
				<tr>
					<td align="right">
						是否退费：
					</td>
					<td>
						<input name="feeReturn" id="feeReturnYes" type="radio" value="是" /><label for="feeReturnYes">是</label>&nbsp;
						<input name="feeReturn" id="feeReturnNo" type="radio" value="否" /><label for="feeReturnNo">否</label>										
					</td>
					<td align="right">
						国际班类型：
					</td>
					<td>
						<select id="interClassType" name="interClassType" style="width:100px" ></select>								
					</td>
					<td align="right">
						是否选班：
					</td>
					<td>
						<input name="selectClass" id="selectClassYes" type="radio" value="已选" /><label for="selectClassYes">已选</label>&nbsp;
						<input name="selectClass" id="selectClassNo" type="radio" value="未选" /><label for="selectClassNo">未选</label>								
					</td>
					<td colspan="2">
						<a href="javascript:void(0)" id="queryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%">
			<table class="easyui-datagrid" title="学员列表" style="height:390px" id="manList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th width="7%" field="schoolName">校区</th>
						<th width="7%" field="name">学员姓名</th>
						<th width="7%" field="byName">英文名</th>
						<th width="7%" field="studentPhone">联系电话</th>
						<th width="7%" field="classType">国际班类型</th>
						<th width="7%" field="className">班级</th>
						<th width="7%" field="adviserTeacher">业绩老师</th>
						<th width="7%" field="adviser">业绩顾问</th>
						<th width="7%" field="payDate">缴费日期</th>
						<th width="7%" field="totalAmount">实际缴费金额</th>
						<th width="7%" field="favorType">优惠方式</th>
						<th width="7%" field="feeStateName">是否退费</th>
						<th width="7%" field="isChoiceClass">是否选班</th>
						<th width="9%" field="interClassName">国际班班级</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="toolManbar" style="padding: 2px; height: auto">
			<a href="javascript:void(0)" id="exportBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="exportFunc()">导出全部</a>
		</div>
		<script type="text/javascript">
			ajaxLoading("正在处理，请稍待。。。");
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=852&fieldId=schoolId",function(data){
				$("#schoolId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/shortBus/getShortClassTypeList.do?typeName="+encodeURI("国际班"),function(data){
				$("#interClassType").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$(document).ready(function(){
				$("#interClassType").combobox({
					formatter:function(data){
						return '<span>'+data.classType+'</span>';
					}, 
					valueField: 'classType', 
					textField: 'classType',
					panelHeight: 'auto'
				});
				$("#schoolId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto',
					onLoadSuccess:function(data){
						if(data.length > 0)
						{
							$("#schoolId").combobox("setValue",data[0].schoolId);
						}
					}
				});
			});
			function queryFunc()
			{
				var obj = $("#manFm").serializeObject();
				obj["queryCode"] = "qryInterInfoList";
				obj["funcNodeId"] = "38112";
				obj = JSON.stringify(obj);
				$("#manList").datagrid({
					url:"/sys/pubData/qryDataListByPage.do",
					queryParams:{
						param : obj
					}
				});
			}
			function resetFunc()
			{
				$("#schoolId").combobox("setValue","");
				$("#staffName").textbox("setValue","");
				$("#contactPhone").textbox("setValue","");
				$("#interClassType").combobox("setValue","");
				$("#feeStartTime").datebox("setValue","");
				$("input[name='feeReturn']").each(function(i,node){
					node.checked = false; 
				});
				$("input[name='selectClass']").each(function(i,node){
					node.checked = false; 
				});
			}
			function exportFunc()
			{
				exportLink("exportBtn","manList");
			}
		</script>
 	</body>
</html>
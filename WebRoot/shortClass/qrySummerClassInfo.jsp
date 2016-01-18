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
			<table align="center" style="min-width:1200px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:80px;" cellspacing="2">
				<tr>
					<td align="right" width="7%">
						所属校区：
					</td>
					<td width="10%">
						<select id="schoolId" name="schoolId" style="width:100px;height:25px;" ></select>
					</td>
					<td align="right" width="7%">	
						学员姓名：
					</td>
					<td width="10%">
						<select id="staffName" name="staffName" style="width:100px;height:25px;">
      					</select>
					</td>
					<td align="right" width="7%">
						缴费日期：
					</td>
					<td width="20%">
						<input name="feeStartTime" id="feeStartTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="feeEndTime" id="feeEndTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
					<td align="right" width="9%">
						联系电话：
					</td>
					<td colspan="3">
						<input name="contactPhone" id="contactPhone" type="text" class="easyui-textbox" style="width:100px;height:25px;"/>
					</td>
				</tr>
				<tr>
					<td align="right">
						赠课类型：
					</td>
					<td>
						<select id="classType" name="classType" style="width:100px;height:25px;" ></select>								
					</td>
					<td align="right">
						赠课状态：
					</td>
					<td>
						<select id="classState" name="classState" style="width:100px;height:25px;" ></select>				
					</td>
					<td align="right">
						是否过期：
					</td>
					<td>
						<input name="isExpire" id="isExpireYes" type="radio" value="是" /><label for="isExpireYes">是</label>&nbsp;
						<input name="isExpire" id="isExpireNo" type="radio" value="否" /><label for="isExpireNo">否</label>								
					</td>
					<td align="right">
						几天内过期：
					</td>
					<td>
						<input name="expireDate" id="expireDate" type="text" class="easyui-textbox" style="width:100px;height:25px;"/>
					</td>
					<td colspan="2">
						<a href="javascript:void(0)" id="queryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%">
			<table class="easyui-datagrid" title="学员列表" style="height:390px" id="manList" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
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
		<script type="text/javascript">
			ajaxLoading("加载中...");
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=820&fieldId=schoolId",function(data){
				$("#schoolId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pub/paramComboxList.do?staffId=${sessionScope.StaffT.staffId}&funcNodeId=${param.funcNodeId}&fieldId=staffName",function(data){
				$("#staffName").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_GIFT_T&codeType=COURSE_STATE",function(data){
				$("#classState").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/shortBus/getGiftTypeList.do",function(data){
				$("#classType").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$(document).ready(function(){
				$("#classType").combobox({
					formatter:function(data){
						return '<span>'+data.typeName+'</span>';
					}, 
					valueField: 'giftType', 
					textField: 'typeName',
					panelHeight: 'auto'
				});
				$("#staffName").combobox({
					formatter:function(data){
						return '<span>'+data.staffName+'</span>';
					},
					valueField: 'staffId', 
					textField: 'staffName', 
					panelHeight: 'auto'
				});
				$("#classState").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
				$("#schoolId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto'
				});
			});
			function queryFunc()
			{
				var obj = $("#manFm").serializeObject();
				obj["queryCode"] = "qrySummerInfoList";
				obj["funcNodeId"] = "38136";
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
				$("#staffName").combobox("setValue","");
				$("#contactPhone").textbox("setValue","");
				$("#classType").combobox("setValue","");
				$("#classState").combobox("setValue","");
				$("#feeStartTime").datebox("setValue","");
				$("#feeEndTime").datebox("setValue","");
				$("#expireDate").datebox("setValue","");
				$("input[name='isExpire']").each(function(i,node){
					node.checked = false; 
				});
			}
		</script>
 	</body>
</html>
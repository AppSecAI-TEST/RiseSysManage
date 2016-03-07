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
			ajaxLoading("正在处理，请稍待。。。");
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=819&fieldId=schoolId",function(data){
				$("#schoolId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE",function(data){
				$("#classManState").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$(document).ready(function(){
				$("#classManState").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
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
				obj["queryCode"] = "qryForeignInfoList";
				obj["funcNodeId"] = "38141";
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
				var schoolData = $("#schoolId").combobox("getData");
				if(schoolData != null && schoolData.length > 0)
				{
					$("#schoolId").combobox("setValue",schoolData[0].schoolId);
				}
				$("#staffName").textbox("setValue","");
				$("#contactPhone").textbox("setValue","");
				$("#classManState").combobox("setValue","");
				$("#feeStartTime").datebox("setValue","");
				$("#feeEndTime").datebox("setValue","");
				$("input[name='isExpire']").each(function(i,node){
					node.checked = false; 
				});
				$("#expireDate").textbox("setValue","");
			}
		</script>
  	</head>
  	<body>
  		<div style="margin-right:5px;">
		<form id="manFm">
			<table class="search_tab">
				<tr>
					<td align="right" width="12%">
						所属校区：
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
						<input name="feeStartTime" id="feeStartTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="feeEndTime" id="feeEndTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
					<td align="right" width="8%">
						联系电话：
					</td>
					<td>
						<input name="contactPhone" id="contactPhone" type="text" class="easyui-textbox" style="width:100px;height:25px;"/>
					</td>
				</tr>
				<tr>
					<td align="right">
						外教课状态：
					</td>
					<td>
						<select id="classManState" name="classManState" style="width:100px;height:25px;" ></select>								
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
			<table class="easyui-datagrid" title="学员列表" style="height:390px" id="manList" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th width="7%" field="schoolName">校区</th>
						<th width="8%" field="name">学员姓名</th>
						<th width="8%" field="byName">英文名</th>
						<th width="8%" field="studentPhone">联系电话</th>
						<th width="7%" field="giftChannelDesc">赠课来源</th>
						<th width="9%" field="payDate">赠课来源开始日期</th>
						<th width="7%" field="courseStateName">关联课状态</th>
						<th width="7%" field="giftStateName">外教课状态</th>
						<th width="7%" field="giftNum">赠送课时</th>
						<th width="8%" field="giftJoinNum">已消耗课时</th>
						<th width="8%" field="effDate">有效期开始日期</th>
						<th width="8%" field="expDate">有效期结束日期</th>
						<th width="7%" field="disExpDate">距过期天数</th>
					</tr>
				</thead>
			</table>
		</div>
 	</body>
</html>
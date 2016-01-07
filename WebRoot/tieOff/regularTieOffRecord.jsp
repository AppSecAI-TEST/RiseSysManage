<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
  	</head>
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm" style="margin:0 auto;">
	  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
	  				<tr>
	  					<td width="100px" align="right"><span>扎帐月份：</span></td>
						<td width="114px">
							<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="tieOffTime" name="tieOffTime" data-options="formatter:myYearMonthformatter, parser:myparser" />
						</td>
						<td style="padding-left:60px">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" onclick="queryFunc()">查询</a>&nbsp;
						</td>
	  				</tr>	
	  			</table>
  			</form>
			<table class="tab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
				<tr class="headTr">
					<td width="10%"><input type="checkbox" id="allRecord" onclick="checkAllFunc(this)" /></td>
					<td width="90%">校区</td>
				</tr>
				<c:choose>
					<c:when test="${fn:length(arrList) == 0}">
						<tr class="tieRec">
							<td colspan="2" align="center">所选月份暂无需要扎帐的校区</td>
						</tr>	
					</c:when>
					<c:otherwise>
						<c:forEach items="${arrList}" var="node" varStatus="i">
							<tr class="tieRec">
								<td align="center"><input type="checkbox" name="recourdInfo" value="${node.schoolId}" onclick="checkFunc(this)" /></td>
								<td align="center">${node.schoolName}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
			<div style="margin:0 auto;padding:0 0;text-align:right;padding-right:2px;width:99%;margin-top:10px">
				<a href="javascript:void(0)" id="enterBtn" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="submitClick()">提交</a>
				<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
			</div>
  		</div>
  		<script type="text/javascript">
  			ajaxLoadEnd();
  			$(document).ready(function(){
				$("#tieOffTime").datebox({
					onShowPanel:settingYearMonthPanel
				});
				$("#tieOffTime").datebox("setValue","${monthDate}-01");
			});
  			function queryFunc()
			{
				var tieOffTime = $("#tieOffTime").datebox("getValue");
				if(tieOffTime != "")
				{
					ajaxLoading("查询中...");
					$.post("/sys/incomeFinish/getRecordInfo.do",{monthDate:tieOffTime,incomeFlag:"regular"},function(data){
						ajaxLoadEnd();
						var dataObj = null;
						try{
							dataObj = eval("("+data+")");
						}catch(e){
							$.messager.alert("提示", data,"error");
						}
						if(dataObj!=null)
						{
							$(".tieRec").remove();
							if(dataObj.arrList.length != 0)
							{
								var arr = [];
								for(var i = 0,n = dataObj.arrList.length;i < n;i++)
								{
									arr.push("<tr class='tieRec'>");
									arr.push("<td align='center'><input type='checkbox' name='recourdInfo' value='"+dataObj.arrList[i].schoolId+"' onclick='checkFunc(this)' /></td>");
									arr.push("<td align='center'>"+dataObj.arrList[i].schoolName+"</td>");
									arr.push("</tr>");
								}
								$(".headTr").after(arr.join(""));
							}
							else
							{
								$(".headTr").after("<tr class='tieRec'><td colspan='2' align='center'>所选月份暂无需要扎帐的校区</td></tr>");
							}
						}
					});
				}
				else
				{
					$.messager.alert("提示", "请先选择要扎帐的月份");
				}
			}
  			function backFunc()
			{
				window.history.back();
			}
			function checkAllFunc(obj)
			{
				$("input[name='recourdInfo']").each(function(i,node){
					node.checked = obj.checked;
				});
			}
			function checkFunc(obj)
			{
				if(obj.checked == false)
				{
					$("#allRecord").get(0).checked = false;
				}
				else
				{
					var flag = true;
					$("input[name='recourdInfo']").each(function(i,node){
						if(!node.checked)
						{
							flag = false;
						}
					});
					$("#allRecord").get(0).checked = flag;
				}
			}
			function submitClick()
			{
				var tieOffTime = $("#tieOffTime").datebox("getValue");
				if(tieOffTime == "")
				{
					$.messager.alert("提示", "请先选择要扎帐的月份");
				}
				else if($("input[name='recourdInfo']:checked").length == 0)
				{
					$.messager.alert("提示", "请先选择要扎帐的校区");
				}
				else
				{
					var arr = [];
					$("input[name='recourdInfo']:checked").each(function(i,node){
						var timeArr = tieOffTime.split("-");
						var obj = {
							schoolId:node.value,
							classInstId:"",
							startDate:tieOffTime+"-01",
							endDate:new Date(timeArr[0],timeArr[1],0).format("yyyy-MM-dd"),
							finishDate:tieOffTime+"-01",
							incomeType:"regular",
							handlerId:"${sessionScope.StaffT.staffId}"
						}
						arr.push(obj);
					});
					ajaxLoading("提交中...");
					$.post("/sys/incomeFinish/addIncomeFinishRecord.do",{json:encodeURI(JSON.stringify(arr))},function(data){
						ajaxLoadEnd();
						if(data == "success")
						{
							$.messager.alert("提示", "扎帐成功" , "info" , function(){
								backFunc();
							});
						}
						else
						{
							$.messager.alert("提示", data,"error");
						}
					});
				}
			}
  		</script>
  	</body>
</html>

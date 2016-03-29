<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript">
			ajaxLoadEnd();
			function attendSubmit()
			{
				$.messager.confirm('提示','您确定审批当前热身课吗?',function(r){
					if (r){
						ajaxLoading("正在处理，请稍待。。。");
						$.post('/sys/shortBus/verifyShortClassFunc.do',{shortClassInstId:${shortClassInstT.shortClassInstId},handlerId:${sessionScope.StaffT.staffId},isPutClass:$("input[name='isPutClass']:checked").val(),verifyCont:string2Json($("#verifyCont").textbox("getValue"))},function(result){
							ajaxLoadEnd();
							if(result == "success")
							{
								backFunc();
							}
							else
							{
								$.messager.alert('提示', result);
							}
						});
					}
				});
			}
			function backFunc()
			{
				window.location.href = "/sys/shortClass/warmupClassMan.jsp?funcNodeId=${funcNodeId}&pageFlag=audit";
			}
			$(document).ready(function(){
				$("textarea").each(function(i,node){
					$(node).attr("maxlength",500);
				});
			});
		</script>
  	</head>
  	<body class="manage">
		<div class="panel datagrid easyui-fluid" style="width:99%">
		  <div class="panel-header">
		    <div class="panel-title">课程信息</div>
		    <div class="panel-tool"></div>
		  </div>
		</div>
		<table align="center" class="tab" style="height:90px;width:99%;margin:0px auto;margin-bottom:5px;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" width="15%">课程类型：</td>
				<td width="18%">${shortClassInstT.classTypeId}</td>
				<td align="right" width="15%">热身课班级名称：</td>
				<td width="18%">${shortClassInstT.className}</td>
				<td align="right" width="15%">计划上课人数：</td>
				<td width="18%">${shortClassInstT.planClassNum}</td>
			</tr>
			<tr>
				<td align="right">计划课时量：</td>
				<td>${shortClassInstT.planHours}</td>
				<td align="right">开课日期：</td>
				<td><fmt:formatDate value="${shortClassInstT.openDate}" pattern="yyyy-MM-dd" /></td>
				<td align="right">结课日期：</td>
				<td><fmt:formatDate value="${shortClassInstT.finishDate}" pattern="yyyy-MM-dd" /></td>
			</tr>
		</table>
		<div class="panel datagrid easyui-fluid" style="width:99%">
		  <div class="panel-header">
		    <div class="panel-title">课程计划信息</div>
		    <div class="panel-tool"></div>
		  </div>
		</div>
		<table region="center" class="tab" id="attendList" style="width:99%;margin:0px auto;margin-bottom:5px;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<c:choose>
				<c:when test="${fn:length(shortClassInstT.classSchooltimeList) == 0}">
					<tr>
						<td colspan="8" align="center">暂无上课计划</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${shortClassInstT.classSchooltimeList}" var="node" varStatus="i">
						<tr>
							<td align="right" width="15%">上课计划：</td>
							<td width="18%"><fmt:formatDate value="${node.schooltime}" pattern="yyyy-MM-dd" /> ${node.startTime}~${node.endTime}</td>
							<td align="right" width="5%">教室：</td>
							<td width="10%">${node.roomT.roomName}</td>
							<td align="right" width="8%">课时：</td>
							<td width="10%">${node.lessionHours}</td>
							<td align="right" width="9%">老师：</td>
							<td width="24%">
								<ul>
									<c:forEach items="${node.classTeacherList}" var="item" varStatus="i">
										<li><span>${item.teacherT.byName}</span><span style="padding-left:15px">${item.teacherType}</span></li>
									</c:forEach>
								</ul>
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		<div class="panel datagrid easyui-fluid" style="width:99%">
		  <div class="panel-header">
		    <div class="panel-title">审批信息</div>
		    <div class="panel-tool"></div>
		  </div>
		</div>
		<table region="center" class="tab" id="studentList" style="width:99%;margin:0px auto;margin-bottom:5px;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" width="15%">放班审批:</td>
				<td>
					<input type="radio" name="isPutClass" id="isPutClassY" value="Y" checked="checked" /><label for="isPutClassY">同意放班</label>&nbsp;&nbsp;
					<input type="radio" name="isPutClass" id="isPutClassN" value="N"/><label for="isPutClassN">不同意放班</label>
				</td>
			</tr>
			<tr>
				<td align="right" width="15%" valign="top">审批意见:</td>
				<td>
					<input name="verifyCont" id="verifyCont" type="text" style="width:800px;height:120px" class="easyui-textbox easyui-validatebox" data-options="multiline:true" />
				</td>
			</tr>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:right;padding-right:2px;width:99%;margin-top:10px">
			<a href="javascript:void(0)" id="enterBtn" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="attendSubmit()">提交</a>
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		</div>
 	</body>
</html>
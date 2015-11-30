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
		<style type="text/css">
			
		</style>
  	</head>
  
  	<body class="manage">
		<table align="center" class="tab" style="height:90px;width:99%;margin:0 auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" width="15%">国际班类型：</td>
				<td width="18%">${shortClassInstT.shortClassTypeT.classType}</td>
				<td align="right" width="15%">班级名称：</td>
				<td width="18%">${shortClassInstT.className}</td>
				<td align="right" width="15%">开课日期：</td>
				<td width="18%"><fmt:formatDate value="${shortClassInstT.openDate}" pattern="yyyy-MM-dd" /></td>
			</tr>
			<tr>
				<td align="right">国际班上课校区：</td>
				<td>${shortClassInstT.schoolT.schoolName}</td>
				<td align="right">计划总课时量：</td>
				<td>${shortClassInstT.planHours}</td>
				<td align="right">结课日期：</td>
				<td><fmt:formatDate value="${shortClassInstT.finishDate}" pattern="yyyy-MM-dd" /></td>
			</tr>
			<tr>
				<td align="right">放班人：</td>
				<td>${shortClassInstT.creatorObj.staffName}</td>
				<td align="right">放班日期：</td>
				<td><fmt:formatDate value="${shortClassInstT.putClassDate}" pattern="yyyy-MM-dd" /></td>
				<td align="right">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<table region="center" class="tab" id="attendList" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<c:choose>
				<c:when test="${fn:length(shortClassInstT.classSchooltimeList) == 0}">
					<tr>
						<td colspan="9" align="center">暂无上课计划</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${shortClassInstT.classSchooltimeList}" var="node" varStatus="i">
						<tr>
							<td align="right">上课计划：</td>
							<td><fmt:formatDate value="${node.schooltime}" pattern="yyyy-MM-dd" /> ${node.hourRangeObj.paramDesc}</td>
							<td align="right">教室：</td>
							<td>${node.roomT.roomName}</td>
							<td align="right">课时：</td>
							<td>${node.lessionHours}</td>
							<td align="right">老师：</td>
							<td>
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
			<tr>
				<td width="10%" align="right">备注：</td>
				<td colspan="8">
					<input name="remark" id="remark" type="text" style="width:95%;height:100px" class="easyui-textbox" data-options="multiline:true" />
				</td>
			</tr>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:right;padding-right:2px;width:99%;margin-top:10px">
			<a href="javascript:void(0)" id="addSubmitBtn" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="addSubmitFunc()">提交</a>
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		</div>
		<script type="text/javascript">
			function addSubmitFunc()
			{
				$.messager.confirm("提示", "您确定要取消该课程吗？", function (data) {
		            if(data){
		            	ajaxLoading("取消中...");
		                $.post("/sys/shortBus/cancelShortClassFunc.do",{shortClassInstId:${shortClassInstT.shortClassInstId},remark:$("#remark").textbox("getValue")},function(data){
		                	ajaxLoadEnd();
		                	if(data == "success")
		                	{
		                		backFunc();
		                	}
		                	else
		                	{
		                		$.messager.alert('提示',"取消课程失败:"+data,"error");
		                	}
		                });
		            }
		        });
			}
			function backFunc()
			{
				window.location.href = "/sys/shortClass/interClassMan.jsp?funcNodeId=${funcNodeId}";
			}
		</script>
 	</body>
</html>
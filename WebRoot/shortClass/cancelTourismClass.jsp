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
			function addSubmitFunc()
			{
				$.messager.confirm("提示", "您确定要取消该课程吗？", function (data) {
		            if(data){
		            	ajaxLoading("正在处理，请稍待。。。");
		                $.post("/sys/shortBus/cancelShortClassFunc.do",{shortClassInstId:${shortClassInstId},remark:string2Json($("#remark").textbox("getValue")),handleId:${sessionScope.StaffT.staffId}},function(data){
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
				window.location.href = "/sys/shortClass/tourismClassMan.jsp?funcNodeId=${funcNodeId}";
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
				<td align="right" width="15%">游学类型：</td>
				<td width="18%">${shortClassInstT.shortClassTypeT.classType}</td>
				<td align="right" width="15%">班级名称：</td>
				<td width="18%">${shortClassInstT.className}</td>
				<td align="right" width="15%">计划招生人数：</td>
				<td width="18%">${shortClassInstT.planClassNum}</td>
			</tr>
			<tr>
				<td align="right">游学开始日期：</td>
				<td><fmt:formatDate value="${shortClassInstT.openDate}" pattern="yyyy-MM-dd" /></td>
				<td align="right">游学结束日期：</td>
				<td><fmt:formatDate value="${shortClassInstT.finishDate}" pattern="yyyy-MM-dd" /></td>				
				<td align="right">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<div class="panel datagrid easyui-fluid" style="width:99%">
		  <div class="panel-header">
		    <div class="panel-title">上课老师信息</div>
		    <div class="panel-tool"></div>
		  </div>
		</div>
		<table region="center" class="tab" id="teacherList" style="width:99%;margin:0px auto;margin-bottom:5px;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<c:choose>
				<c:when test="${fn:length(shortClassTeacherTList) == 0}">
					<tr>
						<td colspan="9" align="center">暂无安排老师</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${shortClassTeacherTList}" var="node" varStatus="i">
						<tr>
							<tr><td align='center' width='15%'>${node.schoolT.schoolName}</td><td align='center' width='15%'>${node.teacherT.byName}</td><td width='70%' style='padding-left:30px'>&nbsp;</td></tr>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		<table region="center" class="tab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
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
 	</body>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/teaFeebackManage/teaFeebackManage.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="添加反馈维护">
  			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<input id="qualityId" type="hidden" value="${qualityId}"/>
  			<input id="classInstId" type="hidden" value="${classInstId}"/>
  			<input id="className" type="hidden" value="${className}"/>
  			<input id="fSchoolId" type="hidden" value="${schoolId}"/>
  			<input id="month" type="hidden" value="${month}"/>
	 		<table id="feedbackTab" width="98%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td width="3%" align="center"><span>序号</span></td>
  					<td width="7%" align="center"><span>姓名</span></td>
  					<td width="7%" align="center"><span>英文名</span></td>
  					<td width="6%" align="center"><span>课程状态</span></td>
  					<td width="10%" align="center"><span>电教次数</span></td>
  					<td width="15%" align="center"><span>开班典礼</span></td>
  					<td width="15%" align="center"><span>家长会</span></td>
  					<td width="15%" align="center"><span>公开课</span></td>
  					<td width="15%" align="center"><span>毕业典礼</span></td>
  					<td width="7%" align="center"><span>行政满意度</span></td>
  				</tr>
  				<c:forEach items="${obj.studentInfo}" var="studentInfo" varStatus="status">
     	        <input type="hidden" name="studentId" id="studentId${status.index}" value="${studentInfo.studentId}"/>
     	        <input type="hidden" id="courseState${status.index}" value="${studentInfo.courseState}"/>
					<tr>
						<td align="center">${status.count}</td>
						<td id="studentName${status.index}" align="center">${studentInfo.name}</td>
						<td id="byname${status.index}" align="center">${studentInfo.byName}</td>
						<td align="center">${studentInfo.courseStateVal}</td>
						<td align="center"><span class="teaching${status.index}"><input type="radio" value="0" name="teachingNum${status.index}" checked="checked"/><span>0</span>&nbsp;<input type="radio" value="1" name="teachingNum${status.index}"/><span>1</span>
						&nbsp;<input type="radio" value="2" name="teachingNum${status.index}" /><span>2</span></span></td>
							
						<c:if test="${obj.qualityInfo.startFlag == '0'}">
							<td align="center">
								<input type="radio" class="start" value="Y" status="${status.index}" name="startIsAttend${status.index}" checked="checked"/><span>已到</span>&nbsp;<input type="radio" class="start" value="N" status="${status.index}" name="startIsAttend${status.index}"/><span>未到</span>
								</br><span class="startCsi">满意度：<input id="startCsi${status.index}" class="easyui-numberbox" min="0" max="100" style='width:40px;' />%</span>
							</td>
						</c:if>
						<c:if test="${obj.qualityInfo.startFlag == '1'}">
							<td align="center">
							</td>
						</c:if>
						<c:if test="${obj.qualityInfo.meetingFlag == '0'}">
							<td align="center">
								<input type="radio" class="meeting" value="Y" status="${status.index}" name="meetingIsAttend${status.index}" checked="checked"/><span>已到</span>&nbsp;<input type="radio" class="meeting" value="N" status="${status.index}" name="meetingIsAttend${status.index}"/><span>未到</span>
								</br><span class="meetingCsi">满意度：<input id="meetingCsi${status.index}" class="easyui-numberbox" min="0" max="100" style='width:40px;' />%</span>
							</td>
						</c:if>
						<c:if test="${obj.qualityInfo.meetingFlag == '1'}">
							<td align="center">
							</td>
						</c:if>
						<c:if test="${obj.qualityInfo.openClassFlag == '0'}">
							<td align="center">
								<input type="radio" class="open" value="Y" status="${status.index}" name="openIsAttend${status.index}" checked="checked"/><span>已到</span>&nbsp;<input type="radio" class="open" value="N" status="${status.index}" name="openIsAttend${status.index}"/><span>未到</span>
								</br><span class="openCsi">满意度：<input id="openCsi${status.index}" class="easyui-numberbox" min="0" max="100" style='width:40px;' />%</span>
							</td>
						</c:if>
						<c:if test="${obj.qualityInfo.openClassFlag == '1'}">
							<td align="center">
							</td>
						</c:if>
						<c:if test="${obj.qualityInfo.gradFlag == '0'}">
							<td align="center">
								<input type="radio" class="grad" value="Y" status="${status.index}" name="gradIsAttend${status.index}" checked="checked"/><span>已到</span>&nbsp;<input type="radio" class="grad" value="N" status="${status.index}" name="gradIsAttend${status.index}"/><span>未到</span>
								</br><span class="gradCsi">满意度：<input id="gradCsi${status.index}" class="easyui-numberbox" min="0" max="100" style='width:40px;' />%</span>
							</td>
						</c:if>
						<c:if test="${obj.qualityInfo.gradFlag == '1'}">
							<td align="center">
							</td>
						</c:if>
						<td align="center">
								<span class="strativeCsi${status.index}"><input id="strativeCsi${status.index}" class="easyui-numberbox" min="0" max="100" style='width:40px;' />%</span>
							</td>
					</tr>
			   </c:forEach>
	 		</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:right">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="addTeaFeedbackSubmit()"><span>提交</span></a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
</html>
<script type="text/javascript">
$(document).ready(function(){
	var flag =0;
	$("#feedbackTab").find("tr").each(function(index){
		if(index>0&&$(this).find("td:eq(5)").find("input[type='radio']").length>0)
		{
			flag =5;
			return false;
		}
		else if(index>0&&$(this).find("td:eq(6)").find("input[type='radio']").length>0)
		{
			flag =6;
			return false;
		}
		else if(index>0&&$(this).find("td:eq(7)").find("input[type='radio']").length>0)
		{
			flag =7;
			return false;
		}
		else if(index>0&&$(this).find("td:eq(8)").find("input[type='radio']").length>0)
		{
			flag =8;
			return false;
		}
	});
	if(flag>0)
	{
		$("#feedbackTab").find("tr:eq(0)").find("td:eq(4)").append("<p><span>全选：</span></span><input type='radio' name='all1' onclick='selectAll(4,\"0\")' checked='ckecked'><span>0</span>&nbsp;<input type='radio' name='all1' onclick='selectAll(4,\"1\")'><span>1</span>&nbsp;<input type='radio' name='all1' onclick='selectAll(4,\"2\")'><span>2</span>");
		$("#feedbackTab").find("tr:eq(0)").find("td:eq("+flag+")").append("<p><span>全选：</span><input type='radio' onclick='selectAll("+flag+",\"Y\")' name='all2' checked='checked'><span>已到</span>&nbsp;<input type='radio' onclick='selectAll("+flag+",\"N\")' name='all2'><span>未到</span>");
		
	}	
})

		function selectAll(val1,val2)
		{
			$("#feedbackTab").find("tr").each(function(index){
				if(index>0)
				{
					if(val1==4)
					{
						if($(this).find("td:eq("+val1+")").find("span").css("visibility")!="hidden")
						{
							$(this).find("td:eq("+val1+")").find("span").find("input[type='radio'][value='"+val2+"']").trigger("click");
						}
					}
					else
					{
						$(this).find("td:eq("+val1+")").find("input[type='radio'][value='"+val2+"']").trigger("click");
					}	
				}	
			})
		}
</script>
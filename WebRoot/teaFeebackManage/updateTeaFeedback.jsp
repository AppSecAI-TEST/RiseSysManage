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
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="修改反馈维护">
  			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<input id="feedbackId" type="hidden" value="${feedbackId}"/>
	 		<table id="feedbackTab" width="98%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td width="3%" align="center"><span>序号</span></td>
  					<td width="7%" align="center"><span>姓名</span></td>
  					<td width="7%" align="center"><span>英文名</span></td>
  					<td width="8%" align="center"><span>课程状态</span></td>
  					<td width="15%" align="center"><span>电教次数</span></td>
  					<td width="20%" align="center"><span>家长会</span></td>
  					<td width="20%" align="center"><span>公开课</span></td>
  					<td width="20%" align="center"><span>毕业典礼</span></td>
  				</tr>
  				<c:forEach items="${obj.feedback}" var="feedback" varStatus="status">
					<tr>
						<input type="hidden" name="feedbackDetailId" value="${feedback.feedbackDetailId}" />
						<input type="hidden" id="teachingNum${status.index}" value="${feedback.teachingNum}" />
						<input type="hidden" id="meetingIsAttend${status.index}" value="${feedback.meetingIsAttend}" />
						<input type="hidden" id="openIsAttend${status.index}" value="${feedback.openIsAttend}" />
						<input type="hidden" id="gradIsAttend${status.index}" value="${feedback.gradIsAttend}" />
						<td align="center"><span>${status.count}</span></td>
						<td align="center"><span>${feedback.studentName}</span></td>
						<td align="center"><span>${feedback.byname}</span></td>
						<td align="center"><span>${feedback.courseStateVal}</span></td>
						<td align="center"><span class="teaching${status.index}"><input type="radio" value="0" name="teachingNum${status.index}" /><span>0</span>&nbsp;<input type="radio" value="1" name="teachingNum${status.index}"/><span>1</span>
						&nbsp;<input type="radio" value="2" name="teachingNum${status.index}" /><span>2</span></span></td>
						<td align="center">
							<c:if test="${feedback.meetingIsAttend != ''}">
								<input type="radio" class="meeting" value="Y" status="${status.index}" name="meetingIsAttend${status.index}"/><span>已到</span>&nbsp;<input type="radio" class="meeting" value="N" status="${status.index}" name="meetingIsAttend${status.index}"/><span>未到</span>
								&nbsp;<span class="meetingCsi">满意度：<input id="meetingCsi${status.index}" csiVal="${feedback.meetingCsi}" class="easyui-numberbox" min="0" max="100" style='width:40px;' />%</span>
							</c:if>
						</td>
						<td align="center">
							<c:if test="${feedback.openIsAttend != ''}">
								<input type="radio" class="open" value="Y" status="${status.index}" name="openIsAttend${status.index}" /><span>已到</span>&nbsp;<input type="radio" class="open" value="N" status="${status.index}" name="openIsAttend${status.index}"/><span>未到</span>
								&nbsp;<span class="openCsi">满意度：<input id="openCsi${status.index}" csiVal="${feedback.openCsi}" class="easyui-numberbox" min="0" max="100" style='width:40px;' />%</span>
							</c:if>
						</td>
						<td align="center">
							<c:if test="${feedback.gradIsAttend != ''}">
								<input type="radio" class="grad" value="Y" status="${status.index}" name="gradIsAttend${status.index}" /><span>已到</span>&nbsp;<input type="radio" class="grad" value="N" status="${status.index}" name="gradIsAttend${status.index}"/><span>未到</span>
								&nbsp;<span class="gradCsi">满意度：<input id="gradCsi${status.index}" csiVal="${feedback.gradCsi}" class="easyui-numberbox" min="0" max="100" style='width:40px;' />%</span>
							</c:if>
						</td>
					</tr>
			   </c:forEach>
	 		</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:center">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="updateTeaFeedbackSubmit()"><span>提交</span></a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
  	<script type="text/javascript">
		$(document).ready(function(){
   			for(var i = 0;i < ${fn:length(obj.feedback)};i++){
   				$("input[name='teachingNum"+i+"']").each(function(index,node){
   					var flag = true;
					if(node.value == $("#teachingNum"+i).val())
					{
						$(this).prop("checked","checked");
						flag = false;
					}
					if(flag){
						$("input[name='teachingNum"+i+"']").eq(0).attr("checked",true);
					}
				});
				var meetingIsAttend = $("#meetingIsAttend"+i).val();
				if(meetingIsAttend != ''){
					$("input[name='meetingIsAttend"+i+"']").each(function(index,node){
						if(node.value == meetingIsAttend)
						{
							$(this).prop("checked","checked");
							if(node.value == "N"){
							   $(".teaching"+i).css("visibility","hidden");
							   $(this).siblings(".meetingCsi").css("visibility","hidden");
							}
							if(node.value == "Y"){
								$("#meetingCsi"+i).numberbox("setValue",$("#meetingCsi"+i).attr("csiVal"));
							}
						}
					});
				}
				var openIsAttend = $("#openIsAttend"+i).val();
				if(openIsAttend != ''){
					$("input[name='openIsAttend"+i+"']").each(function(index,node){
						if(node.value == openIsAttend)
						{
							$(this).prop("checked","checked");
							if(node.value == "N"){
							   $(".teaching"+i).css("visibility","hidden");
							   $(this).siblings(".openCsi").css("visibility","hidden");
							}
							if(node.value == "Y"){
								$("#openCsi"+i).numberbox("setValue",$("#openCsi"+i).attr("csiVal"));
							}
						}
					});
				}
				var gradIsAttend = $("#gradIsAttend"+i).val();
   				if(gradIsAttend != ''){
					$("input[name='gradIsAttend"+i+"']").each(function(index,node){
						if(node.value == gradIsAttend)
						{
							$(this).prop("checked","checked");
							if(node.value == "N"){
							   $(".teaching"+i).css("visibility","hidden");
							   $(this).siblings(".gradCsi").css("visibility","hidden");
							}
							if(node.value == "Y"){
								$("#gradCsi"+i).numberbox("setValue",$("#gradCsi"+i).attr("csiVal"));
							}
						}
					});
				}
   			}
   			$(".meeting").change(function() {
			   var val = $(this).val();
			   if(val == "Y"){
				   $(this).siblings(".meetingCsi").css("visibility","visible");
				   var status = $(this).attr("status");
				   $(".teaching"+status).css("visibility","visible");
			   }else if(val == "N"){
				   $(this).siblings(".meetingCsi").css("visibility","hidden");
				   var status = $(this).attr("status");
				   var openIsAttend = $("input[name='openIsAttend"+status+"']:checked").val();
			  	   var gradIsAttend = $("input[name='gradIsAttend"+status+"']:checked").val();
			  	   if(openIsAttend != "Y" && gradIsAttend != "Y"){
			  		   $(".teaching"+status).css("visibility","hidden");
			  	   }
			   }
		   });
		   
		    $(".open").change(function() {
			   var val = $(this).val();
			   if(val == "Y"){
				   $(this).siblings(".openCsi").css("visibility","visible");
				   var status = $(this).attr("status");
				   $(".teaching"+status).css("visibility","visible");
			   }else if(val == "N"){
				   $(this).siblings(".openCsi").css("visibility","hidden");
				   var status = $(this).attr("status");
				   var meetingIsAttend = $("input[name='meetingIsAttend"+status+"']:checked").val();
			  	   var gradIsAttend = $("input[name='gradIsAttend"+status+"']:checked").val();
			  	   if(meetingIsAttend != "Y" && gradIsAttend != "Y"){
			  		   $(".teaching"+status).css("visibility","hidden");
			  	   }
			   }
		   });
		   
		   $(".grad").change(function() {
			   var val = $(this).val();
			   if(val == "Y"){
				   $(this).siblings(".gradCsi").css("visibility","visible");
				   var status = $(this).attr("status");
				   $(".teaching"+status).css("visibility","visible");
			   }else if(val == "N"){
				   $(this).siblings(".gradCsi").css("visibility","hidden");
				   var status = $(this).attr("status");
				   var meetingIsAttend = $("input[name='meetingIsAttend"+status+"']:checked").val();
				   var openIsAttend = $("input[name='openIsAttend"+status+"']:checked").val();
			  	   if(meetingIsAttend != "Y" && openIsAttend != "Y"){
			  		   $(".teaching"+status).css("visibility","hidden");
			  	   }
			   }
		   });
   		});
   		
	</script>
</html>
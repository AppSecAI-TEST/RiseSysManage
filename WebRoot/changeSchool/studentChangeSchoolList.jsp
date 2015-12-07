<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript">
			$(document).ready(function() {
				$("[name='applyId']").each(function() {
					var applyId = $(this).val();
					$("#changeImgUrl" + applyId).lightBox();
				});
			});
		</script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员转校信息">
  			<c:forEach items="${array }" var="changeSchool">
  				<input type="hidden" name="applyId" value="${changeSchool.applyId }"/>
  				<table width="100%" cellpadding="5px" class="maintables" style="margin-top: 10px;">
  					<tr>
	  					<td style="border-right: 0" colspan="6">
	  						<span style="font-size: 16px; font-weight: bold;"><span>转校状态：${changeSchool.changeState }</span></span>
	  					</td>
	  					<td align="right" colspan="2">
	  						<c:if test="${!empty changeSchool.imgUrl }">
	  							<span style="margin-right: 200px"><a href="${changeSchool.imgUrl }" id="changeImgUrl${changeSchool.applyId }" class="linkmore">查看转校申请单</a></span>
	  						</c:if>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="100px"><span>转校次数：</span></td>
	  					<td width="150px"><span>${changeSchool.changeSchoolNum }</span></td>
	  					<td align="right" width="120px"><span>转出校区：</span></td>
	  					<td width="150px"><span>${changeSchool.outSchoolName }</span></td>
	  					<td align="right" width="120px"><span>在读班级：</span></td>
	  					<td colspan="3" width="460px"><span>${changeSchool.outClass }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="100px"><span>课程状态：</span></td>
	  					<td width="150px"><span>${changeSchool.oldCourseStateText }</span></td>
	  					<td align="right" width="120px"><span>转入校区：</span></td>
	  					<td width="150px"><span>${changeSchool.inSchoolName }</span></td>
	  					<td align="right" width="120px"><span>转入班级：</span></td>
	  					<td colspan="3" width="460px"><span>${changeSchool.inClass }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="100px"><span>已结课阶段：</span></td>
	  					<td width="150px"><span>${changeSchool.lowerStageId }</span></td>
	  					<td align="right" width="120px"><span>已升学阶段：</span></td>
	  					<td width="150px"><span>${changeSchool.higherStageId }</span></td>
	  					<td align="right" width="120px"><span>当前课程：</span></td>
	  					<td width="100px"><span>${changeSchool.stageId }</span></td>
	  					<td align="right" width="120px"><span>业绩类型：</span></td>
		  				<td width="240px"><span>${changeSchool.feeTypeText }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="100px"><span>申请人：</span></td>
	  					<td width="150px"><span>${changeSchool.applyName }</span></td>
	  					<td align="right" width="120px"><span>申请时间：</span></td>
	  					<td width="150px"><span>${changeSchool.applyDate }</span></td>
	  					<td align="right" width="120px"><span>申请说明：</span></td>
	  					<td colspan="3" width="460px"><span>${changeSchool.applyRemark }</span></td>
	  				</tr>
	  				<c:if test="${!empty changeSchool.approveDate }">
		  				<tr>
		  					<td align="right" width="100px"><span>审批人：</span></td>
		  					<td width="150px"><span>${changeSchool.approveName }</span></td>
		  					<td align="right" width="120px"><span>审批时间：</span></td>
		  					<td width="150px"><span>${changeSchool.approveDate }</span></td>
		  					<td align="right" width="120px"><span>审批意见：</span></td>
		  					<td width="100px"><span>${changeSchool.approveTypeText }</span></td>
		  					<td align="right" width="120px"><span>审批说明：</span></td>
		  					<td width="240px"><span>${changeSchool.approveRemark }</span></td>
		  				</tr>
	  				</c:if>
	  				<c:if test="${!empty changeSchool.outDate }">
		  				<tr>
		  					<td align="right" width="100px"><span>转出人：</span></td>
		  					<td width="150px"><span>${changeSchool.outName }</span></td>
		  					<td align="right" width="120px"><span>转出时间：</span></td>
		  					<td colspan="5" width="730px"><span>${changeSchool.outDate }</span></td>
		  				</tr>
	  				</c:if>
	  				<c:if test="${!empty changeSchool.inDate }">
		  				<tr>
		  					<td align="right" width="100px"><span>转入人：</span></td>
		  					<td width="150px"><span>${changeSchool.inName }</span></td>
		  					<td align="right" width="120px"><span>转入时间：</span></td>
		  					<td colspan="5" width="730px"><span>${changeSchool.inDate }</span></td>
		  				</tr>
	  				</c:if>
	  				<c:if test="${!empty changeSchool.finishDate }">
		  				<tr>
		  					<td align="right" width="100px"><span>考勤人：</span></td>
		  					<td width="150px"><span>${changeSchool.finishName }</span></td>
		  					<td align="right" width="120px"><span>完成时间：</span></td>
		  					<td colspan="5" width="730px"><span>${changeSchool.finishDate }</span></td>
		  				</tr>
	  				</c:if>
  				</table>
  			</c:forEach>
  		</div>
  	</body>
</html>

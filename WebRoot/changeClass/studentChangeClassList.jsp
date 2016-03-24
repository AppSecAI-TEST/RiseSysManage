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
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员转班信息">
  			<c:forEach items="${array }" var="changeClass">
  				<input type="hidden" name="applyId" value="${changeClass.applyId }"/>
	  			<table width="100%" cellpadding="5px" class="maintables" style="margin-top: 10px;">
	  				<tr>
	  					<td style="border-right: 0" colspan="6">
	  						<span style="font-size: 16px; font-weight: bold;"><span>转班状态：${changeClass.changeStateText }</span></span>
	  					</td>
	  					<td align="right" colspan="2">
	  						<c:if test="${!empty changeClass.imgUrl }">
	  							<span style="margin-right: 200px"><a href="${changeClass.imgUrl }" id="changeImgUrl${changeClass.applyId }" class="linkmore">查看转班申请单</a></span>
	  						</c:if>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="100px"><span>转班次数：</span></td>
	  					<td width="150px"><span>${changeClass.changeClassNum }</span></td>
	  					<td align="right" width="120px"><span>转出班级：</span></td>
	  					<td width="150px"><span>${changeClass.outClass }</span></td>
	  					<td align="right" width="120px"><span>转入班级：</span></td>
	  					<td colspan="3" width="460px"><span>${changeClass.inClass }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="100px">
	  						<c:if test="${changeClass.feeType == '001' }">
		  						<span>业绩顾问：</span>
	  						</c:if>
	  						<c:if test="${changeClass.feeType != '001' }">
	  							<span>业绩老师：</span>
	  						</c:if>
	  					</td>
	  					<td width="150px">
	  						<c:if test="${changeClass.feeType == '001' }">
		  						<span>${changeClass.adviserName }</span>
	  						</c:if>
	  						<c:if test="${changeClass.feeType != '001' }">
	  							<span>${changeClass.adviserTeacherName }</span>
	  						</c:if>
	  					</td>
	  					<td align="right" width="120px"><span>原带班老师：</span></td>
	  					<td width="150px"><span>${changeClass.outClassTeacherName }</span></td>
	  					<td align="right" width="120px"><span>原课程状态：</span></td>
	  					<td colspan="3" width="460px"><span>${changeClass.courseStateText }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="100px"><span>申请人：</span></td>
	  					<td width="150px"><span>${changeClass.applyName }</span></td>
	  					<td align="right" width="120px"><span>申请时间：</span></td>
	  					<td width="150px"><span>${changeClass.applyDate }</span></td>
	  					<td align="right" width="120px"><span>申请说明：</span></td>
	  					<td colspan="3" width="460px"><span>${changeClass.applyRemark }</span></td>
	  				</tr>
	  				<c:if test="${!empty changeClass.approveDate }">
		  				<tr>
		  					<td align="right" width="100px"><span>审批人：</span></td>
		  					<td width="150px"><span>${changeClass.approveName }</span></td>
		  					<td align="right" width="120px"><span>审批时间：</span></td>
		  					<td width="150px"><span>${changeClass.approveDate }</span></td>
		  					<td align="right" width="120px"><span>审批意见：</span></td>
		  					<td width="100px"><span>${changeClass.approveTypeText }</span></td>
		  					<td align="right" width="120px"><span>审批说明：</span></td>
		  					<td width="240px"><span>${changeClass.approveRemark }</span></td>
		  				</tr>
	  				</c:if>
	  				<c:if test="${!empty changeClass.outDate }">
		  				<tr>
		  					<td align="right" width="100px"><span>转出人：</span></td>
		  					<td width="150px"><span>${changeClass.outName }</span></td>
		  					<td align="right" width="120px"><span>转出时间：</span></td>
		  					<td colspan="5" width="730px"><span>${changeClass.outDate }</span></td>
		  				</tr>
	  				</c:if>
	  				<c:if test="${!empty changeClass.inDate }">
		  				<tr>
		  					<td align="right" width="100px"><span>转入人：</span></td>
		  					<td width="150px"><span>${changeClass.inName }</span></td>
		  					<td align="right" width="120px"><span>转入时间：</span></td>
		  					<td colspan="5" width="730px"><span>${changeClass.inDate }</span></td>
		  				</tr>
	  				</c:if>
	  				<c:if test="${!empty changeClass.finishDate }">
		  				<tr>
		  					<td align="right" width="100px"><span>考勤人：</span></td>
		  					<td width="150px"><span>${changeClass.finishName }</span></td>
		  					<td align="right" width="120px"><span>完成时间：</span></td>
		  					<td colspan="5" width="730px"><span>${changeClass.finishDate }</span></td>
		  				</tr>
	  				</c:if>
	  				<c:if test="${!empty changeSchool.cancelDate }">
	  					<tr>
	  						<td align="right" width="100px"><span>取消人：</span></td>
	  						<td width="150px"><span>${changeSchool.cancelName }</span></td>
		  					<td align="right" width="120px"><span>取消时间：</span></td>
		  					<td colspan="5" width="730px"><span>${changeSchool.cancelDate }</span></td>
	  					</tr>
	  				</c:if>
	  				<c:if test="${!empty changeSchool.stopDate }">
	  					<tr>
	  						<td align="right" width="100px"><span>终止人：</span></td>
	  						<td width="150px"><span>${changeSchool.stopName }</span></td>
		  					<td align="right" width="120px"><span>终止时间：</span></td>
		  					<td colspan="5" width="730px"><span>${changeSchool.stopDate }</span></td>
	  					</tr>
	  				</c:if>
	  			</table>
  			</c:forEach>
  		</div>
  	</body>
</html>

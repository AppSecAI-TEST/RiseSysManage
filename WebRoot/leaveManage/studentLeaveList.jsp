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
			function viewChangeImg(imgUrl) {
				parent.viewChangeImg(imgUrl);
			}
		</script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员休学信息">
  			<c:forEach items="${array }" var="leave">
  				<table width="100%" cellpadding="5px" class="maintables" style="margin-top: 10px;">
  					<tr>
	  					<td style="border-right: 0" colspan="6">
	  						<span style="font-size: 16px; font-weight: bold;"><span>休学状态：${leave.leaveStateText }</span></span>
	  					</td>
	  					<td align="right" colspan="2">
	  						<c:if test="${!empty leave.imgUrl }">
	  							<span style="margin-right: 200px"><a href="#" onclick="viewChangeImg('${leave.imgUrl }')" class="linkmore">查看休学申请单</a></span>
	  						</c:if>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="120px"><span>休学次数：</span></td>
	  					<td width="150px"><span>${leave.leaveNum }</span></td>
	  					<td align="right" width="120px"><span>校区：</span></td>
	  					<td width="150px"><span>${leave.schoolName }</span></td>
	  					<td align="right" width="120px"><span>在读班级：</span></td>
	  					<td colspan="3" width="440px"><span>${leave.className }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="120px"><span>带班老师：</span></td>
	  					<td width="150px"><span>${leave.teacherName }</span></td>
	  					<td align="right" width="120px"><span>客户关怀：</span></td>
	  					<td width="150px"><span>${leave.carerName }</span></td>
	  					<td align="right" width="120px"><span>在读课程状态：</span></td>
	  					<td colspan="3" width="440px"><span>${leave.courseStateText }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="120px"><span>已结课阶段：</span></td>
	  					<td width="150px"><span>${leave.lowerStageId }</span></td>
	  					<td align="right" width="120px"><span>已升学阶段：</span></td>
	  					<td width="710px" colspan="5"><span>${leave.higherStageId }</span></td>
	  				</tr>
	  				<tr>
		  				<td align="right" width="120px"><span>休学开始日期：</span></td>
		  				<td width="150px"><span>${leave.createDate }</span></td>
		  				<td align="right" width="120px"><span>计划休学时长：</span></td>
		  				<td width="150px"><span>${leave.leaveTime }</span></td>
		  				<td align="right" width="120px"><span>已经休学时长：</span></td>
		  				<td width="100px"><span>${leave.leaveDays }</span></td>
		  				<td align="right" width="120px"><span>操作人：</span></td>
		  				<td width="220px"><span>${leave.handlerName }</span></td>
		  			</tr>
		  			<tr>
	  					<td align="right" width="120px"><span>复课日期：</span></td>
		  				<td width="150px"><span>${leave.resumeDate }</span></td>
		  				<td align="right" width="120px"><span>复课方式：</span></td>
		  				<td width="150px"><span>${leave.resumeTypeText }</span></td>
		  				<td align="right" width="120px"><span>终止日期：</span></td>
		  				<td width="100px"><span>${leave.resumeDate }</span></td>
		  				<td align="right" width="120px"><span>操作人：</span></td>
		  				<td width="220px"><span>${leave.handlerName }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="120px"><span>休学备注：</span></td>
		  				<td width="980px" colspan="7"><span>${leave.leaveReason }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="120px"><span>复课备注：</span></td>
		  				<td width="980px" colspan="7"><span>${leave.leaveReason }</span></td>
	  				</tr>
  				</table>
  			</c:forEach>
  		</div>
  	</body>
</html>

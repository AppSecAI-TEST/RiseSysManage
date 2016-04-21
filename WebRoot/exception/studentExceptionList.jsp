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
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员异常信息">
  			<c:forEach items="${array }" var="exc">
  				<table width="100%" cellpadding="5px" class="maintables" style="margin-top: 10px;">
  					<tr>
	  					<td colspan="8">
	  						<span style="font-size: 16px; font-weight: bold;"><span>异常状态：${exc.excStateText }</span></span>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="120px"><span>异常次数：</span></td>
	  					<td width="150px"><span>${exc.extNum }</span></td>
	  					<td align="right" width="120px"><span>校区：</span></td>
	  					<td width="150px"><span>${exc.schoolName }</span></td>
	  					<td align="right" width="120px"><span>在读班级：</span></td>
	  					<td colspan="3" width="440px"><span>${exc.orignClassName }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="120px"><span>带班老师：</span></td>
	  					<td width="150px"><span>${exc.teacherName }</span></td>
	  					<td align="right" width="120px"><span>客户关怀：</span></td>
	  					<td width="150px"><span>${exc.carerName }</span></td>
	  					<td align="right" width="120px"><span>在读课程状态：</span></td>
	  					<td colspan="3" width="440px"><span>${exc.courseStateText }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="120px"><span>已结课阶段：</span></td>
	  					<td width="150px"><span>${exc.lowerStageId }</span></td>
	  					<td align="right" width="120px"><span>已升学阶段：</span></td>
	  					<td width="710px" colspan="5"><span>${exc.stageLevel }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="120px"><span>异常开始日期：</span></td>
	  					<td width="150px"><span>${exc.createDate }</span></td>
	  					<td align="right" width="120px"><span>已经异常时长：</span></td>
	  					<td width="150px"><span>${exc.excDays }</span></td>
	  					<td align="right" width="120px"><span>操作人：</span></td>
	  					<td colspan="3" width="440px"><span>${exc.handlerName }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="120px"><span>复课日期：</span></td>
	  					<td width="150px"><span>${exc.resumeDate }</span></td>
	  					<td align="right" width="120px"><span>复课方式：</span></td>
	  					<td width="150px"><span>${exc.resumeTypeText }</span></td>
	  					<td align="right" width="120px"><span>操作人：</span></td>
	  					<td colspan="3" width="440px"><span>${exc.resumeHandlerName }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="120px"><span>终止日期：</span></td>
		  				<td width="980px" colspan="7"><span>${exc.finishDate }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="120px"><span>异常备注：</span></td>
		  				<td width="980px" colspan="7"><span>${exc.remark }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="120px"><span>复课备注：</span></td>
		  				<td width="980px" colspan="7"><span></span></td>
	  				</tr>
  				</table>
  			</c:forEach>
  		</div>
  	</body>
</html>

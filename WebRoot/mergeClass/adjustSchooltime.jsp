<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/mergeClass/adjustSchooltime.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="调整上课时段">
  			<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  			<c:forEach items="${list }" var="obj">
  				<input type="hidden" id="schoolId${obj.classInstId }" name="schoolId" value="${obj.schoolId }"/>
  				<input type="hidden" id="addSchoolNum${obj.classInstId }" name="addSchoolNum" value="${obj.schooltimeObj.total }"/> 
  				<input type="hidden" id="classInstId${obj.classInstId }" name="classInstId" value="${obj.classInstId }"/>
  				<input type="hidden" id="classType${obj.classInstId }" name="classType" value="${obj.classType }"/>
  				<input type="hidden" id="stageId${obj.classInstId }" name="stageId" value="${obj.stageId }"/>
  				<input type="hidden" id="className${obj.classInstId }" name="className" value="${obj.className }"/>
	  			<table width="99.9%" cellpadding="5px" class="maintables" style="margin-top: 10px;">
	  				<tr>
	  					<td colspan="8" style="border-right: 0">
  							<span style="font-size: 16px; font-weight: bold;">${obj.className }</span>
  						</td>
	  				</tr>
	  				<tr>
  						<td align="right" width="12%"><span>上课时段：</span></td>
  						<td colspan="3" width="32%">
  							<select name="weekTime" id="weekTime${obj.classInstId }" class="easyui-combobox" style="width: 100px; height: 28px;" editable="false" >
	        				</select>
	        				<select name="hourRange" id="hourRange${obj.classInstId }" class="easyui-combobox" style="width: 150px; height: 28px;" editable="false" >
	        				</select>
  						</td>
  						<td align="right" width="8%"><span>教室：</span></td>
  						<td width="6%">
  							<select id="roomId${obj.classInstId }" name="roomId" class="easyui-combobox" style="width: 80px; height: 28px;" editable="false" 
		      					data-options="formatter:formatRoom, valueField: 'roomId', textField: 'roomName', panelHeight: 'auto'" 
		      					url="<%=path %>/pubData/qryRoomList.do?schoolId=${obj.schoolId }">
	        				</select>
  						</td>
  						<td colspan="2" align="center" width="42%">
							<a href="javascript:void(0)" id="addHourRange${obj.classInstId }" name="addHourRange" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px; height: 28px;">添加上课时间</a>					
  							&nbsp;<a href="javascript:void(0)" id="view${obj.classInstId }" name="view" class="easyui-linkbutton" iconCls="icon-redo" style="width: 120px; height: 28px;">查看排期表</a>
  						</td>
  					</tr>
  					<tr>
  						<td colspan="8">
  							<table width="100%" id="schooltimeTb${obj.classInstId }" class="maintable">
  								<tr>
  									<td align="center" width='4%'><span>序号</span></td>
  									<td align="center" width='14%'><span>上课时段</span></td>
  									<td align="center" width='8%'><span>教室</span></td>
  									<td align="center" width='4%'><span>课时</span></td>
  									<td align="center" width='50%'><span>带班老师</span></td>
  									<td align="center" width='20%' style="border-right: 0px;"><span>操作</span></td>
  								</tr>
  								<tr id="addSchootimeTd${obj.classInstId }" style="display:none; height: 20px;">
  									<td align="center" width='4%'></td>
  									<td align="center" width='14%'></td>
  									<td align="center" width='8%'></td>
  									<td align="center" width='4%'></td>
  									<td width='50%'></td>
  									<td align="center" width='20%'>
  										<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px; height: 28px;" onclick="addTeacher(this)">添加老师</a>
  										<a href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-remove' style='width: 100px; height: 28px;' onclick="deleteSchooltime(this)">删除</a></td></tr>
  									</td>
  								</tr>
  								<c:forEach items="${obj.schooltimeObj.rows }" var="schooltime" varStatus="status">
  									<tr>
		  								<input type='hidden' name='schooltimes' roomId='${schooltime.roomId }' weekTime='${schooltime.weekTime }' 
		  									hourRange='${schooltime.hourRange }' lessionHours='${schooltime.lessionHours }' addNum='${status.index + 1 }' 
		  									schooltimeId='${schooltime.schooltimeId }' classInstId='${obj.classInstId }' schooltimeName='${schooltime.schooltimeName }'/>
		  								<td align="center" width='4%' lessionHours='${schooltime.lessionHours }' index='${status.index + 1 }' addFlag='N' classInstId='${obj.classInstId }'
		  									schooltimeId='${schooltime.schooltimeId }' weekTime='${schooltime.weekTime }' hourRange='${schooltime.hourRange }'><span>${status.index + 1 }</span></td>
		  								<td align="center" width='14%'><span>${schooltime.schooltimeName }</span></td>
		  								<td align="center" width='8%'><span>${schooltime.roomName }</span></td>
		  								<td align="center" width='4%'><span>${schooltime.lessionHours }</span></td>
		  								<c:choose>
			  								<c:when test="${fn:length(schooltime.classTeacherList) > 0 }">
			  									<td width='50%' lessions='${schooltime.lessionHours }'>
				  									<c:forEach items="${schooltime.classTeacherList }" var="classTeacher">
				  										<span id="teacher${classTeacher.teacherId }${schooltime.weekTime }${schooltime.hourRange }${obj.classInstId }">
				  											${classTeacher.schoolName }&nbsp;${classTeacher.byname }&nbsp;${classTeacher.hours }&nbsp;${classTeacher.isLicense }&nbsp;
				  											<a href='javascript:void(0)' class='linkmore' onclick="deleteTeacher(this, ${classTeacher.teacherId })"><span>删除</span></a>
				  											<input type='hidden' name='teachers' teacherId='${classTeacher.teacherId }' schooltimeId="${schooltime.schooltimeId }"
				  												weekTime='${schooltime.weekTime }' hourRange='${schooltime.hourRange }' classInstId='${obj.classInstId }'
				  												lessions='${classTeacher.hours }' classTeacherId='${classTeacher.classTeacherId }' addFlag='N'/>&nbsp;
				  										</span>
				  									</c:forEach>
			  									</td>
			  								</c:when>
		  									<c:otherwise>
		  										<td width='50%' lessions='0'></td>
		  									</c:otherwise>
		  								</c:choose>
		  								<td align="center" width='20%'>
		  									<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px; height: 28px;" onclick="addTeacher(this)">添加老师</a>
		  									<a href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-remove' style='width: 100px; height: 28px;' onclick="deleteSchooltime(this)">删除</a>
		  								</td>
		  							</tr>
  								</c:forEach>
  							</table>
  						</td>
  					</tr>
	  			</table>
  			</c:forEach>
  		</div>
  		<div style="margin-top: 25px;min-width:1100px; width:99%;text-align: right;">
	      	<a href="javascript:void(0)" id="adjustSchooltimeSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      	&nbsp;<a href="javascript:void(0)" id="activityBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	    </div>
  		<div id="dlg" class="easyui-dialog" style="width:500px;height: 300px;" closed="true" data-options="modal:true" buttons="#dlgBtn">
  			<form id="addTeacherFm" method="post">
  				<input type="hidden" id="selClassInstId"/>
  				<input type="hidden" id="selSchooltimeId"/>
  				<table width="96%" cellspacing="10px" style="margin-left: 2%; margin-top: 5%" class="maintable1">
  					<tr>
  						<td align="right" width="40%"><span>归属组织：</span></td>
  						<td width="60%">
  							<select id="teacherSchoolId" name="teacherSchoolId" class="easyui-combobox" style="width: 200px; height: 25px;" required="true">
		        			</select>
  						</td>
  					</tr>
  					<tr>
  						<td align="right" width="40%"><span>带班老师：</span></td>
  						<td width="60%">
  							<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 200px; height: 25px;" required="true" >
  							</select>
  						</td>
  					</tr>
  					<tr>
  						<td align="right" width="40%"><span>是否持证：</span></td>
  						<td width="60%">
  							<span id="licenseFlagText"></span>
  						</td>
  					</tr>
  					<tr>
  						<td align="right" width="40%"><span>课时：</span></td>
  						<td width="60%">
  							<input name="lessions" id="lessions" type="text" class="easyui-numberbox" required="true" style="width: 200px; height: 28px;"/>
  						</td>
  					</tr>
  				</table>
  			</form>
  		</div>
  		<div id="dlgBtn">
    		<a href="javascript:void(0)" id="addTeacherSubmit" class="easyui-linkbutton" iconCls="icon-ok">提交</a> 
    		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
  		</div>
  	</body>
</html>

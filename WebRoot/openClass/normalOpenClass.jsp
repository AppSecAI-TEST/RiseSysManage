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
		<script type="text/javascript" src="<%=path %>/js/openClass/openClass.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:100%;height:auto;" title="正常开班申请">
  			<form id="openClassFm">
  				<input type="hidden" id="applyId" name="applyId" value="${obj.createClassObj.applyId }"/>
  				<input type="hidden" id="classInstId" name="classInstId" value="${obj.createClassObj.classInstId }"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="schoolId" name="schoolId" value="${obj.createClassObj.schoolId}"/>
  				<input type="hidden" id="classTeacherId" name="classTeacherId"/>
  				<input type="hidden" id="openClassType" name="openClassType" value="N"/>
  				<input type="hidden" id="openClassNum" name="openClassNum" value="0"/>
	  			<table width="99.99%" cellpadding="5px" class="maintable" id="cancelApplyClassTd">
	  				<tr>
	  					<td align="right" width="10%"><span>课程阶段：</span></td>
	  					<td width="20%"><span id="stageId">${obj.createClassObj.stageId }</span></td>
	  					<td align="right" width="10%"><span>班级类型：</span></td>
	  					<td width="20%"><span id="classType">${obj.createClassObj.classType }</span></td>
	  					<td align="right" width="10%"><span>班级名称：</span></td>
	  					<td width="30%"><span id="className">${obj.createClassObj.className }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>开课时间：</span></td>
	  					<td width="20%">
	  						<input name="startDate" id="startDate" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 28px;" value="${obj.createClassObj.startDate }"/>
	  					</td>
	  					<td align="right" width="10%"><span>学员来源类型：</span></td>
	  					<td width="20%"><span id="studentChannelTypeVal">${obj.createClassObj.studentChannelTypeVal }</span></td>
	  					<td align="right" width="10%"><span>来源班级：</span></td>
	  					<td width="30%"><span id="higherSchoolName">${obj.createClassObj.higherSchoolName }</span></td>
	  				</tr>
	  				<tr>
  						<td colspan="6">
  							<table width="100%" cellpadding="5px" id="schooltimeTb" class="maintable">
  								<tr>
  									<td align="center" width='4%'><span>序号</span></td>
  									<td align="center" width='14%'><span>上课时段</span></td>
  									<td align="center" width='4%'><span>教室</span></td>
  									<td align="center" width='4%'><span>课时</span></td>
  									<td align="center" width='64%'><span>带班老师</span></td>
  									<td align="center" width='10%'><span>操作</span></td>
  								</tr>
  								<c:forEach items="${obj.schooltimeObj.rows }" var="schooltime" varStatus="status">
	  								<tr>
					        			<input type='hidden' name='schooltimes' roomId='${schooltime.roomId }' weekTime='${schooltime.weekTime }' hourRange='${schooltime.hourRange }' lessionHours='${schooltime.lessionHours }' addNum='${status.index + 1 }' schooltimeId='${schooltime.schooltimeId }'/>
	  									<td align="center" width='4%' lessionHours='${schooltime.lessionHours }' weekTime='${schooltime.weekTime }' hourRange='${schooltime.hourRange }'><span>${status.index + 1 }</span></td>
	  									<td align="center" width='14%'><span>${schooltime.schooltimeName }</span></td>
	  									<td align="center" width='4%'>
	  										<select id="roomId${schooltime.schooltimeId }" name="roomId" class="easyui-combobox" style="width: 80px; height: 28px;" editable="false" 
		      									data-options="formatter:formatRoom, valueField: 'roomId', textField: 'roomName', panelHeight: 'auto', 
		      									onLoadSuccess: function (data){if(data.length > 0) $('#roomId${schooltime.schooltimeId }').combobox('select', ${schooltime.roomId });}" 
		      									url="<%=path %>/pubData/qryRoomList.do?schoolId=${obj.createClassObj.schoolId}">
	        								</select>
	  									</td>
	  									<td align="center" width='4%'><span>${schooltime.lessionHours }</span></td>
	  									<c:choose>
			  								<c:when test="${fn:length(schooltime.classTeacherList) > 0 }">
			  									<td width='64%' lessions='${schooltime.lessionHours }'>
			  										<c:forEach items="${schooltime.classTeacherList }" var="classTeacher">
			  											<span id="teacher${classTeacher.teacherId }${schooltime.weekTime }${schooltime.hourRange }">
			  												${classTeacher.schoolName }&nbsp;${classTeacher.byname }&nbsp;${classTeacher.hours }&nbsp;${classTeacher.isLicense }&nbsp;
			  												<a href='javascript:void(0)' class='linkmore' onclick="deleteTeacher(this, ${classTeacher.teacherId })"><span>删除</span></a>
			  												<input type='hidden' name='teachers' teacherId='${classTeacher.teacherId }' weekTime='${schooltime.weekTime }' hourRange='${schooltime.hourRange }' lessions='${classTeacher.hours }' classTeacherId='${classTeacher.classTeacherId }'/>&nbsp;
			  											</span>
			  										</c:forEach>
			  									</td>
			  								</c:when>
		  									<c:otherwise>
		  										<td width='64%' lessions='0'></td>
		  									</c:otherwise>
		  								</c:choose>
	  									<td align="center" width='10%'>
	  										<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px; height: 28px;" onclick="addTeacher(this)">添加老师</a>
	  									</td>
	  								</tr>
  								</c:forEach>
  							</table>
  						</td>
  					</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>开班申请说明：</span></td>
	  					<td width="90%" colspan="5">
	  						<textarea rows="6" cols="122" id="remark" name="remark" class="textarea easyui-validatebox" validType="length[0,120]"></textarea>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td colspan="8" align="right">
	  						<a href="javascript:void(0)" id="openClassSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
		      				&nbsp;<a href="javascript:void(0)" id="activityBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
		      				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  					</td>
	  				</tr>
	  			</table>
  			</form>
  		</div>
  		
  		<div style="padding:5px 0;min-width:1100px; width:100%;">
	  		<table class="easyui-datagrid" title="班级学员列表" style="height:auto;" id="list_data" 
	  			url="<%=path %>/pubData/qryDataListByPage.do?funcNodeId=1005&param={'classInstId':'${obj.createClassObj.classInstId }'}" 
		  		rownumbers="true" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
						<th data-options="field:'byName',width:100,align:'center'">英文名</th>
						<th data-options="field:'payDate',width:100,align:'center'">缴费时间</th>
						<th data-options="field:'studentChannelType',width:100,align:'center'">学员来源</th>
						<th data-options="field:'identityId',width:200,align:'center'">证件号码</th>
						<th data-options="field:'phone',width:100,align:'center'">联系方式</th>
						<th data-options="field:'selectClassNum',width:100,align:'center'">定班次数</th>
						<th data-options="field:'waitClassDays',width:100,align:'center'">等班时长</th>
						<th data-options="field:'advisterName',width:100,align:'center'">招生顾问</th>
						<th data-options="field:'adviserTeacherName',width:100,align:'center'">业绩老师</th>
					</tr>
				</thead>
			</table>
  		</div>
  		
		<div id="dlg" class="easyui-dialog" style="width:500px;height: 300px;" closed="true" data-options="modal:true" buttons="#dlgBtn">
  			<form id="addTeacherFm" method="post">
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

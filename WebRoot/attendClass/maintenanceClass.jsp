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
		<script type="text/javascript" src="<%=path %>/js/attendClass/maintenanceClass.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="班级维护">
  			<div style="margin-left: 10px; margin-bottom: 5px; margin-top: 5px;">
		  		<a href="javascript:void(0)" onclick="viewChangeTeacherHist()" class="easyui-linkbutton" iconCls="icon-redo" style="width: 120px;">老师变更历史</a>
		  		<a href="javascript:void(0)" onclick="viewClassAttendInfo()" class="easyui-linkbutton" iconCls="icon-redo" style="width: 120px;">浏览排课考勤</a>
	  		</div>
  			<form id="maintenanceClassFm">
  				<input type="hidden" id="oldTeacherName" name="oldTeacherName"/>
  				<input type="hidden" id="newTeacherName" name="newTeacherName"/>
  				<input type="hidden" id="classTeacherId" name="classTeacherId"/>
  				<input type="hidden" id="schoolId" name="schoolId" value="${obj.attendClassObj.schoolId }"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="className" name="className" value="${obj.attendClassObj.className }"/>
  				<input type="hidden" id="classInstId" name="classInstId" value="${obj.attendClassObj.classInstId }"/>
  				<input type="hidden" id="classProgress" name="classProgress" value="${obj.attendClassObj.classProgress }"/>
  				<input type="hidden" id="funcNodeId" name="funcNodeId" value="${funcNodeId}" />
  				<div class="easyui-panel" style="min-width:1100px; width:100%; height:auto;" title="班级信息">
		  			<table width="99.99%" cellpadding="5px" class="maintable">
		  				<tr>
		  					<td align="right" width="10%"><span>课程阶段：</span></td>
		  					<td width="20%"><span id="stageId">${obj.attendClassObj.stageId }</span></td>
		  					<td align="right" width="10%"><span>班级类型：</span></td>
		  					<td width="20%"><span id="classType">${obj.attendClassObj.classType }</span></td>
		  					<td align="right" width="10%"><span>班级名称：</span></td>
		  					<td width="30%"><span id="classNameText">${obj.attendClassObj.className }</span></td>
		  				</tr>
		  				<tr>
		  					<td align="right" width="10%"><span>开课时间：</span></td>
		  					<td width="20%"><span>${obj.attendClassObj.startDate }</span></td>
		  					<td align="right" width="10%"><span>学员来源类型：</span></td>
		  					<td width="20%"><span id="studentChannelTypeVal">${obj.attendClassObj.studentChannelTypeText }</span></td>
		  					<td align="right" width="10%"><span>来源班级：</span></td>
		  					<td width="30%"><span id="higherSchoolName">${obj.attendClassObj.higherSchoolName }</span></td>
		  				</tr>
		  				<tr>
		  					<td align="right" width="10%"><span>开班类型：</span></td>
		  					<td width="20%"><span>${obj.attendClassObj.openClassTypeText }</span></td>
		  					<td align="right" width="10%"><span>开班人数：</span></td>
		  					<td width="20%"><span id="studentChannelTypeVal">${obj.attendClassObj.openClassNum }</span></td>
		  					<td align="right" width="10%"><span>在读人数：</span></td>
		  					<td width="30%"><span id="higherSchoolName">${obj.attendClassObj.classStudentNum }</span></td>
		  				</tr>
		  				<tr>
		  					<td align="right" width="10%"><span>升学基数：</span></td>
		  					<td width="20%"><span>${obj.attendClassObj.higherBaseNum }</span></td>
		  					<td align="right" width="10%"><span>已升学人数：</span></td>
		  					<td width="20%"><span id="studentChannelTypeVal">${obj.attendClassObj.higherStudentNum }</span></td>
		  					<td align="right" width="10%"><span>升学率：</span></td>
		  					<td width="30%"><span id="higherSchoolName">${obj.attendClassObj.higherRateText }</span></td>
		  				</tr>
		  				<tr>
		  					<td align="right" width="10%"><span>课时进度：</span></td>
		  					<td width="20%"><span id="classProgressText">${obj.attendClassObj.classProgress }</span></td>
		  					<td align="right" width="10%"><span>持证率：</span></td>
		  					<td width="20%"><span id="studentChannelTypeVal">${obj.attendClassObj.licenseRateText }</span></td>
		  					<td align="right" width="10%"><span>班级性质：</span></td>
		  					<td width="30%">
		  						<c:if test="${obj.attendClassObj.handType == '1' }">
		  							<input type="radio" value="1" name="handType" checked="checked"/><span>一手班</span>
	      							&nbsp;<input type="radio" value="2" name="handType"/><span>二手班</span>
		  						</c:if>
		  						<c:if test="${obj.attendClassObj.handType == '2' }">
		  							<input type="radio" value="1" name="handType" disabled="disabled"/><span>一手班</span>
	      							&nbsp;<input type="radio" value="2" name="handType" disabled="disabled" checked="checked"/><span>二手班</span>
		  						</c:if>
		  					</td>
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
		  									<td align="center" width='4%'><span>${schooltime.roomName }</span></td>
		  									<td align="center" width='4%'><span>${schooltime.lessionHours }</span></td>
		  									<c:choose>
			  									<c:when test="${fn:length(schooltime.classTeacherList) > 0 }">
			  										<td width='64%' lessions='${schooltime.lessionHours }'>
				  										<c:forEach items="${schooltime.classTeacherList }" var="classTeacher">
				  											<span id="teacher${classTeacher.teacherId }${schooltime.weekTime }${schooltime.hourRange }">
				  												${classTeacher.schoolName }&nbsp;${classTeacher.byname }&nbsp;${classTeacher.hours }&nbsp;${classTeacher.isLicense }&nbsp;
				  												<a href='javascript:void(0)' class='linkmore' onclick="deleteTeacher(this, ${classTeacher.teacherId })"><span>删除</span></a>
				  												<input type='hidden' name='teachers' teacherId='${classTeacher.teacherId }' weekTime='${schooltime.weekTime }' 
				  													hourRange='${schooltime.hourRange }' lessions='${classTeacher.hours }' classTeacherId='${classTeacher.classTeacherId }'
				  													schoolName='${classTeacher.schoolName }' byname='${classTeacher.byname }' isLicense='${classTeacher.isLicense }'/>&nbsp;
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
		  					<td align="right" width="10%"><span>老师变更备注：</span></td>
		  					<td colspan="5">
		  						<textarea rows="6" cols="122" id="changeRemark" name="changeRemark" class="textarea easyui-validatebox" validType="length[0,120]"></textarea>
		  					</td>
		  				</tr>
		  				<tr>
		  					<td colspan="6" align="right">
		  						<a href="javascript:void(0)" id="maintenanceClassSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
			      				&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.location.href='/sys/attendClass/attendClassList.jsp?funcNodeId=${funcNodeId}'">返回</a>
			      				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  					</td>
		  				</tr>
		  			</table>
			  		<div style="height: 5px;"></div>
			  		<div style="padding:5px 0;min-width:1100px; width:100%;">
			  			<table class="easyui-datagrid" title="班级学员列表" style="height:auto;" id="list_data" fitColumns="true" singleSelect="false" rownumbers="true"
			  				toolbar="#toolbar" url="<%=path %>/pubData/qryDataListByPage.do?param={'classInstId':'${obj.attendClassObj.classInstId }','funcNodeId':'1021'}">
					  		<thead>
					  			<tr>
					  				<th data-options="field:'ck',checkbox:true"></th>
					  				<th data-options="field:'rowNo',width:50,align:'center'">序号</th>
					  				<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
					  				<th data-options="field:'byName',width:80,align:'center'">英文名</th>
					  				<th data-options="field:'payDate',width:100,align:'center'">缴费时间</th>
					  				<th data-options="field:'attendDate',width:100,align:'center'">进班上课日期</th>
					  				<th data-options="field:'phone',width:180,align:'center'">联系方式</th>
					  				<th data-options="field:'courseStateText',width:100,align:'center'">课程状态</th>
					  				<th data-options="field:'higherStageId',width:100,align:'center'">已升学阶段</th>
					  				<th data-options="field:'normalAttend',width:80,align:'center'">正常课时</th>
					  				<th data-options="field:'leaveAttend',width:80,align:'center'">请假课时</th>
					  				<th data-options="field:'truancyAttend',width:80,align:'center'">旷课课时</th>
					  				<th data-options="field:'behindhandAttend',width:80,align:'center'">迟到次数</th>
					  				<th data-options="field:'makeupAttend',width:80,align:'center'">已补课时</th>
					  				<th data-options="field:'exceptionDate',width:120,align:'center'">异动开始日期</th>
					  				<th data-options="field:'exceptionDays',width:120,align:'center'">异动时长（天）</th>
					  			</tr>
					  		</thead>
					  	</table>
			  		</div>
			  		<div id="toolbar" style="padding: 2px; height: auto">
			   			<a href="javascript:void(0)" id="removeStudent" class="easyui-linkbutton" iconCls="icon-remove" style="width: 100px;">移除</a>
			   			<a href="javascript:void(0)" id="changeClass" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">转班</a>
			   			<a href="javascript:void(0)" id="changeSchool" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;">转校</a>
			   			<a href="javascript:void(0)" id="leave" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;">休学</a>
			   			<a href="javascript:void(0)" id="exception" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;">异常</a>
			   			<a href="javascript:void(0)" id="updateStudent" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;" funcNodeId="1002">修改档案</a>
			   			<a href="javascript:void(0)" id="view" class="easyui-linkbutton" iconCls="icon-redo" style="width: 100px;">浏览</a>
					</div>
  				</div>
  			</form>
  		</div>
  		
  		<div id="histDlg" class="easyui-dialog" style="width:94%;height: 50%;" closed="true" data-options="modal:true">
  			<iframe src="/sys/attendClass/changeTeacherHistList.jsp?classInstId=${obj.attendClassObj.classInstId }" scrolling="yes" frameborder="0" width="99%" height="99%"></iframe>
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

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript">
			//查看老师变更历史
			function viewChangeTeacherHist() {
				$("#histDlg").dialog("open").dialog("setTitle", "老师变更历史");//设定表头  
			}
			function viewClassAttendInfo(){
				ajaxLoading("正在处理，请稍待。。。");
				window.location.href = "/sys/attend/getAttenceCalendarView.do?funcNodeId=${funcNodeId}&classInstId=${obj.attendClassObj.classInstId}&flag=view";
			}
		</script>
  	</head>
  
  	<body>
  		<div style="margin-left: 10px; margin-bottom: 5px; margin-top: 5px;">
		  	<a href="javascript:void(0)" onclick="viewChangeTeacherHist()" class="easyui-linkbutton" iconCls="icon-redo" style="width: 120px;">老师变更历史</a>
		  	<a href="javascript:void(0)" onclick="viewClassAttendInfo()" class="easyui-linkbutton" iconCls="icon-redo" style="width: 120px;">浏览排课考勤</a>
	  	</div>
  		<div class="easyui-panel" style="min-width:1100px; width:98%;height:auto;" title="班级信息">
  			<form id="disbandClassFm">
  				<input type="hidden" id="applyId" name="applyId" value="${obj.attendClassObj.applyId }"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="classInstId" name="classInstId" value="${obj.attendClassObj.classInstId }"/>
	  			<table width="99.99%" cellpadding="5px" class="maintable">
	  				<tr>
	  					<td align="right" width="10%"><span>课程阶段：</span></td>
	  					<td width="20%"><span id="stageId">${obj.attendClassObj.stageId }</span></td>
	  					<td align="right" width="10%"><span>班级类型：</span></td>
	  					<td width="20%"><span id="classType">${obj.attendClassObj.classType }</span></td>
	  					<td align="right" width="10%"><span>班级名称：</span></td>
	  					<td width="30%"><span id="className">${obj.attendClassObj.className }</span></td>
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
		  				<td width="20%"><span id="higherSchoolName">${obj.attendClassObj.higherBaseNum }</span></td>
	  					<td align="right" width="10%"><span>已升学人数：</span></td>
	  					<td width="20%"><span id="studentChannelTypeVal">${obj.attendClassObj.higherStudentNum }</span></td>
	  					<td align="right" width="10%"><span>升学率：</span></td>
	  					<td width="30%"><span id="higherSchoolName">${obj.attendClassObj.higherRateText }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>课时进度：</span></td>
	  					<td width="20%"><span>${obj.attendClassObj.classProgress }</span></td>
	  					<td align="right" width="10%"><span>持证率：</span></td>
	  					<td width="20%"><span id="studentChannelTypeVal">${obj.attendClassObj.licenseRateText }</span></td>
	  					<td align="right" width="10%"><span>班级性质：</span></td>
	  					<td width="30%"><span id="higherSchoolName">${obj.attendClassObj.handTypeText }</span></td>
	  				</tr>
	  				<tr>
	  					<td colspan="6">
	  						<table width="100%" cellpadding="5px" id="schooltimeTb" class="maintable">
	  							<tr>
	  								<td align="center" width='4%'><span>序号</span></td>
	  								<td align="center" width='14%'><span>上课时段</span></td>
	  								<td align="center" width='4%'><span>教室</span></td>
	  								<td align="center" width='4%'><span>课时</span></td>
	  								<td align="center" width='74%'><span>带班老师</span></td>
	  							</tr>
	  							<c:forEach items="${obj.schooltimeObj.rows }" var="schooltime" varStatus="status">
		  							<tr>
						        		<input type='hidden' name='schooltimes' roomId='${schooltime.roomId }' weekTime='${schooltime.weekTime }' hourRange='${schooltime.hourRange }' lessionHours='${schooltime.lessionHours }' addNum='${status.index + 1 }' schooltimeId='${schooltime.schooltimeId }'/>
		  								<td align="center" width='4%' lessionHours='${schooltime.lessionHours }' weekTime='${schooltime.weekTime }' hourRange='${schooltime.hourRange }'><span>${status.index + 1 }</span></td>
		  								<td align="center" width='14%'><span>${schooltime.schooltimeName }</span></td>
		  								<td align="center" width='4%'><span>${schooltime.roomName }</span></td>
		  								<td align="center" width='4%'><span>${schooltime.lessionHours }</span></td>
		  								<c:choose>
			  								<c:when test="${not empty schooltime.classTeacherList }">
			  									<td width='74%' lessions='${schooltime.lessionHours }'>
				  									<c:forEach items="${schooltime.classTeacherList }" var="classTeacher">
				  										<span id="teacher${classTeacher.teacherId }${schooltime.weekTime }${schooltime.hourRange }">
				  											${classTeacher.schoolName }&nbsp;${classTeacher.byname }&nbsp;${classTeacher.hours }&nbsp;${classTeacher.isLicense }&nbsp;
				  										</span>
				  									</c:forEach>
				  								</td>
			  								</c:when>
		  									<c:otherwise>
		  										<td width='64%' lessions='0'></td>
		  									</c:otherwise>
		  								</c:choose>
		  							</tr>
	  							</c:forEach>
	  						</table>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
  		</div>
  		<div style="height: 5px;"></div>
  		<div style="padding:5px 0;min-width:1100px; width:100%;">
  			<table class="easyui-datagrid" title="班级学员列表" style="height:auto;" id="list_data" fitColumns="true" singleSelect="false"
  				url="<%=path %>/pubData/qryDataListByPage.do?param={'classInstId':'${obj.attendClassObj.classInstId }','funcNodeId':'1021'}">
		  		<thead>
		  			<tr>
		  				<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
		  				<th data-options="field:'byName',width:80,align:'center'">英文名</th>
		  				<th data-options="field:'payDate',width:100,align:'center'">缴费时间</th>
		  				<th data-options="field:'payDate',width:100,align:'center'">进班上课日期</th>
		  				<th data-options="field:'phone',width:180,align:'center'">联系方式</th>
		  				<th data-options="field:'courseStateText',width:100,align:'center'">课程状态</th>
		  				<th data-options="field:'higherStageId',width:100,align:'center'">已升学阶段</th>
		  				<th data-options="field:'normalAttend',width:80,align:'center'">正常课时</th>
		  				<th data-options="field:'leaveAttend',width:80,align:'center'">请假课时</th>
		  				<th data-options="field:'truancyAttend',width:80,align:'center'">旷课课时</th>
		  				<th data-options="field:'behindhandAttend',width:80,align:'center'">迟到课时</th>
		  				<th data-options="field:'makeupAttend',width:80,align:'center'">已补课时</th>
		  				<th data-options="field:'exceptionDate',width:120,align:'center'">异动开始日期</th>
		  				<th data-options="field:'exceptionDays',width:120,align:'center'">异动时长（天）</th>
		  			</tr>
		  		</thead>
		  	</table>
  		</div>
  		<div style="height: 5px;"></div>
  		<div style="padding:5px 0;min-width:1101px; width:100%;">
  			<table class="easyui-datagrid" style="height: auto; width: 100%" id="list_data" title="放班操作历史信息" fitColumns="true" singleSelect="false"
  				url="<%=path %>/pubData/qryData.do?param={'classInstId':'${obj.attendClassObj.classInstId }','funcNodeId':'1008'}">
				<thead>
					<tr>
						<th data-options="field:'operType',width:100,align:'center'">操作类型</th>
						<th data-options="field:'createDate',width:120,align:'center'">操作时间</th>
						<th data-options="field:'operName',width:100,align:'center'">操作人</th>
						<th data-options="field:'approveRemark',width:150,align:'center'">审批意见</th>
						<th data-options="field:'remark',width:350,align:'center'">情况说明</th>
					</tr>
				</thead>
			</table>
  		</div> 
  		<div style="text-align:right;margin-top: 25px;min-width:1100px; width:99%;">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 25px;" onclick="javascript:window.history.back()">返回</a>
	   	</div>	
  		
  		<div id="histDlg" class="easyui-dialog" style="width:94%;height: 50%;" closed="true" data-options="modal:true">
  			<iframe src="/sys/attendClass/changeTeacherHistList.jsp?classInstId=${obj.attendClassObj.classInstId }" scrolling="yes" frameborder="0" width="99%" height="99%"></iframe>
  		</div>	
  	</body>
</html>

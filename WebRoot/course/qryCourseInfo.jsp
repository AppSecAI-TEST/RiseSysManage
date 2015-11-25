<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/courseManage.js"></script>
  	</head>
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm">
	  			<table align="center" style="min-width:1100px;width:100%;border:1px solid #95B8E7;margin:0 auto;height:80px;">
	  				<tr>
	  					<td align="right"><span>所属校区：</span></td>
	  					<td>
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
					      		onLoadSuccess:function(data){if(data.length > 0) $('#schoolId').combobox('setValue',data[0].schoolId);}"
					      		url="<%=path %>/pubData/qrySchoolList.do?schoolId=${sessionScope.StaffT.schoolId}">
				        	</select>
				        </td>
				        <td align="right"><span>学生姓名：</span></td>
	  					<td>
	  						<select id="studentId" name="studentId" class="easyui-combobox" style="width: 100px; height: 25px;">
				        	</select>
	  					</td>
	  					<td align="right"><span>责任顾问：</span></td>
	  					<td>
	  						<select id="dutyAdviser" name="dutyAdviser" class="easyui-combobox" style="width: 100px; height: 25px;">
				        	</select>
	  					</td>
	  					<td align="right"><span>联系电话：</span></td>
	  					<td>
	  						<input class="easyui-textbox" name="phone" id="phone" style="width:210px; height: 25px;" />
	  					</td>
	  					<td align="right"><span>缴费日期：</span></td>
			  			<td width="100px">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimePay" name="startTimePay" ata-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="center">
							<span>至</span>
						</td>
						<td width="100px">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimePay" name="endTimePay" ata-options="formatter:myformatter, parser:myparser"/>
						</td>
	  				</tr>
	  				<tr>
	  					<td align="right"><span>业绩顾问：</span></td>
			  			<td width="100px">
							<select id="adviserId" name="adviserId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
				        	</select>
						</td>
						<td align="right"><span>业绩类型：</span></td>
			  			<td width="100px">
							<select id="feeType" name="feeType" class="easyui-combobox" style="width: 100px; height: 25px;"
								data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      			url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=FEE_TYPE">
				        	</select>
						</td>
						<td align="right"><span>课程状态：</span></td>
	  					<td>
	  						<select id="courseState" name="courseState" class="easyui-combobox" style="width: 100px; height: 25px;"
	  							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      			url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=COURSE_STATE">
				        	</select>
	  					</td>
	  					<td align="right"><span>课程类型：</span></td>
	  					<td>
	  						<select id="courseType" name="courseType" class="easyui-combobox" style="width: 100px; height: 25px;"
								data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      			url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=COURSE_TYPE">
				        	</select>
				        	<select id="courseTypeDetail" name="courseTypeDetail" class="easyui-combobox" style="width: 100px; height: 25px;"
								data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
				      			url="<%=path %>/pubData/qryStage.do">
		        			</select>
	  					</td>
	  					<td align="right"><span>退费时间：</span></td>
	  					<td width="100px">
	  						<input class="easyui-datebox" name="startTimeRefund" id="startTimeRefund" style="width:100px; height: 25px;" />
	  					</td>
	  					<td align="center">
							<span>至</span>
						</td>
						<td width="100px">
							<input class="easyui-datebox" name="endTimeRefund" id="endTimeRefund" style="width:100px; height: 25px;" />
						</td>
	  				</tr>
	  				<tr>
	  					<td align="right"><span>业绩老师：</span></td>
	  					<td width="100px" colspan="5">
							<select id="adviserTeacherId" name="adviserTeacherId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
				        	</select>
						</td>
						<td align="right">口碑类型:</td>
	  					<td>
	  						<select class="easyui-combobox"  name="womType" id="womType" style="width:100px; height: 25px;" />
	  						</select>
	  						<select class="easyui-combobox"  name="womTypeDetail" id="womTypeDetail" style="width:100px; height: 25px;" />
	  						</select>
	  					</td>
	  					<td align="right"><span>结课时间：</span></td>
	  					<td width="100px">
	  						<input class="easyui-datebox" name="startTimeFinish" id="startTimeFinish" style="width:100px; height: 25px;" />
	  					</td>
	  					<td align="center">
							<span>至</span>
						</td>
						<td width="100px">
							<input class="easyui-datebox" name="endTimeFinish" id="endTimeFinish" style="width:100px; height: 25px;" />
						</td>
	  				</tr>
	  				<tr>
	  					<td colspan="12" align="center">
	  						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="5002">查询</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
  			<div id="toolbar">
    			<a href="javascript:void(0)" id="addCourse" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加课程</a>
    			<a href="javascript:void(0)" id="updateCourse" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="">修改课程</a>
    			<a href="javascript:void(0)" id="courseDetail" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="">浏览</a>
  			</div>
			<div style="padding:5px 0;">
				<table class="easyui-datagrid" title="查询结果" style="height:450px" id="list_data" toolbar="#toolbar" 
					pagination="true" rownumbers="true" fitColumns="true" singleSelect="true"
				 	url="<%=path %>/pubData/qryDataListByPage.do?funcNodeId=5002">
					<thead>
						<tr>
							<th field="ck" checkbox="true" width="2%"></th>
							<th field="schoolName" align="center" width="8%">所属校区</th>
							<th field="name" align="center" width="7%">学员姓名</th>
							<th field="byName" align="center" width="7%">英文名</th>
							<th field="identityId" align="center" width="10%">证件号码</th>
							<th field="feeTypeText" align="center" width="7%">业绩类型</th>
							<th field="classType" align="center" width="8%">班级类型</th>
							<th field="payDate" align="center" width="8%">缴费时间</th>
							<th field="adviserName" align="center" width="7%">业绩顾问</th>
							<th field="adviserTeacherName" align="center" width="7%">业绩老师</th>
							<th field="dutyAdvisterName" align="center" width="7%">责任顾问</th>
							<th field="courseStateText" align="center" width="7%">课程状态</th>
							<th field="className" align="center" width="8%">当前班级</th>
							<th field="womTypeText" align="center" width="7%">口碑类型</th>
							<th field="phone" align="center" width="7%">联系电话</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
<script type="text/javascript">
var linkCourses = [];

$("#updateCourse").click(function()
{
	if(validateSelect("list_data"))
	{
		var row = $('#list_data').datagrid('getSelected');
		var studentId=row.studentId;
		var linkId=row.linkId;
		var oldCourses=getOldCourse(studentId);
		for(var i=0;i<oldCourses.length;i++)
		{
			var course = oldCourses[i];
			var courseState=course.courseState;
			var stageName =course.stageId;
			var linkIdT=course.linkId;
			if(linkId!='' && linkId==linkIdT)
			{
				linkCourses.push(course);
			}
		}
		
		var studentId = row.studentId;
    	var schoolId = row.schoolId;
    	var studentInfo =row.name+";;"+row.byName+";;"+row.birthday+";;"+row.identityId+";;"+row.sexText;
     
		if(linkCourses.length>1)
		{
			var str=JSON.stringify(linkCourses);
			window.location.href="link.jsp?schoolId="+schoolId+"&studentId="+studentId+"&studentInfo="+studentInfo+"&linkCourses="+str;
		}else 
		{
			var str=JSON.stringify(row);
			if(row.courseType=='002')
			{
				window.location.href="updateShortCourse.jsp?schoolId="+schoolId+"&studentId="+studentId+"&studentInfo="+studentInfo+"&courses="+str;
			}else
			{
				window.location.href="updateCourse.jsp?schoolId="+schoolId+"&studentId="+studentId+"&studentInfo="+studentInfo+"&courses="+str;
			}
			
	    
		}
	}
	
}) 
 
</script>
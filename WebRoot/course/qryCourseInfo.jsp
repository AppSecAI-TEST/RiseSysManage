<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<%@ include file="../common/pub.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/courseManage.js"></script>
  	</head>
  	<body>
  		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
		<input type="hidden" id="funcNodeId" value="${param.funcNodeId}"/>
  		<div style="margin-right:5px">
  			<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" style="min-width: 70px;"><span>所属校区：</span></td>
	  					<td style="min-width: 100px;">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
				        	</select>
				        </td>
				        <td align="right" style="min-width: 70px;"><span>学生姓名：</span></td>
	  					<td style="min-width: 100px;">
	  						<input id="studentId" name="studentId" class="easyui-textbox" style="width: 100px; height: 25px;">
	  					</td>
	  					<td align="right" style="min-width: 70px;"><span>责任顾问：</span></td>
	  					<td style="min-width: 100px;">
	  						<select id="dutyAdviser" name="dutyAdviser" class="easyui-combobox" style="width: 100px; height: 25px;">
				        	</select>
	  					</td>
	  					<td align="right" style="min-width: 70px;"><span>联系电话：</span></td>
	  					<td style="min-width: 120px;">
	  						<input class="easyui-textbox" name="phone" id="phone" style="width:120px; height: 25px;" />
	  					</td>
	  					<td align="right" style="min-width: 70px;"><span>缴费日期：</span></td>
			  			<td style="min-width: 100px;">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimePay" name="startTimePay" editable="false" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="center"><span>至</span></td>
						<td style="min-width: 100px;">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimePay" name="endTimePay" editable="false" data-options="formatter:myformatter, parser:myparser"/>
						</td>
	  				</tr>
	  				<tr>
	  					<td align="right" style="min-width: 70px;"><span>业绩顾问：</span></td>
			  			<td style="min-width: 100px;">
							<select id="adviserId" name="adviserId" class="easyui-combobox" style="width: 100px; height: 25px;">
				        	</select>
						</td>
						<td align="right" style="min-width: 70px;"><span>业绩类型：</span></td>
			  			<td style="min-width: 100px;">
							<select id="feeType" name="feeType" class="easyui-combobox" style="width: 100px; height: 25px;"
								data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" editable="false"
				      			url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=FEE_TYPE">
				        	</select>
						</td>
	  					<td align="right" style="min-width: 70px;"><span>课程类型：</span></td>
	  					<td style="min-width: 210px;" colspan="3">
	  						<select id="courseType" name="courseType" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
				        	</select>
				        	<select id="courseTypeDetail" name="courseTypeDetail" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
		        			</select>
	  					</td>
	  					<td align="right" style="min-width: 70px;"><span>退费时间：</span></td>
	  					<td style="min-width: 100px;">
	  						<input class="easyui-datebox" name="startTimeRefund" id="startTimeRefund" style="width:100px; height: 25px;" editable="false"/>
	  					</td>
	  					<td align="center"><span>至</span></td>
						<td style="min-width: 100px;">
							<input class="easyui-datebox" name="endTimeRefund" id="endTimeRefund" style="width:100px; height: 25px;" editable="false"/>
						</td>
	  				</tr>
	  				<tr>
	  					<td align="right" style="min-width: 70px;"><span>课程状态：</span></td>
	  					<td style="min-width: 100px;">
	  						<select id="courseState" name="courseState" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
	  							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      			url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=COURSE_STATE">
				        	</select>
	  					</td>
	  					<td align="right" style="min-width: 70px;"><span>业绩老师：</span></td>
	  					<td style="min-width: 100px;">
							<select id="adviserTeacherId" name="adviserTeacherId" class="easyui-combobox" style="width: 100px; height: 25px;">
				        	</select>
						</td>
						<td align="right" style="min-width: 70px;"><span>口碑类型：</span></td>
	  					<td style="min-width: 210px;" colspan="3">
	  						<select class="easyui-combobox"  name="womType" id="womType" style="width:100px; height: 25px;" editable="false"/>
	  						</select>
	  						<select class="easyui-combobox"  name="womTypeDetail" id="womTypeDetail" style="width:100px; height: 25px;" />
	  						</select>
	  					</td>
	  					<td align="right" style="min-width: 70px;"><span>结课时间：</span></td>
	  					<td style="min-width: 100px;">
	  						<input class="easyui-datebox" name="startTimeFinish" id="startTimeFinish" style="width:100px; height: 25px;" editable="false"/>
	  					</td>
	  					<td align="center" width="10px"><span>至</span></td>
						<td style="min-width: 100px;">
							<input class="easyui-datebox" name="endTimeFinish" id="endTimeFinish" style="width:100px; height: 25px;" editable="false"/>
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
    			<a href="javascript:void(0)" id="addCourse" class="easyui-linkbutton" style="width:100px;" iconCls="icon-add">添加课程</a>
    			<a href="javascript:void(0)" id="updateCourse" class="easyui-linkbutton" style="width:100px;" iconCls="icon-edit">修改课程</a>
    			<a href="javascript:void(0)" id="courseDetail" class="easyui-linkbutton" style="width:100px;" iconCls="icon-redo">浏览</a>
  			</div>
			 
				<table class="easyui-datagrid" title="查询结果" style="height:400px" id="list_data" toolbar="#toolbar" 
					pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th field="ck" checkbox="true" width="2%"></th>
							<th field="schoolName" align="center" width="6%">所属校区</th>
							<th field="name" align="center" width="6%">学员姓名</th>
							<th field="byName" align="center" width="5%">英文名</th>
							<th field="identityId" align="center" width="12%">证件号码</th>
							<th field="feeTypeText" align="center" width="5%">业绩类型</th>
							<th field="classType" align="center" width="8%">班级类型</th>
							<th field="payDate" align="center" width="7%">缴费时间</th>
							<th field="adviserName" align="center" width="8%">业绩顾问</th>
							<th field="adviserTeacherName" align="center" width="8%">业绩老师</th>
							<th field="dutyAdvisterName" align="center" width="8%">责任顾问</th>
							<th field="courseStateText" align="center" width="5%">课程状态</th>
							<th field="className" align="center" width="6%">当前班级</th>
							<th field="womTypeText" align="center" width="8%">口碑类型</th>
							<th field="phone" align="center" width="12%">联系电话</th>
						</tr>
					</thead>
				</table>
			 
  		</div>
  	</body>
</html>
<script type="text/javascript">
var linkCourses = [];

$("#updateCourse").click(function()
{
	coures("update");
}) 
 
$("#courseDetail").click(function()
{
	coures("view");
});

function coures(type)
{
	if(validateSelect("list_data"))
	{
		var row = $('#list_data').datagrid('getSelected');
		var studentId=row.studentId;
		var linkId=row.linkId;
		var oldCourses=getOldCourse(studentId);
		var courseState=row.courseState;
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
				if(type=="view")
				{
					window.location.href="updateShortCourse.jsp?schoolId="+schoolId+"&studentId="+studentId+"&studentInfo="+studentInfo+"&courses="+str+"&viewFlag=true";
				}
				else 
				{
					window.location.href="updateShortCourse.jsp?schoolId="+schoolId+"&studentId="+studentId+"&studentInfo="+studentInfo+"&courses="+str;
				}	
			}else
			{
				if(courseState=='001' || type=='view')
				{
					var studentCourseId=row.studentCourseId;
					if(type=="view")
					{
						window.location.href="updateCourse.jsp?schoolId="+schoolId+"&studentId="+studentId+"&studentInfo="+studentInfo+"&courses="+str+"&viewFlag=true";
					}
					else
					{
						window.location.href="updateCourse.jsp?schoolId="+schoolId+"&studentId="+studentId+"&studentInfo="+studentInfo+"&courses="+str;
					}	
				}else
				{
					showMessage("提示","该课程不可修改,请重新选择",null);
				}
			}
		}
	}
}
</script>

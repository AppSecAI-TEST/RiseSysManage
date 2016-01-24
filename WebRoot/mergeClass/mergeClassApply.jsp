<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String classInstIds =request.getParameter("classInstIds");
	String isHead =request.getParameter("isHead");
	String schoolId =request.getParameter("schoolId");
	System.err.println("isHead:"+isHead+"schoolId:"+schoolId);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/mergeClass/mergeApply.js"></script>
  	</head>
  	
  	<body>
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<input id="classInstIds" type="hidden" value="<%=classInstIds%>"/>
  		<input id="isHead" type="hidden" value="<%=isHead%>"/>
  		<input id="comSchoolId" type="hidden" value="<%=schoolId%>"/>
  		<div id="schoolInfo" style="width:1293px;margin:20px">
  			<span>合并班校区：</span>
  			<select id="schoolId" name="schoolId" style="width: 100px;height:25px" editable="false"
				data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
		    </select>
  		</div>
  		<div id ="classInfo" class="easyui-panel" title="班级信息" style="width:1293px;">
  			<table width="100%;" id="classTab" class="maintable">
  				<tr>
  					<td align="center" width="6%">校区</td>
  					<td align="center" width="7%">班级名称</td>
  					<td align="center" width="15%">结课日期</td>
  					<td align="center"  width="29%">上课时间段</td>
  					<td align="center" width="7%">在读人数</td>
  					<td align="center" width="7%">已升学人数</td>
  					<td align="center" width="7%">升学率</td>
  					<td align="center" width="14%">可升学人数</td>
  					<td align="center" width="7%">升学缺口</td>
  				</tr>
  				<tr id="modelTr2" style="display:none">
  					<td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td>
  					<td align="center"></td><td align="center"></td><td align="center"></td><td align="center"><input style="width:108px" data-options="required:true"/></td><td align="center"></td>
  				</tr>
  			</table>
  		</div>
  		<div id="mergePlan"  class="easyui-panel" title="合并班计划" style="width:1293px;">
  			<table width="100%;" class="maintable" id ="mergeTab">
  				<tr>
  					<td align="center" width="4%">校区</td>
  					<td align="center" width="5%">班级名称</td>
  					<td align="center" width="9%">开始日期</td>
  					<td align="center" width="4%">开始课时</td>
  					<td align="center" width="4%">合并时长(周)</td>
  					<td align="center" width="8%">合并形式</td>
  					<td align="center" width="8%">合并后结课日期</td>
  					<td align="center" width="5%">合并后班级</td>
  					<td align="center" width="4%">定班人数</td>
  					<td align="center" width="4%">定班率</td>
  					<td align="center" width="18%">合并后上课时段</td>
  					<td align="center" width="14%">带班老师</td>
  					<td align="center" width="9%">开课日期</td>
  				</tr>
  				<tr id="modelTr1" style="display:none">
  					<td align="center">经开万达</td>
  					<td align="center">KS1234</td>
  					<td align="center" rowspan="1"><input style="width:108px" data-options="required:true"/></td>
  					<td align="center"><input style="width:42px" data-options="required:true"/></td>
  					<td align="center" rowspan="1"><input style="width:42px" data-options="required:true,onChange:initCourseApply,min:1,max:50,precision:0"/></td>
  					<td align="center">
  						<select style="width:100px;" data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName',required:true">
  						</select>
  					</td>
  					<td align="center"><input style="width:108px" data-options="required:true"/></td>
  					<td align="center" rowspan="1"><input style="width:50px" data-options="required:true"/></td>
  					<td align="center"><input style="width:42px"/></td>
  					<td align="center" rowspan="1"></td>
  					<td align="center" rowspan="1">
  						<select style="width:64px;" data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName',required:true">
  						</select>
  						<select style="width:135px;" data-options="required:true">
  						</select>
  						<p>
  						<select style="width:64px;" data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName',required:true">
  						</select>
  						<select style="width:135px;" data-options="required:true">
  						</select>
  					</td>
  					<td align="center" rowspan="1">
  						<select style="width:90px;" data-options="formatter:formatSchool,valueField: 'schoolId', textField: 'schoolName',required:true">
  						</select>
  						<select style="width:80px;" data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname',required:true">
  						</select>
  						<p>
  						<select style="width:90px;" data-options="formatter:formatSchool,valueField: 'schoolId', textField: 'schoolName',required:true">
  						</select>
  						<select style="width:80px;" data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname',required:true">
  						</select>
  					</td>
  					<td align="center" rowspan="1"><input style="width:108px" data-options="required:true"/></td>
  				</tr>
  			</table>
  		</div>
  		<div id="courseChangePlan"  class="easyui-panel" title="课程调整计划" style="width:1293px;">  			
  		</div>
  		<div class="easyui-panel" title="合并说明" style="width:1293px;height:100px;">
  			<textarea id="remark" style="border:0;width:100%;height:100%;resize:none;overflow-y:hidden"></textarea>
  		</div>
  		<div style="width:1293px;text-align:center;margin:50px 0;">
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:150px" id="submitBtn"><span>提交</span></a>
  				&nbsp;&nbsp;&nbsp;&nbsp;
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:150px" id="backBtn" ><span>返回</span></a>	
  		</div>
  	</body>
</html>

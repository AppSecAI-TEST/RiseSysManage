<%@ page language="java" import="java.util.*,net.sf.json.*"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="com.rise.pub.util.*"%>
<%
	String path = request.getContextPath();
	String studentInfo =request.getParameter("studentInfo");
	String studentId =request.getParameter("studentId");
	String schoolId= request.getParameter("schoolId");
	String order=request.getParameter("order");
	String courses=request.getParameter("courses");
	String name=request.getParameter("name");
	JSONObject object=new JSONObject();
	if(courses!=null && !"".equals(courses))
    {
		object = JSONObject.fromObject(courses);
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<%@ include file="../common/head.jsp"%>
		<%@ include file="../common/formvalidator.jsp"%>
		<script type="text/javascript" src="<%=path %>/pub/js/date.js"></script>
		 <script type="text/javascript" src="<%=path %>/js/course/addCourse.js"></script>
		<script type="text/javascript">
		$(document).ready(function()
		{
			var height = $(document).height();
			$('#frame<%=name%>',parent.document).css("height",height+20);
		});
			
			
		</script>
		<style>
.praiseTab {
	border-collapse: collapse;
	border-spacing: 0;
	border: 0px solid #ccc;
}

.praiseTab td {
	border: none;
	margin: 0;
	padding: 0;
}
</style>
	</head>

	<body>
	 	<div  class="easyui-panel" title="连报课程<%=order%>" style="width:99%;padding:10px;border-color:#95B1E7">
		<form id="courseFm">
			<div style="height: 10px;"></div>
			<input id="studentCourseId" name="studentCourseId" type="hidden" value="<%=StringUtil.getJSONObjectKeyVal(object,"studentCourseId")%>"/>
    	    <input id="oldClassType"  type="hidden" value="<%=StringUtil.getJSONObjectKeyVal(object,"classType")%>"/>
    	    <input id="oldStageId"   type="hidden" value="<%=StringUtil.getJSONObjectKeyVal(object,"stageId")%>"/>
			<input type="hidden" id="paySchoolId" name="paySchoolId" value="<%=schoolId%>" />	
			<input type="hidden" id="studentId" name="studentId" value="<%=studentId%>">
			<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}" />
			<input type="hidden" id="coursePriceId" name="coursePriceId" value="" />
			<div id="normal">
				<div class="easyui-panel" style="width: 100%; height: auto;"
					title="常规课课程">
					<table width="100%" cellpadding="5px" class="maintable">
						<tr>
							<input id="advisterType" name="adviserType" type="hidden" value="teacher" />
							<input id="courseState" name="courseState" type="hidden" value="001" />
							<input id="feeState" name="feeState" type="hidden" value="00A" />
							<input id="stageOrder" name="stageOrder" type="hidden" value="" />
							<td align="right"><span>缴费时间：</span></td>
	      	    			    <td><input name="payDate" id="payDate" type="text" class="easyui-datebox" required="true" value="<%=StringUtil.getJSONObjectKeyVal(object,"payDate")%>" style="width: 150px; height: 28px;" /></td>
							<td align="right">
								<span>阶段：</span>
							</td>
							<td>
								 <select name="stageId"  id="stageId"   style="width: 150px; height: 28px;" class="easyui-combobox"
	      							data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto',
	      						 	onLoadSuccess:function(data){$('#stageId').combobox('setValue','<%=StringUtil.getJSONObjectKeyVal(object,"stageId")%>');}"
	      						url="<%=path %>/pubData/qryStage.do"  required="true" >
							</td>
							
							<td align="right">
								<span>班级类型：</span>
							</td>
							<td>
								<select name="classType" class="easyui-combobox" id="classType"
									style="width: 150px; height: 28px;"  editable='false' required="true">
									<option>
										请先选择阶段
									</option>
								</select>
							</td>
							 
						</tr>
						<tr >
						<td align="right">
							 <span>业绩类型：</span>
							</td>
							<td>
								<select name="feeType" class="easyui-combobox" id="feeType" editable='false' required="true"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName',
									onLoadSuccess:function(data){$('#feeType').combobox('setValue',data[0].codeFlag)},onChange:changeFeeType"
									style="width: 150px; height: 28px;"
									url="<%=path%>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=FEE_TYPE">
								</select>
							</td>
							<td align="right" id="adviserNameA"><span>业绩顾问A：</span></td>
							<td>
								<div id="adviserADiv">
								<select name="adviserA" class="easyui-combobox" id="adviserA" required="true"
									style="width: 150px; height: 28px;"
									data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto',
									onLoadSuccess:function(data){$('#adviserA').combobox('setValue','<%=StringUtil.getJSONObjectKeyVal(object,"adviserA")%>');}"
		      						url="<%=path %>/pubData/qryTeacherList.do">
								</select>
								</div>
								
								<div id="adviserTeacherADiv" style="display:none">
									<select name="adviserTeacherA" class="easyui-combobox" id="adviserTeacherA" required="true"
									style="width: 150px; height: 28px;"
									data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"
		      						url="<%=path %>/pubData/qryTeacherList.do?schoolId=1001">
	      						</div>
	      						
							</td>
							<td align="right" id="adviserNameB"><span>业绩顾问B：</span></td>
							<td>
								<div id="adviserBDiv">
								<select name="adviserB" class="easyui-combobox" id="adviserB" required="true"
									style="width: 150px; height: 28px;"
									data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto',
									onLoadSuccess:function(data){$('#adviserB').combobox('setValue','<%=StringUtil.getJSONObjectKeyVal(object,"adviserB")%>');}"
		      						url="<%=path %>/pubData/qryTeacherList.do">
								</select>
								</div>
								<div id="adviserTeacherBDiv" style="display:none">
								<select name="adviserTeacherB" class="easyui-combobox" id="adviserTeacherB"  required="true"
								style="width: 150px; height: 28px;"
								data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"
	      						url="<%=path %>/pubData/qryTeacherList.do?schoolId=1001">
	      						</div>
							</select>
							</td>
						</tr>
					</table>
				</div>
				<div id="giftDiv">
				<div style="height: 10px;"></div>
				<div   class="easyui-panel" style="width: 100%; height: auto;"
					title="赠品信息">
				<table width="100%" cellpadding="5px" class="maintable" id="giftTab">
	      	      <tr id="giftModelTR">
	      	        <td width="8%" align="right"><span>赠品类型：</span></td>
	      	        <td width="8%">
	      	        <select id="parentType" style="width: 100px; height: 28px;"
	      			data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      			required="true" >
      	            </select>
      	            </td>
	      	        <td width="7%" align="right"><span>赠品名称：</span></td>
	      	        <td width="39%">
	      	      	<table  border="0">
	   	                <tr>
			      	         <td id='td0' ><select  class="easyui-combobox" id="giftType" style="width: 120px; height: 28px;"></select></td>
			      	         <td id="td1" style="display:none"><select  class="easyui-combobox" id="giftId" style="width: 120px; height: 28px;"></select></td>
			      	         <td id="td2" style="display:none"><input   id="giftCode" type="text" class="easyui-textbox validatebox" required="true" style="width:150px; height: 28px;"/></td>
		                     <td id="td3" style="display:none"><input   id="giftEffDate" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 28px;"/></td>
	      	             </tr>
      	            </table>
      	            </td>
	      	        <td width="7%" align="right"><span>是否领用：</span></td>
	      	        <td width="5%" align="left">
	      	          <input type="radio" name="isGetY"  value="Y">
	      	          <label for="radio"><span>已领用</span></label>
	      	          <input type="radio" name="isGetY"   checked value="N">
	      	          <label for="radio"> <span>未领用</span></label>
      	           </td>
	      	        <td width="6%" align="right"><span>发放人：</span></td>
	      	        <td width="8%"><input   id="granter" type="text" class="easyui-textbox validatebox" required="true" style="width: 100px; height: 28px;"/></td>
	      	       
	      	        <td width="6%"><a href="javascript:void(0)" id="addGiftBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px; height: 28px;">添加</a></td>
      	        </tr>
      	      <tr style="display:none;" name="addGift" id="addGift" >
      	        <td align="right"><span>赠品类型：</span></td>
      	        <td align="left" parentType="">&nbsp;</td>
      	        <td align="right"><span>赠品名称：</span></td>
      	        <td align="left" giftType="" giftId="">&nbsp;</td>
      	        <td align="right"><span>是否领用：</span></td>
      	        <td align="left" isGet="">&nbsp;</td>
      	        <td align="right"><span>发放人：</span></td>
      	        <td align="left" granter="">&nbsp;</td>
      	        
      	        <td><a href='javascript:void(0)' class='linkmore' onclick='delRow(this)' ><span>删除</span></a></td>
     	       </tr>
      	      </table>
      		</div>

				<div style="height: 10px;"></div>
				<div class="easyui-panel" style="width: 100%; height: auto;"
					title="赠课信息">
					<table width="100%" cellpadding="5px" class="maintable">
						<tr id="giftCourseTr">
							<td colspan="2" align="right">
								<span>赠课类型</span>
							</td>
							<td width="22%" align="right">
								<div align="left">
									<select class="easyui-combobox" id="giftCourseType"
										style="width: 150px; height: 28px;"
										data-options="formatter:formatTypeName,  valueField: 'giftType', textField: 'typeName', panelHeight: 'auto'"
										url="/sys/pubData/qryData.do?param={queryCode:'Qry_Gift_Type',parentType:'COURSE'}"></select>
								</div>
							</td>
							<td width="10%" align="right">
								<span>赠课名称：</span>
							</td>
							<td width="11%">
								<select class="easyui-combobox" id="giftCourseId"
									style="width: 120px; height: 28px;" >
								</select>
							</td>

							<td width="12%" align="right">
								<span>课时量:</span>
							</td>
							<td width="22%" id="courseHours"></td>
							<td width="7%">
								<a href="javascript:void(0)" id="addCourse"
									class="easyui-linkbutton" iconCls="icon-add"
									style="width: 80px; height: 28px;">添加</a>
							</td>
						</tr>
					</table>
					<table width="100%" cellpadding="5px" class="maintable"
						id="giftCourse">
						<tr align="center">
							<td width="6%">
								<span>序号</span>&nbsp;
							</td>
							<td width="9%">
								<span>赠课类型</span>
							</td>
							<td width="9%">
								<span>赠课名称</span>
							</td>
							<td width="11%">
								<span>赠送课时量</span>
							</td>
							<td width="9%">
								<span>赠送时间</span>
							</td>
							<td width="10%">
								<span>课程状态</span>
							</td>
							<td width="11%">
								<span>有效期开始时间</span>
							</td>
							<td width="11%">
								<span>有效期结束时间</span>
							</td>
							<td width="8%">
								<span>课程进度</span>
							</td>
							<td width="7%">
								<span>操作</span>
							</td>
						</tr>
						<tr style="display: none;" id="add" align="right">
							<td align="center" val="">
								&nbsp;
							</td>
							<td align="center" giftCourseType="">
								&nbsp;
							</td>
							<td align="center" giftId="">
								&nbsp;
							</td>
							<td align="center">
								&nbsp;
							</td>
							<td align="center">
								&nbsp;
							</td>
							<td align="center">
								&nbsp;
							</td>
							<td align="center">
								&nbsp;
							</td>
							<td align="center">
								&nbsp;
							</td>
							<td align="center">
								&nbsp;
							</td>
							<td align="center">
								<a href='javascript:void(0)' class='linkmore'
									onclick='delRow(this)'><span>删除</span> </a>
							</td>
						</tr>
					</table>
				</div>
				</div>
				<div id="womDiv">
				<div style="height: 10px;"></div>
				<div  class="easyui-panel" style="width: 100%; height: auto;" title="口碑信息">
					<table width="100%" cellpadding="5px" id="praiseInfo"
						class="maintable">
						<tr>
							<td align="right" width="120px;">
								<span>口碑类型：</span>
							</td>
							<td colspan="9" align="left">
								<input type="radio" womType="Y" name="praise"
									onclick="changePraise(this)">
								<span>可控口碑</span>&nbsp;&nbsp;&nbsp;
								<input type="radio" name="praise" womType="N"
									onclick="changePraise(this)">
								<span>不可控口碑</span>
							</td>
						</tr>
						<tr style="display: none;">
							<td align="right">
								<span>口碑来源：</span>
							</td>
							<td align="center" width="170px">
								<select id="praiseSourceY" name="praiseSourceY"
									class="easyui-combobox"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName',
									onLoadSuccess:function(data){$('#praiseSourceY').combobox('setValue',data[0].codeFlag)},onChange:changePraiseSourceY"
									style="width: 150px; height: 28px;"
									url="<%=path%>/pubData/qryCodeNameList.do?tableName=STUDENT_WOM_T&codeType=WOM_CHANNEL_Y">
								</select>
							</td>
							<td colspan="8">
								<table width="100%" class="praiseTab" id="praiseTab1">
									<tr id="A" style="display: none;">
										<td align="left" colspan="8">
											<span>活动名称：</span>
											<select class="easyui-combobox" id="activeSchool"
												data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
												url="<%=path %>/pubData/qrySchoolList.do?schoolId=" required="true">
											</select>
											<select class="easyui-combobox" id="activeId" style="width: 150px; height: 28px;"
												data-options="valueField: 'actionId', textField: 'title', panelHeight: 'auto'">
											</select>
										</td>
									</tr>
									<tr id="C" style="display: none;">
										<td align="left" colspan="8">
											<span>口碑顾问A：</span>
											<select class="easyui-combobox" id="c_schoolA"
											data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
											url="<%=path %>/pubData/qrySchoolList.do?schoolId=" required="true"
												style="width: 150px; height: 28px;">
											</select>
											<select class="easyui-combobox" id="c_adviserA"
												data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"
												style="width: 120px; height: 28px;">
											</select>
											<span>口碑顾问B：</span>
											<select class="easyui-combobox" id="c_schoolB"
											data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
											url="<%=path %>/pubData/qrySchoolList.do?schoolId=" required="true"
												style="width: 150px; height: 28px;">
											</select>
											<select class="easyui-combobox" id="c_adviserB"
												data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"
												style="width: 120px; height: 28px;">
											</select>
										</td>
									</tr>
									<tr id="T" style="display: none;">
										<td colspan="8">
											<span>口碑顾问A：</span>
											<select class="easyui-combobox" id="c_schoolsA"
												data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
												url="<%=path %>/pubData/qrySchoolList.do?schoolId=" required="true"
												style="width: 120px; height: 28px;">
											</select>
											<select class="easyui-combobox" id="c_teacherA"
												data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"
												style="width: 120px; height: 28px;">
											</select>
											<span>口碑顾问B：</span>
											<select class="easyui-combobox" id="c_schoolsB"
												data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
												url="<%=path %>/pubData/qrySchoolList.do?schoolId=" required="true"
												style="width: 120px; height: 28px;">
											</select>
											<select class="easyui-combobox" id="c_teacherB"
												data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"
												style="width: 120px; height: 28px;">
						
											</select>
											<a href="javascript:void(0)" id="qryStudent"
												style="width: 80px" class="easyui-linkbutton"
												iconCls="icon-add" plain="true" onclick="qryStudent()">查询学生</a>
											<a href="javascript:void(0)" id="recordGifts"
												style="width: 80px" class="easyui-linkbutton"
												iconCls="icon-add" plain="true">录入赠品</a>
										</td>
									</tr>
									<tr id="T" style="display: none;">
										<td width="80px" align="center"
											style="border-top: 1px solid #ccc; border-right: 1px solid #ccc;">
											<span>学员姓名：</span>
										</td>
										<td width="100px" align="center"
											style="border-top: 1px solid #ccc; border-right: 1px solid #ccc;">
											&nbsp;
										</td>
										<td width="80px" align="center"
											style="border-top: 1px solid #ccc; border-right: 1px solid #ccc;">
											<span>证件号码：</span>
										</td>
										<td width="200px" align="center"
											style="border-top: 1px solid #ccc; border-right: 1px solid #ccc;">
											&nbsp;
										</td>
										<td width="80px" align="center"
											style="border-top: 1px solid #ccc; border-right: 1px solid #ccc;">
											<span>班级：</span>
										</td>
										<td width="100px" align="center"
											style="border-top: 1px solid #ccc; border-right: 1px solid #ccc;">
											&nbsp;
										</td>
										<td width="80px" align="center"
											style="border-top: 1px solid #ccc; border-right: 1px solid #ccc;">
											<span>赠品：</span>
										</td>
										<td align="center" style="border-top: 1px solid #ccc;">
											&nbsp;
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr style="display: none;">
							<td align="right">
								<span>不可控口碑类型：</span>
							</td>
							<td align="left" width="170px">
								<select id="praiseSourceN" name="praiseSourceN"
									class="easyui-combobox"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName',
									onLoadSuccess:function(data){$('#praiseSourceN').combobox('setValue',data[0].codeFlag)},onChange:changePraiseSourceN"
									style="width: 150px; height: 28px;"
									url="<%=path%>/pubData/qryCodeNameList.do?tableName=STUDENT_WOM_T&codeType=WOM_CHANNEL_N">
								</select>
							</td>
							<td colspan="8">
								<table width="100%" class="praiseTab" id="praiseTab2">
									<tr style="display: none;">
										<td align="right" width="130px"
											style="border-right: 1px solid #ccc;">
											<span>学员姓名：</span>
										</td>
										<td align="center" style="border-right: 1px solid #ccc;">
											<input type="text" class="easyui-textbox"
												style="width: 150px">
										</td>
										<td align="right" width="100px"
											style="border-right: 1px solid #ccc;">
											<span>证件：</span>
										</td>
										<td align="center">
											<select id="identityType" name="identityType"
												class="easyui-combobox"
												data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName',
												onLoadSuccess:function(data){$('#identityType').combobox('setValue',data[0].codeFlag)},onChange:changePraiseSourceN"
												style="width: 150px; height: 28px;"
												url="<%=path%>/pubData/qryCodeNameList.do?tableName=STUDENT_T&codeType=IDENTITY_TYPE">
											</select>
											<input type="text" class="easyui-textbox"
												style="width: 150px">
										</td>
									</tr>
									<tr style="display: none;">
										<td align="right"
											style="border-top: 1px solid #ccc; border-right: 1px solid #ccc;">
											<span>班级：</span>
										</td>
										<td align="center"
											style="border-top: 1px solid #ccc; border-right: 1px solid #ccc;">
											<input type="text" class="easyui-textbox"
												style="width: 150px">
										</td>
										<td align="right"
											style="border-top: 1px solid #ccc; border-right: 1px solid #ccc;">
											<span>转介绍老师:</span>
										</td>
										<td align="center"
											style="border-top: 1px solid #ccc; border-right: 1px solid #ccc;">
											<select class="easyui-combobox" id="t_teacher_school"
												data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
												url="<%=path %>/pubData/qrySchoolList.do?schoolId=" required="true"
												style="width: 100px; height: 28px;">
											</select>
											<select class="easyui-combobox" id="t_teacher_id"
												data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"
												style="width: 150px; height: 28px;">
											<select>
										</td>
										<td align="left" style="border-top: 1px solid #ccc;">
											<a href="javascript:void(0)" id="searchStudent"
												style="width: 150px" class="easyui-linkbutton"
												iconCls="icon-add" plain="true" onclick="searchStudent()"><span>学员检索</span>
										</td>
									</tr>
									<tr style="display: none;">
										<td width="130px" align="right"
											style="border-right: 1px solid #ccc;">
											<span>转介绍员工姓名：</span>
										</td>
										<td align="left">
											<input type="text" id="womStaffName" class="easyui-textbox"
												style="width: 150px">
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
				</div>
			</div>
			<div style="height: 10px;"></div>
			<div class="easyui-panel" style="width: 100% height: auto;" title="缴费信息">
				<table width="100%" cellpadding="5px" class="maintable">
					<tr>
						<td align="center">
							<href ="javascript:void(0)" id="addArchives"
								class="easyui-linkbutton" iconCls="icon-add" plain="true"
								onclick="minusCoupon()">
							<span>使用现金抵扣券</span>
						</td>
						<td colspan="7" giftId="">
							<div id="useCoupon"></div>
						</td>
					</tr>
					<tr>
						<td align="right">
							<span>总金额：</span>
						</td>
						<td align="left">
							<input id="totalAmount" name="totalAmount" type="text"    readonly="readonly"
								class="easyui-textbox validatebox"
								style="width: 200px; height: 25px;">
						</td>
						<td align="right">
							<span>赠券抵扣金额：</span>
						</td>
						 
						<td align="left">
							<input id="minusAmount" name="minusAmount" type="text"   readonly="readonly" class="easyui-textbox validatebox" style="width: 200px; height: 25px;">
						</td>
						<td align="left">
						 <span>连报优惠金额：</span> 
						 </td>
						 <td align="left">
				      	 <input id="favorAmount"   name="favorAmount" type="text"    class="easyui-textbox validatebox"  style="width: 200px; height: 25px;"/> 
				      	 </td>
						<td align="right">
							<span>实缴金额：</span>
						</td>
						<td align="left">
							<input id="amount" name="amount" type="text"   readonly="readonly" class="easyui-textbox validatebox" style="width: 200px; height: 25px;">
						</td>
					</tr>
				</table>
			</div>
		</form>
		 </div>
		 <iframe id="dlg" class="easyui-dialog"
				style="width: 1000px; height: 450px; padding: 10px 20px"
				closed="true" modal="true">
			</iframe>
	</body>
</html>
<script type="text/javascript">
initCousreGift();

$(function()
{
	$('#payDate').datebox().datebox('calendar').calendar(
	{
		validator: function(date)
		{
			var now = new Date();
			var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate()-30);
			var d2 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
			return d1<=date && date<=d2;
		}
	});
});

 
$('#parentType').combobox({
	 onChange:function(n,o)
		{
		     $("#td0").css('display','none');
		 	 $("#td1").css('display','none');
             $("#td2").css('display','none');
             $("#td3").css('display','none');
       		if(n=='COUPON')//券类
       		{
			    var urls="/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift_Type\",parentType:\""+n+"\"}";
	       		$("#giftType").combobox(
	       		{
	        		url : urls,//返回json数据的url
	        		valueField : "giftType",
	        		textField :  "typeName",
	        		panelHeight : "auto",
	        		onLoadSuccess : function ()
	        		{ //数据加载完毕事件
	                    var data = $('#giftType').combobox('getData');
	                    if (data.length > 0)
	                    {
	                      //  $("#giftId").combobox('select', data[0].param2);
	                    }
	                    $("#td0").css('display','block');
	                    $("#td1").css('display','block');
	                    $("#td2").css('display','block');
	                    $("#td3").css('display','block');
	                }
	        	});
       		}else if(n=='GOODS')//实物类
       		{
       			$("#td1").css('display','block');
			    var urls="/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+n+"\"}";
	       		$("#giftId").combobox(
	       		{
	        		url : urls,//返回json数据的url
	        		valueField : "giftId",
	        		textField :  "giftName",
	        		panelHeight : "auto",
	        		onLoadSuccess : function ()
	        		{ //数据加载完毕事件
	                    var data = $('#giftId').combobox('getData');
	                    if (data.length > 0)
	                    {
	                      //  $("#giftId").combobox('select', data[0].param2);
	                    }
	                }
	        	});
       		}
		},
		url:"<%=path%>/pubData/qryCodeNameList.do?tableName=GIFT_TYPE_T&codeType=PARENT_TYPE"
	});

$('#giftType').combobox(
{
	onChange : function(n, o) 
	{
		var urls = "/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+ n + "\"}";
		$("#giftId").combobox(
		{
			url : urls,//返回json数据的url
			valueField : "giftId",
			textField : "giftName",
			panelHeight : "auto",
			onLoadSuccess : function() 
			{ //数据加载完毕事件
				var data = $('#giftId').combobox('getData');
				if (data.length > 0) 
				{
					//  $("#giftId").combobox('select', data[0].param2);
				}
			}	
		});
	}
});

$('#giftCourseType').combobox(
{
	onChange : function(n, o)
	{
		var urls = "/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+ n + "\"}";
		$("#giftCourseId").combobox(
		{
			url : urls,//返回json数据的url
			valueField : "giftId",
			textField : "giftName",
			panelHeight : "auto"
		});
	}
});

$('#giftCourseId').combobox(
{
	onChange : function(n, o) 
	{
		var data = $('#giftCourseId').combobox('getData');
		if (data.length > 0) 
		{
			for ( var i = 0; i < data.length; i++)
			{
				var giftNum = data[0].giftNum;
				var giftId = data[0].giftId;
				if (n == giftId) 
				{
					$("#courseHours").html(giftNum);
				}
			}
		}
	}
});
//选择活动校区加载活动
$("#activeSchool").combobox(
{
	onChange:function()
	{
		var sId = $("#activeSchool").combobox('getValue');
		var urls ="<%=path%>/pubData/qryAction.do?schoolId="+sId;
		$("#activeId").combobox(
		{
			url:urls
		});
	}
});


//选择阶段价加载班级
$('#stageId').combobox({
	onChange : function(n, o)
	{
	var data = $("#stageId").combobox('getData');
	var amount;

	for ( var i = 0; i < data.length; i++)
	{
		if (n == data[i].stageId) 
		{
			$("#stageOrder").val(data[i].seqOrder);
		}
	}
	
	var stageType = $("#stageId").combobox('getText');
	var payDate=$("#payDate").datebox('getValue');
	if(payDate=='')
	{
		$("#stageId").combobox('setText',"");
		$("#classType").combobox('setText',"");
		$("#totalAmount").textbox('setValue', '');
		$.messager.alert('提示', "请选择缴费时间");	
		return;
	}
	var urls = "/sys/pubData/qryData.do?param={queryCode:\"Qry_Stage_Class\",time:\""+ payDate + "\",stageId:\""+ stageType + "\",schoolId:\""+ <%=schoolId%> + "\"}";
	$("#classType").combobox(
	{
		url : urls,//返回json数据的url
		valueField : "classType",
		textField : "classType",
		panelHeight : "auto",
		onLoadSuccess : function() { //数据加载完毕事件
			var data = $('#classType').combobox('getData');
			if (data.length == 1)
			{
				$("#classType").combobox('select',data[0].classType);
				$("#totalAmount").textbox('setValue', data[0].amount);
				$("#amount").textbox('setValue', data[0].amount);
				$("#coursePriceId").val(data[0].setPriceId); 
			}
		}
	});
   }
});
 

$('#favorAmount').textbox( {
	onChange : function(value) {
		minus = $("#minusAmount").textbox('getValue');
		favorAmount = $("#favorAmount").textbox('getValue');
		totalAmount = $("#totalAmount").textbox('getValue');
		amount = totalAmount - minus - favorAmount;
		$("#amount").textbox('setValue', amount);
	}
});

initOldCourse();
function initOldCourse()
{
	var studentCourseId=$("#studentCourseId").val();
	if(studentCourseId!='')
	{
		$("#payDate").attr("readOnly",true);
		var json = '<%=courses%>';
		var courseT=eval("("+json+")");
		var stageId=courseT.stageId;
		var classType=courseT.classType;
		$("#stageId").combobox({ disabled: true});
		$("#classType").combobox({ disabled: true});
		$("#feeType").combobox({ disabled: true});
		$("#adviserA").combobox({ disabled: true});
		$("#adviserB").combobox({ disabled: true});
	}
}

var studentCourse = {};//最后提交学生课程信息
var gifts = [];
var courses = [];
var coupons = [];//使用抵扣劵
var useCoupon = "";
var wom = {};//口碑信息

var minus = 0;//抵扣金额
var favorAmount = 0;//优惠金额
var totalAmount = 0;//课程金额
var amount = 0;//实缴金额


//删除相对应的行  
function delRow(rows) {
	$(rows).parent("td").parent("tr").remove();
}

//提交
$("#submitBtn").click(function() 
{
	if($("#payDate").datebox("getValue")=="")
	{
		parent.window.showMsg("请选择缴费时间");
		return false;
	}
	
	oldCourses =getOldCourse();
	var stageId = $("#stageId").combobox("getValue");
	var stageOrder =  $("#stageOrder").val();
	var feeType = $("#feeType").combobox("getValue");
	
		for(var i=0;i<oldCourses.length;i++)
		{
			var course = oldCourses[i];
			var order = course.stageOrder;
			var courseState=course.courseState;
			var stageName =course.stageId;
			if(courseState=='003' || courseState=='004' || courseState=='005' || courseState=='006' || courseState=='007')
			{
				if(feeType=='001')//新招
				{
					if(Number(stageOrder)<=Number(order))
					{
						parent.window.showMsg("当前所报新招阶段"+stageId+"低于或同于在读阶段"+stageName+",请重新选择阶段");
						return;
					}
				}else if(feeType=='002'|| feeType=='003')
				{
					if(Number(stageOrder)<Number(order))
					{
						parent.window.showMsg("当前所报复读或升学阶段"+stageId+"低于在读阶段"+stageName+",请重新选择阶段");
						return;
					}
				}
			}
		}
	return;
	addCourseInfo();
});

$("#backBtn").click(function() {
	window.location.href = "addCourseList.jsp"
});

 //增加赠品
$("#addGiftBtn").click(function ()
{
		var giftModelTR=$("#giftModelTR").clone();
		var flag=true;
		var giftTR=$("#addGift").clone();
		giftTR.css("display",'table-row');
		giftTR.attr("val","gift");
		giftTR.find("td").each(function(n,node)
		{
			var parentType=$("#parentType").combobox('getValue');
			var giftEffDate=$("#giftEffDate").textbox('getValue');
			if(n==1)//赠品类型;	
			{
				var name=$("#parentType").combobox('getText');
				if(name=='')
				{
					parent.window.showMsg("请选择赠品类型");
					flag=false;
					return false;
				}
				$(node).html("<span>"+name+"</span>");	
				$(node).attr("parentType",parentType);
			}else if(n==3)//赠品名称;劵类ID
			{
				var giftId=$("#giftId").combobox('getValue');
				var giftName=$("#giftId").combobox('getText');
			 
				var giftType=$("#giftType").combobox("getText");
				var giftTypeVal=$("#giftType").combobox('getValue');
				
				var code=$("#giftCode").textbox('getValue');
				
				//判断是否是券类
				if(giftId=='')
				{
					parent.window.showMsg("请选择赠品名称");
					flag=false;
					return false;
				}
				
				//判断是否是券类
				if(parentType=='COUPON' && code=='')
				{
					parent.window.showMsg("请输入券类编码");
					flag=false;
					return false;
				}
			
				if(''!=code)
				{
						$(node).html("<span>"+giftType+"  "+giftName+"   "+ code +"   "+giftEffDate+"</span>");	
				}else
				{
					$(node).html("<span>"+giftName+"</span>");	
				}
				
				var datas = $('#giftType').combobox('getData');
				 
				for(var m=0;m<datas.length;m++)
				{
					if(giftTypeVal==datas[m].giftType)
					{
						 $(node).attr("effNum",datas[m].effNum);
						 $(node).attr("unit",datas[m].unit);
					}
				}
				
				var amount=""; 
				var data = $('#giftId').combobox('getData');
                if (data.length > 0)
                {
                    for(var i=0;i<data.length;i++)
                    {
                    	var giftIdT=data[i].giftId;
                    	if(giftIdT==giftId)
                    	{
                    		giftTypeVal=data[i].giftType;
                    		amount=data[i].amount;
                    	}
                    }
                }
				 
				$(node).attr("giftName",giftName);
				$(node).attr("amount",amount);
				$(node).attr("giftId",giftId);
				$(node).attr("giftType",giftTypeVal);
				$(node).attr("giftCode",code);
				$(node).attr("effDate",giftEffDate);
				
			}else if(n==5)
			{
				var getFlag = $("input[name='isGetY']:checked").val(); //是否领取
				$(node).attr("isGet","N");
				if('Y'==getFlag)
				{
					if(giftEffDate=='' &&　parentType=='COUPON')
					{
						flag=false;
						parent.window.showMsg("请填写有效期");
						return false;
					}
					$(node).html("<span>已领取</span>");	
					$(node).attr("isGet","Y");
				}else if('N'==getFlag)
				{
					$(node).html("<span>未领取</span>");	
					$(node).attr("isGet","N");
				}
				else
				{
					 parent.window.showMsg("请选择已领或者未领");
					  flag=false;
					  return false;
				}
			}else if(n==7)
			{
				var granter=$("#granter").textbox("getValue");
				if(''==granter)
				{
					  parent.window.showMsg("发放人为空");
					  flag=false;
					  return false;
				}
				$(node).html("<span>"+granter+"</span>");	
				$(node).attr("granter",granter);
			} 
			
		});
	
		if(flag)
		{
			$("#giftFm").form('clear');
			$("#addGift").after(giftTR);
			var height = $(document).height();
			var frameName=$("#frameName").val();
			$(frameName,parent.document).css("height",height);
			clearData("giftModelTR");
			$("input[name='isGetY'][value='Y']").attr("checked", "checked");
	    }
		
	
	
	});

//增加课程
$("#addCourse").click(function()
{
	var objectTr = $("#add").clone();//克隆模板
		objectTr.css("display", 'table-row');
		objectTr.attr("val", "course");
		var flag=true;
		objectTr.find("td").each(function(i, node) {
			var effDate = "";
			if (i == 0) {
				$(node).html("<span>" + (i ++) + "</span>");
				
			} else if (i == 1) {
				var name = $("#giftCourseType").combobox('getText');
				var val = $("#giftCourseType").combobox('getValue');

				var datas = $('#giftCourseType').combobox('getData');

				for ( var m = 0; m < datas.length; m++) 
				{
					if (val == datas[m].giftType) {
						$(node).attr("effNum", datas[m].effNum);
						$(node).attr("unit", datas[m].unit);
					}
				}
				if(name=='')
				{
					parent.window.showMsg("请选择赠课类型");
					flag=false;
					return false;
				}
				$(node).html("<span>" + name + "</span>");
				$(node).attr("giftCourseType", val);//赠课类型	
			} else if (i == 2) {
				var name = $("#giftCourseId").combobox('getText');
				var val = $("#giftCourseId").combobox('getValue');
				$(node).html("<span>" + name + "</span>");
				$(node).attr("giftId", val);//赠课细类	
				if(name=='')
				{
					parent.window.showMsg("请选择赠课名称");
					flag=false;
					return false;
				}
				
			} else if (i == 3) {
				var hours = $("#courseHours").html();
				$(node).html("<span>" + hours + "</span>");
				$(node).attr("hours", hours);//课时
			} else if (i == 4) {
				$(node).html("<span>" + sysDate() + "</span>");
			} else if (i == 5) {
				$(node).html("<span>未使用</span>");
			} else if (i == 6) {
				$(node).html("<span>" + afterDate(1) + "</span>");
			} else if (i == 7) {
				$(node).html("<span>" + afterYear(1) + "</span>");
			}
		});
		if(flag==true)
		{
			$("#add").after(objectTr);
			clearData("giftCourseTr");
			$("#courseHours").html("");
		}
			
		
	});


	//创建单报提交数据
	function build()
	{
		gifts=[];
		studentCourse={};                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
		$("#giftTab").find('tr').each(function(i,node)
		{
			var trName=$(this).attr("val");
			var studentGiftId=$(this).attr("studentGiftId");
 
			if('gift'==trName)
			{
				 var  tds=$(this).children('td');
			 
				 var giftName=tds.eq(3).attr("giftName");
				 var  amount=tds.eq(3).attr('amount');
				 var  effNum=tds.eq(3).attr('effNum');
				 var  unit=tds.eq(3).attr('unit');
				 var  giftId=tds.eq(3).attr('giftId');
				 var  giftType=tds.eq(3).attr('giftType');
				 var  giftCode=tds.eq(3).attr('giftCode');
				 var  isGet=tds.eq(5).attr('isGet');
				 var  granter=tds.eq(7).attr('granter');
				 var  gift = {};
				 
				 gift.studentId=$("#studentId").val();
				
				 gift.giftName=giftName;
				 gift.usableAmount=amount;
				 gift.amount=amount;
				 gift.studentGiftId=studentGiftId;
				 gift.unit = unit; 
				 gift.effNum = effNum; 
				 gift.giftType = giftType;
				 gift.giftId=giftId;
				 gift.giftCode=giftCode;
				 gift.isGet=isGet;
				 gift.granter=granter;
				 gifts.push(gift);  
			 }
		});
			  
			 
		$("#giftCourse").find('tr').each(function(i,node)
		{
			var trName=$(this).attr("val");
			var studentGiftId=$(this).attr("studentGiftId");
			if('course'==trName)
			{
				 var  tds=$(this).children('td');
				 var  giftType=tds.eq(1).attr('giftCourseType');
				 var  effNum=tds.eq(1).attr('effNum');
				 var  unit=tds.eq(1).attr('unit');
				 var  giftId=tds.eq(2).attr('giftId');
				 var  hours=tds.eq(3).attr('hours');
				
				 var  gift = {};
				 gift.studentId=$("#studentId").val();
				 gift.giftType = giftType;
				 gift.giftId=giftId;
				 gift.giftNum=hours;
				 gift.studentGiftId=studentGiftId;
				 gift.unit = unit; 
				 gift.effNum = effNum; 
				 
				 var datas = $('#giftType').combobox('getData');
				 
				for(var m=0;m<datas.length;m++)
				{
					if(giftType==datas[m].giftType)
					{
						gift.unit=datas[m].unit;
						gift.effNum=datas[m].effNum;
					}
				}
				
				 gifts.push(gift);  
			 }
		});
		
		studentCourse.gifts=gifts;
		var obj = $("#courseFm").serializeObject();
		obj.payDate=$("#payDate").datebox("getValue");
		studentCourse.course=obj;
		studentCourse.coupon=JSON.stringify(coupons); 
		var womInfo=getWom();
		studentCourse.wom=womInfo;
		return studentCourse;
	}
		
	function closeDlg()
	{
		$('#dlg').dialog('close');
		$('#useCoupon').html(useCoupon);
		$("#minusAmount").textbox('setValue',minus);
		totalAmount=$("#totalAmount").textbox('getValue');
		amount=totalAmount-minus;
		$("#amount").textbox('setValue',amount);
	}
	
	function colDis(id)
	{
		var idT="#useCoupon"+id+"";
		$(idT).css('display','none');
		for(var i=coupons.length-1;i>=0;i--)
		{
			 var coupon=coupons[i];
			 if(coupon.studentGiftId==id)
			 {
				var usableAmountT=$("#minusAmount").textbox('getValue');
				usableAmountT=usableAmountT-coupon.usableAmount;
				$("#minusAmount").textbox('setValue',usableAmountT);
				coupons.remove(i);
			 }
		}
		minus=$("#minusAmount").textbox('getValue');
		favorAmount=$("#favorAmount").textbox('getValue');
		totalAmount=$("#totalAmount").textbox('getValue');
		amount=totalAmount-minus-favorAmount;
		$("#amount").textbox('setValue',amount);
	}
	
	function minusCoupon()
	{
		$('#dlg').dialog({
			title:"使用抵扣券",
		});
		$('#dlg').attr("src","/sys/course/useCoupon.jsp?studentId="+$("#studentId").val());
		$('#dlg').dialog("open");
	}
	
	function getMinus()
	{
		return $("#minusAmount").textbox('getValue');
	}
	
	function getFavorAmount()
	{
		return $("#favorAmount").textbox('getValue');
	}
	
	function getTotalAmount()
	{
		return $("#totalAmount").textbox('getValue');
	}
	
	function getAmount()
	{
		return $("#amount").textbox('getValue');
	}
	
	function changePraise(obj)
	{
		var flag=$(obj).attr("womType");
		if(flag=="Y")
		{
			$("#praiseInfo").find("tr").each(function(index){
				if(index==1)
				{
					$(this).css("display","table-row");
				}
				else if(index>1)
				{
					$(this).css("display","none");
					
				}	
			})
			clearData("praiseTab2");
		}
		else
		{
			$("#praiseInfo").find("tr").each(function(index){
				if(index==1)
				{
					$(this).css("display","none");
				
				}
				else if(index>1)
				{
					$(this).css("display","table-row");
				}	
			})
			clearData("praiseTab1");
		}
		$("#praiseTab1").find("tr").css("display","none");
		$("#praiseSourceY").combobox("setValue"," "); 
		$("#praiseTab2").find("tr").css("display","none");
		$("#praiseSourceN").combobox("setValue"," "); 
	}
	function changeName()
	{
		var tr =$("#short").find("table").find("tr:eq(0)");
		var name =tr.find("td:eq(2)").find("select").combobox("getText");
		tr.find("td:eq(3)").find("span").html(name+"A");
		tr.find("td:eq(5)").find("span").html(name+"B");
	}
	
	function changeFeeType()
	{
		var type=$("#feeType").combobox("getValue");
		 
		if(type=='001')
		{
			$("#womDiv").css("display","block");
			$("#giftDiv").css("display","block");
			$("#adviserADiv").css("display","block");
			$("#adviserTeacherADiv").css("display","none");
			$("#adviserBDiv").css("display","block");
			$("#adviserTeacherBDiv").css("display","none");
			$("#adviserNameA").html("<span>业绩顾问A：</span>");
			$("#adviserNameB").html("<span>业绩顾问B：</span>");
		}else if(type=='002')
		{
			$("#womDiv").css("display","none");
			$("#giftDiv").css("display","block");
			$("#adviserADiv").css("display","none");
			$("#adviserTeacherADiv").css("display","block");
			$("#adviserBDiv").css("display","none");
			$("#adviserTeacherBDiv").css("display","block");
			$("#adviserNameA").html("<span>业绩老师A：</span>");
			$("#adviserNameB").html("<span>业绩老师B：</span>");
		} 
		
	}
	
	function changeCourseType()
	{
		var type=$("#courseType").combobox("getValue");
		if(type=="001")
		{
			$("#normal").css("display","block");
			$("#short").css("display","none");
			initFeeInfo()
			$("#courseType").val("001")
		}
		else if(type=="004")
		{
			$("#normal").css("display","none");
			$("#short").css("display","block");
			initFeeInfo()
		}	
	}
	
	function initFeeInfo()
	{
		var minus = 0;
		var favorAmount = 0;
		var totalAmount = 0;
		var amount = 0;
		$("#totalAmount").textbox("setValue",0);
		$("#minusAmount").textbox("setValue",0);
		$("#amount").textbox("setValue",0);
		$('#useCoupon').html("");
	}
	
	function changePraiseSourceY()
	{
		var source =$("#praiseSourceY").combobox("getValue");
		if(source=="")
		{
			$("#praiseTab1").find("tr").css("display","none");
		}
		else
		{
			$("#praiseTab1").find("tr").each(function(){
				if($(this).attr("id")!=source)
				{
					$(this).css("display","none");
				}
				else
				{
					$(this).css("display","table-row");
				}	
			})
		}	
	}
	
	
	function changePraiseSourceN()
	{
		var type=$("#praiseSourceN").combobox("getValue");
		if(type=="Stu")
		{
			$("#praiseTab2").find("tr").each(function(index){
				if(index>1)
				{
					$(this).css("display","none");
				}
				else
				{
					$(this).css("display","table-row");
				}	
			});
		}
		else if(type=="Sta")
		{
			$("#praiseTab2").find("tr").each(function(index){
				if(index>1)
				{
					$(this).css("display","table-row");
				}
				else
				{
					$(this).css("display","none");
				}	
			});
		}
		else
		{
			$("#praiseTab2").find("tr").css("display","none");
		}	
	}
	
	function getWom()
	{
		//获取口碑信息-begin
		var womType="";
		$("input[name=praise]").each(function()
		{
			if(this.checked)
			{
				womType =$(this).attr("womType");
			}
		})
		if(womType!="")
		{	
			var womChannel=womType=="Y"?$("#praiseSourceY").combobox("getValue"):$("#praiseSourceN").combobox("getValue");
			if(trim(womChannel)!="")
			{
				var womInfo ={
					womId:"",
					womType:womType,
					womChannel:womChannel,
					studentCourseId:"",
					handlerId:$("#handlerId").val()
				};
				var womItem ={
					itemId:"",
					womId:"",
					activitySchool:"",
					activityId:"",
					adviserASchool:"",
					adviserA:"",
					adviserBSchool:"",
					adviserB:"",
					teacherASchool:"",
					teacherA:"",
					teacherBSchool:"",
					teacherB:"",
					studentIdSchool:"",
					studentId:"",
					studentName:"",
					identityType:"",
					identityId:"",
					courseName:"",
					teacherIdSchool:"",
					teacherId:"",
					staffName:"",
					handlerId:$("#handlerId").val()
				};
				if(womChannel=="A")
				{
					if($("#activeId").combobox("getValue")=="")
					{
						parent.window.showMsg("请选择一个活动!");
					}
					else
					{
						womItem["activitySchool"]=$("#activeSchool").combobox("getValue");
						womItem["activityId"]=$("#activeId").combobox("getValue");
					}	
				}
				else if(womChannel=="C")
				{
					if($("#c_adviserA").combobox("getValue")==""&&$("#c_adviserB").combobox("getValue")=="")
					{
						parent.window.showMsg("请至少选择一个顾问!");
						return false;
					}
					else
					{
						womItem["adviserASchool"]=$("#c_schoolA").combobox("getValue");
						womItem["adviserA"]=$("#c_adviserA").combobox("getValue");
						womItem["adviserBSchool"]=$("#c_schoolB").combobox("getValue");
						womItem["adviserB"]=$("#c_adviserB").combobox("getValue");
					}	
				}
				else if(womChannel=="T")
				{
					if($("#c_teacherA").combobox("getValue")==""&&$("#c_teacherB").combobox("getValue")=="")
					{
						parent.window.showMsg("请至少选择一个顾问!");
						return false;
					}
					else
					{
						womItem["teacherASchool"]=$("#c_schoolsA").combobox("getValue");
						womItem["teacherA"]=$("#c_teacherA").combobox("getValue");
						womItem["teacherBSchool"]=$("#c_schoolsB").combobox("getValue");
						womItem["teacherB"]=$("#c_teacherB").combobox("getValue");
						var tr =$("#praiseTab1").find("tr:eq(3)");
						if(tr.attr("studentId")!=null)
						{
							womItem["studentId"]=tr.attr("studentId");
							womItem["studentIdSchool"]=tr.attr("studentSchoolId");
							womItem["studentName"]=tr.find("td:eq(1)").find("span").html();
							womItem["identityType"]=tr.attr("identityType");
							womItem["identityId"]=tr.find("td:eq(3)").find("span").html();
							womItem["className"]=tr.find("td:eq(5)").find("span").html();
						}	
					}	
				}
				else if(womChannel=="Stu")
				{
					var tr1=$("#praiseTab2").find("tr:eq(0)");
					if(tr1.attr("studentId")==null)
					{
						parent.window.showMsg("请选择一个学员!");
						return false;
					}
					else
					{
						womItem["studentId"]=tr1.attr("studentId");
						womItem["studentIdSchool"]=tr1.attr("studentSchoolId");
						womItem["studentName"]=tr1.find("td:eq(1)").find(".easyui-textbox").textbox("getValue");
						womItem["identityType"]=tr1.find("td:eq(3)").find(".easyui-combobox").combobox("getValue");
						womItem["identityId"]=tr1.find("td:eq(3)").find(".easyui-textbox").textbox("getValue");
						var tr2 =$("#praiseTab2").find("tr:eq(1)");
						womItem["className"]=tr2.find("td:eq(1)").find(".easyui-textbox").textbox("getValue");
						womItem["teacherIdSchool"]=tr2.find("td:eq(3)").find(".easyui-combobox.school").combobox("getValue");
						womItem["teacherId"]=tr2.find("td:eq(3)").find(".easyui-combobox.teacher").combobox("getValue");
						
					}	
						
				}
				else if(womChannel=="Sta")
				{
					if($("#womStaffName").textbox("getValue")!="")
					{
						womItem["staffName"]=$("#womStaffName").textbox("getValue");
					}
					else
					{
						parent.window.showMsg("请填写员工姓名 !");
						return false;
					}	
				}	
				wom["info"]=womInfo;
				wom["item"]=womItem;
			}	
		}
		 return womInfo;
	}
	
	
	function searchStudent()
	{
		$('#dlg').dialog({
			title:"学员检索",
		});
		$('#dlg').attr("src","/sys/course/searchStudent.jsp?callBackFn=searchStudentInfo");
		$('#dlg').dialog("open");
	}
	
	function searchStudentInfo(obj)
	{
		obj =eval("("+obj+")");
		var tr1 =$("#praiseTab2").find("tr:eq(0)");
		tr1.find("td:eq(1)").find(".easyui-textbox").textbox("setValue",obj.name);
		tr1.find("td:eq(3)").find(".easyui-combobox").combobox("setValue",obj.identityType);
		tr1.find("td:eq(3)").find(".easyui-textbox").textbox("setValue",obj.identityId);
		var tr2 =$("#praiseTab2").find("tr:eq(1)");
		tr2.find("td:eq(1)").find(".easyui-textbox").textbox("setValue",obj.className);
		tr1.attr("studentId",obj.studentId);
		tr1.attr("studentSchoolId",obj.schoolId);
		$('#dlg').attr("src","");
		$('#dlg').dialog("close");
	}
	
	
	function qryStudent()
	{
		$('#dlg').dialog({
			title:"查询学生",
		});
		$('#dlg').attr("src","/sys/course/searchStudent.jsp?callBackFn=qryStudentInfo");
		$('#dlg').dialog("open");
	}
	
	function qryStudentInfo(obj)
	{
		obj =eval("("+obj+")");
		var tr =$("#praiseTab1").find("tr:eq(3)");
		tr.find("td:eq(1)").html("<span>"+obj.name+"</span>");
		tr.find("td:eq(3)").html("<span>"+obj.identityId+"</span>");
		tr.find("td:eq(5)").html("<span>"+obj.className+"</span>");
		tr.attr("identityType",obj.identityType);
		tr.attr("studentId",obj.studentId);
		tr.attr("studentSchoolId",obj.schoolId);
		$('#dlg').attr("src","");
		$('#dlg').dialog("close");
	}
	
	$("#c_schoolA").combobox({
		onChange:function(){
			var sId =$("#c_schoolA").combobox("getValue");
			var urls ="<%=path %>/pubData/qryTeacherList.do?schoolId="+sId;
			$("#c_adviserA").combobox({
				url:urls
			});
		}
	})
	
	$("#c_schoolB").combobox({
		onChange:function(){
			var sId =$("#c_schoolB").combobox("getValue");
			var urls ="<%=path %>/pubData/qryTeacherList.do?schoolId="+sId;
			$("#c_adviserB").combobox({
				url:urls
			});
		}
	})
	
	$("#c_schoolsA").combobox({
		onChange:function(){
			var sId =$("#c_schoolsA").combobox("getValue");
			var urls ="<%=path %>/pubData/qryTeacherList.do?schoolId="+sId;
			$("#c_teacherA").combobox({
				url:urls
			});
		}
	})
	
	$("#c_schoolsB").combobox({
		onChange:function(){
			var sId =$("#c_schoolsB").combobox("getValue");
			var urls ="<%=path %>/pubData/qryTeacherList.do?schoolId="+sId;
			$("#c_teacherB").combobox({
				url:urls
			});
		}
	})
	
	$("#t_teacher_school").combobox({
		onChange:function(){
			var sId =$("#t_teacher_school").combobox("getValue");
			var urls ="<%=path %>/pubData/qryTeacherList.do?schoolId="+sId;
			$("#t_teacher_id").combobox({
				url:urls
			});
		}
	})
	
	$("#s_schooldA").combobox({
		onChange:function(){
			var sId =$("#s_schooldA").combobox("getValue");
			var urls ="<%=path %>/pubData/qryTeacherList.do?schoolId="+sId;
			$("#s_teacherA").combobox({
				url:urls
			});
		}
	})
	
	$("#s_schooldB").combobox({
		onChange:function(){
			var sId =$("#s_schooldB").combobox("getValue");
			var urls ="<%=path %>/pubData/qryTeacherList.do?schoolId="+sId;
			$("#s_teacherB").combobox({
				url:urls
			});
		}
	})
	
	
	</script>

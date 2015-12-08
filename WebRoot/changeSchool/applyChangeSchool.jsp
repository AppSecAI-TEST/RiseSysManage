<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String byName = request.getParameter("byName");
	String schoolId = request.getParameter("schoolId");
	String studentId = request.getParameter("studentId");
	String schoolName = request.getParameter("schoolName");
	String classInstId = request.getParameter("classInstId");
	String studentCourseId = request.getParameter("studentCourseId");
	String currentClassName = request.getParameter("currentClassName");
	String adviserTeacherName = request.getParameter("adviserTeacherName");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/changeSchool/applyChange.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:98%;height:auto;" title="转校申请">
	  		<div style="margin-right: 150px; margin-bottom: 5px; margin-top: 5px; text-align: right;">
		  		<a href="javascript:void(0)" onclick="viewChangeSchoolHist()" class="easyui-linkbutton" iconCls="icon-redo" style="width: 120px;">查看转校历史</a>
	  		</div>
  			<form id="applyChangeSchoolFm" method="post" enctype="multipart/form-data">
  				<input type="hidden" id="applyType" name="applyType" value="002"/>
  				<input type="hidden" id="schoolId" name="schoolId" value="<%=schoolId %>"/>
  				<input type="hidden" id="studentId" name="studentId" value="<%=studentId %>"/>
  				<input type="hidden" id="outSchoolId" name="outSchoolId" value="<%=schoolId %>"/>
  				<input type="hidden" id="outClassId" name="outClassId" value="<%=classInstId %>"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="studentCourseId" name="studentCourseId" value="<%=studentCourseId %>"/>
  				<div class="easyui-panel" style="min-width:1100px; width:100%; height:auto;" title="学员信息">
		  			<table width="100%" cellpadding="5px" class="maintable" id="applyChangeClassTd">
		  				<tr>
		  					<td align="right" width="10%"><span>校区：</span></td>
		  					<td width="20%"><span id="schoolNameText"><%=schoolName %></span></td>
		  					<td align="right" width="10%"><span>学员姓名：</span></td>
		  					<td width="25%"><span id="nameText"><%=name %></span></td>
		  					<td align="right" width="10%"><span>英文名：</span></td>
		  					<td width="25%"><span id="byNameText"><%=byName %></span></td>
		  				</tr>
		  				<tr>
		  					<td align="right" width="10%"><span>联系电话：</span></td>
		  					<td width="20%"><span id="phoneText"><%=phone %></span></td>
		  					<td align="right" width="10%"><span>带班老师：</span></td>
		  					<td width="25%"><span id="nameText"><%=adviserTeacherName %></span></td>
		  					<td align="right" width="10%"><span>在读班级：</span></td>
		  					<td width="25%">
		  						<span id="byNameText"><%=currentClassName %></span>
		  					</td>
		  				</tr>
		  				<tr id="courseTr">
		  					<td colspan="6">
			  					<table class="easyui-datagrid" title="常规课信息" style="height:auto;" id="course_list_data"
							  		pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
									<thead>
										<tr>
											<th data-options="field:'stageId',width:100,align:'center'">课程阶段</th>
											<th data-options="field:'courseStateText',width:100,align:'center'">课程状态</th>
											<th data-options="field:'paySchoolName',width:100,align:'center'">校区</th>
											<th data-options="field:'payDate',width:120,align:'center'">缴费日期</th>
											<th data-options="field:'feeTypeText',width:100,align:'center'">业绩类型</th>
											<th data-options="field:'className',width:100,align:'center'">班级</th>
											<th data-options="field:'startDate',width:120,align:'center'">开课日期</th>
											<th data-options="field:'finishDate',width:120,align:'center'">结课日期</th>
											<th data-options="field:'classProgress',width:100,align:'center'">课时进度</th>
											<th data-options="field:'classTeacherName',width:100,align:'center'">带班老师</th>
											<th data-options="field:'adviserName',width:100,align:'center'">业绩顾问</th>
											<th data-options="field:'adviserTeacherName',width:100,align:'center'">业绩老师</th>
											<th data-options="field:'dutyAdvisterName',width:100,align:'center'">责任顾问</th>
											<th data-options="field:'carerName',width:100,align:'center'">客户关怀</th>
										</tr>
									</thead>
								</table>
		  					</td>
		  				</tr>
		  				<tr id="internationalTr">
		  					<td colspan="6">
		  						<table class="easyui-datagrid" title="短期课-国际班信息" style="height:auto;" id="international_list_data"
									pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
									<thead>
										<tr>
											<tr>
												<th data-options="field:'classType',width:100,align:'center'">国际班类型</th>
												<th data-options="field:'paySchoolName',width:100,align:'center'">报名校区</th>
												<th data-options="field:'schoolName',width:100,align:'center'">上课校区</th>
												<th data-options="field:'payDate',width:120,align:'center'">缴费日期</th>
												<th data-options="field:'courseStateText',width:100,align:'center'">课程状态</th>
												<th data-options="field:'className',width:100,align:'center'">班级</th>
												<th data-options="field:'openDate',width:120,align:'center'">开课日期</th>
												<th data-options="field:'finishDate',width:120,align:'center'">结课日期</th>
												<th data-options="field:'classProgress',width:100,align:'center'">课时进度</th>
												<th data-options="field:'adviserTeacherName',width:100,align:'center'">业绩老师</th>
												<th data-options="field:'adviserName',width:100,align:'center'">业绩顾问</th>
											</tr>
										</tr>
									</thead>
								</table>
		  					</td>
		  				</tr>
		  				<tr id="travelTr">
		  					<td colspan="6">
		  						<table class="easyui-datagrid" title="短期课-游学信息" style="height:auto;" id="travel_list_data"
									pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
									<thead>
										<tr>
											<th data-options="field:'classType',width:100,align:'center'">游学班类型</th>
											<th data-options="field:'className',width:100,align:'center'">班级</th>
											<th data-options="field:'paySchoolName',width:100,align:'center'">报名校区</th>
											<th data-options="field:'payDate',width:100,align:'center'">缴费日期</th>
											<th data-options="field:'courseStateText',width:120,align:'center'">课程状态</th>
											<th data-options="field:'openDate',width:100,align:'center'">出发日期</th>
											<th data-options="field:'finishDate',width:100,align:'center'">返回日期</th>
											<th data-options="field:'adviserTeacherName',width:120,align:'center'">业绩老师</th>
											<th data-options="field:'adviserName',width:120,align:'center'">业绩顾问</th>
										</tr>
									</thead>
								</table>
		  					</td>
		  				</tr>
		  				<tr id="giftTr">
		  					<td colspan="6">
		  						<table class="easyui-datagrid" title="赠送课信息" style="height:auto;" id="gift_list_data"
									pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
									<thead>
										<tr>
											<th data-options="field:'giftChannelDesc',width:100,align:'center'">赠课来源</th>
											<th data-options="field:'giftName',width:100,align:'center'">赠课名称</th>
											<th data-options="field:'createDate',width:100,align:'center'">赠送日期</th>
											<th data-options="field:'giftNum',width:100,align:'center'">赠送课时量</th>
											<th data-options="field:'giftStateText',width:100,align:'center'">课程状态</th>
											<th data-options="field:'effDate',width:100,align:'center'">有效期开始日期</th>
											<th data-options="field:'expDate',width:100,align:'center'">有效期结束日期</th>
											<th data-options="field:'granter',width:100,align:'center'">课时进度</th>
										</tr>
									</thead>
								</table>
		  					</td>
		  				</tr>
		  				<tr>
	  						<td align="right" width="10%"><span>申请转入：</span></td>
	  						<td colspan="5" width="90%">
	  							<select id="inSchoolId" name="inSchoolId" class="easyui-combobox" style="width: 200px; height: 25px;" required="true" 
									data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
					      			onLoadSuccess:function(data){if(data.length > 0) $('#inSchoolId').combobox('setValue',data[0].schoolId);}"
					      			url="<%=path %>/pubData/qrySchoolList.do">
					        	</select>
	  						</td>
  						</tr>
	  					<tr>
	  						<td align="right" width="10%"><span>上传转校申请单：</span></td>
	  						<td colspan="5" width="90%">
	  							<input type="hidden" name="imgUrl" id="imgUrl"/>
	                        	<input style="width: 500px; height: 28px;" class="easyui-filebox" name="fileName" id="fileName" data-options="prompt:''"/>
	                        	<a href="javascript:void(0)" class="easyui-linkbutton" id="uploadBtn" iconCls="icon-save" iconCls="icon-save" style="width: 80px; height: 28px;">上传</a>
	                        	<a href="javascript:void(0)" class="easyui-linkbutton" id="cancelUploadBtn" iconCls="icon-cancel" iconCls="icon-cancel" style="width: 80px; height: 28px;">取消</a>
	  						</td>
	  					</tr>
	  					<tr>
	  						<td align="right" width="10%"><span>转校情况说明：</span></td>
	  						<td colspan="5" width="90%">
	  							<textarea rows="6" cols="122" id="remark" name="remark" class="easyui-validatebox textbox"></textarea>
	  						</td>
	  					</tr>
		  			</table>
  				</div>
  			</form>
  		</div>
  		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: left;margin-left: 800px;">
	      		<a href="javascript:void(0)" id="applyChangeSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>

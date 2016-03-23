<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String byName = request.getParameter("byName");
	String applyId = request.getParameter("applyId");
	String studentId = request.getParameter("studentId"); 
	String outClassId = request.getParameter("outClassId");
	String courseState = request.getParameter("courseState");
	String outClassName = request.getParameter("outClassName");
	String outSchoolName = request.getParameter("outSchoolName");
	String oldCourseState = request.getParameter("oldCourseState");
	String studentCourseId = request.getParameter("studentCourseId");
	String outClassTeacherName = request.getParameter("outClassTeacherName");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/changeSchool/cancelChange.js"></script>
  	</head>
  
  	<body>
		<div class="easyui-panel" style="min-width:1100px; width:98%;height:auto;" title="取消转校">
			<form id="calcenChangeSchoolFm">
				<input type="hidden" id="applyId" name="applyId" value="<%=applyId %>"/>
				<input type="hidden" id="studentId" name="studentId" value="<%=studentId %>"/>
				<input type="hidden" id="outClassId" name="outClassId" value="<%=outClassId %>"/>
				<input type="hidden" id="courseState" name="courseState" value="<%=courseState %>"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
				<input type="hidden" id="oldCourseState" name="oldCourseState" value="<%=oldCourseState %>"/>
  				<input type="hidden" id="studentCourseId" name="studentCourseId" value="<%=studentCourseId %>"/>
				<div class="easyui-panel" style="min-width:1100px; width:100%; height:auto;" title="学员信息">
					<table width="100%" cellpadding="5px" class="maintable" id="calcenChangeSchoolTd">
						<tr>
		  					<td align="right" width="10%"><span>校区：</span></td>
		  					<td width="20%"><span id="schoolNameText"><%=outSchoolName %></span></td>
		  					<td align="right" width="10%"><span>学员姓名：</span></td>
		  					<td width="25%"><span id="nameText"><%=name %></span></td>
		  					<td align="right" width="10%"><span>英文名：</span></td>
		  					<td width="25%"><span id="byNameText"><%=byName %></span></td>
		  				</tr>
		  				<tr>
		  					<td align="right" width="10%"><span>联系电话：</span></td>
		  					<td width="20%"><span id="phoneText"><%=phone %></span></td>
		  					<td align="right" width="10%"><span>带班老师：</span></td>
		  					<td width="25%"><span id="nameText"><%=outClassTeacherName %></span></td>
		  					<td align="right" width="10%"><span>在读班级：</span></td>
		  					<td width="25%"><span id="byNameText"><%=outClassName %></span></td>
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
		  						<table class="easyui-datagrid" title="赠送课信息" style="height:auto;" id="gift_list_data">
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
		  					<td colspan="6">
		  						<div class="easyui-panel" style="min-width:1100px; width:100%; height:auto;" title="申请信息">
			  						<table width="100%" cellpadding="5px" class="maintable">
			  							<tr>
					  						<td align="center" width="10%"><span>申请人</span></td>
			  								<td align="center" width="15%"><span>申请时间</span></td>
					  						<td align="center" width="15%"><span>申请转入校区</span></td>
					  						<td width="60%">
					  							<span>转校情况说明</span>
					  							<span style="display: none; width: 100px; margin-left: 250px;" id="imgUrl">
  													<a href="#" id="url" class="linkmore">查看转校申请单</a>
  												</span>
  												<a href="javascript:void(0)" id="viewChangeSchoolList" class="easyui-linkbutton" iconCls="icon-redo" style="width: 120px; margin-left: 50px;">查看转校历史</a>
					  						</td>
			  							</tr>
			  							<tr>
					  						<td align="center" width="10%"><span id="applyNameText"></span></td>
					  						<td align="center" width="15%"><span id="applyDateText"></span></td>
					  						<td align="center" width="15%"><span id="inSchoolNameText"></span></td>
					  						<td width="60%"><span id="applyRemark"></span></td>
			  							</tr>
			  						</table>
		  						</div>
		  					</td>
		  				</tr>
		  				<tr>
		  					<td colspan="6">
		  						<div class="easyui-panel" style="min-width:1100px; width:100%; height:auto;" title="转校审批信息">
			  						<table width="100%" cellpadding="5px" class="maintable">
			  							<tr>
					  						<td align="center" width="10%"><span>审批人</span></td>
			  								<td align="center" width="15%"><span>审批时间</span></td>
					  						<td align="center" width="15%"><span>审批意见</span></td>
					  						<td width="60%"><span>审批情况说明</span></td>
			  							</tr>
			  							<tr>
					  						<td align="center" width="10%"><span id="approveNameText"></span></td>
					  						<td align="center" width="15%"><span id="approveDateText"></span></td>
					  						<td align="center" width="15%"><span id="approveTypeText"></span></td>
					  						<td width="60%"><span id="approveRemark"></span></td>
			  							</tr>
			  						</table>
		  						</div>
		  					</td>
		  				</tr>
		  				<tr>
		  					<td colspan="6">
		  						<div class="easyui-panel" style="min-width:1100px; width:100%; height:auto;" title="转校信息">
			  						<table width="100%" cellpadding="5px" class="maintable">
			  							<tr>
			  								<td align="center" width="10%"><span>是否转出原校区</span></td>
					  						<td align="center" width="15%"><span>转出时间</span></td>
					  						<td align="center" width="15%"><span>是否转入班级</span></td>
					  						<td width="60%"><span>转入时间</span></td>
			  							</tr>
			  							<tr>
					  						<td align="center" width="10%"><span id="isOutText"></span></td>
					  						<td align="center" width="15%"><span id="outDateText"></span></td>
					  						<td align="center" width="15%"><span id="isInText"></span></td>
					  						<td width="60%"><span id="inDateText"></span></td>
			  							</tr>
			  						</table>
		  						</div>
		  					</td>
		  				</tr>
		  				<tr>
	  						<td align="right" width="10%"><span>取消转校原因：</span></td>
		  					<td width="90%" colspan="5">
			  					<textarea rows="6" cols="122" id="remark" name="remark" class="easyui-validatebox textbox"></textarea>
			  				</td>
	  					</tr>
					</table>
				</div>
			</form>
		</div>
		<div style="margin-top: 25px;min-width:1100px; width:99%;text-align: right">
	      	<a href="javascript:void(0)" id="cancelChangeSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      	&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	   </div>
  	</body>
</html>

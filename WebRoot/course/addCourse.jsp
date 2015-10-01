<%@ page language="java" import="java.util.*,net.sf.json.*"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="com.rise.pub.util.*"%>
<%
	String path = request.getContextPath();
	String studentId = request.getParameter("studentId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<%@ include file="../common/head.jsp"%>
		<%@ include file="../common/formvalidator.jsp"%>
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
		<div class="easyui-panel" style="width: 1200px" title="学员基础信息">
			<form id="studentFm">
				<input type="hidden" id="studentId" name="studentId" value="<%=studentId%>">
				<input type="hidden" id="handlerId" name="handlerId"
					value="${sessionScope.StaffT.staffId}" />
				<input type="hidden" id="schoolId" name="schoolId"
					value="${sessionScope.StaffT.schoolId}" />
				<table width="100%" cellpadding="5px" class="maintable"
					id="stuBaseInfo">
					<tr>
						<td width="13%" align="right">
							<span style="color: red;">*</span>
							<span>学员姓名：</span>
						</td>
						<td width="25%">
							<span></span>
						</td>
						<td width="13%" align="right">
							<span>出生日期：</span>
						</td>
						<td width="15%">
							<span></span>
						</td>
						<td align="right">
							<span>证件号码：</span>
						</td>
						<td>
							<span></span>
						</td>
					</tr>
					<tr>
						<td align="right">
							<span>性别：</span>
						</td>
						<td><span><span></td>
						<td align="right">
							<span>缴费时间：</span>
						</td>
						<td>
							<input name="payDate" id="payDate" type="text"
								class="easyui-datebox" required="true"
								style="width: 200px; height: 28px;" />
						</td>
						<td align="right">
							<span>课程类型：</span>
						</td>
						<td>
							<select name="courseTypeName"
								data-options="onChange:changeCourseType" class="easyui-combobox"
								id="courseTypeName" style="width: 150px; height: 28px;">
								<option value="normal">
									常规课
								</option>
								<option value="short">
									短期课
								</option>
							</select>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div style="height: 10px;"></div>
		<form id="courseFm">
			<div id="normal">
				<div class="easyui-panel" style="width: 1200px; height: auto;"
					title="常规课课程">

					<table width="100%" cellpadding="5px" class="maintable">
						<tr>
							<input id="studentId" name="studentId" type="hidden" value="2" />
							<input id="courseType" name="courseType" type="hidden"
								value="001" />
							<input id="advisterType" name="adviserType" type="hidden"
								value="teacher" />
							<input id="courseState" name="courseState" type="hidden"
								value="001" />
							<input id="feeType" name="feeType" type="hidden" value="001" />
							<input id="feeState" name="feeState" type="hidden" value="00A" />
							<td align="right">
								<span>阶段：</span>
							</td>
							<td>
								<select name="stageId" id="stageId" class="easyui-combobox"
									style="width: 150px; height: 28px;"
									data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'"
									url="<%=path%>/pubData/qryData.do?param={'queryCode':'Qry_Set_Price','setPriceId':'10001'}"
									required="true">
								</select>
							</td>
							<td align="right">
								<span>班级类型：</span>
							</td>
							<td>
								<select name="classType" class="easyui-combobox" id="classType"
									style="width: 150px; height: 28px;" drequired="true">
									<option>
										请先选择阶段
									</option>
								</select>
							</td>
							<td align="right">
								<span>缴费时间：</span>
							</td>
							<td>
								<input name="payDate" id="payDate" type="text"
									class="easyui-datebox" required="true"
									style="width: 200px; height: 28px;" />
							</td>
						</tr>
						<tr>
							<td align="right">
								<DIV id="u170_state0" data-label="状态1">
									<DIV id="u170_state0_content">
										<span>业绩老师A：</span>
							</td>
							<td>
								<select name="adviserA" class="easyui-combobox" id="adviserA"
									style="width: 150px; height: 28px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
									url="<%=path%>/pubData/qryCodeNameList.do?tableName=REAL_SCHOOL_T&codeType=SCHOOL_TYPE"
									required="true">
								</select>
							</td>
							<td align="right">
								<span>业绩老师B：</span>
							</td>
							<td>
								<select name="adviserB" class="easyui-combobox" id="adviserB"
									style="width: 150px; height: 28px;"
									data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
									url="<%=path%>/pubData/qrySchoolList.do?schoolId=">
								</select>
							</td>
							<td align="right"></td>
							<td></td>
						</tr>
					</table>
				</div>
				<div style="height: 10px;"></div>
				<div class="easyui-panel" style="width: 1200px; height: auto;"
					title="赠品信息">

					<table width="100%" cellpadding="5px" class="maintable"
						id="giftTab">
						<tr id="giftModelTR">
							<td width="8%" align="right">
								<span>赠品类型：</span>
							</td>
							<td width="8%">
								<select class="easyui-combobox" id="parentType"
									style="width: 100px; height: 28px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
									url="<%=path%>/pubData/qryCodeNameList.do?tableName=GIFT_TYPE_T&codeType=PARENT_TYPE"
									required="true">
								</select>
							</td>
							<td width="7%" align="right">
								<span>赠品名称：</span>
							</td>
							<td width="39%">
								<table border="0">
									<tr>
										<td id='td0'>
											<select class="easyui-combobox" id="giftType"
												style="width: 120px; height: 28px;"></select>
										</td>
										<td id="td1" style="display: none">
											<select class="easyui-combobox" id="giftId"
												style="width: 120px; height: 28px;"></select>
										</td>
										<td id="td2" style="display: none">
											<input id="giftCode" type="text"
												class="easyui-textbox validatebox" required="true"
												style="width: 150px; height: 28px;" />
										</td>
										<td id="td3" style="display: none">
											<input id="giftEffDate" type="text" class="easyui-datebox"
												required="true" style="width: 100px; height: 28px;" />
										</td>
									</tr>
								</table>
							</td>
							<td width="7%" align="right">
								<span>是否领用：</span>
							</td>
							<td width="7%" align="left">
								<input type="radio" name="isGetY" id="isGetY" value="Y">
								<label for="radio">
									<span>已领用</span>
								</label>
								<input type="radio" name="isGetN" id="isGetN" value="N">
								<label for="radio">
									<span>未领用</span>
								</label>
							</td>
							<td width="6%" align="right">
								<span>发放人：</span>
							</td>
							<td width="8%">
								<input id="granter" type="text"
									class="easyui-textbox validatebox" required="true"
									style="width: 100px; height: 28px;" />
							</td>
							<td width="4%">
								<span>是否退回</span>
							</td>
							<td width="6%">
								<a href="javascript:void(0)" id="addGiftBtn"
									class="easyui-linkbutton" iconCls="icon-add"
									style="width: 80px; height: 28px;">添加</a>
							</td>
						</tr>
						<tr style="display: none;" name="addGift" id="addGift">
							<td align="right">
								<span>赠品类型：</span>
							</td>
							<td align="left" parentType="">
								&nbsp;
							</td>
							<td align="right">
								<span>赠品名称：</span>
							</td>
							<td align="left" giftType="" giftId="">
								&nbsp;
							</td>
							<td align="right">
								<span>是否领用：</span>
							</td>
							<td align="left" isGet="">
								&nbsp;
							</td>
							<td align="right">
								<span>发放人：</span>
							</td>
							<td align="left" granter="">
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								<a href='javascript:void(0)' class='linkmore'
									onclick='delRow(this)'><span>删除</span>
								</a>
							</td>
						</tr>
					</table>
				</div>

				<div style="height: 10px;"></div>
				<div class="easyui-panel" style="width: 1200px; height: auto;"
					title="赠课信息">
					<table width="100%" cellpadding="5px" class="maintable">
						<tr>
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
									style="width: 120px; height: 28px;" required="true">
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
							<td val="">
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
									onclick='delRow(this)'><span>删除</span>
								</a>
							</td>
						</tr>
					</table>
				</div>

				<div style="height: 10px;"></div>
				<div class="easyui-panel" style="width: 1200px; height: auto;"
					title="口碑信息">
					<table width="100%" cellpadding="5px" id="praiseInfo"
						class="maintable">
						<tr>
							<td align="right" width="120px;">
								<span>口碑类型：</span>
							</td>
							<td colspan="9" align="left">
								<input type="radio" checked="true" name="praise"
									onclick="changePraise('Y')">
								<span>可控口碑</span>&nbsp;&nbsp;&nbsp;
								<input type="radio" name="praise" onclick="changePraise('N')">
								<span>不可控口碑</span>
							</td>
						</tr>
						<tr>
							<td align="right">
								<span>口碑来源：</span>
							</td>
							<td align="center" width="170px">
								<select name="praiseSelect" class="easyui-combobox"
									data-options="onChange:changePraiseSource" id="praiseSelect"
									style="width: 150px; height: 28px;">
									<option value=""></option>
									<option value="activity">
										活动邀约
									</option>
									<option value="ccIntroduce">
										CC转介绍
									</option>
									<option value="teacherInstroduce">
										老师转介绍
									</option>
								</select>
							</td>
							<td colspan="8">
								<table width="100%" class="praiseTab" id="praiseTab1">
									<tr id="activity" style="display: none;">
										<td align="left" colspan="8">
											<span>活动名称：</span>
											<select class="easyui-combobox" id="activeName"
												style="width: 150px; height: 28px;">
												<option value="all">
													所有
												</option>
												<option value="all">
													武展
												</option>
												<option value="all">
													总部
												</option>
											</select>
											<select class="easyui-combobox" id="activeDetail"
												style="width: 150px; height: 28px;">
												<option value="">
													活动1
												</option>
												<option value="">
													活动2
												</option>
												<option value="">
													活动3
												</option>
											</select>
										</td>
									</tr>
									<tr id="ccIntroduce" style="display: none;">
										<td align="left" colspan="8">
											<span>口碑顾问A：</span>
											<select class="easyui-combobox" id="schoolA"
												style="width: 150px; height: 28px;">
												<option value="">
													所有
												</option>
												<option value="">
													武展
												</option>
												<option value="">
													徐东
												</option>
												</select>
													<select class="easyui-combobox" id="adviserA"
														style="width: 120px; height: 28px;">
														<option value="">
															顾问1
														</option>
														<option value="">
															顾问2
														</option>
														<option value="">
															顾问3
														</option>
														</select>
															<span>口碑顾问B：</span>
															<select class="easyui-combobox" id="schoolB"
																style="width: 150px; height: 28px;">
																<option value="">
																	所有
																</option>
																<option value="">
																	武展
																</option>
																<option value="">
																	徐东
																</option>
																</select>
																	<select class="easyui-combobox" id="adviserB"
																		style="width: 120px; height: 28px;">
																		<option value="">
																			顾问1
																		</option>
																		<option value="">
																			顾问2
																		</option>
																		<option value="">
																			顾问3
																		</option>
																		</select>
										</td>
									</tr>
									<tr id="teacherInstroduce" style="display: none;">
										<td colspan="8">
											<span>口碑顾问A：</span>
											<select class="easyui-combobox" id="schoolsA"
												style="width: 120px; height: 28px;">
												<option value="">
													所有
												</option>
												<option value="">
													武展
												</option>
												<option value="">
													徐东
												</option>
												</select>
													<select class="easyui-combobox" id="teacherA"
														style="width: 120px; height: 28px;">
														<option value="">
															顾问1
														</option>
														<option value="">
															顾问2
														</option>
														<option value="">
															顾问3
														</option>
														</select>
															<span>口碑顾问B：</span>
															<select class="easyui-combobox" id="schoolsB"
																style="width: 120px; height: 28px;">
																<option value="">
																	所有
																</option>
																<option value="">
																	武展
																</option>
																<option value="">
																	徐东
																</option>
																</select>
																	<select class="easyui-combobox" id="teacherB"
																		style="width: 120px; height: 28px;">
																		<option value="">
																			顾问1
																		</option>
																		<option value="">
																			顾问2
																		</option>
																		<option value="">
																			顾问3
																		</option>
																		</select>
																			<a href="javascript:void(0)" id="qryStudent"
																				style="width: 80px" class="easyui-linkbutton"
																				iconCls="icon-add" plain="true">查询学生</a>
																			<a href="javascript:void(0)" id="recordGifts"
																				style="width: 80px" class="easyui-linkbutton"
																				iconCls="icon-add" plain="true">录入赠品</a>
										</td>
									</tr>
									<tr id="teacherInstroduce" style="display: none;">
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
							<td align="right"><span>不可控口碑类型：</span></td>
							<td align="left" width="170px">
								<select name="praiseType" class="easyui-combobox"
									data-options="onChange:changePraiseType" id="praiseType"
									style="width: 150px; height: 28px;">
									<option value="">请选择</option>
									<option value="stuIntroduce">
										学员转介绍
									</option>
									<option value="staffInstroduce">
										员工转介绍
									</option>
								</select>
							</td>	
							<td colspan="8">
								<table width="100%" class="praiseTab" id="praiseTab2">
									<tr style="display:none;">
										<td align="right" width="130px" style="border-right: 1px solid #ccc;"><span>学员姓名：</span></td>
										<td align="center" style="border-right: 1px solid #ccc;"><input type="text" class="easyui-textbox" style="width: 150px"></td>
										<td align="right" width="100px" style="border-right: 1px solid #ccc;">
											<span>证件：</span>
										</td>
										<td align="center">	
											<select class="easyui-combobox"
												style="width: 100px; height: 28px;">
												<option value="">
													身份证
												</option>
												<option value="">
														护照
													</option>
											<select>
											<input type="text" class="easyui-textbox" style="width: 150px">
										</td>
									</tr>
									<tr style="display:none;">	
										<td align="right" style="border-top:1px solid #ccc;border-right: 1px solid #ccc;"><span>班级：</span></td>
										<td align="center" style="border-top:1px solid #ccc;border-right: 1px solid #ccc;"><input type="text" class="easyui-textbox" style="width: 150px"></td>
										<td align="right" style="border-top:1px solid #ccc;border-right: 1px solid #ccc;">
											<span>转介绍老师:</span>
										</td>
										<td align="center" style="border-top:1px solid #ccc;border-right: 1px solid #ccc;">	
											<select class="easyui-combobox"
												style="width: 100px; height: 28px;">
												<option value="">
													选择校区
												</option>
												<select>
											<select class="easyui-combobox"
												style="width: 150px; height: 28px;">
												<option value="">
													选择老师
												</option>
											<select>
										</td>
										<td align="left"  style="border-top:1px solid #ccc;">
											<a href="javascript:void(0)" id="searchStudent"
											style="width: 150px" class="easyui-linkbutton"
											iconCls="icon-add" plain="true"><span>学员检索</span>
										</td>
									</tr>
									<tr style="display:none;">
										<td width="130px" align="right" style="border-right: 1px solid #ccc;"><span>转介绍员工姓名：</span></td>
										<td align="left"><input type="text" class="easyui-textbox" style="width: 150px"></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div id="short" style="display: none;">
				<div class="easyui-panel" style="width: 1200px; height: auto;"
					title="短期课课程">
					<table width="100%" cellpadding="5px" class="maintable">
						<tr>
							<td align="right">
								<span>短期课类型：</span>
							</td>
							<td align="left">
								<select class="easyui-combobox"
									style="width: 100px; height: 28px;">
									<option value="">
										国际班
									</option>
									<option value="">
										游学班
									</option>
									<select>
							</td>
							<td align="center">
								<select class="easyui-combobox"
									data-options="onChange:changeName"
									style="width: 100px; height: 28px;">
									<option>
										业绩老师
									</option>
									<option>
										业绩顾问
									</option>
									<select>
							</td>
							<td align="center">
								<span>业绩老师A</span>
							</td>
							<td align="left">
								<select class="easyui-combobox"
									style="width: 100px; height: 28px;">
									<option value="">
										武展
									</option>
									<select>
										<select class="easyui-combobox"
											style="width: 100px; height: 28px;">
											<option value="">
												李丽华
											</option>
											<select>
							</td>
							<td align="center">
								<span>业绩老师B</span>
							</td>
							<td align="left">
								<select class="easyui-combobox"
									style="width: 100px; height: 28px;">
									<option value="">
										武展
									</option>
									<select>
										<select class="easyui-combobox"
											style="width: 100px; height: 28px;">
											<option value="">
												李丽华
											</option>
											<select>
							</td>
						</tr>
						<tr>
							<td align="right">
								<span>备注：</span>
							</td>
							<td colspan="6">
								<textarea rows="2" cols="120" id="remark" name="remark"
									class="easyui-validatebox textbox"></textarea>
							</td>
						</tr>
						<tr>
							<td align="right">
								<span>上传缴费单：</span>
							</td>
							<td colspan="6">
								<input style="width: 300px; height: 28px;"
									class="easyui-filebox" name="file2" data-options="prompt:''">
								<a href="javascript:void(0)" id="viewStudent"
									class="easyui-linkbutton" iconCls="icon-redo"
									style="width: 100px;">查看缴费单</a>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div style="height: 10px;"></div>
			<div class="easyui-panel" style="width: 1200px; height: auto;"
				title="缴费信息">
				<table width="100%" cellpadding="5px" class="maintable">
					<tr>
						<td align="center">
							<href ="javascript:void(0)" id="addArchives"
								class="easyui-linkbutton" iconCls="icon-add" plain="true"
								onclick="addArchives()">
							<span>使用现金抵扣券</span>
						</td>
						<td colspan="5" giftId="">
							<div id="useCoupon">
						</td>
					</tr>
					<tr>
						<td align="right">
							<span>总金额：</span>
						</td>
						<td align="left">
							<input id="totalAmount" name="totalAmount" type="text"
								value="1000" class="easyui-textbox validatebox"
								style="width: 200px; height: 25px;">
						</td>
						<td align="right">
							<span>赠券抵扣金额：</span>
						</td>
						<td align="left">
							<input id="minusAmount" name="minusAmount" type="text" value="0"
								class="easyui-textbox validatebox"
								style="width: 200px; height: 25px;">
						</td>
						<td align="right">
							<span>实缴金额：</span>
						</td>
						<td align="left">
							<input id="amount" name="amount" type="text" value="1000"
								class="easyui-textbox validatebox"
								style="width: 200px; height: 25px;">
						</td>
					</tr>
				</table>
			</div>
		</form>
		<div style="width:1200px;text-align:center">
		 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:150px" id="submitBtn"><span>提交</span></a>
  				&nbsp;&nbsp;&nbsp;&nbsp;
  		 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:150px" id="backBtn" ><span>返回</span></a>	
		<iframe id="dlg" class="easyui-dialog"
			style="width: 1000px; height: 450px; padding: 10px 20px"
			closed="true" modal="true">
		</iframe>
	</body>
</html>
<script type="text/javascript">
loadStuBaseInfo();
var studentCourse = {};//最后提交学生课程信息
var gifts = [];
var courses = [];
var coupons = [];//使用抵扣劵
var useCoupon = "";

var minus = 0;//抵扣金额
var favorAmount = 0;//优惠金额
var totalAmount = 0;//课程金额
var amount = 0;//实缴金额

//增加课程
$("#addCourse").click(function() {
	var objectTr = $("#add").clone();//克隆模板
		objectTr.css("display", 'table-row');
		objectTr.attr("val", "course");
		objectTr.find("td").each(function(i, node) {
			var effDate = "";
			if (i == 0) {
				$(node).html("<span>" + (i + 1) + "</span>");
			} else if (i == 1) {
				var name = $("#giftCourseType").combobox('getText');
				var val = $("#giftCourseType").combobox('getValue');
				$(node).html("<span>" + name + "</span>");
				$(node).attr("giftCourseType", val);//赠课类型	
			} else if (i == 2) {
				var name = $("#giftCourseId").combobox('getText');
				var val = $("#giftCourseId").combobox('getValue');
				$(node).html("<span>" + name + "</span>");
				$(node).attr("giftId", val);//赠课细类	
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

		$("#add").after(objectTr);
	});

//删除相对应的行  
function delRow(rows) {
	$(rows).parent("td").parent("tr").remove();
}

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
				if(parentType=='COUPON' && code=='')
				{
					$.messager.alert('提示', "请输入券类编码!");
					flag=false;
					return;
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
				 
				
				$(node).attr("amount",amount);
				$(node).attr("giftId",giftId);
				$(node).attr("giftType",giftTypeVal);
				$(node).attr("giftCode",code);
				$(node).attr("giftEffDate",giftEffDate);
				
			}else if(n==5)
			{
				var getFlag = $("input[name='isGetY']:checked").val(); //是否领取
				var getFlagN =$("input[name='isGetN']:checked").val(); 
				$(node).attr("isGet","N");
				if('Y'==getFlag)
				{
					if(giftEffDate=='' &&　parentType=='COUPON')
					{
						flag=false;
						$.messager.alert('提示', "请填写有效期!");
					}
					$(node).html("<span>已领取</span>");	
					$(node).attr("isGet","Y");
				}else if('N'==getFlagN)
				{
					$(node).html("<span>未领取</span>");	
					$(node).attr("isGet","N");
				}
				else
				{
					 
				}
			}else if(n==7)
			{
				var granter=$("#granter").textbox("getValue");
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
	    }
		clearData("giftModelTR")
	});

	//创建连报提交数据
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
			 
				 var  amount=tds.eq(3).attr('amount');
				 var  effNum=tds.eq(3).attr('effNum');
				 var  unit=tds.eq(3).attr('unit');
				 var  giftId=tds.eq(3).attr('giftId');
				 var  giftType=tds.eq(3).attr('giftType');
				 var  giftCode=tds.eq(3).attr('giftCode');
				 var  isGet=tds.eq(5).attr('isGet');
				 var  granter=tds.eq(7).attr('granter');
				 var  giftEffDate=tds.eq(3).attr('giftEffDate');
				 var  gift = {};
				 
				 gift.studentId=$("#studentId").val();
				
				 gift.usableAmount=amount;
				 gift.amount=amount;
				 gift.studentGiftId=studentGiftId;
				 gift.unit = unit; 
				 gift.effNum = effNum; 
				 gift.giftType = giftType;
				 gift.giftId=giftId;
				 gift.giftCode=giftCode;
				 gift.giftEffDate=giftEffDate;
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
				 var  giftId=tds.eq(2).attr('giftId');
				 var  hours=tds.eq(3).attr('hours');
				
				 var  gift = {};
				 gift.studentId=$("#studentId").val();
				 gift.giftType = giftType;
				 gift.giftId=giftId;
				 gift.giftNum=hours;
				 gift.studentGiftId=studentGiftId;
				 
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
		studentCourse.giftCourses= courses;
		
		var obj = JSON.stringify($("#courseFm").serializeObject());
		studentCourse.course=obj;
		alert(JSON.stringify(studentCourse));
		return studentCourse;
	}
		
	function closeDlg()
	{
		$('#dlg').dialog('close');
		$('#useCoupon').html(useCoupon);
		$("#minusAmount").textbox('setValue',minus);
	}
	
	function colDis(id)
	{
		var idT="#useCoupon"+id+"";
		$(idT).css('display','none');
		for(var i=0;i<coupons.length;i++)
		{
			 var coupon=coupons[i];
			 if(coupon.studentGiftId==id)
			 {
				var usableAmountT=$("#minusAmount").textbox('getValue');
				usableAmountT=usableAmountT-coupon.usableAmount;
				$("#minusAmount").textbox('setValue',usableAmountT);
				
			 }
			 
		}
	}
	
	function addArchives()
	{
		$('#dlg').dialog({
			title:"使用抵扣券",
		});
		$('#dlg').attr("src","/sys/course/useCoupon.jsp?studentId="+$("#studentId").val());
		$('#dlg').dialog("open");
	}
	
	function getDataName(id,val)
	{
		
		var data = $(id).combobox('getData');
		
		for(var i=0;i<data.length;i++)
		{
			 
		}
		
	}
	
	function changePraiseSource()
	{
		var source =$("#praiseSelect").combobox("getValue");
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
	
	function changePraise(flag)
	{
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
					$("#praiseTab2").find("tr").css("display","none");
				}	
			})
		}	
	}
	function changeName()
	{
		var tr =$("#short").find("table").find("tr:eq(0)");
		var name =tr.find("td:eq(2)").find("select").combobox("getText");
		tr.find("td:eq(3)").find("span").html(name+"A");
		tr.find("td:eq(5)").find("span").html(name+"B");
	}
	
	function changeCourseType()
	{
		var type=$("#courseTypeName").combobox("getValue");
		if(type=="normal")
		{
			$("#normal").css("display","block");
			$("#short").css("display","none");
		}
		else if(type=="short")
		{
			$("#normal").css("display","none");
			$("#short").css("display","block");
		}	
	}
	
	function changePraiseType()
	{
		var type=$("#praiseType").combobox("getValue");
		if(type=="stuIntroduce")
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
		else if(type=="staffInstroduce")
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
	
	function loadStuBaseInfo()
	{
		$.ajax({
			type : "POST",
			url: "/sys/student/qryStudentById.do",
			data: "studentId="+$("#studentId").val()+"&funcNodeId=1002",
			async: false,
			dataType:"json",
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '系统消息', msg : '正在加载数据，请稍等……'});
	    	},
	    	success: function(data) {
	    		$.messager.progress('close');
	    		if(data.studentObj!=undefined&&data.studentObj!=null)
	    		{
	    			var obj =data.studentObj;
	    			var tr1 =$("#stuBaseInfo").find("tr:eq(0)");
	    			tr1.find("td:eq(1)").find("span").html(obj.name);
	    			tr1.find("td:eq(3)").find("span").html(obj.birthday);
	    			tr1.find("td:eq(5)").find("span").html(obj.identityId);
	    			$("#stuBaseInfo").find("tr:eq(1)").find("td:eq(1)").find("span").html(obj.sexVal);
	    		}	
	        },
	        error:function(){
	        	$.messager.progress('close'); 
	        }
	    	
		});
	}
	//initCousreGift();
	</script>

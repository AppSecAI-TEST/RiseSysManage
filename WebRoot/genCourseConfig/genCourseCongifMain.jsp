<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<script type="text/javascript" src="<%=path %>/js/genCourseConfig/stageConfig.js"></script>
		<script type="text/javascript" src="<%=path %>/js/genCourseConfig/classNumConfig.js"></script>
		<script type="text/javascript" src="<%=path %>/js/genCourseConfig/openClassPlan.js"></script>
		<script type="text/javascript" src="<%=path %>/js/genCourseConfig/comPriceConfig.js"></script>
		<script type="text/javascript" src="<%=path %>/js/genCourseConfig/linkPriceConfig.js"></script>
		<script type="text/javascript" src="<%=path %>/js/genCourseConfig/discountPriceConfig.js"></script>
  	</head>
  	<body>
  	<div id="tt" class="easyui-tabs" style="min-width:1110px;width:98%;height:auto;">
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<div title="课程阶段配置" style="padding:5px;display:block;">
			<table align="center" title="查询结果" data-options="height:600" id="stage_data">
				
			</table>
			<div id="stageToolbar">
	   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addStage()">添加阶段</a>
	   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="updateStage()">修改阶段</a>
	   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" onclick="deleteStage()">删除阶段</a>
	   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addClassType()">添加班级类型</a>
	 		</div>
	 		<div id="stageDlg" class="easyui-dialog" style="width:550px;height:300px;padding:0px 0px" modal="true" closed="true" buttons="#stage-buttons">
				<form id="stageFm" method="post">
					<input name="classId" type="hidden" />
					<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
						<tr>
							<td align="right">阶段名称：</td>
							<td align="left"><input id="stageId" name="stageId" style="width:265px" class="easyui-textbox" required="true"/></td>
						</tr>
						<tr id="seqOrderTr">
							<td align="right">年级：</td>
							<td align="left"><input id="seqOrder" name="seqOrder" style="width:265px" class="easyui-numberbox" required="true"/></td>
						</tr>
						<tr>
							<td align="right">班级类型：</td>
							<td align="left"><input name="classType" style="width:265px" class="easyui-textbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right">基础课时：</td>
							<td align="left"><input name="hours" style="width:265px" class="easyui-numberbox" required="true" />个</td>
						</tr>
						<tr>
							<td align="right">毕业典礼课时：</td>
							<td align="left"><input name="gradHours" style="width:265px" class="easyui-numberbox" required="true" />个</td>
						</tr>
						<tr>
							<td align="right">毕业典礼消耗时长：</td>
							<td align="left"><input name="gradRemark" style="width:265px" class="easyui-textbox" required="true"/>周</td>
						</tr>
						<tr>
							<td align="right">是否开放（班级）：</td>
							<td align="left"><input type="radio" value="Y" name="isOpen" checked="checked"/><span>是</span>&nbsp;<input type="radio" value="N" name="isOpen"/><span>否</span></td>
						</tr>
					</table>
				</form>
			</div>
			<div id="stage-buttons">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveSubmit()">提交</a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#stageDlg').dialog('close')">取消</a>
			</div>
			<div id="updateStageDlg" class="easyui-dialog" style="width:550px;height:150px;padding:0px 0px" modal="true" closed="true" buttons="#updateStage-buttons">
				<form id="updateStageFm" method="post">
					<input name="id" type="hidden" />
					<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
						<tr>
							<td align="right">阶段名称：</td>
							<td align="left"><input name="stageId" style="width:265px" class="easyui-textbox" required="true"/></td>
						</tr>
						<tr>
							<td align="right">年级：</td>
							<td align="left"><input name="seqOrder" style="width:265px" class="easyui-numberbox" required="true"/></td>
						</tr>
					</table>
				</form>
			</div>
			<div id="updateStage-buttons">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="updateStageSubmit()">提交</a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#updateStageDlg').dialog('close')">取消</a>
			</div>
  		</div>
  		<div title="开班人数配置" style="padding:5px;display:block;">
			<table align="center" title="查询结果" data-options="height:600" id="class_data">
				
			</table>
	 		<div id="classDlg" class="easyui-dialog" style="width:550px;height:220px;padding:0px 0px" modal="true" closed="true" buttons="#class-buttons">
				<form id="classFm" method="post">
					<input name="classId" type="hidden" />
					<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
						<tr>
							<td width="30%" align="right">课程阶段：</td>
							<td width="20%" id="stageTd" align="center"</td>
							<td width="20%" align="right">班级类型：</td>
							<td width="30%" id="classTypeTd" align="center"></td>
						</tr>
						<tr>
							<td align="right">最高开班人数：</td>
							<td id="maxTd" align="center"></td>
							<td align="right">修改为：</td>
							<td align="center"><input name="maxNum" style="width:150px" class="easyui-numberbox" data-options="min:1" required="true"/></td>
						</tr>
						<tr>
							<td align="right">最低开班人数：</td>
							<td id="minTd" align="center"></td>
							<td align="right">修改为：</td>
							<td align="center"><input name="minNum" style="width:150px" class="easyui-numberbox" data-options="min:1" required="true"/></td>
						</tr>
						<tr>
							<td align="right">异常开班人数：</td>
							<td id="expTd" align="center"></td>
							<td align="right">修改为：</td>
							<td align="center"><input name="expNum" style="width:150px" class="easyui-numberbox" data-options="min:1" /></td>
						</tr>
					</table>
				</form>
			</div>
			<div id="class-buttons">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="updateClassNumSubmit()">提交</a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#classDlg').dialog('close')">取消</a>
			</div>
  		</div>
  		<div title="教质时间轴配置" style="padding:5px;display:block;">
			<table align="center" title="查询结果" data-options="height:600" id="open_data">
				
			</table>
	 		<div id="openDlg" class="easyui-dialog" style="width:550px;height:280px;padding:0px 0px" modal="true" closed="true" buttons="#open-buttons">
				<form id="openFm" method="post">
					<input name="openId" type="hidden" />
					<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
						<tr>
							<td width="30%" align="right">课程阶段：</td>
							<td width="20%" id="oStageTd" align="center"</td>
							<td width="20%" align="right">班级类型：</td>
							<td width="30%" id="oClassTypeTd" align="center"></td>
						</tr>
						<tr>
							<td align="right">第1次公开课：</td>
							<td id="oneTd" align="center"></td>
							<td align="right">修改为：</td>
							<td align="center"><input name="one" style="width:150px" class="easyui-numberbox" data-options="min:1,max:24" required="true"/></td>
						</tr>
						<tr>
							<td align="right">第2次公开课：</td>
							<td id="twoTd" align="center"></td>
							<td align="right">修改为：</td>
							<td align="center"><input name="two" style="width:150px" class="easyui-numberbox" data-options="min:1,max:24" required="true"/></td>
						</tr>
						<tr>
							<td align="right">第3次公开课：</td>
							<td id="threeTd" align="center"></td>
							<td align="right">修改为：</td>
							<td align="center"><input name="three" style="width:150px" class="easyui-numberbox" data-options="min:1,max:24" required="true"/></td>
						</tr>
						<tr>
							<td align="right">第4次公开课：</td>
							<td id="fourTd" align="center"></td>
							<td align="right">修改为：</td>
							<td align="center"><input name="four" style="width:150px" class="easyui-numberbox" data-options="min:1,max:24" required="true"/></td>
						</tr>
						<tr>
							<td align="right">毕业典礼：</td>
							<td id="gradTd" align="center"></td>
							<td align="right">修改为：</td>
							<td align="center"><input name="grad" style="width:150px" class="easyui-numberbox" data-options="min:1,max:24" required="true"/></td>
						</tr>
					</table>
				</form>
			</div>
			<div id="open-buttons">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="updateClassPlanNumSubmit()">提交</a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#openDlg').dialog('close')">取消</a>
			</div>
  		</div>
  		<div title="课程价格配置" style="padding:5px;display:block;">
  			<div id="ttab" class="easyui-tabs" style="min-width:1110px;width:100%;height:auto;">
  				<div title="课程价格配置" style="padding:5px;display:block;">
					<table align="center" title="查询结果" data-options="height:550" id="common_data">
						
					</table>
					<div id="commonToolbar">
			   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addComPrice()">添加新价格</a>
			   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" onclick="viewSchoolComPrice()">校区开启价格体系</a>
		 			</div>
		 			<div style="margin: 5px 5px"><span style="font-size:16px;color:red;font-family:'微软雅黑'" id="upApplySchools"></span></div>
		 			<iframe id="comDlg" class="easyui-dialog" style="width:450px; height: 500px; padding: 10px 20px" closed="true" modal="true"></iframe>
				</div>
				<div title="连报优惠配置" style="padding:5px;display:block;">
					<table align="center" title="查询结果" data-options="height:550" id="link_data">
						
					</table>
					<div id="linkToolbar">
			   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addLinkPrice()">添加新优惠</a>
			   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" onclick="viewSchoolLinkPrice()">校区开启优惠体系</a>
		 			</div>
		 			<iframe id="linkDlg" class="easyui-dialog" style="width:450px; height: 500px; padding: 10px 20px" closed="true" modal="true"></iframe>
				</div>
				<div title="复读折扣配置" style="padding:5px;display:block;">
					<table align="center" title="查询结果" data-options="height:550" id="discount_data">
						
					</table>
					<div id="discountToolbar">
			   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addDiscountPrice()">添加新折扣</a>
			   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" onclick="viewSchoolDiscountPrice()">查看校区开启折扣</a>
		 			</div>
		 			<iframe id="disDlg" class="easyui-dialog" style="width:450px; height: 500px; padding: 10px 20px" closed="true" modal="true"></iframe>
				</div>
  			</div>
  		</div>
	  </div>
  	</body>
</html>

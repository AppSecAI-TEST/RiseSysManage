<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String path = request.getContextPath();
%>
<style type="text/css">
	#index_public_main .bar {border:1px solid #999999; background:#FFFFFF; height:5px; font-size:2px; width:89%; margin:2px 0 5px 0;padding:1px;overflow: hidden;}
	#index_public_main .bar_1 {border:1px dotted #999999; background:#FFFFFF; height:5px; font-size:2px; width:89%; margin:2px 0 5px 0;padding:1px;overflow: hidden;}
	#index_public_main .barli_red{background:#ff6600; height:5px; margin:0px; padding:0;}
	#index_public_main .barli_blue{background:#0099FF; height:5px; margin:0px; padding:0;}
	#index_public_main .barli_green{background:#36b52a; height:5px; margin:0px; padding:0;}
	#index_public_main .barli_1{background:#999999; height:5px; margin:0px; padding:0;}
	#index_public_main .barli{background:#36b52a; height:5px; margin:0px; padding:0;}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#notice_list_data").datagrid({
			onClickRow : function(index, row) {
				viewMsgDetail(row);
			},
			onDblClickRow : function(index, row) {
				viewMsgDetail(row);
			}
		});
		$("#approve_list_data").datagrid({
			onClickRow : function(index, row) {
				viewMsgDetail(row);
			},
			onDblClickRow : function(index, row) {
				viewMsgDetail(row);
			}
		});
	});
	
	function viewMsgDetail(row) {
		var url = "";
		var title = "";
		var applyId = row.apply_id;
		var msgType = row.msg_type;
		var pushType = row.push_type;
		var applyType = row.apply_type;
		var studentId = row.student_id;
		var classInstId = row.class_inst_id;
		var studentCourseId = row.student_course_id;
		if(msgType.indexOf("leave_course") > -1) { //休学
			title = "休学管理";
			url = "/sys/leaveManage/viewLeaveInfo.do?studentId=" + studentId + "&leaveId=" + applyId + "&funcNodeId=&type=view";
		} else if(msgType.indexOf("exp_course") > -1) { //异常
			title = "异常管理";
			url = "/sys/exception/expDetail.jsp?expInfo=" + studentId + "," + studentCourseId + "," + applyId;
		} else if(msgType.indexOf("apply_class") > -1 || msgType.indexOf("cancel_class") > -1) { //放班
			title = "放班管理";
			//通知 跳转到浏览页面
			if("notice" == pushType) {
				url = "/sys/applyClass/qryCreateClass.do?classInstId="+classInstId+"&type=view&applyType=" + applyType;
			} else {
				if(msgType.indexOf("apply_class") > -1) {
					//放班审批
					url = "/sys/applyClass/applyApprove.jsp?applyId=" + applyId + "&classInstId=" + classInstId;
				} else if(msgType.indexOf("cancel_class") > -1) {
					//取消放班审批
					url = "/sys/applyClass/cancelApprove.jsp?applyId=" + applyId + "&classInstId=" + classInstId;
				}
			}
		} else if(msgType.indexOf("exp_open_class") > -1 || msgType.indexOf("open_class") > -1) { //异常开班
			title = "开班管理";
			//通知 跳转到浏览页面
			if("notice" == pushType) {
				url = "/sys/openClass/qryCreateClass.do?classInstId=" + classInstId + "&type=view&applyType=" + applyType;
			} else {
				url = "/sys/openClass/qryCreateClass.do?classInstId=" + classInstId + "&type=approve&applyType=" + applyType;
			}
		} else if(msgType.indexOf("change_school") > -1) { //转校
			title = "转校管理";
			//通知 跳转到浏览页面
			if("notice" == pushType) {
				url = "/sys/changeSchool/viewChangeSchool.jsp?applyId=" + applyId;
			} else {
				url = "/sys/changeSchool/approveChangeSchool.jsp?applyId=" + applyId + "&studentId=" + studentId;
			}
		} else if(msgType.indexOf("change_class") > -1) { //转班
			title = "转班管理";
			//通知 跳转到浏览页面
			if("notice" == pushType) {
				url = "/sys/changeClass/viewChangeClass.jsp?applyId=" + applyId;
			} else {
				url = "/sys/changeClass/approveChangeClass.jsp?applyId=" + applyId + "&studentId=" + studentId + "&studentCourseId=" + studentCourseId;
			}
		} else if(msgType.indexOf("refund_fee") > -1) { //退费
			title = "退费管理";
			//通知 跳转到浏览页面
			if("notice" == pushType) {
				url = "/sys/refund/qryApproveRefund.do?refundFeeId=" + applyId + "&courseType=" + courseType + "&type=view";
			} else {
				
			}
		}
		$("#pagetabs").tabs("add", {
			title: title,
			closable: true,
			cache: false,
			content : "<iframe name='"+title+"' src='"+url+"' width='100%' height='99%' frameborder='0' scrolling='auto'></iframe>"
		});
	}
</script>
<div id="index_public_main" class="easyui-panel" data-options="fit:true,title:'',border:false">
	<table width="100%" cellspacing="5" border="0" style="height:300px">
		<tr>
			<td width="70%" valign="top">
				<div class="panel">
					<div class="panel-header">
						<div class="panel-title">待办事项</div>
					</div>
					<div class="panel-body" style="padding:8px;line-height:1.8;text-align:center;height:auto;font-family:'微软雅黑';font-size:12px;">
						<table class="easyui-datagrid" style="min-width:300px; height: auto;" id="approve_list_data"
							url = "<%=path %>/staff/msg.do?staffId=${sessionScope.StaffT.staffId}&flag=approve"
							pagination="false" rownumbers="false" fitColumns="true">
							<thead>
								<tr>
									<th data-options="field:'remark',width:'70%',align:'left'">待办事项标题</th>
									<th data-options="field:'date',width:'30%',align:'left'">时间</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</td>
			<td valign="top" style="height:173px">
				<div class="panel">
					<div class="panel-header">
						<div class="panel-title">我的个人信息</div>
					</div>
					<div class="panel-body" style="padding:8px;line-height:1.8">
						您好，${sessionScope.StaffT.staffName}<br />
						最后登录时间：<fmt:formatDate value="${sessionScope.StaffT.lastDate}" pattern="yyyy-MM-dd HH:mm:ss" /><br />
						最后登录IP： ${sessionScope.StaffT.remoteIp}<br />
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td width="70%" valign="top">
				<div class="panel">
					<div class="panel-header">
						<div class="panel-title">通知事项</div>
					</div>
					<div class="panel-body" style="padding:8px;line-height:1.8;text-align:center;height:auto;font-family:'微软雅黑';font-size:12px;">
						<table class="easyui-datagrid" style="min-width:300px; height: auto;" id="notice_list_data"
							url = "<%=path %>/staff/msg.do?staffId=${sessionScope.StaffT.staffId}&flag=notice"
							pagination="false" rownumbers="false" fitColumns="true">
							<thead>
								<tr>
									<th data-options="field:'remark',width:'70%',align:'left'">通知事项标题</th>
									<th data-options="field:'date',width:'30%',align:'left'">时间</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</td>
			<td valign="top" width="30%">
				<div class="panel">
					<div class="panel-header">
						<div class="panel-title">系统说明</div>
						<div class="panel-tool"></div>
					</div>
					<div class="panel-body" style="padding:8px;line-height:1.8">
						<!-- 瑞思教务管理系统 -->
					</div>
				</div>
			</td>
		</tr>
	</table>
</div>
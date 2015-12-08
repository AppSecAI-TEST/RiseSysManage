<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentId = request.getParameter("studentId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
  		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript">
			$(document).ready(function() {
				var studentId = $("#studentId").val();
				$("#goods_list_data").datagrid({ 
					url:"/sys/pubData/qryDataListByPage.do?param={funcNodeId:'1028',studentId:'"+studentId+"'}",
					onLoadSuccess: function() { 
						var rows = $("#goods_list_data").datagrid('getRows');
						if(parseInt(rows.length) <= 0) {
							$("#goodsDiv").css("display", "none");
						}
					}
				});
				
				$("#coupon_list_data").datagrid({ 
					url:"/sys/pubData/qryDataListByPage.do?param={funcNodeId:'1029',studentId:'"+studentId+"'}",
					onLoadSuccess: function() { 
						var rows = $("#coupon_list_data").datagrid('getRows');
						if(parseInt(rows.length) <= 0) {
							$("#couponDiv").css("display", "none");
						}
					}
				});
				
				$("#course_list_data").datagrid({ 
					url:"/sys/pubData/qryDataListByPage.do?param={funcNodeId:'1030',studentId:'"+studentId+"'}",
					onLoadSuccess: function() { 
						var rows = $("#course_list_data").datagrid('getRows');
						if(parseInt(rows.length) <= 0) {
							$("#courseDiv").css("display", "none");
						}
					}
				});
			});
		</script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员赠品赠课信息">
  			<input type="hidden" id="studentId" value="<%=studentId %>"/>
  			<div id="goodsDiv">
	  			<table class="easyui-datagrid" title="实物赠品与教材" style="height:auto;" id="goods_list_data"
					pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th data-options="field:'giftChannelDesc',width:200,align:'center'">赠品来源</th>
							<th data-options="field:'giftName',width:100,align:'center'">赠品名称</th>
							<th data-options="field:'createDate',width:100,align:'center'">赠送日期</th>
							<th data-options="field:'isGetText',width:80,align:'center'">是否领用</th>
							<th data-options="field:'isRtnText',width:80,align:'center'">是否退回</th>
							<th data-options="field:'getDate',width:150,align:'center'">领取时间</th>
							<th data-options="field:'rtnDate',width:150,align:'center'">退回时间</th>
							<th data-options="field:'granter',width:100,align:'center'">赠品发放人</th>
						</tr>
					</thead>
				</table>
  			</div>
  			<div id="couponDiv">
				<table class="easyui-datagrid" title="券类赠品" style="height:auto;" id="coupon_list_data"
					pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th data-options="field:'giftChannelDesc',width:200,align:'center'">赠品来源</th>
							<th data-options="field:'typeName',width:80,align:'center'">赠券类型</th>
							<th data-options="field:'amount',width:80,align:'center'">面值</th>
							<th data-options="field:'usableAmount',width:80,align:'center'">剩余金额</th>
							<th data-options="field:'giftCode',width:150,align:'center'">赠券编号</th>
							<th data-options="field:'createDate',width:100,align:'center'">赠送日期</th>
							<th data-options="field:'effDate',width:120,align:'center'">有效期开始日期</th>
							<th data-options="field:'expDate',width:120,align:'center'">有效期结束日期</th>
							<th data-options="field:'isGetText',width:80,align:'center'">是否领用</th>
							<th data-options="field:'giftStateText',width:100,align:'center'">赠券状态</th>
							<th data-options="field:'getDate',width:150,align:'center'">领取时间</th>
							<th data-options="field:'granter',width:100,align:'center'">赠品发放人</th>
						</tr>
					</thead>
				</table>
  			</div>
  			<div id="courseDiv">
				<table class="easyui-datagrid" title="赠课信息" style="height:auto;" id="course_list_data"
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
  			</div>
  			<div style="height: 10px;"></div>
  		</div>
  	</body>
</html>

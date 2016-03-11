<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentId=request.getParameter("studentId");
	String courseType=request.getParameter("courseType");
%>
<html>
	<head>
	<%@ include file="../common/head.jsp" %>
	<%@ include file="../common/formvalidator.jsp" %>
	<style>
		.datagrid
		{
			min-width:800px;
		}
	</style>
	</head>
	<body>
	<input type="hidden" id="staffName" name="staffName" value="${sessionScope.StaffT.userName}" />
		<table class="easyui-datagrid"  align="center" title="现金抵扣券列表" style="width:920px;margin-top:10px;height:330px;" id="couponList" 
			url="<%=path%>/pubData/qryDataListByPage.do?param={'queryCode':'Qry_Student_Coupon','studentId':'<%=studentId%>'}" 
			pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
			<thead>
				<tr>
					<th data-options="field:'ck', checkbox:true"></th>
					<th field="typeVal" align="center" width="10%"><span>赠券类型</span></th>
					<th field="giftName" align="center" width="10%"><span>赠券名称</span></th>
					<th field="giftCode" align="center" width="19%"><span>条码</span></th>
					<th field="amount" align="center" width="8%"><span>面值</span></th>
					<th field="usableAmount" align="center" width="9%"><span>剩余金额</span></th>
					<th field="createDate" align="center" width="14%"><span>赠送时间</span></th>
					<th field="effDate" align="center" width="11%"><span>有效期开始时间</span></th>
					<th field="expDate" align="center" width="11%"><span>有效期结束时间</span></th>
					<th field="giftStateText" align="center" width="8%"><span>状态</span></th>
					<input type='hidden'  data-options="field:'studentGiftId'" />
				</tr>
			</thead>
		</table>
		<div style="margin-top: 10px;text-align:center;">
	      	<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      	&nbsp;<a href="javascript:void(0)" id="back" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;">返回</a>
	     </div>
	     
	</body>

</html>
<script type="text/javascript">
	var coupons = [];
	var minus = 0;
	var name = "<div style:'width:300px'>";
	$("#submit").click(function() {
		coupons = [];
		name = "<div style:'width:300px'>";
		minus = 0;
		var obj = $("#couponList").datagrid("getSelections");
		for (var i = 0, n = obj.length; i < n; i++) {
			var giftName = obj[i].giftName;
			var giftCode = obj[i].giftCode;
			var isGet = obj[i].isGet;
			
			if("Y" == isGet) {
				var usableAmount = obj[i].usableAmount;
				if (parseInt(usableAmount) > 0) {
					var giftState = obj[i].giftState;
					if (giftState == "UNSUED" || giftState == "PARTUSED") {
						var effDateStr = obj[i].effDate;
						effDateStr = effDateStr.replace(/-/g, "/");
						var effDate = new Date(effDateStr);
						var currentDate = new Date();
						if (effDate <= currentDate) {
							var expDateStr = obj[i].expDate;
							expDateStr = expDateStr.replace(/-/g, "/");
							var expDate = new Date(expDateStr);
							if (expDate < currentDate) {
								showMessage("提示", "您选择的" + giftName + "，编号：" + giftCode + "的券已失效，无法使用！", null);
								return;
							} else {
								var coupon = {};
								var giftId = obj[i].giftId;
								var studentGiftId = obj[i].studentGiftId;
								coupon.usableAmount = usableAmount;
								coupon.giftId = giftId;
								coupon.studentGiftId = studentGiftId;
								coupon.couponName = giftName;
								coupon.couponCode = giftCode;
								coupon.amount = obj[i].amount;
								coupon.usedAmount = usableAmount;
								coupon.leftAmount = "0";
								coupon.studentGiftId = studentGiftId;
								coupon.handlerName = $("#staffName").val();
								minus = minus + usableAmount;
								name = name + "<span id='useCoupon"+studentGiftId+"'>" + giftCode + "/" + usableAmount + "元&nbsp;&nbsp;" + "<a href='javascript:void(0)' onclick='colDis(" + studentGiftId + ")'>取消</a>，</span>";
								coupons.push(coupon);
							}
						} else {
							showMessage("提示", "您选择的" + giftName + "，编号：" + giftCode + "的券还未生效，暂时无法使用！", null);
							return;
						}
					} else {
						var giftStateText = obj[i].giftStateText;
						showMessage("提示", "您选择的" + giftName + "，编号：" + giftCode + "的券已" + giftStateText + "，无法使用！", null);
						return;
					}
				} else {
					showMessage("提示", "您选择的" + giftName + "，编号：" + giftCode + "的券剩余金额为" + usableAmount + "元，无法使用！", null);
					return;
				}
			} else {
				showMessage("提示", "您选择的" + giftName + "，编号：" + giftCode + "的券还暂未领取，暂时无法使用！", null);
				return;
			}
		}
		name = name.substring(0, name.length - 8) + "</span></div>";
		parent.window.coupons = coupons;
		parent.window.useCoupon = name;
		parent.window.minus = minus;
		parent.window.closeDlg();
	});

	$("#back").click(function() {
		parent.window.closeDlg();
	});

	$("#couponList").datagrid({
		onClickRow : function(index, row) {
			var giftName = row.giftName;
			var giftCode = row.giftCode;
			var isCheck = $("#couponList").datagrid("getPanel").find(".datagrid-view2 .datagrid-body table input[type='checkbox']:eq(" + index + ") ").attr("checked");
			if (isCheck) {
				$("#couponList").datagrid("getPanel").find(".datagrid-view2 .datagrid-body table input[type='checkbox']:eq(" + index + ") ").attr("checked", false);
			} else {
				var isGet = row.isGet;
				
				var courseTypes=row.courseTypes;
				if(courseTypes.indexOf('<%=courseType%>')<0)
				{
					var courseName="常规课";
					if('<%=courseType%>'=='002')
					{
						courseName='短期课';
					}
					showMessage("提示", "您选择的" + giftName + "，编号：" + giftCode + "的券不能抵扣"+courseName+"！", callback(index));
					return;
				}
				
				if ("Y" == isGet) {
					var usableAmount = row.usableAmount;
					if (parseInt(usableAmount) > 0) {
						if (row.giftState == "UNSUED" || row.giftState == "PARTUSED") {
							var effDateStr = row.effDate;
							effDateStr = effDateStr.replace(/-/g, "/");
							var effDate = new Date(effDateStr);
							var currentDate = new Date();
							if (effDate <= currentDate) {
								var expDateStr = row.expDate;
								expDateStr = expDateStr.replace(/-/g, "/");
								var expDate = new Date(expDateStr);
								if (expDate < currentDate) {
									showMessage("提示", "您选择的" + giftName + "，编号：" + giftCode + "的券已失效，无法使用！", callback(index));
								}
							} else {
								showMessage("提示", "您选择的" + giftName + "，编号：" + giftCode + "的券还未生效，暂时无法使用！", callback(index));
							}
						} else {
							var giftStateText = row.giftStateText;
							showMessage("提示", "您选择的" + giftName + "，编号：" + giftCode + "的券已" + giftStateText + "，无法使用！", callback(index));
						}
					} else {
						showMessage("提示", "您选择的" + giftName + "，编号：" + giftCode + "的券剩余金额为" + usableAmount + "元，无法使用！", callback(index));
					}
				} else {
					showMessage("提示", "您选择的" + giftName + "，编号：" + giftCode + "的券还暂未领取，暂时无法使用！", callback(index));
				}
			}
		}
	});
	
	function callback(index)
	{
		$("#couponList").datagrid("getPanel").find(".datagrid-view2 .datagrid-body table input[type='checkbox']:eq(" + index + ") ").attr("checked", false);
		hideMessage();
	}
</script>

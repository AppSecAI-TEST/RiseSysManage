<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentId=request.getParameter("studentId");
%>
<html>
	<head>
	<%@ include file="../common/head.jsp" %>
	<%@ include file="../common/formvalidator.jsp" %>
	</head>
	<body>
	 
	      	
	      	<div style="padding:5px 0; width:800px;">
			<table class="easyui-datagrid"  title="使用现金抵扣券" style="height:400px;" id="list_data" url="<%=path %>/pubData/qryDataListByPage.do?param={'queryCode':'Qry_Student_Gift','studentId':'<%=studentId%>'}" 
				toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th width="6" data-options="field:'ck',checkbox:true"></th>
						<th width="20" data-options="field:'giftCode',width:100,align:'center'">条码</th>
						<th width="20" data-options="field:'amount',width:30,align:'center'">面值</th>
						<th width="20" data-options="field:'usableAmount',width:30,align:'center'">剩余金额</th>
						<th width="20" data-options="field:'createDate',width:60,align:'center'">赠送时间</th>
						<th width="20" data-options="field:'effDate',width:60,align:'center'">有效期开始时间</th>
						<th width="20" data-options="field:'expDate',width:60,align:'center'">有效期结束时间</th>
						<input type='hidden'  data-options="field:'studentGiftId'" />
					</tr>
				</thead>
			</table>
		</div>
		<div style="margin-top: 10px;">
      		 
	      			<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      			&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onClick="javascript:window.history.back()">返回</a>
	      	 
	     </div>
	     
	</body>

</html>
<script type="text/javascript">
	var coupons=[];
	var minus;
	var name="<div style:'width:300px'>";
	$("#submit").click(function ()
	{
		var obj = $('#list_data').datagrid('getSelections');
		for(var i = 0, n = obj.length; i < n; i++)
		{
			var usableAmount = obj[i].usableAmount;
			var giftCode= obj[i].giftCode;
			var giftId= obj[i].giftId;
			var studentGiftId=obj[i].studentGiftId;
			var coupon={};
			coupon.giftCode=giftCode;
			coupon.usableAmount=usableAmount;
			coupon.giftId=giftId;
			minus+=usableAmount;
			name=name+"<span id='useCoupon"+studentGiftId+"'>"+giftCode+"/"+usableAmount+"元"+"<a href='javascript:void(0)' onclick='colDis("+studentGiftId+")'>取消</a>,</span>";
			coupons.push(coupon);
		}
		name+="</div>";
		parent.window.coupons=coupons;
		parent.window.useCoupon=name;
		parent.window.minus=minus;
		parent.window.closeDlg();
	});
	</script>
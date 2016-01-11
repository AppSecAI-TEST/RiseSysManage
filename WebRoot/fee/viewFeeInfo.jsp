<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentCourseId =request.getParameter("studentCourseId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  	
  	<body>
  		<input id="studentCourseId" type="hidden" value="<%=studentCourseId %>"/>
  		<div class="easyui-panel" id="changeInfo" title="调整记录" style="width:1100px;">
  			<table id="changeTab" width="100%;" class="maintable">
  				<tr>
  					<td align="center" width="10%"><span>调整人</span></td><td align="center"  width="20%"><span>调整时间</span></td><td align="center" width="10%"><span>调整前金额</span></td><td width="10%" align="center"><span>调整后金额</span> </td><td align="center" width="50%"><span>备注</span></td>
  				</tr>
  				<tr id="modelTr" style="display:none">
  					<td align="center"><span></span></td><td align="center"><span></span></td><td align="center"><span></span></td><td align="center"><span></span></td><td align="center"><span></span></td>
  				</tr>
  			</table>
  		</div>
  		<div style="width:1100px;text-align:center;margin-top:25px;">
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px" id="backBtn" >返回</a>	
  		</div>
  	</body>
</html>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
			type : "POST",
			url: "/sys/courseFee/qryFeeChangeInfo.do",
			data: "studentCourseId="+$("#studentCourseId").val(),
			async: false,
			dataType:"json",
			beforeSend: function()
	    	{
	    		showProgressLoader("正在加载数据,请稍等",500)
	    	},
	    	success: function(data) {
	    		hideProgressLoader();
	    		if(data!=undefined&&data.length>0)
	    		{
	    			$.each(data,function(i,obj){
	    				var tr =$("#modelTr").clone();
	    				tr.find("td:eq(0)").find("span").html(obj.handlerName);
	    				tr.find("td:eq(1)").find("span").html(obj.createTime);
	    				tr.find("td:eq(2)").find("span").html(obj.beforeAmount+"元");
	    				tr.find("td:eq(3)").find("span").html(obj.afterAmount+"元");
	    				tr.find("td:eq(4)").find("span").html(obj.remark);
	    				tr.css("display","table-row");	
	    				$("#changeTab").append(tr)	
	    			});
	    		}
	    		else
	    		{
	    			$("#changeInfo").panel("close");
	    		}	
	        },
	        error:function(){
	        	hideProgressLoader();
	        }
	    	
	});
	
	$("#backBtn").click(function(){
		window.location.href = "qryCourseFee.jsp";
	});
})
</script>
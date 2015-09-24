<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	<style>
  		.infotable 
		{
			border-collapse: collapse;
			border-spacing: 0;
			border:none;
			margin-bottom:10px;
		}
					
		.infotable td 
		{
			border: 1px solid #ccc;
			padding:2px 1px;
			font-size:12px;
			text-align:center;
		}
  		
  		.cbox
  		{
  			vertical-align:bottom; 
  		}
  	
  		a
  		{
  			cursor:pointer;
  		}
  		
  		.detail
  		{
  			display:none;
  		}
  	</style>
  	</head>
  	<body>
   
  			<div id="u0">
        		<div id="u1">
          			<p><span></span></p>
        		</div>
      		</div>
      		<div id="baseInfo" class="easyui-panel" title="基本信息" style="width:720px">
	   			 <table width="100%" class="maintable">
		   			  <tr>
		   			     <td width="70px">学员姓名：</td><td width="100px"></td>
		   			     <td width="70px">英文名：</td><td width="180px"></td>
		   			     <td width="70px">出生日期：</td><td width="170px"></td>
		   			  </tr>
		   			  <tr>   
		   			     <td>性别：</td><td></td>
		   			     <td>证件号码：</td><td colspan="2"></td>
		   			     <td align="center"><a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">关联连报</a></td>
				      </tr>
			     </table>
		     </div>  
		     <div style="height:20px;"></div>
		     <div class="easyui-panel" title="连报课程" style="width:720px">
		     	<div id="courseInfo" class="courseDiv" style="display:none">
			     <table class="infotable base" width="100%">
			   		<tr>
			   			<td width="70px">报名日期:</td>
			   			<td width="100px"></td>
			   			<td style="width:370px;color:#ff000"></td>
			   			<td width="100px"><input type="checkbox" class="cbox">选择连报</td>
			   			<td width="80px"><a onclick="changeDetail(this)">展开详情</a></td>
			   		</tr>
				 </table>
				 <table class="infotable detail" width="100%">
			   		<tr>
			   			<td width="120px">课程阶段：</td>
			   			<td width="120px"></td>
			   			<td width="120px">班级类型:</td>
			   			<td width="120px"></td>
			   			<td width="120px">业绩类型:</td>
			   			<td width="120px"></td>
			   		</tr>
			   		<tr>
			   			<td>业绩顾问：</td>
			   			<td></td>
			   			<td>业绩老师：</td>
			   			<td></td>
			   			<td>课程状态：</td>
			   			<td></td>
			   		</tr>
			   		<tr>
			   			<td>课程进度：</td>
			   			<td></td>
			   			<td>现金抵扣券：</td>
			   			<td colspan="3"></td>
			   		</tr>
			   		<tr>
			   			<td>备注：</td>
			   			<td colspan="5"></td>
			   		</tr>
			   		<tr>
			   			<td>总金额：</td>
			   			<td></td>
			   			<td>优惠金额：</td>
			   			<td></td>
			   			<td>连报优惠：</td>
			   			<td></td>
			   		</tr>
			   		<tr>
			   			<td>实缴金额：</td>
			   			<td></td>
			   			<td colspan="4"><a>查看缴费单据</a></td>
			   		</tr>
				 </table>
				</div>
			</div>	
		</div>
  	</body>
</html>

<script type="text/javascript">
	var linkCourses=[];//选择关联已有连报课程
	var courses;
	$("#submit").click(function()
	{
		$(".detail").find("input[type=checkbox]").each(function (){
			if(this.checked)
			{
				var id = $(this).attr('studentCousreId');
				if(id!='')
				{
					$.each(courses,function(i,node)
				   	{
				   		var idT = node.studentCourseId;
				   		if(id==idT)
				   		{
				   			linkCourses.push(node);
				   		}
				   	});
				}
  			}
		});
		if(linkCourses.length==0)
		{
				
		}
		parent.window.linkCourses=linkCourses;
		parent.window.closeDlg();
	});
	

	$(document).ready(function()
	{
		var stu={};
		stu.studentId='2';
		stu.queryCode='Qry_Student_Courses';
		var str = JSON.stringify(stu);
			$.ajax({
			url: "/sys/course/getStuCourses.do?",
			data: "param="+str,
			dataType: "json",
			async: false,
	    	success: function (data)
	    	{
	    		courses = data.data;//学员已有课程
	    		$.each(courses,function(i,node)
	    		{
	    			var tabModel=$('#courseInfo').clone();
	    			var base=tabModel.find(".base").find("tr:eq(0)")
	    			base.find("td:eq(1)").html(node.payDate);
	    			base.find("td:eq(2)").html(node.remark)//提示 不知如何取 暂时取备注字段
	    			base.find("td:eq(3)").find("input[type=checkbox]").attr('studentCousreId',node.studentCourseId)
	    			
	    			var detail1 =tabModel.find(".detail").find("tr:eq(0)");
	    			detail1.find("td:eq(1)").html(node.stageId)
	    			detail1.find("td:eq(3)").html(node.classType)
	    			detail1.find("td:eq(5)").html(node.feeType)
	    			var detail2 =tabModel.find(".detail").find("tr:eq(1)");
	    			detail2.find("td:eq(1)").html(node.adviserA+"/"+node.adviserB)
	    			detail2.find("td:eq(3)").html(node.adviserTeacherA+"/"+node.adviserTeacherB)
	    			detail2.find("td:eq(5)").html(node.courseState)
	    			var detail3 =tabModel.find(".detail").find("tr:eq(2)");
	    			detail3.find("td:eq(1)").html()//课程进度字段尚无
	    			detail3.find("td:eq(3)").html(node.minusAmount)
	    			var detail4 =tabModel.find(".detail").find("tr:eq(3)");
	    			detail4.find("td:eq(1)").html(node.remark)
	    			var detail5 =tabModel.find(".detail").find("tr:eq(4)");
	    			detail5.find("td:eq(1)").html(node.totalAmount)
	    			detail5.find("td:eq(3)").html(node.favorAmount)
	    			detail5.find("td:eq(5)").html(node.linkFavorId)
	    			var detail6 =tabModel.find(".detail").find("tr:eq(5)");
	    			detail6.find("td:eq(1)").html(node.amount)
	    			detail6.find("td:eq(2)").find("a").click(function(){showImage(node.imgUrl)})
	    			tabModel.css("display","block");
	    			$('#courseInfo').after(tabModel);
	    			
	    		});
	    	 
	            //	window.location.reload();
	            	//$.messager.alert('提示', "批量修改客户关怀和责任顾问失败！");
	        } 
		});
		
	});
	
	 function changeDetail(obj)
	 {
		 if($(obj).html()=="展开详情")
		 {
			 $(".detail").css("display","none");
			  $(".base").find("a").html("展开详情");
			 $(obj).closest(".courseDiv").find(".detail").css("display","table");
			 $(obj).html("隐藏详情");
		 }
		 else
		 {
			 $(obj).closest(".courseDiv").find(".detail").css("display","none");
			 $(obj).html("展开详情");
		 }	 
		 
	 }
	 
	 
	 function showImage(url)
	 {
		   url ="http://pica.nipic.com/2008-03-19/2008319183523380_2.jpg";//临时查看效果
		   parent.$("#showImg").find("img").attr("src",url);
		   parent.$("#showImg").dialog('open'); 
	 }

</script>

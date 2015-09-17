<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/css/style.css">
		<script type="text/javascript" src="<%=path %>/js/student.js"></script>
		<script type="text/javascript">
			$(document).ready(function()
				{
				var height = $(document).height();
				$("#leftFrame",top.document).css("height",height);
				$("#nextFrame",top.document).css("height",height);
				
			})
		</script>
  	</head>
  
  	<body>
  	<div id="base">
  			<div id="u0">
        		<div id="u1">
          			<p><span></span></p>
        		</div>
      		</div>
   			 <table width="100%" height="100PX" cellpadding="5px" class="maintable" id="addStudentTd">
   			   <tr>
   			     <td align="right"><span>学员姓名：</span></td>
   			     <td><span>王兄阿尔</span></td>
   			     <td align="right"><span>出生日期：</span></td>
   			     <td><span>2012-12-12</span></td>
   			     <td width="16%" align="right"><span>证件号码：</span></td>
   			     <td width="6%"><span>422822198407311010</span></td>
   			     <td width="12%" align="right"><a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">关联连报</a></td>
		       </tr>
		       </table>
		       
		       	<div style="height: 10px;"></div>
		       
		       <table width="100%" height="100px" cellpadding="5px" class="maintable" id="linkCourseTab">
   				<tr id="cousreModel">
   				  <td align="right"><span>报名日期</span></td>
   				  <td>&nbsp;</td>
   				  <td colspan="2" align="center"><span>提示：</span></td>
   				  <td colspan="2" align="right">
   				  <input type="checkbox" name="checkbox" id="checkbox" studentCousreId=""><span>选择连报</span></td>
   				  <td align="right"><span>详情</span></td>
			   </tr>
			   
			   <!--
   				<tr>
   				  <td width="15%" align="right"><span>阶段：</span></td>
   				  <td width="23%">&nbsp;</td>
   				  <td width="15%" align="right"><span>班级类型：</span></td>
   				  <td width="13%">&nbsp;</td>
   				  <td align="right"><span>业绩类型：</span></td>
   				  <td>&nbsp;</td>
   				  <td align="right">&nbsp;</td>
			   </tr>
   				<tr>
   				  <td align="right"><span>课程状态：</span></td>
   				  <td>&nbsp;</td>
   				  <td align="right"><span>课程进度：</span></td>
   				  <td>&nbsp;</td>
   				  <td align="right"><span>招生顾问：</span></td>
   				  <td>&nbsp;</td>
   				  <td align="right">&nbsp;</td>
			   </tr>
   				<tr>
   				  <td align="right"><span>备注：</span></td>
   				  <td colspan="6">&nbsp;</td>
			   </tr>
   				<tr>
   				  <td align="right"><span>总金额：</span></td>
   				  <td>&nbsp;</td>
   				  <td align="right"><span>优惠券：</span></td>
   				  <td>&nbsp;</td>
   				  <td align="right"><span>实缴金额：</span></td>
   				  <td>&nbsp;</td>
   				  <td align="right">&nbsp;</td>
			   </tr>
   			   -->
			</table>
		</div>
  	</body>
</html>

<script type="text/javascript">

	var linkCourses=[];//选择关联已有连报课程
	
	
	
	$("#submit").click(function()
	{
		$("#linkCourseTab").find("input[type=checkbox]").each(function (){
			if(this.checked)
			{
				var id = $(this).attr('studentCousreId');
				if(id!='')
				{
					linkCourses.push(id);
				}
  			}
		});
		if(linkCourses.length==0)
		{
				
		}
		parent.window.linkCourse(linkCourses);
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
			beforeSend: function()
	    	{
	    		// $.messager.progress({title : '批量修改', msg : '正在批量修改客户关怀和责任顾问，请稍等……'});
	    	},
	    	success: function (data)
	    	{
	    		$.messager.progress('close'); 
	    		var courses = data.courses;//学员已有课程
	    		
	    		
	    		$.each(courses,function(i,node)
	    		{
	    			var trModel=$('#cousreModel').clone();
	    			var id = node.studentCourseId;
	    			var payDate = node.payDate;
	    			var  tds=$(trModel).children('td');
				    tds.eq(1).html("<span>"+payDate+"</span>");
				 
	    			trModel.find("input[type=checkbox]").attr('studentCousreId',id);
	    			
	    			$('#cousreModel').after(trModel);
	    			
	    		});
	    	 
	            //	window.location.reload();
	            	//$.messager.alert('提示', "批量修改客户关怀和责任顾问失败！");
	        } 
		});
		
	});
	
	 

</script>
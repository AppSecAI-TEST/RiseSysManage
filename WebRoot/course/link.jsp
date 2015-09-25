<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<html>
	<head>
	<%@ include file="../common/head.jsp" %>
	<%@ include file="../common/formvalidator.jsp" %>
	</head>
	<body>
	<div id="base">
  			<div id="u0">
        		<div id="u1">
          			<p><span></span></p>
        		</div>
      		</div>
      		 
			<div class="easyui-panel" style="width:99%;" title="学员基础信息">
	      		<form id="studentFm">
	      			<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
	      			<input type="hidden" id="schoolId" name="schoolId" value="${sessionScope.StaffT.schoolId}"/>
	      			<table width="100%" cellpadding="5px" class="maintable" id="addStudentTd">
	      				<tr>
	      					<td width="13%" align="right">
	      						<span style="color: red;">*</span>
	      						<span>学员姓名：</span>
	      					</td>
	      					<td width="25%">
	      						<span>王兄阿尔</span>
	      					</td>
	      					<td width="13%" align="right">
	      						<span>出生日期：</span>
	      					</td>
	      					<td width="15%">
	      						<span>2012-12-12</span>
	      					</td>
	      					<td align="right"><span>证件号码：</span></td>
	      					<td><span>422822</span></td>
      					</tr>
	      				<tr>
	      					<td align="right">
	      						<span>性别：</span>
	      					</td>
	      					<td><span>男</span></td>
	      					<td align="right"><span>缴费时间：</span></td>
	      					<td><input name="payDate" id="payDate" type="text" class="easyui-datebox" required="true" style="width: 200px; height: 28px;"/></td>
	      					<td align="right"><span>课程类型：</span></td>
	      					<td><span>常规课</span></td>
      					</tr>
      					<tr>
      					  <td align="right"><span>上传缴费单：</span></td>
      					  <td  colspan="5"><input style="width: 300px; height: 28px;" class="easyui-filebox" name="file2" data-options="prompt:''" ><a href="javascript:void(0)" id="viewStudent" class="easyui-linkbutton" iconCls="icon-redo" style="width: 100px;">查看缴费单</a></td>
   					  </tr>
      					<tr>
      					  <td align="right"><span>备注：</span></td>
      					  <td colspan="5"><textarea rows="2" cols="120" id="vipRemark" name="vipRemark" class="easyui-validatebox textbox"></textarea></td>
   					  </tr>
      					<tr>
      					  <td align="right"><span>关联已报课程：</span></td>
      					  <td><href="javascript:void(0)" id="addArchives" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="linkCourse()">打开学员之前的课程列表关联连报</a></td>
      					  <td align="right"><span>连报类型：</span></td>
      					  <td colspan="3">
      					  <select  id="link"  class="easyui-combobox"  style="width: 150px; height: 28px;"
	      						data-options="formatter:formatLinkNum, valueField: 'favorPrice', textField: 'linkNum', panelHeight: 'auto'
	      						 "
	      						url="<%=path %>/pubData/qryData.do?param={'queryCode':'Qry_Link_Favor','setPriceId':'10002'}">
      					    
    					    </select></td>
   					  </tr>
	      			</table>
                </form>
	      	</div>
	     <div id='frms'> 		 
			
			<iframe id="frame0" name="frame0"  style="display:none"  src=""  marginwidth=0 marginheight=0 frameborder=0 scrolling="auto" width="100%"></iframe>
		
			<iframe id="frame1" name="frame1"  style="display:none"  src=""  marginwidth=0 marginheight=0 frameborder=0 scrolling="auto" width="100%"></iframe>
			
			<iframe id="frame2" name="frame2" style="display:none"   src=""  marginwidth=0 marginheight=0 frameborder=0 scrolling="auto" width="100%"></iframe>
		
			<iframe id="frame3" name="frame3" style="display:none"   src=""  marginwidth=0 marginheight=0 frameborder=0 scrolling="auto" width="100%"></iframe>
			
			<iframe id="frame4" name="frame4" style="display:none"   src=""  marginwidth=0 marginheight=0 frameborder=0 scrolling="auto" width="100%"></iframe>
		
			<iframe id="frame5" name="frame5" style="display:none"   src=""  marginwidth=0 marginheight=0 frameborder=0 scrolling="auto" width="100%"></iframe>
				
		</div>
		
			
		<div style="height: 10px;"></div>
		<div class="easyui-panel" style="width:99%;height:auto;" title="合计金额">
		     	      <table width="100%" cellpadding="5px" class="maintable" >
		   	            <tr>
			      	        <td width="5%"  align="right" ><span>总金额：</span></td>
			      	        <td width="10%"  align="left" >&nbsp;</td>
			      	        <td width="8%"  align="right" ><span >抵扣总金额：</span></td>
			      	        <td colspan="8%"  align="left" >&nbsp;</td>
			      	        <td width="10%"  align="right"><span>连报总优惠金额：</span></td>
			      	        <td width="8%"  align="left" >&nbsp;</td>
			      	        <td width="10%"  align="right">实缴合计金额：</td>
			      	        <td width="8%"  align="right">&nbsp;</td>
			      	        <td width="10%"  align="right"><span>原已缴金额：</span></td>
			      	        <td width="8%"  align="right">&nbsp;</td>
			      	        <td width="10%"  align="right"><span>本次补缴金额：</span></td>
			      	        <td width="8%"  align="right">&nbsp;</td>
		      	         </tr>
		      	      </table>
		</div>
					
		<div id="dlg" class="easyui-dialog" style="width: 1000px; height: 450px; padding: 10px 20px" closed="true" modal="true" buttons="#dlgBtn">
 				<iframe id="frame2" name="frame2"   src="/sys/course/oldCourse.jsp"  marginwidth=0 marginheight=0 frameborder=0 scrolling="auto" height="445px" width="100%"></iframe>
  	   </div>
	 
		<div style="margin-top: 20px;">
	      		<div style="float: left;margin-left: 900px;">
	      			<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      			&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onClick="javascript:window.history.back()">返回</a>
	      		</div>
	     </div>
	     </div>
	     <div id="showImg" class="easyui-dialog" title="缴费单据"  data-options="modal:true,closed:true" style="width:1000px;height:450px;text-align:center;">
			<img style="width:100%;height:100%">
		</div>
	</body>

</html>
<script type="text/javascript">

	var studentCourses=[];//提交课程
	var linkCourses=[];//选择关联已有连报课程
	var orderCourses=["一","二","三","四","五","六","七","八","九","十"];//连报课程大写顺序
	
	function closeDlg()
	{
		$('#dlg').dialog('close');
	}
	function linkCourse()
	{
		$('#dlg').dialog('open').dialog('setTitle', '关联连报课程');
		$('#fm').form('clear');
	
	}
	
	//连报课程选择
    $('#link').combobox(
    {    
       onChange : function(n,o) 
       {
    		var num=$(this).combobox('getText');
    		$(this).combobox('setText',num+"年连报");
    		
    		for(var n=0;n<5;n++)
    		{
    			var name="#frame"+n;
		    	if(n<num)
		    	{
		    		var order = orderCourses[n];
		    		if(n<linkCourses.length)
		    		{
		    			var str=JSON.stringify(linkCourses[n]);
						var url="/sys/course/linkcourse.jsp?name="+n+"&order="+order+"&courses="+str;
							alert(url);
		    			$(name).attr('src',url);
		    		
		    		}else
		    		{
		    			$(name).attr('src',"/sys/course/linkcourse.jsp?name="+n+"&order="+order+"&name="+name);
		    		}
		    		$(name).css("display","block");
		    	}else
		    	{
		    	    $(name).css("display","none");
		    	}
		    	 
	    	}
        }  
    });  
	
	$("#submit").click(function()
	{
		$('#frms').find('iframe').each(function (i,node)
		{
		 
		});
	
		var l=frame0.window.build();
	//	var ll=frame1.window.build();
		studentCourses.push(l);
		//studentCourses.push(ll);
			
	    var str = JSON.stringify(studentCourses);
		
	    $.ajax({
    			url: "/sys/course/addLinkCourses.do",
    			data: "param=" +str,
    			dataType: "json",
    			async: false,
    			beforeSend: function()
    	    	{
    	    		$.messager.progress({title : '课程信息', msg : '正在添加课程信息，请稍等……'});
    	    	},
    	    	success: function (data) {
    	    		$.messager.progress('close'); 
    	    		var flag = data.flag
    	            if(flag)
    	            {
    	            	$.messager.alert('提示', "成功添加课程信息！");
    	            	window.location.reload();
    	            }
    	            else
    	            {
    	            	$.messager.alert('提示', "添加活动课程信息！");
    	            }
    	        } 
    		});
			
	});
	</script>

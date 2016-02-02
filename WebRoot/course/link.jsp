<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentId=request.getParameter("studentId");
	String schoolId=request.getParameter("schoolId");
	String studentInfo =request.getParameter("studentInfo");
	String linkCourses=request.getParameter("linkCourses");
%>
<html>
	<head>
	<%@ include file="../common/head.jsp" %>
	<%@ include file="../common/formvalidator.jsp" %>
	<script type="text/javascript" src="<%=path %>/js/course/addCourse.js"></script>
	</head>
	<body>
	<div id="base">
  			<div id="u0">
        		<div id="u1">
          			<p><span></span></p>
        		</div>
      		</div>
      		 
			<div class="easyui-panel" style="width:99%;min-width:1100px;" title="学员基础信息">
	      		<form id="studentFm">
	      			<input type="hidden" id="studentId" name="studentId" value="<%=studentId%>">
	      			<input type="hidden" id="studentInfo" name="studentInfo" value="<%=studentInfo%>" />
	      			<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
	      			<input type="hidden" id="schoolId" name="schoolId" value="<%=schoolId%>"/>
	      			<table width="100%" cellpadding="5px" class="maintable" id="addStudentTd">
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
	      					<td width="13%" align="right"><span>证件号码：</span></td>
	      					<td><span></span></td>
      					</tr>
	      				<tr>
	      					<td align="right">
	      						<span>性别：</span>
	      					</td>
	      					<td><span></span></td>
	      					<td align="right"><span>课程类型：</span></td>
	      					<td><span>常规课</span></td>
	      					<td align="right"></td>
	      					<td></td>
      					</tr>
      					<tr>
      					  <td align="right"><span>上传缴费单：</span></td>
      					  <td  colspan="5"><input style="width: 300px; height: 28px;" class="easyui-filebox" name="file2" data-options="prompt:''" ><a href="javascript:void(0)" id="viewStudent" class="easyui-linkbutton" iconCls="icon-redo" style="width: 100px;">查看缴费单</a></td>
   					  </tr>
      					<tr>
      					  <td align="right"><span>备注：</span></td>
      					  <td colspan="5"><input type="text" id="remark" name="remark" class="easyui-textbox validatebox"  style="width: 820px; height: 25px;"></textarea></td>
   					  </tr>
      				  <tr>
      					  <td align="right"><span>关联已报课程：</span></td>
      					  <td><href="javascript:void(0)" id="addArchives" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="linkCourse()">打开学员之前的课程列表关联连报</a></td>
      					  <td align="right"><span>连报类型：</span></td>
      					  <td colspan="3">
      					  <select  id="link"   style="width: 150px; height: 28px;"
	      						data-options="formatter:formatLinkNum, valueField: 'favorPrice', textField: 'linkNum', panelHeight: 'auto'"
	      						>
      					    
    					    </select></td>
   					  </tr>
	      			</table>
                </form>
	      	</div>
	     <div id='frms' style="margin-left:-5px;"> 		 
			
			<iframe id="frame0" name="frame0"  style="display:none"   src=""  marginwidth=0 marginheight=0 frameborder=0 scrolling="no" width="100%"></iframe>
		
			<iframe id="frame1" name="frame1"  style="display:none"   src=""  marginwidth=0 marginheight=0 frameborder=0 scrolling="no" width="100%"></iframe>
			
			<iframe id="frame2" name="frame2"  style="display:none"   src=""  marginwidth=0 marginheight=0 frameborder=0 scrolling="no" width="100%"></iframe>
		
			<iframe id="frame3" name="frame3"  style="display:none"   src=""  marginwidth=0 marginheight=0 frameborder=0 scrolling="no" width="100%"></iframe>
			
			<iframe id="frame4" name="frame4"  style="display:none"   src=""  marginwidth=0 marginheight=0 frameborder=0 scrolling="no" width="100%"></iframe>
		
			<iframe id="frame5" name="frame5"  style="display:none"   src=""  marginwidth=0 marginheight=0 frameborder=0 scrolling="no" width="100%"></iframe>
				
		</div>
		
			
		<div style="height: 10px;"></div>
		<div class="easyui-panel" style="width:99%;height:auto;min-width:1100px;" title="合计金额">
 	      <table width="100%" cellpadding="5px" class="maintable" >
            <tr>
   	        <td width="5%"   align="right" ><span>总金额：</span></td>
   	        <td width="10%"  align="left" id="totalAmount" >&nbsp;</td>
   	        <td width="8%"   align="right" ><span >抵扣总金额：</span></td>
   	        <td colspan="8%" align="left" id="minus" >&nbsp;</td>
   	        <td width="10%"  align="right"><span>连报总优惠金额：</span></td>
   	        <td width="8%"   align="left" id="favorAmount" >&nbsp;</td>
   	        <td width="10%"  align="right">实缴合计金额：</td>
   	        <td width="8%"   align="left" id="amount" >&nbsp;</td>
   	        <td width="10%"  align="right"><span>原已缴金额：</span></td>
   	        <td width="8%"   align="left" id="oldAmount" >&nbsp;</td>
   	        <td width="10%"  align="right"><span>本次补缴金额：</span></td>
   	        <td width="8%"   align="left" id="addAmount" >&nbsp;</td>
  	         </tr>
  	      </table>
		</div>
					
		<div id="dlg" class="easyui-dialog" style="width: 1000px; height: 550px; padding: 10px 20px" closed="true" modal="true" buttons="#dlgBtn">
 				<iframe id="frame2" name="frame2"   src="/sys/course/oldCourse.jsp?studentId=<%=studentId%>"  marginwidth=0 marginheight=0 frameborder=0 scrolling="auto" height="445px" width="100%"></iframe>
  	    </div>
	 
		<div style="margin-top: 25px;text-align:center;">
	      		<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		&nbsp;&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onClick="javascript:window.history.back()">返回</a>
	     </div>
	     </div>
	     <div id="showImg" class="easyui-dialog" title="缴费单据"  data-options="modal:true,closed:true" style="width:1000px;height:450px;text-align:center;">
			<img style="width:100%;height:100%">
		</div>
	</body>

</html>
<script type="text/javascript">
	loadStuBaseInfo();
	var minus=0;//抵扣金额
	var favorAmount=0;//优惠金额
	var totalAmount=0;//课程金额
	var amount=0;//实缴金额
	var oldAmount=0;//原已缴金额
	var addAmount=0;//补缴金额
	var allCoupons=[];//使用抵扣券
	var allCourseInfos={};//提交课程所有信息
	var studentCourses=[];//提交课程信息
	var linkCourses=[];//选择关联已有连报课程
	var orderCourses=["一","二","三","四","五","六","七","八","九","十"];//连报课程大写顺序
	var num;//连报年数
	var oldCourses;//学员已有课程
	var linkCourseT={};//连报金额汇总表
	var favorPrice=0;//连报总优惠金额
	function closeDlg()
	{
		$('#dlg').dialog('close');
	}
	
	function linkCourse()
	{
		$("#link").combobox('setValue',"");
   	    $("#link").combobox('setText',"");
		$('#dlg').dialog('open').dialog('setTitle', '关联连报课程');
		$('#fm').form('clear');
	
	}
	
	function checkLink()
	{
		if(linkCourses.length==0)
   	    {
   	    	$.messager.alert('提示',"请选择关联课程!");
   	    	$("#link").combobox('setValue',"");
   	    	$("#link").combobox('setText',"");
   	    	return;
   	    }
    	    
	}
	
	//连报课程选择
    $('#link').combobox(
    {    
       onChange : function(n,o) 
       {
    	    if(n==''){return}
    		num=$("#link").combobox('getText');
    		$("#link").combobox('setText',num+"年连报");
    		if(linkCourses.length>=num)
    		{
    			favorPrice=0;
    			$("#link").combobox('setValue',"");
   	   		 	$("#link").combobox('setText',"");
    			showMessage('提示', "连报年数需大于关联连报课程数,请重新选择", null);
    			return;
    		}else
    		{
    			var data = $(this).combobox('getData');
				for(var i=0;i<data.length;i++)
				{
					 if(num==data[i].linkNum)
					 {
						 favorPrice=data[i].favorPrice; 
					 }
				}
    			toLinkCourse(num);
    		}
    		
       }  
    });  

updateLinkCourses();	
function updateLinkCourses()
{
	var links='<%=linkCourses%>';
	links = eval("("+links+")");
	if(links!=null)
	{	 
		$("#addArchives").linkbutton({ disabled: true});
		$("#link").combobox({ disabled: true});
		num=links.length;
		linkCourses=links;
		toLinkCourse(num);
	} 
	 
		$("#link").combobox(
		{
			    url:"<%=path %>/pubData/qryData.do?param={'queryCode':'Qry_Link_Favor','schoolId':'"+<%=schoolId%>+"'}",
				onLoadSuccess : function() { //数据加载完毕事件
				var data = $(this).combobox('getData');
				 
				if(data==null || data.length==0)
				{
					 showMessage("提示","该校区没有可用连报价格体系",null);
					 return;
				} 
				for(var i=0;i<data.length;i++)
				{
					 if(num==data[i].linkNum)
					 {
						 $("#link").combobox('setText',num+"年连报"); 
					 }
				}
			}
		});
		
	 
}	
	
function toLinkCourse(num)
{
	for(var n=0;n<5;n++)
	{
			var name="#frame"+n;
		  	if(n<num)
		  	{
		  		var order = orderCourses[n];
		  		if(n<linkCourses.length)
		  		{
		  			var courseT= linkCourses[n];
		  			var str=JSON.stringify(linkCourses[n]);
		  			var amountT=courseT.amount;
		  			oldAmount=oldAmount+Number(amountT);
		  			if(n==0)
		  			{
		  				if(courseT.feeType=='001')
		  				{
		  					$(name).attr('src',"/sys/course/newCourse.jsp?studentId="+<%=studentId%>+"&schoolId="+<%=schoolId%>+"&name="+n+"&order="+order+"&courses="+str);
		  				}else
		  				{
		  					$(name).attr('src',"/sys/course/linkcourse.jsp?studentId="+<%=studentId%>+"&schoolId="+<%=schoolId%>+"&name="+n+"&order="+order+"&courses="+str);
		  				}
		  			}else
		  			{
		  				    $(name).attr('src',"/sys/course/linkcourse.jsp?studentId="+<%=studentId%>+"&schoolId="+<%=schoolId%>+"&name="+n+"&order="+order+"&courses="+str);
		  			}
		  		}else
		  		{
			  			if(n==0)
			  			{
			  			    $(name).attr('src',"/sys/course/newCourse.jsp?studentId="+<%=studentId%>+"&schoolId="+<%=schoolId%>+"&name="+n+"&order="+order);
			  			}else
			  			{
			  				$(name).attr('src',"/sys/course/linkcourse.jsp?studentId="+<%=studentId%>+"&schoolId="+<%=schoolId%>+"&name="+n+"&order="+order);
			  			}
		  		 }
		  			
		  		$(name).css("display","block");
		  	}else
		  	{
		  	    $(name).css("display","none");
		  	}
		  	$("#oldAmount").html(oldAmount);
		}
}



function validateCourses(studentCourses)
{
	var oldCourses=getOldCourse();
	
	for(var i=0;i<studentCourses.length;i++)
	{
		var course=studentCourses[i].course;
		
		var stageId =course.stageId;
		var feeType =course.feeType;
		var studentCourseId=course.studentCourseId;
		var stageOrder = course.stageOrder;
		var classType=course.classType;
		
		//校验本次购买课程是否有相同
		for(var m=0;m<studentCourses.length;m++)
		{
			var courseT=studentCourses[m].course;
			var stageIdT =courseT.stageId;
			
			if(stageId==stageIdT && i!=m)
			{
				showMessage("提示",stageId+"阶段只能购买一次",null);
				return false;
			}
		}
		
		for(var n=0;n<oldCourses.length;n++)
		{
			var oldCourse = oldCourses[n];
			var order = oldCourse.stageOrder;
			var courseState=oldCourse.courseState;
			var stageName =oldCourse.stageId;
			var oldFeeType =oldCourse.oldFeeType;
			var oldClassType=oldCourse.classType;
			
			if((studentCourseId==oldCourse.studentCourseId)  &&(stageId!=stageName || classType!=oldClassType || oldFeeType!=feeType))
			{
				if(courseState=='002')
				{
					showMessage("提示","当前课程"+orderCourses[m]+classType+"为已定班,不能修改课程信息",null);
					return;
				}else
				{
					continue;
				}
			}
				
			if(courseState=='001' || courseState=='002' || courseState=='003' || courseState=='004' || courseState=='005' || courseState=='006' || courseState=='007')
			{
				if(feeType=='001')//新招
				{ 
					if(courseState=='002' || courseState=='003' || courseState=='003' || courseState=='004' || courseState=='005' || courseState=='006' || courseState=='007')
					{
						showMessage("提示","该学员有未结束课程,当前所报阶段"+stageId+"不可选择新招业绩类型,请重新选择业绩类型",null);
						return false;
					}
					if(courseState=='001')//未定班
					{
						if(oldCourse.feeType=='001')//已有新招
						{
							showMessage("提示","已存在新招阶段"+stageName+",请重新选择业绩类型",null);
							return false;
						}
						if(Number(stageOrder)>Number(order))
						{
							showMessage("提示","当前所报新招阶段"+stageId+"不是最低阶段"+stageName+",请重新选择阶段",null);
							return false;
						}
					}
				}else if(feeType=='002'|| feeType=='003')
				{
					if(courseState=='001' || courseState=='002')
					{
						if(Number(stageOrder)==Number(order))
						{
							showMessage("提示","当前所报复读或升学阶段"+stageId+"低于或等于阶段"+stageName+",请重新选择阶段",null);
							return false;
						}
					}else if(courseState=='003' || courseState=='004' || courseState=='005' || courseState=='006' || courseState=='007')
					{
						if(Number(stageOrder)<Number(order))
						{
							showMessage("提示","当前所报复读或升学阶段"+stageId+"低于在读阶段"+stageName+",请重新选择阶段",null);
							return false;
						}
					}
					
				}
			}
		}
	}
	return true;
}

/**
 * 判断新招是不是最低阶段
 */
function checkNewCourse(courseT)
{
	var course=courseT.course;
	if(course.feeType=='001')
	{
		newCourse=course;
		return true;
	}
	if(newCourse!=null)
	{
		var stageOrder=newCourse.stageOrder;
		var order =course.stageOrder;
		if(Number(stageOrder)>Number(order))
		{
			 showMessage('提示', "本次报名新招阶段"+newCourse.stageId+"不是最低阶段", null);
			 return false;
		}
	}
	return true;
}

/**
 * 判断连报课程是否在同一价格体系
 */
function checkCoursePrice(studentCourses)
{
	var id;
	for(var i=0;i<studentCourses.length;i++)
	{
		var course=studentCourses[i].course;
		var priceId=course.coursePriceId;
		if(i==0)
		{
			id=priceId;
		}
		if(id!==priceId)
		{
			 showMessage('提示', "本次连报阶段不在同一价格体系中,请重试", null);
			 return false;
		}
	}
	return true;
}
var newCourse;//新招课程阶段
	
	$("#submit").click(function()
	{
		 if(!checkParam())
		 {
			 return false;
		 }	
		countAmount();
		 if(favorPrice<favorAmount)
		 {
			showMessage('提示', "实际优惠总金额:"+favorAmount+"元大于连报优惠总金额:"+favorPrice+"元,请核对金额", null);
		 	return false;
		 }
		 studentCourses=[];
		 for(var n=0;n<num;n++)
		 {
			var name="frame"+n;
	   		var courseT = window.frames[name].window.build();
	   		if(courseT==undefined)
	   		{
	   			showMessage('提示', "课程信息填写不完整", null);
	   			return;
	   		}
	   		
	   	
	   		
	   		if(!checkNewCourse(courseT))
	   		{
	   			return; 
	   		}
	   		 
	   		studentCourses.push(courseT);
		 }
		 if(!checkCoursePrice(studentCourses))
		 {
			 return ;
		 }
		 
		if(!validateCourses(studentCourses))
		{
			return;
		}
		
		allCourseInfos.studentCourses=studentCourses;
		allCourseInfos.linkCourseT=linkCourseT;
	    var str = JSON.stringify( allCourseInfos);
	    $.ajax({
    			url: "/sys/course/addLinkCourses.do",
    			data: "param=" +str,
    			dataType: "json",
    			async: true,
    			beforeSend: function()
    	    	{
    	    		showProgressLoader("正在添加课程信息，请稍等……",1000);
    	    	},
    	    	success: function (data) {
    	    		
    	    		hideProgressLoader();
    	    		var flag = data.flag
    	    		
    	            if(flag)
    	            {
    	            	showMessage('提示', "成功添加课程信息！", function() {window.history.back();});
    	            }
    	            else
    	            {
    	            	showMessage('提示', "添加课程信息失败", null);
    	            }
    	        },
		        error:function(){
		        	hideProgressLoader();
		        	showMessage('提示', "添加课程信息失败", null);
		        }
    		});
			
	});
	
	function countAmount()
	{
		  minus=0;//抵扣金额
		  favorAmount=0;//优惠金额
		  totalAmount=0;//课程金额
		  amount=0;//实缴金额
 
		  for(var n=0;n<num;n++)
		  {
				var name="frame"+n;
		  			 
		   		var minusT = window.frames[name].window.getMinus();
		   		var favorAmountT = window.frames[name].window.getFavorAmount();
		   		var totalAmountT = window.frames[name].window.getTotalAmount();
		   		var amountT = window.frames[name].window.getAmount();
		   		if(totalAmountT=='' || totalAmountT=='undefined')
		   		{
		   			continue;
		   		}
		   		 minus=minus+Number(minusT);
		   		 favorAmount=favorAmount+Number(favorAmountT);//优惠金额
				 totalAmount=totalAmount+Number(totalAmountT);//课程金额
				 amount=amount+Number(amountT);//实缴金额
				   
		    }
			$("#minus").html(minus);
			$("#favorAmount").html(favorAmount);
			$("#totalAmount").html(totalAmount);
			$("#amount").html(amount);
			$("#addAmount").html(amount-oldAmount);
			
			linkCourseT={};//清除
			linkCourseT.minusAmount=minus;
			linkCourseT.totalAmount=totalAmount;
			linkCourseT.favorAmount=favorAmount;
			linkCourseT.amount=amount;
			linkCourseT.oldAmount=oldAmount;
			linkCourseT.addAmount=amount-oldAmount;
			linkCourseT.linkType=num;
			linkCourseT.studentId='<%=studentId%>';
	}
 
	function checkFavorAmount()
	{
		countAmount()
		if(favorPrice!=favorAmount)
		{
			 showMessage('提示', "连报优惠总金额为"+favorPrice+"元,实际优惠总金额为"+favorAmount+"元,请核对金额", null);
			 return;
		}
	}
	//获取所有连报课程已使用的抵扣券
	function getAllCoupon()
	{
		 allCoupons=[];
		 for(var n=0;n<num;n++)
		 {
			var name="frame"+n;
	   		var couponsT = window.frames[name].window.coupons;
	   		for(var m=0;m<couponsT.length;m++)
	   		{
	   			 allCoupons.push(couponsT[m]);
	   		}
		 }
		 return allCoupons;
	}
	
	function loadStuBaseInfo()
	{
		var studentInfo =$("#studentInfo").val();
		if(studentInfo.indexOf(";;")!=-1)
		{
			studentInfo =studentInfo.split(";;");
			var tr1 =$("#addStudentTd").find("tr:eq(0)");
		    tr1.find("td:eq(1)").find("span").html(studentInfo[0]);
		    tr1.find("td:eq(3)").find("span").html(studentInfo[2]);
		    tr1.find("td:eq(5)").find("span").html(studentInfo[3]);
		    $("#addStudentTd").find("tr:eq(1)").find("td:eq(1)").find("span").html(studentInfo[4]);
		}
	}
	
	function showMsg(msg)
	{
		showMessage('提示',msg, null);
	}
	
	function  checkParam()
	{
		for(var n=0;n<num;n++)
		{
			var name="frame"+n;
	   		if(!window.frames[name].window.checkParam(n))
	   		{
	   			return false;
	   		}	
		}
		return true;
	}
	
	function scrolltoFrame(nums,top)
	{
		$("html,body").animate({scrollTop: document.getElementById("frame"+nums).offsetTop+top-50}, 100);	
	}
	</script>

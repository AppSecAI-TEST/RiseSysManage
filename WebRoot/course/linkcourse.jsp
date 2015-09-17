<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String order=request.getParameter("order").toString();
	String studentCousreId=request.getParameter("studentCousreId").toString();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		
	 
		<script type="text/javascript">
			$(document).ready(function()
			{
				var height = $(document).height();
				$("#frame1",parent.document).css("height",height+20);
			 	$("#frame2",parent.document).css("height",height+20);
			})
		</script>
  	</head>
  
  	<body>
  	<div  class="easyui-panel" title="连报课程<%=order%>" style="width:99%;padding:10px;border-color:#95B1E7">
  	<form id="courseFm">
	      <div style="height: 10px;"></div>
	      <div class="easyui-panel" style="width:100%;height:auto;" title="常规课课程">
	      
      	      <table width="100%" cellpadding="5px" class="maintable" >
	      	      <tr>
	      	      	<input id="studentId" name="studentId" type="hidden" value="100000"/>
	      	    	<input id="courseType" name="courseType" type="hidden" value="001"/>
	      	    	<input id="advisterType" name="adviserType" type="hidden" value="teacher"/>
	      	    	<input id="courseState" name="courseState" type="hidden" value="001"/>
	      	    	<input id="feeType" name="feeType" type="hidden" value="001"/>
	      	    	<input id="feeState" name="feeState" type="hidden" value="00A"/>
	      	        <td align="right"> <span>阶段：</span></td>
	      	        <td>
					 <select name="stageId" class="easyui-combobox" id="stageId" style="width: 150px; height: 28px;"
	      						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('stageId').combobox('setValue',data[0].codeFlag);}"
	      						url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=STAGE_ID" required="true" >
      	            </select>
					</td>
	      	        <td align="right"><span>班级类型：</span></td>
	      	        <td> 
	      	         <select name="classType" class="easyui-combobox" id="classType" style="width: 150px; height: 28px;"
	      						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('classType').combobox('setValue',data[0].codeFlag);}"
	      						url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=CLASS_TYPE" required="true" >
      	            </select>
	      	         </td>
	      	        <td align="right"><span>证件号码：</span></td>
	      	        <td>1234567890</td>
      	        </tr>
	      	      <tr>
	      	        <td align="right"><DIV id="u170_state0" data-label="状态1">
	      	          <DIV id="u170_state0_content">
	      	            <span>业绩老师A：</span>
      	                   </td>
	      	        <td><select name="adviserA" class="easyui-combobox" id="adviserA" style="width: 150px; height: 28px;"
	      						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#adviserA').combobox('setValue',data[0].codeFlag);}"
	      						url="<%=path %>/pubData/qryCodeNameList.do?tableName=REAL_SCHOOL_T&codeType=SCHOOL_TYPE" required="true" >
	      	          </select></td>
	      	        <td align="right"><span>业绩老师B：</span></td>
	      	        <td><select name="adviserB" class="easyui-combobox" id="adviserB" style="width: 150px; height: 28px;"
	      						data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('adviserB').combobox('setValue',data[0].schoolId);}"
	      						url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
	      	          </select></td>
	      	        <td  align="right"><span>缴费时间：</span></td>
	      	        <td><input name="payDate" id="payDate" type="text" class="easyui-datebox" required="true" style="width: 200px; height: 28px;"/></td>
      	        </tr>
      	      </table>
      	      
</div>
      		<div style="height: 10px;"></div>
      	<div class="easyui-panel" style="width:100%;height:auto;" title="赠品信息">
      	
      	      <table width="100%" cellpadding="5px" class="maintable" id="giftTab">
	      	      <tr>
	      	        <td width="7%" align="right">  <span>赠品类型：</span></td>
	      	        <td width="12%">
	      	        <select    class="easyui-combobox" id="giftName" style="width: 150px; height: 28px;"
	      						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#giftName').combobox('setValue',data[0].codeFlag);}"
	      						url="<%=path %>/pubData/qryCodeNameList.do?tableName=GIFT_T&codeType=GIFT_NAME" required="true" >
      	            </select>
      	            </td>
	      	        <td width="7%" align="right"><span>赠品名称：</span></td>
	      	        <td width="35%">
	      	        <table width="200" border="0">
   	                <tr>
	      	              <td>
							<select   class="easyui-combobox" id="giftType" style="width: 150px; height: 28px;"
	      						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#giftType').combobox('setValue',data[0].codeFlag);}"
	      						url="<%=path %>/pubData/qryCodeNameList.do?tableName=GIFT_T&codeType=GIFT_TYPE" required="true" >
      	            </select>
						</td>
	      	              <td><select  class="easyui-combobox" id="giftId" style="width: 96px; height: 28px;">
   	                  </select></td>
	      	              <td><input   id="giftCode" type="text" class="easyui-textbox validatebox" required="true" style="width: 200px; height: 28px;"/></td>
      	                </tr>
      	              </table></td>
	      	        <td width="7%" align="right"><span>是否领用：</span></td>
	      	        <td width="13%" align="left">
	      	          <input type="radio" name="isGetY" id="isGetY" value="Y">
	      	          <label for="radio"><span>已领用</span></label>
	      	          <input type="radio" name="isGetN" id="isGetN" value="N">
	      	          <label for="radio"> <span>未领用</span></label>
      	           </td>
	      	        <td width="7%" align="right"><span>发放人：</span></td>
	      	        <td width="8%"><input   id="granter" type="text" class="easyui-textbox validatebox" required="true" style="width: 100px; height: 28px;"/></td>
	      	        <td width="4%"><a href="javascript:void(0)" id="addGiftBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px; height: 28px;">添加</a></td>
      	        </tr>
      	        
      	      <tr style="display:none;" name="addGift" id="addGift" >
      	        <td align="right"><span>赠品类型：</span></td>
      	        <td align="left" giftName="">&nbsp;</td>
      	        <td align="right"><span>赠品名称：</span></td>
      	        <td align="left" giftType="" giftId="">&nbsp;</td>
      	        <td align="right"><span>是否领用：</span></td>
      	        <td align="left" isGet="">&nbsp;</td>
      	        <td align="right"><span>发放人：</span></td>
      	        <td align="left" granter="">&nbsp;</td>
      	        <td><a href='javascript:void(0)' class='linkmore' ><span>删除</span></a></td>
     	       </tr>
      	      </table>
</div>
      		
      		<div style="height: 10px;"></div>
      		<div class="easyui-panel" style="width:100%;height:auto;" title="赠课信息">
      	      <table width="100%" cellpadding="5px" class="maintable" >
	      	      <tr>
	      	        <td colspan="2" align="right"><span>赠课类型</span></td>
	      	        <td width="16%" align="right"><select  class="easyui-combobox" id="giftNameCoruse" style="width: 150px; height: 28px;"
	      						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#giftNameCoruse').combobox('setValue',data[0].codeFlag);}"
	      						url="<%=path %>/pubData/qryCodeNameList.do?tableName=GIFT_T&codeType=GIFT_COURSE" required="true" >
      	            </select></td>
	      	        <td width="11%" align="right"><span>赠课名称：</span></td>
	      	        <td width="11%"><select   class="easyui-combobox" id="giftCourseId" style="width: 96px; height: 28px;"
	      						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#giftCourseId').combobox('setValue',data[0].codeFlag);}"
	      						url="<%=path %>/pubData/qryCodeNameList.do?tableName=GIFT_T&codeType=GIFT_COURSE" required="true">
	      	          </select></td>
	      	       
	      	        <td width="10%" align="right"><span>课时量:</span></td>
	      	        <td width="11%"><input id="courseHours" type="text" class="easyui-textbox validatebox" required="true" style="width: 100px; height: 28px;"/></td>
	      	         <td width="10%" align="right"><span>有效期开始时间</span></td>
	      	        <td width="16%"><input   id="effDate" type="text" class="easyui-datebox" required="true" style="width: 200px; height: 28px;"/></td>
	      	        <td width="7%"><a href="javascript:void(0)" id="addCourse" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px; height: 28px;">添加</a></td>
      	        </tr>
      	      </table>
      	       <table width="100%" cellpadding="5px" class="maintable" id="giftCourse">
	      	    
	      	      <tr align="center">
	      	        <td width="6%" ><span>序号</span>&nbsp;</td>
	      	        <td ><span>赠课名称</span></td>
	      	        <td><span>赠送课时量</span></td>
	      	        <td><span>赠送时间</span></td>
	      	        <td><span>课程状态</span></td>
	      	        <td><span>赠课来源</span></td>
	      	        <td><span>有效期开始时间</span></td>
	      	        <td><span>失效期</span></td>
	      	        <td><span>课程进度</span></td>
	      	       
      	        </tr>
	      	      <tr style="display:none;" id="add" align="right">
	      	        <td  val="">&nbsp;</td>
	      	        <td  giftType="">&nbsp;</td>
	      	        <td  giftId="">&nbsp;</td>
	      	        <td  val="">&nbsp;</td>
	      	        <td  val="">&nbsp;</td>
	      	        <td  val="">&nbsp;</td>
	      	        <td  val="">&nbsp;</td>
	      	        <td  val="">&nbsp;</td>
	      	        <td><a href='javascript:void(0)' class='linkmore' ><span>删除</span></a></td>
      	        </tr>
      	      </table>
</div>
	<div style="height: 10px;"></div>
<div class="easyui-panel" style="width:100%;height:auto;" title="课程费用">
      	      <table width="100%" cellpadding="5px" class="maintable" >
	      	     
   	            <tr>
      	            <td  align="right" ><span>现金抵扣劵：</span></td>
      	            <td align="center"  ><input type="submit" name="button" id="button" value="使用现金抵扣券"></td>
      	            <td colspan="8"  giftId="">&nbsp;</td>
   	            </tr>
   	           
   	            <tr>
	      	        <td width="10%"  align="right" ><span>课程<%=order%>金额：</span></td>
	      	        <td width="14%"  align="left" ><input id="totalAmount" name="totalAmount" type="text" class="easyui-textbox validatebox"  style="width: 200px; height: 25px;"> </td>
	      	        <td width="12%"  align="right" ><span >现金抵扣券金额：</span></td>
	      	        <td colspan="3"  align="left" ><input id="minusAmount" name="minusAmount" type="text" class="easyui-textbox validatebox"  style="width: 200px; height: 25px;">  </td>
	      	        <td width="11%"  align="right"><span>连报优惠金额：</span></td>
	      	        <td width="17%"  align="left" ><input id="favorAmount" name="favorAmount" type="text" class="easyui-textbox validatebox"  style="width: 200px; height: 25px;"/></td>
	      	        <td width="12%"  align="right"><span>实缴课程一金额：</span></td>
	      	        <td width="17%"  align="left" ><input id="amount" name="amount"     type="text" class="easyui-textbox validatebox"  style="width: 200px; height: 25px;"> </td>
      	         </tr>
      	       
      	      </table>
</div>
<div style="height: 10px;"></div>

  
 		<!--  
	      	<div style="margin-top: 50px;">
	      		<div style="float: left;margin-left: 900px;">
	      			<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      			&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onClick="javascript:window.history.back()">返回</a>
	      		</div>
	      	</div>-->
	      	  </form>
  		</div>
  	</body>
</html>
<script type="text/javascript">
	
	var studentCourse={};//最后提交学生课程信息
    var gifts = [];  
	var courses=[];

	
	//增加课程
	$("#addCourse").click(function()
	{
		var objectTr=$("#add").clone();//克隆模板
		objectTr.css("display",'table-row');
		objectTr.attr("val","course");
		objectTr.find("td").each(function(i,node)
		{
			if(i==1)
			{
				var name=$("#giftNameCoruse").combobox('getText');
				var val=$("#giftNameCoruse").combobox('getValue');
				$(node).html("<span>"+name+"</span>");	
				$(node).attr("giftType",val);//赠课类型	
			}else if(i==2)
			{
				var name=$("#giftCourseId").combobox('getText');
			    var val=$("#giftCourseId").combobox('getValue');
				$(node).html("<span>"+name+"</span>");	
				$(node).attr("giftId",val);//赠课细类	
			}else if(i==3)
			{
				var hours=$("#courseHours").textbox('getText');
				$(node).html("<span>"+hours+"</span>");	
				$(node).attr("hours",hours);//课时
			} 
		});
		 
		$("#add").after(objectTr);
		var height = $(document).height();
		$("#frame1",parent.document).css("height",height+20);
	 	$("#frame2",parent.document).css("height",height+20);
	 	
	});
	
	//增加赠品
	$("#addGiftBtn").click(function ()
	{
		var giftTR=$("#addGift").clone();
		giftTR.css("display",'table-row');
		giftTR.attr("val","gift");
		giftTR.find("td").each(function(n,node)
		{
			if(n==1)
			{
				var name=$("#giftName").combobox('getText');
				var val=$("#giftName").combobox('getValue');
				$(node).html("<span>"+name+"</span>");	
				$(node).attr("giftName",val);//赠品类型	
			}else
			if(n==3)
			{
				var giftType=$("#giftType").combobox("getText");
				var val=$("#giftType").combobox('getValue');
				$(node).html("<span>"+giftType+"</span>");	
				$(node).attr("giftType",val);//赠品名称
				$(node).attr("giftId",val);//赠品细项
			}else
			if(n==5)
			{
				var getFlag = $("input[name='isGetY']:checked").val(); //是否领取
				var getFlagN =$("input[name='isGetN']:checked").val(); 
				$(node).attr("isGet","N");
				if('Y'==getFlag)
				{
					$(node).html("<span>已领取</span>");	
					$(node).attr("isGet","Y");
				}else if('N'==getFlagN)
				{
					$(node).html("<span>未领取</span>");	
					$(node).attr("isGet","N");
				}
				else
				{
					//alert("请选择是否领用");
					//return;
				}
			}else if(n==7)
			{
				var granter=$("#granter").textbox("getValue");
				$(node).html("<span>"+granter+"</span>");	
				$(node).attr("granter",granter);
			}
			
		});
	
		$("#addGift").after(giftTR);
		var height = $(document).height();
		$("#frame1",parent.document).css("height",height+20);
	 	$("#frame2",parent.document).css("height",height+20);
	  
	});


	//提交课程
	$("#submit").click(function()
	{
		$("#giftTab").find('tr').each(function(i,node)
		{
			var trName=$(this).attr("val");
			if('gift'==trName)
			{
				 var  tds=$(this).children('td');
				 var  giftName=tds.eq(1).attr('giftName');
				 var  giftType=tds.eq(3).attr('giftType');
				 var  giftId=tds.eq(3).attr('giftId');
				 var  isGet=tds.eq(5).attr('isGet');
				 var  granter=tds.eq(7).attr('granter');
				 
				 var  gift = {};
				 
				 gift.giftName = giftName;
				 gift.giftType=giftType;
				 gift.giftId=giftId;
				 gift.isGet=isGet;
				 gift.granter=granter;
				 
				 gifts.push(gift);  
				// alert(JSON.stringify(gifts));
			 }
		});
		$("#giftCourse").find('tr').each(function(i,node)
		{
			var trName=$(this).attr("val");
			if('course'==trName)
			{
				 var  tds=$(this).children('td');
				 var  giftType=tds.eq(1).attr('giftType');
				 var  giftId=tds.eq(2).attr('giftId');
				 var  hours=tds.eq(3).attr('hours');
				
				 var  course = {};
				 course.giftType = giftType;
				 course.giftId=giftId;
				 course.hours=hours;
				 
				 courses.push(course);  
				// alert(JSON.stringify( courses));
			 }
		});
	});
	
	function build()
	{
		
		$("#giftTab").find('tr').each(function(i,node)
		{
			var trName=$(this).attr("val");
			if('gift'==trName)
			{
				 var  tds=$(this).children('td');
				 var  giftName=tds.eq(1).attr('giftName');
				 var  giftType=tds.eq(3).attr('giftType');
				 var  giftId=tds.eq(3).attr('giftId');
				 var  isGet=tds.eq(5).attr('isGet');
				 var  granter=tds.eq(7).attr('granter');
				 
				 var  gift = {};
				 
				 gift.giftName = giftName;
				 gift.giftType=giftType;
				 gift.giftId=giftId;
				 gift.isGet=isGet;
				 gift.granter=granter;
				 
				 gifts.push(gift);  
				// alert(JSON.stringify(gifts));
			 }
		});
		$("#giftCourse").find('tr').each(function(i,node)
		{
			var trName=$(this).attr("val");
			if('course'==trName)
			{
				 var  tds=$(this).children('td');
				 var  giftType=tds.eq(1).attr('giftType');
				 var  giftId=tds.eq(2).attr('giftId');
				 var  hours=tds.eq(3).attr('hours');
				
				 var  course = {};
				 course.giftType = giftType;
				 course.giftId=giftId;
				 course.hours=hours;
				 
				 courses.push(course);  
			 }
		});
		studentCourse.gifts=gifts;
		studentCourse.giftCourses= courses;
		var obj = JSON.stringify($("#courseFm").serializeObject());
		studentCourse.course=obj;
		return studentCourse;
	}
	</script>
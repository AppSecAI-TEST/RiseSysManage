<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/teaPlanManage/teaPlanManage.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="教质计划修改">
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<table width="98%" style="border:1px solid #ccc;font-family:'微软雅黑';margin-top:5px;height:30px;" align="center" cellspacing="2">
  				<tr>
					<td align="right" width="10%"><span>教质月份：</span></td>
					<td id="teachingMonth" align="left" width="10%">${month}</td>
  					<td align="right" width="8%"><span>校区：</span></td>
	  				<td align="left" width="10%">${schoolName}</td>
					<td align="center" width="60%"></td>
  				</tr>
  			</table>
  			<table width="98%" cellpadding="2px" style="margin-top:5px;margin-bottom:5px;border:1px solid #ccc;" align="center" class="maintable">
	      	   <tr id="planTr">
	      	    <td align="center" width="3%"><span>序号</span></td>
	      	   	 <td align="center" width="9%"><span>班级</span></td>
	      	   	 <td align="center" width="12%"><span>电教</span></td>
	      	   	 <td align="center" width="12%"><span>开班典礼</span></td>
	      	   	 <td align="center" width="12%"><span>家长会</span></td>
	      	   	 <td align="center" width="12%"><span>公开课</span></td>
	      	   	 <td align="center" width="12%"><span>毕业典礼</span></td>
	      	   	 <td align="center" width="15%"><span>是否开教质事件</span></td>
	      	   	 <td align="center" width="25%"><span>说明</span></td>
     	       </tr>
     	       <c:forEach items="${obj.teachingPlan}" var="teachingPlan" varStatus="status">
     	        <input type="hidden" name="qualityId" id="qualityId${status.index}" value="${teachingPlan.qualityId}"/>
				<tr>
					<input type="hidden" id="teachingIsOpen${status.index}" value="${teachingPlan.teachingIsOpen}" />
					<td align="center">${status.count}</td>
					<td align="center">${teachingPlan.className}</td>
					<td align="center"><div id="teaDiv${status.index}"><input id="teachingDate${status.index}" dateVal="${teachingPlan.teachingDate}" class="easyui-numberbox" status="${status.index}" style='width:100px;' /></div></td>
					
					<td align="center"><div id="startDiv${status.index}"><input id="startDate${status.index}" dateVal="${teachingPlan.startDate}" class="easyui-numberbox" dateNum="" status="${status.index}" data-options="events:{blur: function(){clearOthers(${status.index},'startDate','meetingDate','openClassDate','gradDate')},focus: function(){saveCurrentNum(${status.index},'startDate')}}" style='width:100px;' /></div></td>
					
					<td align="center"><div id="meetDiv${status.index}"><input id="meetingDate${status.index}" dateVal="${teachingPlan.meetingDate}" class="easyui-numberbox" dateNum="" status="${status.index}" data-options="events:{blur: function(){clearOthers(${status.index},'meetingDate','startDate','openClassDate','gradDate')},focus: function(){saveCurrentNum(${status.index},'meetingDate')}}" style='width:100px;' /></div></td>
					<td align="center"><div id="openDiv${status.index}"><input id="openClassDate${status.index}" dateVal="${teachingPlan.openClassDate}" class="easyui-numberbox" dateNum="" status="${status.index}" data-options="events:{blur: function(){clearOthers(${status.index},'openClassDate','startDate','meetingDate','gradDate')},focus: function(){saveCurrentNum(${status.index},'openClassDate')}}" style='width:100px;' /></div></td>
					<td align="center"><div id="gradDiv${status.index}"><input id="gradDate${status.index}" dateVal="${teachingPlan.gradDate}" class="easyui-numberbox" dateNum="" status="${status.index}" data-options="events:{blur: function(){clearOthers(${status.index},'gradDate','startDate','meetingDate','openClassDate')},focus: function(){saveCurrentNum(${status.index},'gradDate')}}" style='width:100px;' /></div></td>
					<td align="center"><input name="teachingIsOpen${status.index}" type="radio" status="${status.index}" class="teachingIsOpen" value="Y"/><span>是</span>&nbsp;<input name="teachingIsOpen${status.index}" type="radio" status="${status.index}" class="teachingIsOpen" value="N"/><span>否</span></td>
					<td align="center"><input id="remark${status.index}" remarkVal="${teachingPlan.remark}" class="easyui-textbox" style="width:250px;" /></td>
				</tr>
			   </c:forEach>
      	    </table>
  		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:right">
	      		<a href="javascript:void(0)" id="updatePlanSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="updatePlanSubmit()"><span>提交</span></a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
  	<script type="text/javascript">
		$(document).ready(function(){
			var month = $("#teachingMonth").html();
   			var str = month.split("-");
    		var maxDays = DayNumOfMonth(str[0],str[1]);
   			for(var i = 0;i < ${fn:length(obj.teachingPlan)};i++)
   			{
   				var teachingDate = $("#teachingDate"+i+"").attr('dateVal');
   				if(teachingDate != "/"){
   					teachingDate = teachingDate.substring(8);
	   				$("#teachingDate"+i+"").numberbox('setValue',teachingDate);
   				}
   			
   				var startDate = $("#startDate"+i+"").attr('dateVal');
   				if(startDate != "/")
   				{
   					startDate = startDate.substring(8);
	   				$("#startDate"+i+"").numberbox('setValue',startDate);
   				}
   				
   				var meetingDate = $("#meetingDate"+i+"").attr('dateVal');
   				if(meetingDate != "/"){
   					meetingDate = meetingDate.substring(8);
	   				$("#meetingDate"+i+"").numberbox('setValue',meetingDate);
   				}
   				
   				var openClassDate = $("#openClassDate"+i+"").attr('dateVal');
   				if(openClassDate != "/"){
   					openClassDate = openClassDate.substring(8);
	   				$("#openClassDate"+i+"").numberbox('setValue',openClassDate);
   				}
   				var gradDate = $("#gradDate"+i+"").attr('dateVal');
   				if(gradDate != "/"){
   					gradDate = gradDate.substring(8);
	   				$("#gradDate"+i+"").numberbox('setValue',gradDate);
   				}
   				$("input[name='teachingIsOpen"+i+"']").each(function(index,node){
					if(node.value == $("#teachingIsOpen"+i).val())
					{
						$(this).prop("checked","checked");
						if(node.value == "N"){
						   $("#teaDiv"+i).css("display", "none");
						   $("#meetDiv"+i).css("display", "none");
						   $("#openDiv"+i).css("display", "none");
						   $("#gradDiv"+i).css("display", "none");
						}
					}
				});
   				var remark = $("#remark"+i+"").attr('remarkVal');
   				if(remark != ""){
   					$("#remark"+i+"").textbox('setValue',remark);
   				}
   				$("#teachingDate"+i+"").numberbox({
					min:1,
					max:maxDays,
				}); 
				$("#meetingDate"+i+"").numberbox({
					min:1,
					max:maxDays,
				/**	onChange:function(data){
						var c = $(this).attr("status");
						$("#openClassDate"+c).numberbox('clear');
						$("#gradDate"+c).numberbox('clear');
					} **/
				}); 
				$("#openClassDate"+i+"").numberbox({
					min:1,
					max:maxDays,
				/**	onChange:function(){
						var c = $(this).attr("status");
						$("#meetingDate"+c).numberbox('clear');
						$("#gradDate"+c).numberbox('clear');
					} **/
				}); 
				$("#gradDate"+i+"").numberbox({
					min:1,
					max:maxDays,
				/**	onChange:function(){
						var c = $(this).attr("status");
						$("#meetingDate"+c).numberbox('clear');
						$("#openClassDate"+c).numberbox('clear');
					} **/
				}); 
   			}
   			$(".teachingIsOpen").change(function() {
			   var val = $(this).val();
			   if(val == "Y"){
				   var status = $(this).attr("status");
				   $("#teaDiv"+status).css("display", "block");
				   $("#meetDiv"+status).css("display", "block");
				   $("#openDiv"+status).css("display", "block");
				   $("#gradDiv"+status).css("display", "block");
			   }else if(val == "N"){
				   var status = $(this).attr("status");
				   $("#teaDiv"+status).css("display", "none");
				   $("#meetDiv"+status).css("display", "none");
				   $("#openDiv"+status).css("display", "none");
				   $("#gradDiv"+status).css("display", "none");
			   }
		   });
		   $("input[type=text]").each(function(i,node){
				$(node).attr("maxlength",50);
			});
   		});
   		function clearOthers(index,saveObj,clearObj1,clearObj2,clearObj3)
		{
			var currentNum = $("#"+saveObj+index).numberbox("getValue");
			var dateNum = $("#"+saveObj+index).attr("dateNum");
			if(currentNum != dateNum)
			{
				$("#"+clearObj1+index).numberbox('clear');
				$("#"+clearObj2+index).numberbox('clear');
				$("#"+clearObj3+index).numberbox('clear');
			}
		}
		function saveCurrentNum(index,saveObj)
		{
			var currentNum = $("#"+saveObj+index).numberbox("getValue");
			$("#"+saveObj+index).attr("dateNum",currentNum);
			var dateNum = $("#"+saveObj+index).attr("dateNum");
		}
	</script>
</html>

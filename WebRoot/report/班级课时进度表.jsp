<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/newRecruit.js"></script>
  	</head>
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm" style="margin:0 auto;">
	  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
	  				<tr>
	  					<td align="right"><span>校区：</span></td>
	  					<td align="left"  width="120px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
					      		url="<%=path %>/pubData/qrySchoolList.do?">
				        	</select>
	  					</td>
	  					<td align="right"><span>班级：</span></td>
	  					<td align="left"  width="120px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
					      		url="<%=path %>/pubData/qrySchoolList.do?">
				        	</select>
	  					</td>
	  					<td align="right"><span>教师：</span></td>
	  					<td align="left"  width="120px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
					      		url="<%=path %>/pubData/qrySchoolList.do?">
				        	</select>
	  					</td>
	  					<td align="right"><span>阶段：</span></td>
	  					<td align="left"  width="120px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
					      		url="<%=path %>/pubData/qrySchoolList.do?">
				        	</select>
	  					</td>
	  					<td width="100px" align="right"><span>日期：</span></td>
						<td width="114px">
							<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="startTime" name="startTime" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="center">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="5007">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>	
	  			</table>
  			</form>
  		   <div style="min-width:1100px;width:99%;margin:0 auto;">
		<div class="easyui-panel" title="排课信息" style="width:100%;overflow:auto;">
		<table class="maintable" id="hoursPlanTab" style="width:1500px;" cellspacing="0" cellpadding="0">
		  <tr align="center">
		    <td align="center" width="40px;" rowspan="2"><span>序号</span></td>
		     <td align="center" width="78px;" rowspan="2"><span>学校</span></td>
		    <td align="center" width="78px;" rowspan="2"><span>班级</span></td>
		    <td align="center" width="96px;" rowspan="2"><span>带班老师</span></td>
		    <td align="center" width="240px;"rowspan="2"><span>上课时段</span></td>
		    <td align="center" width="86px;" rowspan="2"><span>开课日期</span></td>
		    <td align="center" width="86px;" rowspan="2"><span>结课日期</span></td>
		    <td align="center" width="42px;" rowspan="2"><span>上月已上课时</span></td>
		    <td align="center" width="42px;" rowspan="2"><span>上月剩余课时数</span></td>
		    <td align="center" width="42px;" rowspan="2"><span>上月课时差异</span></td>
		    <td align="center" width="62px;" colspan="3"><span>第一周</span></td>
		    <td align="center" width="62px;" colspan="3"><span>第二周</span></td>
		    <td align="center" width="62px;" colspan="3"><span>第三周</span></td>
		    <td align="center" width="62px;" colspan="3"><span>第四周</span></td>
		    <td align="center" width="62px;" colspan="3"><span>第五周</span></td>
		    <td align="center" width="62px;" colspan="3"><span>第六周</span></td>
		    <td align="center" width="62px;" colspan="3"><span>第日周</span></td>
		    <td align="center" width="48px;" rowspan="3"><span>本月计划课时</span></td>
		    <td align="center" width="48px;" rowspan="3"><span>本月已排课时</span></td>
		    <td align="center" width="48px;" rowspan="3"><span>课时差异</span></td>
		  </tr>
		  <tr align="center">
		    <td align="center" width="40px;"><span>剩余课时</span></td>
		    <td align="center" width="40px;"><span>计划课时</span></td>
		    <td align="center" width="40px;"><span>已排课时</span></td>
		    <td align="center" width="40px;"><span>剩余课时</span></td>
		    <td align="center" width="40px;"><span>计划课时</span></td>
		    <td align="center" width="40px;"><span>已排课时</span></td>
		    <td align="center" width="40px;"><span>剩余课时</span></td>
		    <td align="center" width="40px;"><span>计划课时</span></td>
		    <td align="center" width="40px;"><span>已排课时</span></td>
		    <td align="center" width="40px;"><span>剩余课时</span></td>
		    <td align="center" width="40px;"><span>计划课时</span></td>
		    <td align="center" width="40px;"><span>已排课时</span></td>
		    <td align="center" width="40px;"><span>剩余课时</span></td>
		    <td align="center" width="40px;"><span>计划课时</span></td>
		    <td align="center" width="40px;"><span>已排课时</span></td>
		    <td align="center" width="40px;"><span>剩余课时</span></td>
		    <td align="center" width="40px;"><span>计划课时</span></td>
		    <td align="center" width="40px;"><span>已排课时</span></td>
		    <td align="center" width="40px;"><span>剩余课时</span></td>
		    <td align="center" width="40px;"><span>计划课时</span></td>
		    <td align="center" width="40px;"><span>已排课时</span></td>
		  </tr>
		</table>
		</div>
		</div>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
			</div>
  		</div>	
  	</body>
</html>
<script type="text/javascript">
	$("#qryBtn").click(function() {
		var object = $("#qryFm").serializeObject();
    	var obj = JSON.stringify(object);
    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
    	$.ajax(
				{
					type : "POST",
					url : "/sys/report/getHours.do?param="+obj,
					async: true,
					dataType:"json",
					beforeSend: function()
			    	{
			    		//$.messager.progress({text:'排课中，请稍候...'});
			    	},
			    	success: function(data) 
			    	{
			    		alert(JSON.stringify(data));
			    		var html="<tr>"+$("#hoursPlanTab").find("tr:eq(0)").html()+"</tr><tr>"+$("#hoursPlanTab").find("tr:eq(1)").html()+"</tr>";
			    		for(var i=0;i<data.length;i++)
			    		{
			    			var obj=data[i];
			    			 html+="<tr>";
			    			html+="<td align='center'>"+(i+1)+"</td>";
			    			html+="<td align='center'><span>"+obj.className+"</span></td>";
			    			html+="<td align='center'><span>"+obj.byname+"</span></td>";
			    			html+="<td align='center'><span>"+obj.dateRange+"</span></td>";
			    			html+="<td align='center'><span>"+obj.startDate+"</span></td>";
			    			html+="<td align='center'><span>"+obj.finishDate+"</span></td>";
			    			html+="<td align='center'><span>"+obj.realHour+"</span></td>";
			    			html+="<td align='center'><span>"+obj.diffNum+"</span></td>";
			    			html+="<td align='center'><span>"+obj.monthDiffNum+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekPlan1+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekHand1+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekPlan2+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekHand2+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekPlan3+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekHand3+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekPlan4+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekHand4+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekPlan5+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekHand5+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekPlan6+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekHand6+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekPlan7+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekHand7+"</span></td>";
			    			html+="<td align='center'><span>"+obj.monthPlanHours+"</span></td>";
			    			html+="<td align='center'><span>"+obj.monthHandHours+"</span></td>";
			    			html+="<td align='center'><span>"+obj.mDiffNum+"</span></td>";
			    			html+="</tr>";
			    		}
						
						$("#hoursPlanTab").html(html);
			    	},
			    	  error:function()
			        {
			    		alert("1");
			        	$.messager.progress('close');
			        }
			   });
    });
</script>

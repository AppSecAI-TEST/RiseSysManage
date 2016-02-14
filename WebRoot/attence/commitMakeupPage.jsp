<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<style type="text/css">
			td{
				font-size:14px;
				font-family:"微软雅黑";
			}
		</style>
		<script type="text/javascript">
			var gTableData = '${makeupInfo}';
			try{
				gTableData = eval("("+gTableData+")");
			}catch(e){
				
			}
			$(document).ready(function(){
				$('#manList').datagrid({
					title:"提交补课记录",
					pagination:true,
					rownumbers:true,
					fitColumns:true,
					singleSelect:true,
					height:500,
					data:gTableData,
					columns:[[
						{
							field:'classHours',title:'课时进度',align:'center',width:50
						},
						{
							field:'attendTypeName',title:'考勤状态',align:'center',width:50
						},
						{
							field:'attendDate',title:'缺课日期',align:'center',width:150,formatter:function(value){return new Date(value).format("yyyy-MM-dd")}
						},
						{
							field:'isMakeup',title:'是否补课',align:'center',width:50
						},
						{
							field:'makeupSchoolDate',title:'补课时间',align:'center',width:150
						},
						{
							field:'makeupTypeName',title:'补课方式',align:'center',width:100
						},
						{
							field:'makeupTeacherName',title:'补课老师（单独补）',align:'center',width:120
						},
						{
							field:'makeupClassName',title:'补课班级（跟班补）',align:'center',width:120
						},
						{
							field:'leaveUrl',title:'请假单', width:100,align:'center',formatter:function(val){
								return "<a href='javascript:void(0)'>查看</a>";
							}
						},
						{
							field:'makeupUrl',title:'补课单', width:100,align:'center',formatter:function(val){
								return "<a href='javascript:void(0)'>查看</a>";
							}
						},
						{
							field:'classAttendId',title:'操作', width:100,align:'center',formatter:function(val,row){
								if(row.isMakeup == '否')
								{
									return "<a href='javascript:void(0)' class='oper_button' style='width: 100px;' onclick=commitMakeupFunc("+val+","+row.studentAttendId+",'"+row.attendType+"','"+row.interval+"')>补课</a>";
								}
								else
								{
									return "";
								}
							}
						}
					]],
					onLoadSuccess:function(data){
			            $(".oper_button").linkbutton({ 
			                text:'补课',
			                iconCls:'icon-add'
			            });
			        }
				});
			});
			function commitMakeupFunc(classAttId,stuAttId,attType,interVal)
			{
				ajaxLoading("正在处理，请稍待。。。");
				window.location.href = "/sys/attend/commitMakeupDetailPage.do?studentId=${studentId}&classAttendId="+classAttId+"&funcNodeId=${funcNodeId}&studentAttendId="+stuAttId+"&attendType="+attType+"&interval="+interVal;
			}
			function backFunc()
			{
				window.location.href = "/sys/attence/leaveMakeupMan.jsp?funcNodeId=${funcNodeId}";
			}
		</script>
  	</head>
  	<body>
		<div style="padding:5px 0;min-width:1100px; width:100%">
			<table id="manList">
				
			</table>
			<p style="text-align:right;margin-right:5px">
				<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
			</p>
		</div>
 	</body>
</html>
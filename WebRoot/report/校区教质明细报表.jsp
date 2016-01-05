<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
  	</head>
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm" style="margin:0 auto;">
	  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:120px;" cellpadding="2">
	  				<tr>
	  					<td align="right"><span>校区：</span></td>
	  					<td align="left">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 120px; height: 25px;"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
					      		url="<%=path %>/pubData/qrySchoolList.do?">
				        	</select>
	  					</td>
	  					<td align="right"><span>阶段：</span></td>
	  					<td align="left">
	  						<select id="stageId" name="stageId" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
			      				url="<%=path %>/pubData/qryStage.do">
				        	</select>
	  					</td>
	  					<td align="right"><span>班级：</span></td>
	  					<td align="left">
	  						<select class="easyui-combobox" name="classInstId" id="classInstId" style="width:120px;"
	  							data-options="formatter:formatClassInst, valueField: 'classInstId', textField: 'className', panelHeight: 'auto'">
	  						</select>
	  					</td>
	  					<td align="right"><span>时间：</span></td>
	  					<td align="left">
	  						<input class="easyui-datebox"  type="text" style="width:120px; height: 25px;" id="month" name="month" editable="false" data-options="formatter:myformatter, parser:myparser"/>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right"><span>公开课满意度：</span></td>
	  					<td align="left">
	  						<input class="easyui-numberbox" name="min1" id="min1"  style="width:38px;" data-options="min:0,max:99,precision:0" />%至
	  						<input class="easyui-numberbox" name="max1" id="max1"  style="width:38px;" data-options="min:1,max:100,precision:0" />%
	  					</td>
	  					<td align="right"><span>毕业典礼满意度：</span></td>
	  					<td align="left">
	  						<input class="easyui-numberbox" name="min2" id="min2"  style="width:38px;" data-options="min:0,max:99,precision:0" />%至
	  						<input class="easyui-numberbox" name="max2" id="max2"  style="width:38px;" data-options="min:1,max:100,precision:0" />%
	  					</td>
	  					<td align="right"><span>电教完成率：</span></td>
	  					<td align="left">
	  						<input class="easyui-numberbox" name="min3" id="min3"  style="width:38px;" data-options="min:0,max:99,precision:0" />%至
	  						<input class="easyui-numberbox" name="max3" id="max3"  style="width:38px;" data-options="min:1,max:100,precision:0" />%
	  					</td>
	  					<td align="right"><span>家长会满意度：</span></td>
	  					<td align="left">
	  						<input class="easyui-numberbox" name="min4" id="min4"  style="width:38px;" data-options="min:0,max:99,precision:0" />%至
	  						<input class="easyui-numberbox" name="max4" id="max4"  style="width:38px;" data-options="min:1,max:100,precision:0" />%
	  					</td>
	  				</tr>	
	  				<tr>		
	  					<td align="right"><span>老师：</span></td>
	  					<td align="left">
	  						<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:120px;"
	  							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'">
	  						</select>
	  					</td>
	  					<td align="right"><span>是否完成：</span></td>
	  					<td align="left">
	  						<input type="radio" name="isFinish" value="Y"><lable><span>是</span></lable>
	  						<input type="radio" name="isFinish" value="N"><lable><span>否</span></lable>
	  					</td>
	  					<td align="left" colspan="4">	
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:120px" id="qryBtn" funcNodeId ="3708"><span>查询</a>
	  						&nbsp;&nbsp;&nbsp;&nbsp;
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" style="width:120px" id="resetBtn"><span>重置</a>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
			<div style="padding:5px 0;min-width:1100px; width:100%;">
				<table class="easyui-datagrid" style="height:435px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true">
					<thead>
						<tr>
							<th field="schoolName" align="center" width="6%" rowspan="2">校区</th>
							<th field="className" align="center" width="6%" rowspan="2">班级</th>
							<th field="studyingNum" align="center" width="5%" rowspan="2">在读人数</th>
							<th field="byname" align="center" width="10%" rowspan="2">带班老师</th>
							<th align="center" width="18%" colspan="3">课后复习(上月)</th>
							<th align="center" width="15%" colspan="3">家长会</th>
							<th align="center" width="15%" colspan="3">毕业典礼</th>
							<th align="center" width="15%" colspan="3">公开课</th>
							<th field="isFinish" align="center" width="6%" rowspan="2">是否完成</th>
						</tr>
						<tr>
							<th field="teachingNum" align="center" width="5%">参与人数</th>
							<th field="oneNum" align="center" width="10%">1次课后复习人数</th>
							<th field="teaRateVal" align="center" width="6%">电教完成率</th>
							<th field="studentMeetingNum" align="center" width="5%">参与人数</th>
							<th field="attendMeetingVal" align="center" width="5%">出勤率</th>
							<th field="meetingCsiVal" align="center" width="6%">满意度</th>
							<th field="studentGradNum" align="center" width="6%">参与人数</th>
							<th field="attendGradVal" align="center" width="5%">出勤率</th>
							<th field="gradCsiVal" align="center" width="5%">满意度</th>
							<th field="studentOpenNum" align="center" width="5%">参与人数</th>
							<th field="openCsiVal" align="center" width="5%">出勤率</th>
							<th field="attendOpenVal" align="center" width="6%">满意度</th>
						</tr>
					</thead>
				</table>
			</div>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
			</div>
  		</div>
  	</body>
</html>
<script>

$(document).ready(function(){
	 $('#month').datebox({
            onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
        		var p = $('#month').datebox('panel'), //日期选择对象
            	span = p.find('span.calendar-text'); //显示月份层的触发控件
            	p.find(".calendar-menu-year").attr("readOnly","true");
            	span.click(function(){
            		p.find('div.calendar-menu').hide();
            	});
                span.get(0).click(); //触发click事件弹出月份层
                p.find("div.datebox-button").find("td:eq(0)").css("visibility","hidden");//隐藏今天按钮
                var months = p.find(".calendar-menu-month-inner").find(".calendar-menu-month");
                months.unbind();
                months.click(function(){
                	var year = /\d{4}/.exec(span.html())[0]//得到年份
                    , month = parseInt($(this).attr('abbr'))+1;
                	if(month<10)
                	{
                		month="0"+month;
                	}
                	var val =year + '-' + month+"-00";
                    $('#month').datebox('setValue',val).datebox('hidePanel'); //设置日期的值
             	});
            }
    	});
	 
	 	$("#schoolId").combobox({
	 		onChange:function(){
	 			$("#classInstId").combobox({
					url:"/sys/pubData/qryClassInstList.do?schoolId="+$("#schoolId").combobox('getValue')+"&stageId="+$("#stageId").combobox('getValue')
				});
	 			$("#teacherId").combobox({
					url : "/sys/pubData/getTeacherBySchoolId.do?schoolId="+$("#schoolId").combobox('getValue')
				});
	 		}
	 	});
	 	$("#stageId").combobox({
	 		onChange:function(){
	 			$("#classInstId").combobox({
					url:"/sys/pubData/qryClassInstList.do?schoolId="+$("#schoolId").combobox('getValue')+"&stageId="+$("#stageId").combobox('getValue')
				});
	 		}
	 	});
	 	initQryButton("qryBtn","resetBtn","qryFm","list_data");
	 	exportLink("export","list_data");
});


function myformatter(date){
            var y = date.getFullYear();
            var m = date.getMonth()+1;
            var d = date.getDate();
            return y+'-'+(m<10?('0'+m):m);
        }

  function myparser(s){
            if (!s) return new Date();
            var ss = (s.split('-'));
            var y = parseInt(ss[0],10);
            var m = parseInt(ss[1],10);
            var d = parseInt(ss[2],10);
            if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
                return new Date(y,m-1,d);
            } else {
                return new Date();
            }
        }
</script>
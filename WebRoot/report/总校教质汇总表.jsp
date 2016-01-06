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
	  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellpadding="2">
	  				<tr>
	  					<td align="right"><span>月份：</span></td>
	  					<td align="left">
	  						<input class="easyui-datebox"  type="text" style="width:120px; height: 25px;" id="month" name="month" editable="false" data-options="formatter:myformatter, parser:myparser"/>
	  					</td>
	  					<td align="right"><span>综合完成率：</span></td>
	  					<td align="left">
	  						<input class="easyui-numberbox" name="minFinish" id="minFinish"  style="width:60px;" data-options="min:0,max:99,precision:0" />%至
	  						<input class="easyui-numberbox" name="maxFinish" id="maxFinish"  style="width:60px;" data-options="min:1,max:100,precision:0" />%
	  					</td>
	  					<td align="right"><span>综合满意度：</span></td>
	  					<td align="left">
	  						<input class="easyui-numberbox" name="minCsi" id="minCsi"  style="width:60px;" data-options="min:0,max:99,precision:0" />%至
	  						<input class="easyui-numberbox" name="maxCsi" id="maxCsi"  style="width:60px;" data-options="min:1,max:100,precision:0" />%
	  					</td>
	  					<td align="center" >	
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:120px" id="qryBtn" funcNodeId ="3709"><span>查询</a>
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
							<th field="classNum" align="center" width="6%" rowspan="2">当月开展<br>教质事件<br>班级数</th>
							<th field="studentNum" align="center" width="7%" rowspan="2">应参与在读<br>学员人数</th>
							<th align="center" width="17%" colspan="3">电教调查(上月完成情况)</th>
							<th align="center" width="15%" colspan="3">家长会</th>
							<th align="center" width="15%" colspan="3">公开课</th>
							<th align="center" width="15%" colspan="3">毕业典礼</th>
							<th field="finishPer" align="center" width="7%" rowspan="2">综合完成率</th>
							<th align="center" width="29%" colspan="4">满意度情况</th>
						</tr>
						<tr>
							<th field="teachingNum" align="center" width="5%">参与人数</th>
							<th field="oneNum" align="center" width="7%">1次电教人数</th>
							<th field="teachingPer" align="center" width="6%">电教完成率</th>
							<th field="planMeetingNum" align="center" width="6%">计划家长会<br>次数</th>
							<th field="meetingNum" align="center" width="6%">实际家长会<br>次数</th>
							<th field="meetingPer" align="center" width="6%">家长会<br>完成率</th>
							<th field="planOpenNum" align="center" width="6%">计划公开课<br>次数</th>
							<th field="openNum" align="center" width="6%">实际公开课<br>次数</th>
							<th field="openPer" align="center" width="6%">公开课<br>完成率</th>
							<th field="planGradNum" align="center" width="6%">计划毕业<br>典礼次数</th>
							<th field="gradNum" align="center" width="6%">实际毕业<br>典礼次数</th>
							<th field="gradPer" align="center" width="6%">毕业典礼<br>完成率</th>
							<th field="meetingCsi" align="center" width="7%">家长会满意度</th>
							<th field="openCsi" align="center" width="7%">公开课满意度</th>
							<th field="gradCsi" align="center" width="8%">毕业典礼满意度</th>
							<th field="csiPer" align="center" width="7%">综合满意度</th>
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
	 	var now =new Date();
	 	$('#month').datebox("setValue",now.getFullYear()+"-"+(now.getMonth()+1));
	 	$("#qryBtn").click(function() {
    		var obj = JSON.stringify($("#qryFm").serializeObject());
    		obj = obj.substring(0, obj.length - 1);
    		var funcNodeId = $("#qryBtn").attr("funcNodeId");
    		obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
    		$("#list_data").datagrid({
	    		url : "/sys/export/qryCenterTeaFeedback.do",
	    		queryParams:{
	    			param : obj
	    		}
    		});    
    	});
	    $("#resetBtn").click(function() {
	    	$("#qryFm").form('clear');
	    	var now =new Date();
	 		$('#month').datebox("setValue",now.getFullYear()+"-"+(now.getMonth()+1));
	    });
	    $("#export").click(function(){
			if($("#list_data").datagrid("getData").total>0)
			{
				var fileName =parent.$("li.tabs-selected").find("span.tabs-title").html();
				try
				{
					window.location.href="/sys/export/exportCenterTeaFeedback.do?fileName="+fileName+"&param="+JSON.stringify($("#list_data").datagrid("options").queryParams.param);
				}
				catch(e)
				{
					$.messager.alert('提示', "模版不存在！",function(){
						window.history.back();
					});
				}
			}
			else
			{
				$.messager.alert('提示', "没有数据可以导出！");
			}	
		});
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
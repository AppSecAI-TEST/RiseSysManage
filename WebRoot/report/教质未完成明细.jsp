

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  	<body>
 		<div style="margin-right:5px;">
  			<input type="hidden" id="resourceId" value="722">
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId}"/>
  			<form id="qryFm">
	  			<table class="search_tab">
  				<tr>
  						<td align="right" width="80px"><span>校区：</span></td>
	  					<td align="left"  width="110px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        	</select>
	  					</td>
	  					<td align="right" width="60px"><span>阶段：</span></td>
	  					<td align="left" width="110px">
	  						<select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px; height: 25px;"
								data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
			      				url="<%=path %>/pubData/qryStage.do">
				        	</select>
	  					</td>
	  					<td align="right" width="60px"><span>班级：</span></td>
	  					<td align="left" width="110px">
	  						<select class="easyui-combobox" name="classInstId" id="classInstId" style="width:100px;height: 25px;"
	  							data-options="formatter:formatClassInst, valueField: 'classInstId', textField: 'className', panelHeight: 'auto'">
	  						</select>
	  					</td>
	  					<td align="right" width="60px"><span>老师：</span></td>
	  					<td align="left">
	  						<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:100px;"
	  							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'">
	  						</select>
	  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>月份：</span></td>
	  				<td align="left">
	  					<input class="easyui-datebox"  type="text" style="width:100px; height: 25px;" id="month" name="month" editable="false" data-options="formatter:myformatter, parser:myparser"/>
	  				</td>
  					<td align="right" colspan="5">
  						<span>未完成原因：</span>
  						<input type="checkbox" id="001" name="001" onclick="clickControl(this,true)">&nbsp;<span>电教未完成</span>&nbsp;&nbsp;&nbsp;&nbsp;
  						<input type="checkbox" id="002" name="002" onclick="clickControl(this,true)">&nbsp;<span>出勤率未达80%</span>&nbsp;&nbsp;&nbsp;&nbsp;
  						<input type="checkbox" id="003" name="003" onclick="clickControl(this,false)">&nbsp;<span>未开教质事件</span>&nbsp;&nbsp;&nbsp;&nbsp;
  					</td>
  					<td align="left">
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:100px" id="qryBtn" funcNodeId ="3710" ><span>查询</span></a>
  						&nbsp;&nbsp;
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:100px" id="resetBtn" ><span>重置</span></a>
  					</td>
  				</tr>
  			</table>
 		</form>
 		
 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:450" id="list_data" toolbar="#toolbar" rownumbers="true" fitColumns="true">
			<thead>
				<tr>
					<th field="schoolName" align="center" width="10%">校区</th>
					<th field="className" align="center" width="15%">班级</th>
					<th field="byname" align="center" width="20%">带班老师</th>
					<th field="qualityType" align="center" width="20%">教质事件</th>
					<th field="reason" align="center" width="35%">未完成原因</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
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
	 	initReportButton("resetBtn","qryFm","schoolId");
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
	 	var now =new Date();
	 	$('#month').datebox("setValue",now.getFullYear()+"-"+(now.getMonth()+1));
	 	$("#qryBtn").click(function() {
    		var obj = JSON.stringify($("#qryFm").serializeObject());
    		obj = obj.substring(0, obj.length - 1);
    		var funcNodeId = $("#qryBtn").attr("funcNodeId");
    		obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
    		$("#list_data").datagrid({
	    		url : "/sys/pubData/qryDataListByPage.do",
	    		queryParams:{
	    			param : obj
	    		},
	    		onLoadSuccess:function(){
	    			MergeCells("list_data","schoolName");
	    			MergeCellWidthSchool("list_data","className");
	    			MergeCellWidthSchoolAndClass("list_data","byname");
	    		}
    		});    
    	});
	    $("#resetBtn").click(function() {
	    	var now =new Date();
	 		$('#month').datebox("setValue",now.getFullYear()+"-"+(now.getMonth()+1));
	    });
	    $("#export").click(function(){
			if($("#list_data").datagrid("getData").total>0)
			{
				var fileName =parent.$("li.tabs-selected").find("span.tabs-title").html();
				try
				{
					window.location.href="/sys/export/exportUnfinishFeedback.do?fileName="+fileName+"&param="+JSON.stringify($("#list_data").datagrid("options").queryParams.param);
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
  
  function MergeCellWidthSchool(tableID, fldList) {
            var Arr = fldList.split(",");
            var dg = $('#' + tableID);
            var fldName;
            var RowCount = dg.datagrid("getRows").length;
            var span;
            var PerValue = "";
            var PreSchool ="";
            var CurValue = "";
            var CurSchool ="";
            var length = Arr.length - 1;
            for (i = length; i >= 0; i--) {
                fldName = Arr[i];
                PerValue = "";
                PreSchool="";
                span = 1;
                for (row = 0; row <= RowCount; row++) {
                    if (row == RowCount) {
                        CurValue = "";
                        CurSchool="";
                    }
                    else {
                        CurValue = dg.datagrid("getRows")[row][fldName];
                        CurSchool =  dg.datagrid("getRows")[row]["schoolId"]
                    }
                    if (PerValue == CurValue&&PreSchool==CurSchool) {
                        span += 1;
                    }
                    else {
                        var index = row - span;
                        dg.datagrid('mergeCells', {
                            index: index,
                            field: fldName,
                            rowspan: span,
                            colspan: null
                        });
                        span = 1;
                        PerValue = CurValue;
                        PreSchool = CurSchool;
                    }
                }
            }
        }
  
  
  
  function MergeCellWidthSchoolAndClass(tableID, fldList) {
            var Arr = fldList.split(",");
            var dg = $('#' + tableID);
            var fldName;
            var RowCount = dg.datagrid("getRows").length;
            var span;
            var PerValue = "";
            var PreSchool ="";
            var PreClassId ="";
            var CurValue = "";
            var CurSchool ="";
            var CurClassId ="";
            var length = Arr.length - 1;
            for (i = length; i >= 0; i--) {
                fldName = Arr[i];
                PerValue = "";
                PreSchool="";
                span = 1;
                for (row = 0; row <= RowCount; row++) {
                    if (row == RowCount) {
                        CurValue = "";
                        CurSchool="";
                        CurClassId="";
                    }
                    else {
                        CurValue = dg.datagrid("getRows")[row][fldName];
                        CurSchool =  dg.datagrid("getRows")[row]["schoolId"]
                        CurClassId = dg.datagrid("getRows")[row]["classInstId"]	
                    }
                    if (PerValue == CurValue&&PreSchool==CurSchool&&PreClassId==CurClassId) {
                        span += 1;
                    }
                    else {
                        var index = row - span;
                        dg.datagrid('mergeCells', {
                            index: index,
                            field: fldName,
                            rowspan: span,
                            colspan: null
                        });
                        span = 1;
                        PerValue = CurValue;
                        PreSchool = CurSchool;
                        PreClassId=CurClassId;
                    }
                }
            }
        }
  
  function clickControl(obj,flag)
  {
	  if(flag)
	  {
		  if($(obj).is(":checked"))
		  {
			$("#003").removeAttr("checked");
		  }	  
	  }
	  else
	  {
		  if($(obj).is(":checked"))
		  {
			$("#001").removeAttr("checked"); 
			$("#002").removeAttr("checked"); 
		  }
	  }	  
  }
</script>
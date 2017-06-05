<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<script type="text/javascript" src="<%=path %>/js/teacherManage.js"></script>
  	</head>
  	<body>
  		<div style="margin-right:5px;">
 		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
					<td width="80px" align="right"><span>校区：</span></td>
	  				<td width="110px">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
						data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
			      		onLoadSuccess:function(data){$('#schoolId').combobox('setValue',data[0].schoolId);}"
			      		url="<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=5041&fieldId=schoolId">
		        		</select>
					</td>
					<td align="right" width="50px;">教师：</td>
  					<td width="100px;">
  						<input name="teacherId"  class="easyui-combobox vaildatebox" id="teacherId"
								style="width: 100px; height: 25px;"
								data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: '250px'"   />
  					</td>
  					<td align="right" width="50px;">班级：</td>
  					<td width="100px;">
  						<input name="className"  class="easyui-textbox" id="className" style="width: 100px; height: 25px;" />
  					</td>
					<td width="80px" align="right">
						<span>周：</span>
					</td>
					<td width="260px" align="left">
							<input class="easyui-datebox"  type="text" style="width:100px; height: 25px;" id="time" name="time" editable="false" data-options="formatter:myformatter, parser:myparser"/>
							<select class="easyui-combobox" name="week" id="week" style="width:120px;height: 25px;" editable="false"
	  							data-options="valueField: 'createWeekId', textField: 'text', panelHeight: 'auto'">
	  						</select>
					</td>
					<td align="left">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn">查询</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
  			</table>
 		</form>
 		 
		<table   align="center" class="easyui-datagrid" title="查询结果"   id="list_data" toolbar="#toolbar" pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
			 
		</table>
		<div id="toolbar" style="padding:5px;">
   			<a href="javascript:void(0)" id="export"  class="easyui-linkbutton" style="width:100px;" iconCls="icon-add" ><span>导出全部</span></a>
 		</div>
		
  		</div>
  		
  	</body>
</html>
<script type="text/javascript">

 
initResetButton("reset","qryFm");
 
 

	  //日期+天
 function AddDays(d, n,end) {
     var t = new Date(d);//复制并操作新对象，避免改动原对象
     t.setDate(t.getDate() + n);
     if(t> new Date(end))
     {
    	return ""; 
     }
     return t.format("yyyy-MM-dd");
 }
 
$("#qryBtn").click(function(){
	
	var schoolId=$("#schoolId").combobox('getValue');
	var teacherId=$("#teacherId").combobox('getValue');
	var schoolName =$("#schoolId").combobox('getText');
	var month=$("#time").datebox('getValue');
	var createWeekId=$("#week").combobox('getValue');
	var weekName =$("#week").combobox('getText')
	var className=$("#className").textbox('getValue');
	if(schoolId=='')
	{
			$.messager.alert('提示', "请选择校区");
			return;
	}
	
	if(createWeekId=='')
	{
			$.messager.alert('提示', "请选择周");
			return;
	}
	$("#content").css('display','none');
	$("#left_side").css('display','none');
	var datas=$("#week").combobox('getData');
	var weekSeq="";
	var dateRange="";
	for(var i=0;i<datas.length;i++)
	{
		var id = datas[i].createWeekId;
		if(id==createWeekId)
		{
			weekSeq=datas[i].weekName;
			dateRange=datas[i].dateRange;	
		}
	}
	var dates = dateRange.split("~");
	var startDate=dates[0];
	var endDate=dates[1];
	var param="{'month':'"+month+"','week':'"+weekSeq+"','dateRange':'"+dateRange+"','schoolId':'"+schoolId+"','teacherId':'"+teacherId+"','className':'"+className+"'}";
	$('#list_data').datagrid({  
		border:false,  
	    fitColumns:true,  
	    singleSelect: true,  
	    url: "/sys/time/getTeacherTimePlan.do?param="+param,
	    columns:[[  
	        {field:'teacherName',title:'教师英文名',align:'center',width:40},
	        {field:'timeT',title:'排班',align:'center',width:60},  
	        {field:'day0',title:startDate,align:'center',width:80},  
	        {field:'day1',title:AddDays(startDate,1,endDate),align:'center',width:80},  
	        {field:'day2',title:AddDays(startDate,2,endDate),align:'center',width:80},  
	        {field:'day3',title:AddDays(startDate,3,endDate),align:'center',width:80},  
	        {field:'day4',title:AddDays(startDate,4,endDate),align:'center',width:80},  
	        {field:'day5',title:AddDays(startDate,5,endDate),align:'center',width:80},
	        {field:'day6',title:AddDays(startDate,6,endDate),align:'center',width:80} 
	    ]],  
	    onLoadSuccess:function(data)
	    {  
	    	mergeCellsByField("list_data", "teacherName");
	       	$("table tr td").each(function()
			{
	       	   var attr=$(this).attr('field');
	       	   if(attr!='teacherName')
	       	   {
				   var d=$(this).text();
				   if(d.indexOf('/TA')>-1)
				   {
					     $(this).css("background-color","#00ff99");
				   }else if(d.indexOf('/T')>-1)
				   {
					  $(this).css("background-color","#ff6699");
				   }else if(d.indexOf('-TA')>-1 ||d.indexOf('-T')>-1 )
				   {
					     $(this).css("background-color","#aaff99");
				   } 
			    }
			});
	    }  
	});
});

	$("#export").click(function(){
		exportPage();
	});



function exportPage()
{
	if($("#list_data").datagrid("getData").rows.length>0)
	{
		var param={};
		param.name="课时计划";
		var columnArr =new Array();
		$(".datagrid-header-row").find("td").each(function(index){
			var columnObj ={};
			columnObj[index+1+""]=$(this).text();
			columnArr.push(columnObj);
		})
		param.cloumn =columnArr;
		var dataArr =new Array();
		$(".datagrid-body").find(".datagrid-btable").find(".datagrid-row").each(function(){
			var dataObj ={};
			$(this).find("td").each(function(index){
				dataObj[index+1+""]=$(this).find("div").html();
			})
			dataArr.push(dataObj);
		})
		param.data =dataArr;
		window.location.href="/sys/export/exportPageInfo.do?param="+JSON.stringify(param);

	}
	else
	{
		showMessage("提示","暂无数据进行导出",null);
		return false;
	}	
}
$(document).ready(function()
{
	//getWeekTime();
		var staffId=$("#staffId").val();
	    $("#schoolId").combobox({
	    	url:"<%=path %>/pub/pageCategory.do?staffId="+staffId+"&resourceId=504&fieldId=schoolId",
	    	onLoadSuccess:function(){
				var arr =$("#schoolId").combobox("getData");
				if(arr.length>0)
				{
					$("#schoolId").combobox("select",arr[0].schoolId);
				}	
			}                                   
	    });
	
		$('#time').datebox({
            onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
        		var p = $('#time').datebox('panel'), //日期选择对象
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
                    $('#time').datebox('setValue',val).datebox('hidePanel'); //设置日期的值
             	});
            }, 
            onChange:function(newValue){
            	var schoolId=+$("#schoolId").combobox('getValue');
            	$.ajax(
				{
					type : "POST",
					url: "/sys/time/getPlanTime.do?schoolId="+schoolId+"&month="+newValue,
					async: true,
					dataType:"json",
					beforeSend: function()
			    	{
			    		//$.messager.progress({text:'排课中，请稍候...'});
			    	},
			    	success: function(data) 
			    	{
			    		$.messager.progress('close');
			    		var dataobj ={
			    			rows:data,
			    			total:data.length
			    		}
			    		$("#hoursPlanTab").datagrid("loadData",dataobj);
			         },
			        error:function()
			        {
			        	$.messager.progress('close');
			        }
				});
            	 
            	$("#week").combobox({data:null});
            	$.ajax(
				{
					type : "POST",
					url: "/sys/time/getPlanTime.do?schoolId="+schoolId+"&month="+$("#time").datebox('getValue'),
					async: true,
					dataType:"json",
					beforeSend: function()
			    	{
			    		//$.messager.progress({text:'排课中，请稍候...'});
			    	},
			    	success: function(data) 
			    	{
			    		$.messager.progress('close');
			    		$("#week").combobox({data:data});
			         },
			        error:function()
			        {
			        	$.messager.progress('close');
			        }
				});
            }
            });
   	var now =new Date();
	$('#time').datebox("setValue",now.getFullYear()+"-"+(now.getMonth()+1));
	$("#reset").click(function(){
		resetData();
	})
	
	$("#schoolId").combobox({
		
	 		onChange:function(n,o)
	 		{
				$("#week").combobox({data:null});
            	$.ajax(
				{
					type : "POST",
					url: "/sys/time/getPlanTime.do?schoolId="+n+"&month="+$("#time").datebox('getValue'),
					async: true,
					dataType:"json",
					beforeSend: function()
			    	{
			    		//$.messager.progress({text:'排课中，请稍候...'});
			    	},
			    	success: function(data) 
			    	{
			    		$.messager.progress('close');
			    		$("#week").combobox({data:data});
			         },
			        error:function()
			        {
			        	$.messager.progress('close');
			        }
				});
            	
            	var sId =$("#schoolId").combobox("getValue");
				var urls ="<%=path %>/pubData/qryTeacherList.do?schoolId="+sId;
				$("#teacherId").combobox({
					url:urls
				});
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
        
function mergeCellsByField(tableId, colList) {
    var rowspan;
    var megerIndex;
    var before = "";
    var after = "";
    var target = $("#" + tableId);
    var colunms = colList.split(",");
    var rows = target.datagrid("getRows").length;
    for (var j = colunms.length - 1; j >= 0; j--) {
    	var field = colunms[j];
    	before = "";
        rowspan = 1;
        megerIndex = 0;
        for (var i = 0; i <= rows; i++) {
            if (i == rows) {
            	after = "";
            } else {
            	after = target.datagrid("getRows")[i][field];
            }
            if (before == after) {
            	rowspan += 1;
            } else {
            	target.datagrid("mergeCells", {
        			index: i - rowspan,
        			field: field,　　// 合并字段
        			rowspan: rowspan
        		});
            	rowspan = 1;
            }
            before = after;
        }
    }
}
</script>

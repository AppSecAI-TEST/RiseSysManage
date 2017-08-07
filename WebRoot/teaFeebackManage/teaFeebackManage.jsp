<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<link href="<%=path %>/pub/js/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=path %>/pub/js/uploadify/jquery.uploadify.js"></script>
		<script type="text/javascript" src="<%=path %>/js/teaFeebackManage/teaFeebackManage.js"></script>
  	</head>
  	<body>
  		<div style="margin-right:5px">
  		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
 		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td align="right" width="7%"><span>所属校区：</span></td>
  					<td align="left" width="8%">
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:100px;height:25px;">
			        	</select>
  					</td>
  					<td align="right" width="8%"><span>课程阶段：</span></td>
  					<td align="left" width="8%">
  						<select name="stageId"  id="stageId"  style="width:100px;height:25px;" class="easyui-combobox" editable='false'
     						data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'"
     						url="<%=path %>/pubData/qryStage.do">
	      				</select>
  					</td>
  					<td align="right" width="8%"><span>班级：</span></td>
  					<td align="left" width="8%">
						<input id="classInstId" name="className" class="easyui-textbox" style="width:100px;height:25px;" />
					</td>
  					</td>
  					<td align="right" width="8%"><span>开课时间：</span></td>
  					<td align="left" width="8%">
  						<input class="easyui-datebox" name="startTime" id="startTime" style="width:100px;height:25px;" />
  					</td>
  					<td align="center" width="2%"><span>至</span></td>
  					<td align="left" width="20%">
  						<input class="easyui-datebox" name="endTime" id="endTime" style="width:100px;height:25px;" />
  					</td>
  					<td></td>
  				</tr>
  				<tr>
  					<td align="right"><span>带班老师：</span></td>
  					<td align="left">
  						<select id="teacherId" name="teacherId" class="easyui-combobox" style="width:100px;height:25px;">
				        </select>
  					</td>
  					<td align="right"><span>是否反馈：</span></td>
  					<td align="center">
  						<input name="feedback" type="checkbox" value="Y" style="margin:0 auto;vertical-align:middle;" /><span>是</span>
  						&nbsp;&nbsp;&nbsp;<input name="feedback" type="checkbox" value="N" style="margin:0 auto;vertical-align:middle;" /><span>否</span>
  					</td>
  					<td align="right" width="10%"><span>教质月份：</span></td>
					<td align="left" width="10%">
						<input class="easyui-datebox" type="text" style="width:100px;height:25px;" id="time" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
  					<td align="right"><span>班级状态：</span></td>
  					<td align="left">
  						<select id="classState" name="classState" class="easyui-combobox" style="width:100px;height:25px;"
	  						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE&codeFlag=003,004">
        				</select>
  					</td>
  					<td colspan="2" align="center">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px;" id="qryBtn" funcNodeId="4500"><span>查询</span></a>
						&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px;" id="resetBtn" ><span>重置</span></a>
					</td>
					<td></td>
  				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:530" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="10%"><span>校区</span></th>
					<th field="className" align="center" width="10%"><span>班级名称</span></th>
					<th field="openDate" align="center" width="10%"><span>开课时间</span></th>
					<th field="teacherName" align="center" width="10%"><span>带班老师</span></th>
					<th field="reflect" align="center" width="9%"><span>是否反馈</span></th>
					<th field="createDate" align="center" width="10%"><span>反馈时间</span></th>
					<th field="teachingDate" align="center" width="10%"><span>电教时间</span></th>
					<th field="startDate" align="center" width="10%"><span>开班时间</span></th>
					<th field="meetingDate" align="center" width="10%"><span>家长会时间</span></th>
					<th field="openClassDate" align="center" width="10%"><span>公开课时间</span></th>
					<th field="gradDate" align="center" width="10%"><span>毕业典礼时间</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" id="toolBtn1" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="addTeaFeedBack()"><span>添加反馈</span></a>
   			<a href="javascript:void(0)" id="toolBtn4" class="easyui-linkbutton" iconCls="icon-add" style="width:150px;" onclick="importTea()"><span>导入反馈（excel）</span></a>
   			<a href="javascript:void(0)" id="toolBtn2" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="updateTeaFeedBack()"><span>修改反馈</span></a>
 			<a href="javascript:void(0)" id="toolBtn3" class="easyui-linkbutton" iconCls="icon-redo" style="width:100px;" onclick="viewTeaFeedBack()"><span>浏览</span></a>
 		</div>
 		</div>
 		
 		<div id="dlg" class="easyui-dialog" style="width: 600px;height: 300px;" closed="true" data-options="modal:true" buttons="#dlgBtn">
 		
 		
 		
 		<table width="100%" cellpadding="5px" class="maintable">
 		<tr>
			<td width="15%" align="right">班级名称：</td>
			<td width="15%"  id="classNameText">
		  	 
			</td>
			<td width="15%"  align="right">
			 反馈月份： 
			</td>
			<td width="15%" id="monthText">
		 
			</td>
		</tr>
		<tr>
			<td width="15%"  align="right">
			 选择文件（excel）：
			</td> 
			<td colspan="3" style="position:relative" > 
			<input type="file" id="export1" name="export1" funcNodeId="111" class="button" value="导入" /></td>
		</tr>
		<div id="dlgBtn">
    		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
  		</div>
		 </table>
 		</div>
 		<script type="text/javascript">
 		
	    var qualityId;//教质计划ID
 		var classInstId;
	    			 
 		$(document).ready(function(){
 		 
 		if($("#staffId").val()!='1003')
 		{
 			$("#toolBtn4").css('display','none');
 		}	
 			
	    $("#export1").uploadify({
		"swf" : "/sys/pub/js/uploadify/uploadify.swf",
		"uploader" : "/sys/teaFeebackManage/uploadFile.do",
		"buttonText" : "",
		"buttonClass" : "btnbUpload",
		"queueID" : "upLoadProgress",
		"buttonImage" : "/sys/pub/images/btn_im_light.png",
		"fileTypeDesc" : "请上传一个指定格式的excel文件",
		"fileTypeExts" : "*.xls;*.xlsx",
		"height" : 28,
		"width" : 82,
		"multi" : false,
		"fileObjName" : "excelFile" ,
		"cancelImg" : "/sys/pub/js/uploadify/uploadify-cancel.png",
		"wmode" : "transparent",
		"onUploadSuccess" : function(file,data, response)
		{
			ajaxLoadEnd();
			 
			if(data=='0')
			{ 
				showMessage("提示","教质导入成功",null);
				$('#dlg').dialog('close');
				$("#qryBtn").click();
			}else
			{
				showMessage("提示","教质导入失败",null);
			}
		},
		"onUploadStart" : function(file)
		{
			 ajaxLoading("正在处理，请稍待。。。");
			$("#fileNameShow").val(file.name);
			 
		},
		"onUploadComplete" : function(file)
		{
			  ajaxLoadEnd();
		},
		"onSelect" : function(file){
			$("#export1").uploadify("settings" , "formData" ,{"qualityId" : qualityId,"classInstId":classInstId, "staffId" :$("#staffId").val()});
		}
	});
 			
 		});
		$(function () {
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
	            
	            //formatter: function (d) { return d.getFullYear() + '-' + d.getMonth(); }//配置formatter，只返回年月
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

	    
	    
	    function importTea()
	    {
	    	if(validateSelect("list_data"))
			{
	    		var row = $('#list_data').datagrid('getSelected');
	    		qualityId=row.qualityId;
	    		classInstId=row.classInstId;
	    		var className=row.className;
	    		var month=row.month;
	    		var reflect=row.reflect;
			
	    		$("#classNameText").html(className);
	    		$("#monthText").html(month);
	    		if("否"==reflect)
	    		{
	    			$("#dlg").dialog('open').dialog('setTitle', '导入教质反馈文件');//设定表头  
	    		}else
	    		{
	    			showMessage("提示","该教质已经反馈!",null);
	    			return;
	    		}
			}
		}	
	</script>
  	</body>
</html>

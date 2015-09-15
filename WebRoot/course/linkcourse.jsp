<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/css/style.css">
	 
		<script type="text/javascript">
			$(document).ready(function()
				{
				var height = $(document).height();
				$("#frame1",top.document).css("height",height);
			 	$("#frame2",top.document).css("height",height);
		
		
				
			})
		</script>
  	</head>
  
  	<body>
  		<div id="base">
  			<div id="u0">
        		<div id="u1">
          			<p><span></span></p>
        		</div>
      		</div>
      		
	      	
	      		<div style="height: 10px;"></div>
	      <div class="easyui-panel" style="width:100%;height:auto;" title="常规课课程">
      	      <table width="100%" cellpadding="5px" class="maintable" id="addStudentTd2">
	      	      <tr>
	      	        <td align="right"> <span>阶段：</span></td>
	      	        <td>&nbsp;</td>
	      	        <td align="right"><span>班级类型：</span></td>
	      	        <td> 2010-10-10 </td>
	      	        <td align="right"><span>证件号码：</span></td>
	      	        <td>1234567890</td>
      	        </tr>
	      	      <tr>
	      	        <td align="right"><DIV id="u170_state0" data-label="状态1">
	      	          <DIV id="u170_state0_content">
	      	            <span>业绩老师A：</span>
      	                   </td>
	      	        <td><select name="schoolType" class="easyui-combobox" id="schoolType2" style="width: 150px; height: 28px;"
	      						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#schoolType').combobox('setValue',data[0].codeFlag);}"
	      						url="<%=path %>/pubData/qryCodeNameList.do?tableName=REAL_SCHOOL_T&codeType=SCHOOL_TYPE" required="true" >
	      	          </select></td>
	      	        <td align="right"><span>业绩老师B：</span></td>
	      	        <td><select name="advisterBSchoolId2" class="easyui-combobox" id="advisterBSchoolId2" style="width: 96px; height: 28px;"
	      						data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#advisterBSchoolId').combobox('setValue',data[0].schoolId);}"
	      						url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
	      	          </select></td>
	      	        <td  align="right"><span>缴费时间：</span></td>
	      	        <td><input name="birthday" id="birthday" type="text" class="easyui-datebox" required="true" style="width: 200px; height: 28px;"/></td>
      	        </tr>
      	      </table>
</div>
      		<div style="height: 10px;"></div>
      	<div class="easyui-panel" style="width:100%;height:auto;" title="赠品信息">
      	
      	      <table width="100%" cellpadding="5px" class="maintable" id="addStudentTd2">
	      	      <tr>
	      	        <td width="8%" align="right"><span style="color: red;">赠品类型</span><span>：</span></td>
	      	        <td width="14%"><select name="schoolType2" class="easyui-combobox" id="schoolType" style="width: 150px; height: 28px;"
	      						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#schoolType').combobox('setValue',data[0].codeFlag);}"
	      						url="<%=path %>/pubData/qryCodeNameList.do?tableName=REAL_SCHOOL_T&codeType=SCHOOL_TYPE" required="true" >
      	            </select></td>
	      	        <td width="7%" align="right"><span>赠品名称：</span></td>
	      	        <td width="29%"><table width="200" border="1">
   	                <tr>
	      	              <td><select name="advisterBSchoolId5" class="easyui-combobox" id="advisterBSchoolId5" style="width: 96px; height: 28px;"
	      						>
      	                  </select></td>
	      	              <td><select name="advisterBSchoolId4" class="easyui-combobox" id="advisterBSchoolId4" style="width: 96px; height: 28px;"
	      						>
   	                  </select></td>
	      	              <td><input name="name2" id="name2" type="text" class="easyui-textbox validatebox" required="true" style="width: 200px; height: 28px;"/></td>
      	                </tr>
      	              </table></td>
	      	        <td width="6%" align="right"><span>是否领用</span></td>
	      	        <td width="12%" align="right">
	      	          <input type="radio" name="radio" id="radio" value="radio">
	      	          <label for="radio"><span>已领用</span></label>
	      	          <input type="radio" name="radio" id="radio" value="radio">
	      	          <label for="radio"> <span>未领用</span></label>
      	           </td>
	      	        <td width="6%"><span>发放人</span></td>
	      	        <td width="13%"><input name="name4" id="name4" type="text" class="easyui-textbox validatebox" required="true" style="width: 100px; height: 28px;"/></td>
	      	        <td width="5%"><span>添加</span></td>
      	        </tr>
	      	      <tr>
	      	        <td align="right">&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td align="right">&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
      	        </tr>
      	      </table>
</div>
      		
      		<div style="height: 10px;"></div>
      		<div class="easyui-panel" style="width:100%;height:auto;" title="赠课信息">
      	      <table width="100%" cellpadding="5px" class="maintable" id="addStudentTd2">
	      	      <tr>
	      	        <td colspan="2" align="right"><span>赠课名称</span></td>
	      	        <td width="16%" align="right"><select name="schoolType3" class="easyui-combobox" id="schoolType3" style="width: 150px; height: 28px;"
	      						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#schoolType').combobox('setValue',data[0].codeFlag);}"
	      						url="<%=path %>/pubData/qryCodeNameList.do?tableName=REAL_SCHOOL_T&codeType=SCHOOL_TYPE" required="true" >
      	            </select></td>
	      	        <td width="11%" align="right"><span>赠课细类：</span></td>
	      	        <td width="11%"><select name="advisterBSchoolId3" class="easyui-combobox" id="advisterBSchoolId3" style="width: 96px; height: 28px;"
	      						data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#advisterBSchoolId').combobox('setValue',data[0].schoolId);}"
	      						url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
	      	          </select></td>
	      	        <td width="7%">&nbsp;</td>
	      	        <td width="10%" align="right"><span>课时量</span></td>
	      	        <td width="11%"><input name="name4" id="name4" type="text" class="easyui-textbox validatebox" required="true" style="width: 100px; height: 28px;"/></td>
	      	        <td width="10%">&nbsp;</td>
	      	        <td width="7%"><span>添加</span></td>
      	        </tr>
      	      </table>
      	    
      	      <div class="easyui-panel" style=width:100%;padding:10px;">
      	       <table width="100%" cellpadding="5px" class="maintable" id="addStudentTd2">
	      	    
	      	      <tr>
	      	        <td width="6%" align="right"><span>序号</span>
&nbsp;</td>
	      	        <td width="11%"><span>赠课来源</span>
&nbsp;</td>
	      	        <td ><span>增课名称</span></td>
	      	        <td><span>赠送时间</span></td>
	      	        <td><span>赠送课时量</span></td>
	      	        <td><span>课程状态</span></td>
	      	        <td><span>有效期开始时间</span></td>
	      	        <td><span>失效期</span></td>
	      	        <td><span>课程进度</span></td>
	      	        <td><span>删除</span></td>
      	        </tr>
	      	      <tr>
	      	        <td align="right">&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td align="right">&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
      	        </tr>
      	      </table>
      	      </div>
</div>
<div style="height: 10px;"></div>

  
 
	      	<div style="margin-top: 50px;">
	      		<div style="float: left;margin-left: 900px;">
	      			<a href="javascript:void(0)" id="studentSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      			&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onClick="javascript:window.history.back()">返回</a>
	      		</div>
	      	</div>
  		</div>
  	</body>
</html>

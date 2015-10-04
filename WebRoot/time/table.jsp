<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!doctype html>
<html>
	<head>
		<title>例子</title>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<style type="text/css">
			#fm{
				margin:0;
				padding:10px 30px;
			}
			.ftitle{
				font-size:14px;
				font-weight:bold;
				color:#666;
				padding:5px 0;
				margin-bottom:10px;
				border-bottom:1px solid #ccc;
			}
			.fitem{
				margin-bottom:5px;
			}
			.fitem label{
				display:inline-block;
				width:80px;
			}
		</style>
		<table id="DataGrid" class="easyui-datagrid" fit="true" border="false" toolbar="#TBar" pagination="true" 
          data-options="autoRowHeight:false,pageSize:50,pageList: [10, 20, 30, 40, 50,100,5000],idField:'zhbid',sortName:'zhbbh', queryParams: { 'action': 'query'}
          ,onLoadSuccess:function(data){ MergeCells('DataGrid','mkmch,zhbmch');},onDblClickRow: onClickRow" 
          rownumbers="true" singleSelect="true" url="../Source/Data/zhbdata.ashx?mxbs=MON">  
        <thead>  
            <tr>  
                <th field="zhbid" hidden="true" sortable="true" width="100"  rowspan="2">指标ID</th> 
                <th field="zhbbs" hidden="true" sortable="true" width="100" rowspan="2">指标ID</th> 
                <th field="mxid" hidden="true" sortable="true" width="100" rowspan="2">模块ID</th> 
                <th field="dwid" hidden="true" sortable="true" width="100" rowspan="2">单位ID</th> 
                <th field="rq" hidden="true" sortable="true" width="100" rowspan="2">日期</th> 

                <th field="mkmch" sortable="true" width="80"  data-options="headalign:'center',align:'center'" rowspan="2">板 块</th> 
                <th field="zhbmch" sortable="true" width="150"  data-options="headalign:'center'" rowspan="2">指标名称</th> 
                <th field="dw" sortable="true" width="80"  data-options="headalign:'center'" rowspan="2">指标单位</th> 
                <th field="shn_ljzh" sortable="true" width="80" data-options="headalign:'center',editor:{type:'numberbox',options:{precision:3}}" rowspan="2">上一年度<br />同期累计<br />完成值</th>  
                <th field="bn_jh" sortable="true" width="80" data-options="headalign:'center'" rowspan="2">已下达年<br />计划</th>  
                <th colspan="4">指标完成情况</th> 
                <th field="mxmch" sortable="true" width="250" data-options="headalign:'center'" rowspan="2">基础数据</th>  
                <th field="mxzh" sortable="true" width="80" data-options="headalign:'center',editor:{type:'numberbox',options:{precision:3}}" rowspan="2">基础数据<br />(本期)</th>  
                <th field="beizhu" sortable="true" width="350"  data-options="headalign:'center'" rowspan="2">备 注</th>  
            </tr>
            <tr>
                <th field="bq_zh" sortable="true" width="90"  data-options="headalign:'center'">本期完成值</th> 
                <th field="bn_ljzh" sortable="true" width="90"  data-options="headalign:'center'">累计完成值</th> 
                <th field="bn_ljtb" sortable="true" width="80"  data-options="headalign:'center'">同 比</th> 
                <th field="bn_tb" sortable="true" width="80"  data-options="headalign:'center'">与计划比</th> 
            </tr>
        </thead>  
    </table>
    
    <script type="text/javascript">
		 /**
        * EasyUI DataGrid根据字段动态合并单元格
        * @param fldList 要合并table的id
        * @param fldList 要合并的列,用逗号分隔(例如："name,department,office");
        */
        function MergeCells(tableID, fldList) {
            var Arr = fldList.split(",");
            var dg = $('#' + tableID);
            var fldName;
            var RowCount = dg.datagrid("getRows").length;
            var span;
            var PerValue = "";
            var CurValue = "";
            var length = Arr.length - 1;
            for (i = length; i >= 0; i--) {
                fldName = Arr[i];
                PerValue = "";
                span = 1;
                for (row = 0; row <= RowCount; row++) {
                    if (row == RowCount) {
                        CurValue = "";
                    }
                    else {
                        CurValue = dg.datagrid("getRows")[row][fldName];
                    }
                    if (PerValue == CurValue) {
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
                    }
                }
            }
        }
		</script>
	</body>
</html>
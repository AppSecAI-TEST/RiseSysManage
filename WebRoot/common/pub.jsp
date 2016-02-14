<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
		new gPrivCtrl('${sessionScope.StaffT.staffId}','${param.funcNodeId}',"");
	});
</script>
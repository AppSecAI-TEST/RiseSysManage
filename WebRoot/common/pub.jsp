<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	gPropertyObject.staffId = ${sessionScope.StaffT.staffId};
	gPropertyObject.funcNodeId = ${param.funcNodeId};
	gPropertyObject.fieldId = "";
	gPropertyObject.filterFunc();
</script>
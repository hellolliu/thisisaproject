<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>合同信息表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/business/oilConInfo/">合同信息表列表</a></li>
		<%-- <shiro:hasPermission name="business:oilConInfo:edit"><li><a href="${ctx}/business/oilConInfo/form">合同信息表添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="oilConInfo" action="${ctx}/business/oilConInfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>产品名称：</label>
				<form:input path="gname" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>订单号：</label>
				<form:input path="orderNumber" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>收货地址：</label>
				<form:input path="shippingAdd" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>产品名称</th>
				<!-- <th>订单号</th> -->
				<th>收货地址</th>
				<th>总量</th>
				<th>更新日期</th>
				<th>备注</th>
				<th>状态</th>
				<shiro:hasPermission name="business:oilConInfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="oilConInfo">
			<tr>
				<td><a href="${ctx}/business/oilConInfo/form2?id=${oilConInfo.id}">
					${oilConInfo.gname}
				</a></td>
				<%-- <td>
					${oilConInfo.orderNumber}
				</td> --%>
				<td>
					${oilConInfo.shippingAdd}
				</td>
				<td>
					${oilConInfo.totalAmount}
				</td>
				<td>
					<fmt:formatDate value="${oilConInfo.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${oilConInfo.remarks}
				</td>
				<td>
					<%-- ${fns:getDictLabel(oilConInfo.oilProcess.status, 'proStatus', '')} --%>
				</td>
				<shiro:hasPermission name="business:oilConInfo:edit"><td>
    				<a href="${ctx}/business/oilConInfo/form2?id=${oilConInfo.id}">查看</a>
    				<a href="#" onclick="change('${oilConInfo.id}')">状态维护</a>
					<%-- <a href="${ctx}/business/oilConInfo/delete?id=${oilConInfo.id}" onclick="re
					turn confirmx('确认要删除该合同信息表吗？', this.href)">删除</a> --%>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	
  <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <form:form id="inputForm" modelAttribute="oilConInfo" action="${ctx}/business/oilConInfo/change" method="post" class="form-horizontal">
	<form:hidden path="id"/>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">合同状态修改</h4>
            </div>
            <div class="modal-body"> 
	           <div class="control-group">
			   <label class="control-label" style="text-align: left;">状态:</label>
				  <div class="controls">
					<form:select path="remarks" class="input-medium">
						<form:options items="${fns:getDictList('status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				  </div>
			   </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="submit" class="btn btn-primary">提交更改</button>
            </div>
        </div>
    </div>
    </form:form>
   </div>
   <script type="text/javascript">
   function change(number){
	   $("#myModal").modal('show');
	   var form=$("#inputForm");
	   form.find("input[name='id']").val(number);
   }
   </script>
</body>
</html>
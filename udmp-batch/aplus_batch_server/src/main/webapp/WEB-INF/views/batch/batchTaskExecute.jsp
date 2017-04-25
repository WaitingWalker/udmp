<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
  <head>
    <title>批处理启动</title>
    <%@ include file="../common/header.jsp" %>
    <link href="${ctxStatic}/lib/bootstrap-daterangepicker/daterangepicker.css" type="text/css" rel="stylesheet" />
    <style>
      #date { min-width:210px;}
    </style>
  </head>
  <body>
    <%-- 流式布局容器 --%>
    <div class="container-fluid clearfix" id="i-manage-panel">
      <%-- 查询模块 --%>
      <udmp-search>
      	<div id="path"></div>
        <udmp-input name="legPerCod" clear-button placeholder="法人代码"></udmp-input>
        <udmp-button label="查询"></udmp-button>
      </udmp-search>

      <%-- 数据展示 --%>
      <udmp-data :itable="table" :url="tableUrl" :options="options">
      </udmp-data>

    <%@ include file="../common/footer.jsp" %>
    <%-- 页面脚本 --%>
    <script type="text/javascript">
      seajs.use('js/batch/batchTaskExecute')
    </script>
  </body>
</html>

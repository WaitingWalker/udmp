<%@page contentType="text/html; charset=utf-8"%>
<%@include file="/udmpCommon.jsp"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div id="menuContent" class="menuContent"
	style="display: none; position: absolute; z-index: 1002;">
	<ul id="branchTree" class="ztree" style="margin-top: 0; width: 150px;"></ul>
</div>
<form id="pagerForm" method="post"
	action="sys/getPermissionByType_dataPermAction.action?leftFlag=0&menuId=${menuId }">
	<input type="hidden" name="pageNum" value="${currentPage.pageNo}" />
	<input type="hidden" name="numPerPage" value="${currentPage.pageSize}" />
</form>
<div class="pageContent">
	<div class="pageHeader">
		<div class="pageFormContent" layoutH="700" id="treeSearchDiv">
			<form id="menuForm_permission" method="post" class="pageForm required-validate"
				onsubmit="return querySubmit(this)"
				style="float: left; width: 100%;"
				action="sys/getPermissionByType_dataPermAction.action?leftFlag=0&menuId=${menuId }" rel="pagerForm">
				<input id="branchCode_permission" type="text" style="width: 120px;" class="required"
					name="permissionTypeInput" value="${permissionTypeInput}"/> &nbsp;
					<a id='menuBtn' href='#' class="btnLook" onclick='showMenu(); return false;'>
					</a> 
					<div class="buttonActive">
						<div class="buttonContent">
							<button type="submit" id="queryDataPermTypeInDPM">查询</button>
						</div>
						<div>
							<input id="add_btn_mark" type="hidden" value="<%=request.getAttribute("addButtonAbleMark")%>"/>
						</div>
					</div>
				<input type="hidden" name="pageNum" value="${currentPage.pageNo}" />
				<input type="hidden" name="numPerPage"
					value="${currentPage.pageSize}" />
			</form>
		</div>
	</div>
	<div class="pageForm" layoutH="0">
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="add" href="sys/updatePermission_dataPermAction.action?op_flag=1&menuId=${menuId }&permissionTypeId=${permissionTypeId}" maxable="false" minable="false" resizable="true" title="权限新增" width="900" height="400" target="dialog" disabled="true" id="add_btn"><span>新增</span></a></li>
			<li class="line">line</li>
			<li><a class="edit" href="sys/updatePermission_dataPermAction.action?permissionId={permissionId}&op_flag=2&menuId=${menuId}" maxable="false" minable="false" resizable="true" title="权限修改" width="900" height="400" rel="update" target="dialog"><span>修改</span></a></li>
			<li class="line">line</li>
			<li><a class="delete" href="sys/deletePermission_dataPermAction.action?permissionId={permissionId}&menuId=${menuId}" target="ajaxTodo" title="是否确认要删除"><span>删除</span></a></li>
			<li class="line">line</li>
		</ul>
	</div>
		<table class="table" width="100%" layoutH="155">
			<thead>
				<tr height="25" align="center">
					<th width="4%">选择</th>
					<th>权限编号</th>
					<th>权限类型</th>
					<th>权限名称</th>
					<th>权限等级</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="currentPage.pageItems" status="st">
					<tr align="center" height="25" target="permissionId"
						rel="${permissionId}">
						<td><input type="radio" name="permissionManager" value="" />
						</td>
						<td>
							<div align="center">${permissionId }</div>
						</td>
						<td>
							<div align="center">${permissionTypeName }</div>
						</td>
						<td>
							<div align="center">${permissionName }</div>
						</td>
						<td>
							<div align="center">${permLevelWorkflow }</div>
						</td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
		<div class="panelBar">
			<div class="pages">
				<span>显示</span>
				<s:select list="#{20:'20',50:'50',100:'100',200:'200'}"
					name="select" onchange="navTabPageBreak({numPerPage:this.value})"
					value="currentPage.pageSize">
				</s:select>
				<span>条，共${currentPage.total}条</span>
			</div>
			<div class="pagination" targetType="navTab"
				totalCount="${currentPage.total}"
				numPerPage="${currentPage.pageSize}" pageNumShown="10"
				currentPage="${currentPage.pageNo}"></div>
		</div>
	</div>
</div>
<script type="text/javascript">
	//页面加载时，判断是否查询过数据权限，若查询过，将新增按钮的disabled属性设置为false
	$(function(){
		var mark = $("#add_btn_mark").val();
		if(mark=='true'){
			$("#add_btn").attr("disabled", false);
		}
	});

	var inputId = "branchCode_permission";//input
	var aId = "menuBtn";//a
	var treeId = "branchTree";//ul
	var treeDivId = "menuContent";//div
	var urlStr = "getTypeList_dataPermAction.action";
	var branchNodes =
<%=request.getAttribute("branchNodes")%>
	;
	var setting = {
		view : {
			dblClickExpand : false
		},
		data : {
			simpleData : {
				enable : true
			}
		},
		callback : {
			onClick : onClick
		}
	};
	
	
	function querySubmit(obj){
		
		if(isNulOrEmpty($("#"+inputId).val())){
			alertMsg.warn("输入框不能为空");
			return false;
		}
		return navTabSearch(obj);
	}
	function onClick(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj(treeId);
		nodes = zTree.getSelectedNodes(), v = nodes[0].name;
		var cityObj = $("#" + inputId);
		cityObj.attr("value", v);
		hideMenu();
	}

	function showMenu() {
		var cityObj = $("#" + inputId);
		var $treeSearchDiv = $("#treeSearchDiv");
		var treeSerrchDivPosition = $treeSearchDiv.position();
		var value = $("#" + inputId).val() == null ? "" : $("#" + inputId)
				.val().trim();
		var cityPosition = $("#" + inputId).position();
		$.ajax({
			type : "POST",
			url : urlStr,
			data : {
				branchLike : value
			},
			dataType : "json",
			success : function(branchNode) {
				$.fn.zTree.init($("#" + treeId), setting, branchNode.typeList);
			}
		});
		$("#" + treeDivId).css(
				{
					left : cityPosition.left + treeSerrchDivPosition.left
							+ "px",
					top : cityPosition.top + cityObj.outerHeight()
							+ treeSerrchDivPosition.top + "px"
				}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
	}

	$("#" + inputId).keyup(
			function(e) {
				var cityObj = $("#" + inputId);
				var value = $("#" + inputId).val() == null ? "" : $(
						"#" + inputId).val().trim();
				var cityPosition = $("#" + inputId).position();
				var $treeSearchDiv = $("#treeSearchDiv");
				var treeSerrchDivPosition = $treeSearchDiv.position();
				e = e || window.event;
				var keyCode = e.keyCode || e.which;
				if ((keyCode >= 48 && keyCode <= 90) || keyCode == 13
						|| keyCode == 8 || keyCode == 32) {
					$.ajax({
						type : "POST",
						url : urlStr,
						data : {
							branchLike : value
						},
						dataType : "json",
						success : function(branchNode) {
							$.fn.zTree.init($("#" + treeId), setting,
									branchNode.typeList);
						}
					});
					$("#" + treeDivId).css(
							{
								left : cityPosition.left
										+ treeSerrchDivPosition.left + "px",
								top : cityPosition.top + cityObj.outerHeight()
										+ treeSerrchDivPosition.top + "px"
							}).slideDown("fast");
					$("body").bind("mousedown", onBodyDown);
				}
			});
	function hideMenu() {
		$("#" + treeDivId).fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (!(event.target.id == aId || event.target.id == treeDivId || $(
				event.target).parents("#" + treeDivId).length > 0)) {
			hideMenu();
		}
	}
	/* $(document).ready(function() {
		$.fn.zTree.init($("#" + treeId), setting, branchNodes);
	}); */

	
</script>

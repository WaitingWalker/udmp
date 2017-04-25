<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<div class="pageContent">
	<form method="post" id="userForm"
		action="sys/insertFieldDataType_fieldDataTypeAction.action?menuId=${menuId}"
		class="pageForm required-validate"
		onsubmit="return validateCallback(this, dialogAjaxDone)">
		<div class="pageFormContent nowrap" layoutH="47">
			<table width="100%" cellpadding="0" cellspacing="10" border="0">
				<tr>
					<td width="17%">
						<div class="label">域段类型描述:</div>
					</td>
					<td width="33%"><input type="text"
						name="fieldDataTypeTVO.dataTypeDesc" class="required"
						maxlength="20" /></td>
				</tr>
				<tr>
					<td width="17%">
						<div class="label">域段类型校验类:</div>
					</td>
					<td width="33%"><input type="text"
						name="fieldDataTypeTVO.dataValidateClass" class="required"
						maxlength="200" /></td>
				</tr>
				<tr>
					<td width="17%">
						<div class="label">域段类型:</div>
					</td>
					<td width="33%"><input type="text"
						name="fieldDataTypeTVO.dataType" class="required" maxlength="20" />
					</td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul style="margin-top: -3px;">
				<li>
					<div class="buttonActive">
						<div class="buttonContent">
							<button type="submit">保存</button>
						</div>
					</div>
				</li>
				<li>
					<div class="buttonActive">
						<div class="buttonContent">
							<button type="button" onclick="$.pdialog.closeCurrent();">取消</button>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</form>
</div>

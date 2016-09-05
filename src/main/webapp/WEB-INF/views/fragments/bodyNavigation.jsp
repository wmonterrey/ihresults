<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<!-- BEGIN SIDEBAR -->
<div class="page-sidebar-wrapper">
	<div class="page-sidebar-wrapper">
		<div class="page-sidebar navbar-collapse collapse">
			<!-- BEGIN SIDEBAR MENU -->
			<ul class="page-sidebar-menu">
				<li class="sidebar-toggler-wrapper">
					<!-- BEGIN SIDEBAR TOGGLER BUTTON -->
					<div class="sidebar-toggler">
					</div>
					<div class="clearfix">
					</div>
					<!-- BEGIN SIDEBAR TOGGLER BUTTON -->
				</li>
				<li class="start">
					<a href="<spring:url value="/" htmlEscape="true "/>">
					<i class="fa fa-home"></i>
					<span class="title">
						<spring:message code="home" />
					</span>
					<span class="selected">
					</span>
					</a>
				</li>
				<sec:authorize url="/tasksSol/">
				<li class="solicitud">
					<a href="javascript:;">
					<i class="fa fa-folder-open-o"></i>
					<span class="title">
						<spring:message code="sols"/>
					</span>
					<span class="arrow ">
					</span>
					</a>
					<ul class="sub-menu">
						<sec:authorize url="/addSol/">
						<li class="nuevasol">
							<a href="<spring:url value="/tasksSol/addSol" htmlEscape="true "/>">
							<i class="fa fa-file-o"></i>
							<spring:message code="add.sol"/></a>
						</li>
						</sec:authorize>
						<sec:authorize url="/editSol/">
						<li class="editarsol">
							<a href="<spring:url value="/tasksSol/editSol" htmlEscape="true "/>">
							<i class="fa fa-edit"></i>
							<spring:message code="edit.sol"/></a>
						</li>
						</sec:authorize>
						<sec:authorize url="/delSol/">
						<li class="borrarsol">
							<a href="<spring:url value="/tasksSol/delSol" htmlEscape="true "/>">
							<i class="fa fa-times"></i>
							<spring:message code="del.sol"/></a>
						</li>
						</sec:authorize>
					</ul>
				</li>
				</sec:authorize>
				<sec:authorize url="/super/">
				<li class="super">
					<a href="javascript:;">
					<i class="fa fa-wrench"></i>
					<span class="title">
						<spring:message code="super" />
					</span>
					<span class="arrow ">
					</span>
					</a>
					<ul class="sub-menu">
						<li class="supercenters">
							<a href="<spring:url value="/super/centers/" htmlEscape="true "/>">
							<i class="fa fa-building"></i>
							<spring:message code="supercenters" /></a>
						</li>
						<li class="superstudies">
							<a href="<spring:url value="/super/studies/" htmlEscape="true "/>">
							<i class="fa fa-archive"></i>
							<spring:message code="superstudies" /></a>
						</li>
						<li class="superprojects">
							<a href="<spring:url value="/super/projects/" htmlEscape="true "/>">
							<i class="fa fa-ruble"></i>
							<spring:message code="superprojects" /></a>
						</li>
						<li class="superaccounts">
							<a href="<spring:url value="/super/accounts/" htmlEscape="true "/>">
							<i class="fa fa-usd"></i>
							<spring:message code="superaccounts" /></a>
						</li>
					</ul>
				</li>
				</sec:authorize>
				<sec:authorize url="/admin/">
				<li class="admin">
					<a href="javascript:;">
					<i class="fa fa-cogs"></i>
					<span class="title">
						<spring:message code="admin" />
					</span>
					<span class="arrow ">
					</span>
					</a>
					<ul class="sub-menu">
						<li class="adminusers">
							<a href="<spring:url value="/admin/users/" htmlEscape="true "/>">
							<i class="fa fa-group"></i>
							<spring:message code="adminusers" /></a>
						</li>
					</ul>
				</li>
				</sec:authorize>
				<li class="last ">
					<a href="<spring:url value="/logout" htmlEscape="true" />">
					<i class="fa fa-sign-out"></i>
					<span class="title">
						<spring:message code="logout" />
					</span>
					</a>
				</li>
			</ul>
			<!-- END SIDEBAR MENU -->
		</div>
	</div>
</div>
<!-- END SIDEBAR -->

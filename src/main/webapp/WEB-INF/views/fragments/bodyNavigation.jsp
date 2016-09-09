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
                    <li class="results">
                        <a href="javascript:;">
                            <i class="fa fa-list"></i>
					<span class="title">
						<spring:message code="results" />
					</span>
					<span class="arrow ">
					</span>
                        </a>
                        <ul class="sub-menu">
                            <li class="addres">
                                <a href="<spring:url value="/results/newResult/" htmlEscape="true "/>">
                                    <i class="fa fa-plus"></i>
                                    <spring:message code="addres" /></a>
                            </li>
                            <li class="editres">
                                <a href="<spring:url value="/results/list/" htmlEscape="true "/>">
                                    <i class="fa fa-pencil"></i>
                                    <spring:message code="editres" /></a>
                            </li>
                            <li class="delres">
                                <a href="<spring:url value="/results/list/" htmlEscape="true "/>">
                                    <i class="fa fa-trash-o"></i>
                                    <spring:message code="delres" /></a>
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

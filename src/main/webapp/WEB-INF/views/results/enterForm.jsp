<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!--[if IE 8]> <html class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html>
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
<jsp:include page="../fragments/headTag.jsp" />
<!-- BEGIN PAGE LEVEL STYLES -->
<spring:url value="/resources/plugins/select2/select2_conquer.css" var="sel2css" />
<link rel="stylesheet" type="text/css" href="${sel2css}"/>
<spring:url value="/resources/plugins/jquery-multi-select/css/multi-select.css" var="jqmscss" />
<link rel="stylesheet" type="text/css" href="${jqmscss}"/>
<!-- END PAGE LEVEL STYLES -->
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body class="page-header-fixed page-sidebar-fixed page-footer-fixed">
<!-- BEGIN HEADER -->
<jsp:include page="../fragments/bodyHeader.jsp" />
<!-- END HEADER -->
<!-- BEGIN CONTAINER -->
<div class="page-container">
<jsp:include page="../fragments/bodyNavigation.jsp" />
<!-- BEGIN CONTENT -->
<div class="page-content-wrapper">
	<div class="page-content-wrapper">
		<div class="page-content">
			<!-- BEGIN STYLE CUSTOMIZER -->
			<jsp:include page="../fragments/bodyCustomizer.jsp" />
			<!-- BEGIN PAGE HEADER-->
			<div class="row">
				<div class="col-md-12">
					<!-- BEGIN PAGE TITLE & BREADCRUMB-->
					<h3 class="page-title">
					<spring:message code="title" /> <small><spring:message code="results" /></small>
					</h3>
					<ul class="page-breadcrumb breadcrumb">
						<li>
							<i class="fa fa-home"></i>
							<a href="<spring:url value="/" htmlEscape="true "/>"><spring:message code="home" /></a>
							<i class="fa fa-angle-right"></i> <a href="<spring:url value="/admin/users/" htmlEscape="true "/>"><spring:message code="results" /></a>
                            <i class="fa fa-angle-right"></i> <a href="<spring:url value="/admin/users/" htmlEscape="true "/>"><spring:message code="addres" /></a>
						</li>
					</ul>
					<!-- END PAGE TITLE & BREADCRUMB-->
				</div>
			</div>
			<!-- END PAGE HEADER-->
			<!-- BEGIN PAGE CONTENT-->
			<spring:url value="/admin/users/{username}"
				var="usuarioUrl">
				<spring:param name="username" value="${user.username}" />
			</spring:url>
			<c:set var="userUpdated"><spring:message code="user.updated" /></c:set>
			<c:set var="errorProcess"><spring:message code="process.error" /></c:set>
			
			<div class="row">
				<div class="col-md-12">
					<div class="portlet">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-list"></i>
							</div>
							<div class="tools">
								<a href="javascript:;" class="collapse"></a>
								<a href="javascript:;" class="remove"></a>
							</div>
						</div>
						<div class="portlet-body form">
						<form action="#" autocomplete="off" id="add-result-form" class="form-horizontal">
								<div class="form-body">
                                    <input id="id" name="id" type="hidden" class="form-control"/>
									<div class="alert alert-danger display-hide">
										<button class="close" data-close="alert"></button>
										<spring:message code="form.errors" />
									</div>
                                    <div class="row">
                                        <div class="col col-sm-12 col-md-4 col-lg-4">
                                            <div class="form-group">
                                                <label class="control-label col-md-4"><spring:message code="rundate" />
                                                <span class="required">
                                                     *
                                                </span>
                                                </label>
                                                <div class="col-md-8">
                                                    <div class="input-group">
                                                        <input type="text" name="rundate" id="rundate"
                                                               placeholder="<spring:message code="rundate"/>"
                                                               class="form-control date-picker" data-date-end-date="+0d"/>
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-calendar"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col col-sm-12 col-md-4 col-lg-4">
                                            <div class="form-group">
                                                <label class="control-label col-md-4"><spring:message code="runnumber" />
                                                </label>
                                                <div class="col-md-6">
                                                    <div class="input-group">
                                                        <input id="runnumber" name="runnumber" type="text" value="" class="form-control"/>
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-sort-numeric-asc"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                         </div>
                                    </div>
                                    <div class="row">
                                        <div class="col col-sm-12 col-md-4 col-lg-4">
                                            <label class="control-label col-md-4"><spring:message code="antigen" />
                                                <span class="required">
                                                     *
                                                </span>
                                            </label>
                                            <div class="col-md-8">
                                                <select class="form-control" id="antigeno" name="antigeno">
                                                    <option value=""><spring:message code="lbl.select"/>...</option>
                                                    <c:forEach items="${antigenos}" var="antigeno">
                                                        <option value="${antigeno.id}">${antigeno.nombre}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col col-sm-12 col-md-4 col-lg-4">
                                            <div class="form-group">
                                                <label class="control-label col-md-4"><spring:message code="positivecontrol" />
                                                <span class="required">
                                                     *
                                                </span>
                                                </label>
                                                <div class="col-md-6">
                                                    <div class="input-group">
                                                        <input id="positivecontrol" name="positivecontrol" type="text" value="" class="form-control"/>
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-sort-alpha-asc"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col col-sm-12 col-md-4 col-lg-4">
                                            <div class="form-group">
                                                <label class="control-label col-md-5"><spring:message code="negativecontrol" />
                                                <span class="required">
                                                     *
                                                </span>
                                                </label>
                                                <div class="col-md-6">
                                                    <div class="input-group">
                                                        <input id="negativecontrol" name="negativecontrol" type="text" value="" class="form-control"/>
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-sort-alpha-asc"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
								</div>

								<div class="form-actions fluid">
									<div class="col-md-offset-6 col-md-6">
										<button id="guardar" type="submit" class="btn btn-success"><spring:message code="save" /></button>
						            	<a href="#" class="btn btn-danger"><spring:message code="end" /></a>
                                        <!-- <a href="${fn:escapeXml(usuarioUrl)}" class="btn btn-danger"><spring:message code="end" /></a>-->
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

            <div class="row">
                <div class="col-md-12">
                    <div class="portlet">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="fa fa-list"></i>
                            </div>
                            <div class="tools">
                                <a href="javascript:;" class="collapse"></a>
                                <a href="javascript:;" class="remove"></a>
                            </div>
                        </div>
                        <div class="portlet-body form">
                            <form action="#" autocomplete="off" id="add-detail-form" class="form-horizontal">
                                <div class="form-body">
                                    <input id="idEncabezado" name="idEncabezado" type="hidden" class="form-control"/>

                                    <div class="alert alert-danger display-hide">
                                        <button class="close" data-close="alert"></button>
                                        <spring:message code="form.errors" />
                                    </div>
                                    <div class="row">
                                        <div class="col col-sm-12 col-md-4 col-lg-4">
                                            <div class="form-group">
                                                <label class="control-label col-md-4"><spring:message code="mxcode" />
                                                <span class="required">
                                                     *
                                                </span>
                                                </label>
                                                <div class="col-md-6">
                                                    <div class="input-group">
                                                        <input id="codigoMx" name="codigoMx" type="text" value="" class="form-control"/>
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-sort-alpha-asc"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col col-sm-12 col-md-4 col-lg-4">
                                            <label class="control-label col-md-4"><spring:message code="restitle" />
                                                <span class="required">
                                                     *
                                                </span>
                                            </label>
                                            <div class="col-md-8">
                                                <select class="form-control" id="titulo" name="titulo">
                                                    <option value=""><spring:message code="lbl.select"/>...</option>
                                                    <c:forEach items="${titulos}" var="titulo">
                                                        <option value="${titulo.id}">${titulo.valor}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col col-sm-12 col-md-4 col-lg-4">
                                            <div class="btn-group">
                                                <button id="add_detail" disabled class="btn btn-info">
                                                    <spring:message code="add" /> <i class="fa fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover table-bordered" id="lista_muestras">
                                    <thead>
                                    <tr>
                                        <th class="hidden-xs" width="50%"><spring:message code="mxcode" /></th>
                                        <th class="hidden-xs" width="50%"><spring:message code="restitle" /></th>
                                    </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
			<!-- END PAGE CONTENT -->
		</div>
	</div>
</div>
<!-- END CONTENT -->
</div>
<!-- END CONTAINER -->
<!-- BEGIN FOOTER -->
<jsp:include page="../fragments/bodyFooter.jsp" />
<!-- END FOOTER -->
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<jsp:include page="../fragments/corePlugins.jsp" />
<jsp:include page="../fragments/bodyUtils.jsp" />
<!-- BEGIN PAGE LEVEL PLUGINS -->

<!-- DATA TABLE-->
<c:choose>
    <c:when test="${cookie.prLang.value == null}">
        <c:set var="lenguaje" value="es"/>
    </c:when>
    <c:otherwise>
        <c:set var="lenguaje" value="${cookie.prLang.value}"/>
    </c:otherwise>
</c:choose>
<spring:url value="/resources/plugins/data-tables/jquery.dataTables.js" var="jQueryDataTables" />
<script type="text/javascript" src="${jQueryDataTables}"></script>
<spring:url value="/resources/plugins/data-tables/DT_bootstrap.js" var="dataTablesBS" />
<script type="text/javascript" src="${dataTablesBS}"></script>
<spring:url value="/resources/plugins/data-tables/TableTools/js/dataTables.tableTools.js" var="dataTablesTT" />
<script type="text/javascript" src="${dataTablesTT}"></script>
<spring:url value="/resources/plugins/data-tables/TableTools/swf/copy_csv_xls_pdf.swf" var="dataTablesTTSWF" />
<spring:url value="/resources/plugins/data-tables/i18n/label_{language}.json" var="dataTablesLang">
    <spring:param name="language" value="${lenguaje}" />
</spring:url>

<!-- Select 2-->
<spring:url value="/resources/plugins/select2/select2.min.js" var="Select2" />
<script type="text/javascript" src="${Select2}"></script>
<spring:url value="/resources/plugins/select2/select2_locale_{language}.js" var="Select2Loc">
    <spring:param name="language" value="${pageContext.request.locale.language}" />
</spring:url>
<script src="${Select2Loc}"></script>

<!-- bootstrap datepicker -->
<spring:url value="/resources/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js" var="datepickerPlugin" />
<script src="${datepickerPlugin}"></script>
<spring:url value="/resources/plugins/bootstrap-datepicker/js/locales/bootstrap-datepicker.{languagedt}.js" var="datePickerLoc">
    <spring:param name="languagedt" value="${pageContext.request.locale.language}" /></spring:url>
<script src="${datePickerLoc}"></script>

<!-- VALIDATOR-->
<spring:url value="/resources/plugins/jquery-validation/dist/jquery.validate.min.js" var="jQValidation" />
<script type="text/javascript" src="${jQValidation}"></script>
<spring:url value="/resources/plugins/jquery-validation/dist/additional-methods.min.js" var="jQValidationAdd" />
<script type="text/javascript" src="${jQValidationAdd}"></script>
<spring:url value="/resources/plugins/jquery-validation/localization/messages_{language}.js" var="jQValidationLoc">
    <spring:param name="language" value="${pageContext.request.locale.language}" />
</spring:url>
<script src="${jQValidationLoc}"></script>

<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<spring:url value="/resources/scripts/app.js" var="App" />
<script src="${App}" type="text/javascript"></script>
<spring:url value="/resources/scripts/utils/handleDatePickers.js" var="handleDatePickers" />
<script src="${handleDatePickers}" type="text/javascript"></script>
<spring:url value="/resources/scripts/results/add-result.js" var="addResultScript" />
<script src="${addResultScript}" type="text/javascript"></script>

<spring:url value="/results/addResult" var="saveUrl"/>
<spring:url value="/results/addResultDetail" var="saveDetailUrl"/>
<spring:url value="/results/getDetailByHeader" var="getDetailUrl"/>

<c:set var="successmessage"><spring:message code="process.success" /></c:set>
<c:set var="errormessage"><spring:message code="process.errors" /></c:set>
<!-- END PAGE LEVEL SCRIPTS -->
<script>
    $(function () {
        $("li.results").removeClass("open").addClass("active");
        $("li.addres").removeClass("addres").addClass("active");
    });
</script>
<script>
	jQuery(document).ready(function() {
		App.init();
		var parametros = {saveUrl: "${saveUrl}",saveDetailUrl: "${saveDetailUrl}",
            getDetailUrl: "${getDetailUrl}", successmessage: "${successmessage}",
				errormessage: "${errormessage}", dataTablesLang: "${dataTablesLang}"
		};
        AddResult.init(parametros);
        handleDatePickers("${pageContext.request.locale.language}");

	});
</script>
<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>
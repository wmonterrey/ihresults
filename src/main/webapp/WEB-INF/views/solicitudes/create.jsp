<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!--[if IE 8]> <html class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html>
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
<jsp:include page="../fragments/headTag.jsp" />
<!-- BEGIN PAGE LEVEL STYLES -->
<spring:url value="/resources/plugins/select2/select2_conquer.css" var="select2css" />
<link rel="stylesheet" type="text/css" href="${select2css}"/>
<spring:url value="/resources/plugins/bootstrap-datepicker/css/datepicker.css" var="datepickercss" />
<link rel="stylesheet" type="text/css" href="${datepickercss}"/>
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
			<jsp:include page="../fragments/bodyCustomizer.jsp" />
			<!-- BEGIN PAGE HEADER-->
			<div class="row">
				<div class="col-md-12">
					<!-- BEGIN PAGE TITLE & BREADCRUMB-->
					<h3 class="page-title">
					<spring:message code="title" /> <small><spring:message code="heading" /></small>
					</h3>
					<ul class="page-breadcrumb breadcrumb">
						<li>
							<i class="fa fa-home"></i>
							<a href="<spring:url value="/" htmlEscape="true "/>"><spring:message code="home" /></a>
							<i class="fa fa-angle-right"></i> <a href="<spring:url value="/tasksSol/addSol" htmlEscape="true "/>"><spring:message code="add.sol" /></a>
						</li>
					</ul>
					<!-- END PAGE TITLE & BREADCRUMB-->
				</div>
			</div>
			<!-- END PAGE HEADER-->
			<!-- BEGIN PAGE CONTENT-->
			<!-- START ROW -->
			<div class="row">
				<div class="col-md-12">
					<div class="portlet" id="form_wizard_1">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-reorder"></i> <spring:message code="new.sol" /> - 
								<span class="step-title">
									 <spring:message code="step" /> 1 <spring:message code="of" /> 3
								</span>
							</div>
							<div class="tools hidden-xs">
							</div>
						</div>
						<div class="portlet-body form">
							<form action="#"  class="form-horizontal" id="submit_form">
								<div class="form-wizard">
									<div class="form-body">
										<ul class="nav nav-pills nav-justified steps hidden-xs">
											<li>
												<a href="#tab1" data-toggle="tab" class="step">
												<span class="number">
													 1
												</span>
												<span class="desc">
													<i class="fa fa-check"></i> <spring:message code="step1" />
												</span>
												</a>
											</li>
											<li>
												<a href="#tab2" data-toggle="tab" class="step">
												<span class="number">
													 2
												</span>
												<span class="desc">
													<i class="fa fa-check"></i> <spring:message code="step2" />
												</span>
												</a>
											</li>
											<li>
												<a href="#tab3" data-toggle="tab" class="step">
												<span class="number">
													 3
												</span>
												<span class="desc">
													<i class="fa fa-check"></i> <spring:message code="step3" />
												</span>
												</a>
											</li>
										</ul>
										<div id="bar" class="progress progress-striped" data-role="progressbar">
											<div class="progress-bar progress-bar-success">
											</div>
										</div>
										<div class="tab-content solcompleta">
											<div class="alert alert-danger display-none">
												<button class="close" data-close="alert"></button>
												<spring:message code="form.errors" />
											</div>
											<div class="alert alert-success display-none">
												<button class="close" data-close="alert"></button>
												<spring:message code="form.success" />
											</div>
											<div class="tab-pane active" id="tab1">
												<h4 class="form-section"><spring:message code="general" /></h4>
												<!-- START ROW -->
												<div class="row">
													<div class="col-sm-12 col-md-6 col-lg-6">
														<div class="form-group">
															<label class="control-label col-md-4"><spring:message code="numSol" />:
															<span class="required">
																 *
															</span>
															</label>
															<div class="col-md-8">
																<input type="text" readonly id="numSolicitud" name="numSolicitud" class="form-control"/>
															</div>
														</div>
													</div>
													<div class="col-sm-12 col-md-6 col-lg-6">
														<div class="form-group">
															<label class="control-label col-md-4"><spring:message code="idSol" />:
															<span class="required">
																 *
															</span>
															</label>
															<div class="col-md-8">
																<input type="text" readonly id="idSolicitud" name="idSolicitud" class="form-control"/>
															</div>
														</div>
													</div>
												</div>
												<!-- END ROW -->
												<!-- START ROW -->
												<div class="row">
													<div class="col-sm-12 col-md-6 col-lg-6">
														<div class="form-group">
															<label class="control-label col-md-4"><spring:message code="fecSol" />:
															<span class="required">
																 *
															</span>
															</label>
															<div class="col-md-8">
																<div class="input-group date date-picker" data-date-format="dd/MM/yyyy" data-date-start-date="-30d" data-date-end-date="+0d">
																	<input id="fechaVisita" name="fechaVisita" value="<fmt:formatDate value="${solicitud.fecSolicitud}" pattern="dd/MM/yyyy" />" type="text" class="form-control" placeholder="<spring:message code="please.enter" /> <spring:message code="fecSol" />">
																	<span class="input-group-btn">
																		<button class="btn btn-info" type="button"><i class="fa fa-calendar"></i></button>
																	</span>
																</div>
															</div>
														</div>
													</div>
													<div class="col-sm-12 col-md-6 col-lg-6">
														<div class="form-group">
															<label class="control-label col-md-4"><spring:message code="cenSol" />:
															<span class="required">
																 *
															</span>
															</label>
															<div class="col-md-8">
																<select data-placeholder="<spring:message code="cenSol" />" name="ctrSolicitud" id="ctrSolicitud" class="form-control">
																	<option value=""></option>
																	<c:forEach items="${centros}" var="centro">
																		<c:choose> 
																			<c:when test="${centro.idCentro eq solicitud.ctrSolicitud.idCentro}">
																				<option selected value="${centro.idCentro}">${centro.nombreCentro}</option>
																			</c:when>
																			<c:otherwise>
																				<option value="${centro.idCentro}">${centro.nombreCentro}</option>
																			</c:otherwise>
																		</c:choose> 
																	</c:forEach>
																</select>
															</div>
														</div>
													</div>
												</div>
												<!-- END ROW -->
												<!-- START ROW -->
												<div class="row">
													<div class="col-sm-12 col-md-6 col-lg-6">
														<div class="form-group">
															<label class="control-label col-md-4"><spring:message code="tiposol" />:
															<span class="required">
																 *
															</span>
															</label>
															<div class="col-md-8">
																<select data-placeholder="<spring:message code="tiposol" />" name="tipoSolicitud" id="tipoSolicitud" class="form-control">
																	<option value=""></option>
																	<c:forEach items="${tipoSol}" var="tipoS"> 
																		<c:choose>
																		<c:when test="${tipoS.catKey eq  centro.tipoSolicitud}">
																			<option selected value="${tipoS.catKey}"><spring:message code="${tipoS.messageKey}" /></option> 
																		</c:when>
																		<c:otherwise>
																			<option value="${tipoS.catKey}"><spring:message code="${tipoS.messageKey}" /></option> 
																		</c:otherwise>
																		</c:choose>
																	</c:forEach>
																</select>
															</div>
														</div>
													</div>
													<div class="col-sm-12 col-md-6 col-lg-6">
														<div class="form-group">
															<label class="control-label col-md-4"><spring:message code="usrSol" />:
															<span class="required">
																 *
															</span>
															</label>
															<div class="col-md-8">
																<select data-placeholder="<spring:message code="usrSol" />" name="usrSolicitud" id="usrSolicitud" class="form-control">
																	<option value=""></option>
																</select>
															</div>
														</div>
													</div>
												</div>
												<!-- END ROW -->
												<!-- START ROW -->
												<div class="row">
													<div class="col-md-12">
														<div class="form-group">
															<label class="control-label col-md-2"><spring:message code="obs" />:
															</label>
															<div class="col-md-10">
																<div class="input-group">
																	<input type="text" placeholder="<spring:message code="please.enter" /> <spring:message code="obs" />" class="form-control" id="observaciones" name="observaciones" />
																	<span class="input-group-addon">
																		<i class="fa fa-sort-alpha-asc"></i>
																	</span>
																</div>
															</div>
														</div>
													</div>
												</div>
												<!-- END ROW -->
											</div>
											<div class="tab-pane" id="tab2">
												<div class="row">
													<div class="col-md-12">
														<!-- BEGIN TABLE PORTLET-->
														<div class="portlet">
															<div class="portlet-title">
																<div class="caption">
																	<i class="fa fa-group"></i><spring:message code="person.list" />
																</div>
																<div class="tools">
																</div>
															</div>
															<div class="portlet-body">
																<div class="table-toolbar">
																	<div class="btn-group">
																		<a class="btn btn-success" data-toggle="modal" onclick="validarModalPersona();" data-target="#personamodalform"><spring:message code="person.add" /> <i class="fa fa-plus"></i></a>																		
																	</div>
																</div>
																<div class="table-responsive">
																<table class="table table-striped table-hover table-bordered" id="lista_personas">
																<thead>
																	<tr>
																		<th><spring:message code="nopersona" /></th>
        																<th><spring:message code="completename" /></th>
        																<th><spring:message code="lastname1" /></th>
        																<th><spring:message code="lastname2" /></th>
        																<th><spring:message code="person.id" /></th>
        																<th><spring:message code="birthdate" /></th>
        																<th><spring:message code="person.gd" /></th>
																	</tr>
																</thead>
																</table>
																</div>
															</div>
														</div>
														<!-- END TABLE PORTLET-->
													</div>
												</div>
												
											</div>
											<div class="tab-pane" id="tab3">
												<h4 class="form-section"><spring:message code="new.sol" /></h4>
												
											</div>
										</div>
									</div>
									<div class="form-actions fluid">
										<div class="row">
											<div class="col-md-12">
												<div class="col-md-offset-3 col-md-9">
													<a href="javascript:;" class="btn btn-default button-previous">
														<i class="fa fa-arrow-left"></i><spring:message code="back" /></a>
													<a href="javascript:;" class="btn btn-info button-next">
														<spring:message code="continue" /> <i class="fa fa-arrow-right"></i></a>
													<a href="javascript:;" class="btn btn-success button-submit">
														<spring:message code="end" /> <i class="fa fa-save"></i></a>
												</div>
											</div>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- END ROW -->
			<!-- END PAGE CONTENT-->
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
<c:choose>
	<c:when test="${cookie.prLang.value == null}">
		<c:set var="lenguaje" value="es"/>
	</c:when>
	<c:otherwise>
		<c:set var="lenguaje" value="${cookie.prLang.value}"/>
	</c:otherwise>
</c:choose>
<spring:url value="/resources/plugins/bootstrap-wizard/jquery.bootstrap.wizard.min.js" var="jQBWizard" />
<script type="text/javascript" src="${jQBWizard}"></script>
<spring:url value="/resources/plugins/jquery-validation/dist/jquery.validate.min.js" var="jQValidation" />
<script type="text/javascript" src="${jQValidation}"></script>
<spring:url value="/resources/plugins/jquery-validation/dist/additional-methods.min.js" var="jQValidationAdd" />
<script type="text/javascript" src="${jQValidationAdd}"></script>
<spring:url value="/resources/plugins/jquery-validation/localization/messages_{language}.js" var="jQValidationLoc">
	<spring:param name="language" value="${lenguaje}" />
</spring:url>				
<script src="${jQValidationLoc}"/></script>
<spring:url value="/resources/plugins/select2/select2.min.js" var="selectDos" />
<script type="text/javascript" src="${selectDos}"></script>
<spring:url value="/resources/plugins/select2/select2_locale_{language}.js" var="Select2Loc">
	<spring:param name="language" value="${lenguaje}" />
</spring:url>				
<script src="${Select2Loc}"/></script>
<spring:url value="/resources/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js" var="datepicker" />
<script type="text/javascript" src="${datepicker}"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<spring:url value="/resources/scripts/app.js" var="App" />
<script src="${App}" type="text/javascript"></script>
<spring:url value="/resources/scripts/sol/sol-wizard.js" var="solWizard" />
<script src="${solWizard}"></script>
<!-- END PAGE LEVEL SCRIPTS -->
<c:set var="processSuccess"><spring:message code="process.success" /></c:set>
<c:set var="processError"><spring:message code="process.error" /></c:set>
<c:set var="deniedError"><spring:message code="403.denied" /></c:set>
<script>
    $(function () {
    	$("li.solicitud").removeClass("solicitud").addClass("active");
    	$("li.nuevasol").removeClass("nuevasol").addClass("active");
    });
</script>
<script>
	jQuery(document).ready(function() {
		App.init();
		var parametros = {addHcUrl: "${addHcUrl}"
			, partUrl: "${partUrl}"
			, processSuccess: "${processSuccess}"
			, processError: "${processError}"
			, deniedError: "${deniedError}"
			,language:"${lenguaje}"
			};
		FormWizardSol.init(parametros);
	});
</script>
<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>
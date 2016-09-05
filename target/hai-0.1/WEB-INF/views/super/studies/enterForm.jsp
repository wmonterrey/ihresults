<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!--[if IE 8]> <html class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html>
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
<jsp:include page="../../fragments/headTag.jsp" />
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
<jsp:include page="../../fragments/bodyHeader.jsp" />
<!-- END HEADER -->
<!-- BEGIN CONTAINER -->
<div class="page-container">
<jsp:include page="../../fragments/bodyNavigation.jsp" />
<!-- BEGIN CONTENT -->
<div class="page-content-wrapper">
	<div class="page-content-wrapper">
		<div class="page-content">
			<!-- BEGIN STYLE CUSTOMIZER -->
			<jsp:include page="../../fragments/bodyCustomizer.jsp" />
			<!-- BEGIN PAGE HEADER-->
			<div class="row">
				<div class="col-md-12">
					<!-- BEGIN PAGE TITLE & BREADCRUMB-->
					<h3 class="page-title">
					<spring:message code="superstudies" />
					</h3>
					<ul class="page-breadcrumb breadcrumb">
						<li>
							<i class="fa fa-home"></i>
							<a href="<spring:url value="/" htmlEscape="true "/>"><spring:message code="home" /></a>
							<i class="fa fa-angle-right"></i> <a href="<spring:url value="/super/studies/" htmlEscape="true "/>"><spring:message code="superstudies" /></a> <i class="fa fa-angle-right"></i> <a href="<spring:url value="/super/studies/newStudy" htmlEscape="true "/>"><spring:message code="add" /></a>
						</li>
					</ul>
					<!-- END PAGE TITLE & BREADCRUMB-->
				</div>
			</div>
			<!-- END PAGE HEADER-->
			<!-- BEGIN PAGE CONTENT-->
			<spring:url value="/super/studies/newStudy" var="newStudyUrl"></spring:url>
			<spring:url value="/super/studies/" var="studyUrl"></spring:url>
			<c:set var="studyCreated"><spring:message code="process.success" /></c:set>
			<c:set var="errorProcess"><spring:message code="process.errors" /></c:set>
			
			<div class="row">
				<div class="col-md-12">
					<div class="portlet">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-archive"></i>
							</div>
							<div class="tools">
								<a href="javascript:;" class="collapse"></a>
								<a href="javascript:;" class="remove"></a>
							</div>
						</div>
						<div class="portlet-body form">
						<form action="#" autocomplete="off" id="add-study-form" class="form-horizontal">
								<div class="form-body">
									<div class="alert alert-danger display-hide">
										<button class="close" data-close="alert"></button>
										<spring:message code="form.errors" />
									</div>
									<div class="form-group">
										<label class="control-label col-md-3"><spring:message code="idEstudio" />
										<span class="required">
											 *
										</span>
										</label>
										<div class="col-md-5">
											<div class="input-group">
												<input value="${study.idEstudio}" id="idEstudio" name="idEstudio" readonly type="text" placeholder="<spring:message code="idEstudio" />" class="form-control"/>
												<span class="input-group-addon">
													<i class="fa fa-keyboard-o"></i>
												</span>
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-md-3"><spring:message code="nombreEstudio" />
										<span class="required">
											 *
										</span>
										</label>
										<div class="col-md-5">
											<div class="input-group">
												<input value="${study.nombreEstudio}" id="nombreEstudio" name="nombreEstudio" type="text" placeholder="<spring:message code="please.enter" /> <spring:message code="nombreEstudio" />" class="form-control"/>
												<span class="input-group-addon">
													<i class="fa fa-keyboard-o"></i>
												</span>
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-md-3"><spring:message code="adminusers" />
										</label>
										<div class="col-md-5">
											<select multiple="multiple" class="multi-select" id="users" name="users">
												<c:forEach items="${usuariosestudio}" var="user" varStatus="stat">
													<c:set var="usuariosEstudio" value="${stat.first ? '' : usuariosEstudio} ${user.usuarioEstudioId.usuario}" />
												</c:forEach>
												<c:forEach items="${usuarios}" var="usuario">
													<c:choose> 
														<c:when test="${fn:contains(usuariosEstudio, usuario.username)}">
															<option selected value="${usuario.username}">${usuario.username}</option>
														</c:when>
														<c:otherwise>
															<option value="${usuario.username}">${usuario.username}</option>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-md-3"><spring:message code="superprojects" />
										</label>
										<div class="col-md-5">
											<select multiple="multiple" class="multi-select" id="projects" name="projects">
												<c:forEach items="${proyectosestudio}" var="project" varStatus="stat">
													<c:set var="proyectosEstudio" value="${stat.first ? '' : proyectosEstudio} ${project.proyectoEstudioId.proyecto}" />
												</c:forEach>
												<c:forEach items="${proyectos}" var="proyecto">
													<c:choose> 
														<c:when test="${fn:contains(proyectosEstudio, proyecto.idProyecto)}">
															<option selected value="${proyecto.idProyecto}">${proyecto.nombreProyecto}</option>
														</c:when>
														<c:otherwise>
															<option value="${proyecto.idProyecto}">${proyecto.nombreProyecto}</option>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>
								<div class="form-actions fluid">
									<div class="col-md-offset-6 col-md-6">
										<button id="guardar" type="submit" class="btn btn-success"><spring:message code="save" /></button>
										<button type="button" class="btn btn-danger" onclick="ejecutarAccionFinalizar()"><spring:message code="end" /></button>
									</div>
								</div>
							</form>
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
<jsp:include page="../../fragments/bodyFooter.jsp" />
<!-- END FOOTER -->
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<jsp:include page="../../fragments/corePlugins.jsp" />
<jsp:include page="../../fragments/bodyUtils.jsp" />
<!-- BEGIN PAGE LEVEL PLUGINS -->
<spring:url value="/resources/plugins/select2/select2.min.js" var="Select2" />
<script type="text/javascript" src="${Select2}"></script>
<spring:url value="/resources/plugins/jquery-multi-select/js/jquery.multi-select.js" var="jQueryMultiSelect" />
<script type="text/javascript" src="${jQueryMultiSelect}"></script>
<spring:url value="/resources/plugins/jquery-validation/dist/jquery.validate.min.js" var="jQValidation" />
<script type="text/javascript" src="${jQValidation}"></script>
<spring:url value="/resources/plugins/jquery-validation/dist/additional-methods.min.js" var="jQValidationAdd" />
<script type="text/javascript" src="${jQValidationAdd}"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<c:choose>
	<c:when test="${cookie.prLang.value == null}">
		<c:set var="lenguaje" value="es"/>
	</c:when>
	<c:otherwise>
		<c:set var="lenguaje" value="${cookie.prLang.value}"/>
	</c:otherwise>
</c:choose>
<spring:url value="/resources/scripts/app.js" var="App" />
<script src="${App}" type="text/javascript"></script>
<spring:url value="/resources/scripts/studies/process-study.js" var="studyScript" />
<script src="${studyScript}" type="text/javascript"></script>
<spring:url value="/resources/plugins/jquery-validation/localization/messages_{language}.js" var="jQValidationLoc">
	<spring:param name="language" value="${lenguaje}" />
</spring:url>				
<script src="${jQValidationLoc}"/></script>
<spring:url value="/resources/plugins/select2/select2_locale_{language}.js" var="Select2Loc">
	<spring:param name="language" value="${lenguaje}" />
</spring:url>				
<script src="${Select2Loc}"/></script>
<!-- END PAGE LEVEL SCRIPTS -->
<spring:url value="/super/studies/saveStudy" var="saveStudyUrl"/>
<c:set var="successmessage"><spring:message code="process.success" /></c:set>
<c:set var="errormessage"><spring:message code="process.errors" /></c:set>
<script>
    $(function () {
    	$("li.super").removeClass("super").addClass("active");
        $("li.superstudies").removeClass("superstudies").addClass("active");
    });
</script>
<script>
	jQuery(document).ready(function() {
		App.init();
		var parametros = {saveStudyUrl: "${saveStudyUrl}",
				successmessage: "${successmessage}",
				errormessage: "${errormessage}"};
		CreateStudy.init(parametros);
		$('#nombreEstudio').focus();
	});
	
    function ejecutarAccionFinalizar() {
    	if($('#idEstudio').val()==''){
			window.location.href = "${studyUrl}";
    	}
    	else{
    		window.location.href = "${studyUrl}viewStudy/"+$('#idEstudio').val();
    	}
	}
	
</script>
<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>
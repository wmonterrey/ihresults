var AddResult = function () {
    return {
//main function to initiate the module
        init: function (parametros) {

            var table  = $('#lista_muestras').DataTable({
                "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs'l>r>"+
                    "t"+
                    "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
                "aLengthMenu": [
                    [5, 10, 15, 20, -1],
                    [5, 10, 15, 20, "Todos"] // change per page values here
                ],
                // set the initial value
                "iDisplayLength": 10,
                "oLanguage": {
                    "sUrl": parametros.dataTablesLang
                },
                "sPaginationType": "bootstrap",
                "bPaginate": true
            });

            var form1 = $('#add-result-form');
            var form2 = $('#add-detail-form');
            var error1 = $('.alert-danger', form1);
            var success1 = $('.alert-success', form1);
            var error2 = $('.alert-danger', form2);
            var success2 = $('.alert-success', form2);

            form1.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-block', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                    rundate: {
                        required: true
                    },
                    antigeno: {
                        required: true
                    },
                    positivecontrol: {
                        required: true,
                        minlength: 4
                    },
                    negativecontrol: {
                        required: true,
                        minlength: 4
                    }
                },

                invalidHandler: function (event, validator) { //display error alert on form submit
                    success1.hide();
                    error1.show();
                    App.scrollTo(error1, -200);
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.form-group').addClass('has-error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change done by hightlight
                    $(element)
                        .closest('.form-group').removeClass('has-error'); // set error class to the control group
                },

                success: function (label) {
                    label
                        .closest('.form-group').removeClass('has-error'); // set success class to the control group
                },

                submitHandler: function (form) {
                    success1.show();
                    error1.hide();
                    processHeader();
                }
            });

            form2.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-block', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                    codigoMx: {
                        required: true
                    },
                    titulo: {
                        required: true
                    }
                },

                invalidHandler: function (event, validator) { //display error alert on form submit
                    success2.hide();
                    error2.show();
                    App.scrollTo(error2, -200);
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.form-group').addClass('has-error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change done by hightlight
                    $(element)
                        .closest('.form-group').removeClass('has-error'); // set error class to the control group
                },

                success: function (label) {
                    label
                        .closest('.form-group').removeClass('has-error'); // set success class to the control group
                },

                submitHandler: function (form) {
                    success2.show();
                    error2.hide();
                    processDetail();
                }
            });

            function processHeader() {
                App.blockUI();
                $.post(parametros.saveUrl
                    , form1.serialize()
                    , function (data) {
                        encabezado = JSON.parse(data);
                        if (encabezado.id === undefined) {
                            toastr.error(data);
                        }
                        else {
                            $('#id').val(encabezado.id);//en el form header
                            $('#idEncabezado').val(encabezado.id); // en el form detail
                            $('#add_detail').removeAttr('disabled','disabled');
                            toastr.success(parametros.successmessage, '');
                        }
                        $('#codigoMx').focus();
                        App.unblockUI();
                    }
                    , 'text')
                    .fail(function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("error:" + errorThrown);
                        App.unblockUI();
                    });
            }

            function processDetail() {
                App.blockUI();
                $.post(parametros.saveDetailUrl
                    , form2.serialize()
                    , function (data) {
                        detalle = JSON.parse(data);
                        if (detalle.id === undefined) {
                            toastr.error(data);
                        }
                        else {
                            toastr.success(parametros.successmessage, '');
                            getDetail();
                        }
                        $('#codigoMx').val('').focus();
                        $('#titulo').val('').change();
                        App.unblockUI();
                    }
                    , 'text')
                    .fail(function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("error:" + errorThrown);
                        App.unblockUI();
                    });
            }

            function getDetail() {
                $.getJSON(parametros.getDetailUrl, {
                    ajax: 'true',
                    idEncabezado: $("#idEncabezado").val()
                }, function (dataToLoad) {
                    table.fnClearTable();
                    var len = Object.keys(dataToLoad).length;
                    for (var i = 0; i < len; i++) {
                        table.fnAddData(
                            [dataToLoad[i].codigoMx, dataToLoad[i].titulo]);
                    }
                }).fail(function(jqXHR) {
                    App.unblockUI();
                });
            }
        }
    };

}();
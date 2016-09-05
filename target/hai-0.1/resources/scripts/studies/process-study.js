var CreateStudy = function () {
	
	var handleMultiSelect = function () {
        $('#users').multiSelect();
        $('#projects').multiSelect();
    };

    return {
        //main function to initiate the module
        init: function (parametros) {
        	//var pageContent = $('.page-content');
            handleMultiSelect();
            
            var form1 = $('#add-study-form');
            var error1 = $('.alert-danger', form1);
            var success1 = $('.alert-success', form1);
            
            jQuery.validator.addMethod("noSpace", function(value, element) { 
	      		  return value.indexOf(" ") < 0 && value != ""; 
	      	}, "Invalid");
            
            form1.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-block', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                	
                    idEstudio: {
                        required: false,
                        minlength: 0,
                        maxlength: 50,
                        noSpace:false
                    },
                    nombreEstudio: {
                        required: true,
                        minlength: 5,
                        maxlength: 50
                    },
                    users: {
                        required: false
                    },
                    projects: {
                        required: false
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
                    processStudy();
                }
            });
            
            function processStudy()
        	{
            	App.blockUI();
        	    $.post( parametros.saveStudyUrl
        	            , form1.serialize()
        	            , function( data )
        	            {
        	    			estudio = JSON.parse(data);
        	    			if (estudio.idEstudio === undefined) {
        						toastr.error(data);        						
        					}
        					else{
        						$('#idEstudio').val(estudio.idEstudio);
        						toastr.success(parametros.successmessage,estudio.nombreEstudio);
        					}
        	            	$('#nombreEstudio').focus();
        	    			App.unblockUI();
        	            }
        	            , 'text' )
        		  		.fail(function(XMLHttpRequest, textStatus, errorThrown) {
        		    		alert( "error:" + errorThrown);
        		    		App.unblockUI();
        		  		});
        	}
            
            
            $(document).on('keypress','form input',function(event)
    		{                
    		    event.stopImmediatePropagation();
    		    if( event.which == 13 )
    		    {
    		        event.preventDefault();
    		        var $input = $('form input');
    		        if( $(this).is( $input.last() ) )
    		        {
    		            //Time to submit the form!!!!
    		            //alert( 'Hooray .....' );
    		        }
    		        else
    		        {
    		            $input.eq( $input.index( this ) + 1 ).focus();
    		        }
    		    }
    		});
        }
    };

}();
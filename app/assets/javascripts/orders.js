// _recent_orders.html.erb
$(document).ready(function(){
    order = $('#order_name_js').data('source')
    $('#order_rgpd_validated').change(function() {
        console.log()
       $.ajax({
        url: "/orders/" + order + "/update-rgpd-validation/",
        data: "value=" + $(this).is(':checked'),
        type: "POST"
        });
     });
});

$(document).on('turbolinks:load', function(){
    var stripeBtn = $("#stripe-payment-btn");
    var stripeAlert = $("#stripe-alert");
    var stripeDiv = $("#stripe-div");
    stripeBtn.prop("disabled", true)

    $('#order-checkboxes input[type=checkbox]').change(function(){ 
        if ($('#order-checkboxes input[type=checkbox]:checked').length == 3) {
            stripeBtn.prop("disabled", false)
            stripeBtn.removeClass('disabled');
            stripeAlert.hide();
        } else {
            stripeBtn.prop("disabled", true)
            stripeBtn.addClass('disabled');
        }
    });

    stripeDiv.click(function(){
        if (stripeBtn.hasClass('disabled')) {
            stripeAlert.show();
        }
    });
});


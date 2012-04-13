//= require jquery.alerts/jquery.alerts
//= require_self

function displayCreditCardDeleteStatus(notice) {
  notice_div = $('.flash.notice');

  if (notice) {
    if (notice_div.length > 0) {
      notice_div.html(notice);
      notice_div.show();
    } else {
      $("#card_notice").html('<div class="flash notice">' + notice + '</div>');
    }
  }
}

(function($){
  $(document).ready(function(){
    if($('[data-hook="billing_fieldset_wrapper"]').is('*')) {

      $('#creditcard_billing_address_state_name:first').remove();

      $('#credit-card-billing-address-form').validate();

      var get_states = function(region){
        country = $('p#' + region + 'country' + ' span#' + region + 'country :only-child').val();
        return state_mapper[country];
      }

      var update_state = function(region) {
        states = get_states(region);

        state_select = $('p#' + region + 'state select');
        state_input = $('p#' + region + 'state input');

        if(states) {
          selected = state_select.val();
          state_select.html('');
          states_with_blank = [["",""]].concat(states);
          $.each(states_with_blank, function(pos,id_nm) {
            var opt = $(document.createElement('option'))
                      .attr('value', id_nm[0])
                      .html(id_nm[1]);
            if(selected==id_nm[0]){
              opt.prop("selected", true);
            }
            state_select.append(opt);
          });
          state_select.prop("disabled", false).show();
          state_input.hide().prop("disabled", true);

        } else {
          state_input.prop("disabled", false).show();
          state_select.hide().prop("disabled", true);
        }

      };

      if ($('p#bcountry').size()) {
      	$('p#bcountry select').change(function() { update_state('b'); });
      	update_state('b');
      }
      if ($('p#scountry').size()) {
      	$('p#scountry select').change(function() { update_state('s'); });
      	update_state('s');
      }
    }

  });
})(jQuery);

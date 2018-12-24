function countryStateSelect(countrySelector, stateSelector, stateWrapperSelector) {
  function loadStates(countryCode) {
    //Perform AJAX request to get the data
    $.ajax({
      url: "countries/states",
      type: 'get',
      dataType: 'json',
      data: { country_code: countryCode },
      success: function (data) {
        updateStateField(data);
      }
    });
  }

  function updateStateField(states) {
    var stateOptions = $.map(states, function (val, key) {
      return '<option value=' + key + '>' + val + '</option>';
    });

    $(stateSelector).html(stateOptions);

    if (stateOptions.length == 0) {
      $(stateWrapperSelector).hide();
    } else {
      $(stateWrapperSelector).show();
    }
  }

  $(countrySelector).change(function () {
    var countryCode = $(this).val();
    loadStates(countryCode);
  });

  var initialStates = $(stateSelector).children();
  if (initialStates.length <= 1) {
    $(stateWrapperSelector).hide();
  }
}

$(document).ready ->
  $(".editable").editable
    mode: "inline"
    showbuttons: false
    format: "yyyy-mm-dd"
    viewformat: "dd/mm/yyyy"
    success: (data, config) ->
      if data and data.id #record created, response like {"id": 2}
        if data.css
          if $(this).prop("tagName") is "TD"
            container = $(this)
          else
            container = $(this).closest("td")

          container.removeClass "available unavailable tentative not-signed"
          container.addClass data.css
      else if data and data.errors
        config.error.call this, data.errors

    error: (errors) ->
      msg = ""
      if errors and errors.responseText #ajax error, errors = xhr object
        for key of errors.responseJSON
          if errors.responseJSON.hasOwnProperty(key)
            this_error = errors.responseJSON[key]
            msg += this_error
            console.log msg
      else #validation error (client-side or server-side)
        $.each errors, (k, v) ->
          msg += k + ": " + v
      return msg

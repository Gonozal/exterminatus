$(document).ready ->
  $(".editable").editable
    mode: "inline"
    showbuttons: false
    format: "yyyy-mm-dd"
    viewformat: "dd/mm/yyyy"
    success: (data, config) ->
      if data and data.id #record created, response like {"id": 2}
        if data.css
          if $(this).prop("tagName") is "span"
            container = $(this)
          else
            container = $(this).closest("span")

          console.log(data.css)
          container.removeClass "available unavailable tentative not-signed"
          container.removeClass "not_started progression killed"
          container.removeClass "need gear want skip"
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
      return ms

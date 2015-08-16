class WFiction.Classes.Alert extends WFiction.Classes.BaseClass
  template: JST["templates/alert"]
  container: ".flash-messages"
  defaults:
    type:   "success"
    delay:  300

  constructor: (options = {}) ->
    super(options)

  danger: (msg, options = {}) ->
    options.type = "danger"
    @render(msg, options)

  success: (msg, options = {}) ->
    options.type = "success"
    @render(msg, options)

  info: (msg, options = {}) ->
    options.type = "info"
    @render(msg, options)

  render: (msg, options = {}) ->
    finalOptions = $.extend(@defaults, options)
    finalOptions.msg = msg;
    $(@container).append(@template(finalOptions));
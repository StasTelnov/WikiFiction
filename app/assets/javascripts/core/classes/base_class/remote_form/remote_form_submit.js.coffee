class WFiction.Classes.RemoteFormSubmit extends WFiction.Classes.RemoteForm
  constructor: (options = {}) ->
    super(options)

  handler: (event) =>
    @$from.submit()
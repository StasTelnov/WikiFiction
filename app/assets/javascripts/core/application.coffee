window.WFiction          ?= {}
window.WFiction.Classes  ?= {}

class WFiction.Application
  constructor: ->
    @alert ||= new WFiction.Classes.Alert

  start: =>
    NProgress.configure({showSpinner: false})
    $(document).on('page:fetch',   NProgress.start)
    $(document).on('page:change',  NProgress.done)
    $(document).on('page:restore', NProgress.remove)

    $(document).on('ready page:load', @afterRenderPage)

  afterRenderPage: =>
    @initializePlugins()
    @bindClasses()

  bindClasses: ($parent = $('body')) =>
    $parent.find("[data-class-binder]").each (k, el) =>
      $.each $(el).data("class-binder").split(" "), (index, className) =>
        unless $(el).hasClass(className)
          new WFiction.Classes[className]({el: el})
          $(el).addClass(className)

  initializePlugins: =>
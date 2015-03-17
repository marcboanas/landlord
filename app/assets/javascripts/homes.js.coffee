window.Homes =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Homes.Routers.Properties()
    Backbone.history.start()

class Homes.Routers.Properties extends Backbone.Router
  routes:
    '': 'index'
    'properties/:id': 'show'

  initialize: ->
    @collection = new Homes.Collections.Properties()
    @collection.fetch
      reset: true

  index: ->
    view = new Homes.Views.PropertiesIndex(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    alert "Property #{id}"

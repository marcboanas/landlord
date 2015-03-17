class Homes.Views.Property extends Backbone.View

  template: JST['properties/property']
  tagName: 'li'

  render: ->
    $(@el).html(@template(property: @model))
    @

class Homes.Views.PropertiesIndex extends Backbone.View

  template: JST['properties/index']

  events:
    'submit #new_property': 'createProperty'

  initialize: ->
    @collection.on('reset', @render, @)
    @collection.on('add', @render, @)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendProperty)
    @

  appendProperty: (property) ->
    view = new Homes.Views.Property(model: property)
    $('#properties').append(view.render().el)

  createProperty: (e) ->
    e.preventDefault()
    attributes = name: $('#new_property_name').val()
    @collection.create attributes,
      wait: true
      success: -> $('#new_property')[0].reset()
      error: @handleError

  handleError: (property, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages

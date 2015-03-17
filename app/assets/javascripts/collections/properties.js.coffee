class Homes.Collections.Properties extends Backbone.Collection

  model: Homes.Models.Property

  url: '/api/properties'

  # GET     /properties
  # Post    /properties
  # GET     /properties/:id
  # PUT     /properties/:id
  # DELETE  /properties/:id

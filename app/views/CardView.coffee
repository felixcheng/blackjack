class window.CardView extends Backbone.View

  className: 'card'

  # template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    # @$el.html @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
    if @model.get('revealed')
      # debugger
      @$el.css('background-image', 'url("card-deck-120x176/cards/' + @model.attributes['rankName'] + '-' + @model.attributes['suitName'] + '.png")')
    else
      @$el.css('background-image', 'url("card-deck-120x176/card-back.png")')

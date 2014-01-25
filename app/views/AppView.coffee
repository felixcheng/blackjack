 class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> 
    <button class="stand-button">Stand</button>
    <button class="reset-button">Reset</button>    
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .reset-button": -> 
      @model.estart()

  initialize: -> 
    @render()
    @listenTo(@model.get('dealerHand'), 'endBoth', @calculate, @)
    #@model.get('dealerHand').on('endBoth', @calculate, @) 
      #@)
      
    @model.get('playerHand').on('end', (-> 
      @model.get('dealerHand').dealerTurn()), @)

  render: ->
    console.log('render')
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  calculate: ->
    playerS = @.model.get('playerHand').scores()[0]
    dealerS = @.model.get('dealerHand').scores()[0]
    console.log('cal', playerS, dealerS)
    if (playerS > dealerS and playerS < 22) or (playerS < 22 and dealerS > 21)
      @win()
    else if (playerS < dealerS) and dealerS < 22 or (playerS > 21 and dealerS < 22)
      @lose()
    else
      @tie()

  restart: ->
    @model = new App()
    @initialize();

  lose: ->
    @$el.prepend("<li> Loser </li>")

  win: ->
    @$el.prepend("<li> Winner </li>")

  tie: ->
    @$el.prepend("<li> You tie </li>")
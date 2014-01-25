class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: -> 
    @render()
    #@listenTo
    @model.get('dealerHand').on('endBoth', @calculate(), @)
      
    @model.get('playerHand').on('end', (-> 
      @model.get('dealerHand').dealerTurn()), @)

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  calculate: ->
    console.log('hi')
    playerS = @.model.get('playerHand').scores()
    dealerS = @.model.get('dealerHand').scores()
    if playerS > dealerS and playerS < 22
      @win()
    if (playerS < dealerS) and dealerS < 22
      debugger
      console.log(playerS, dealerS, (playerS < dealerS))
      @lose()
    else
      @tie()

  lose: ->
    console.log('lose')
    @$el.prepend("<li> Loser </li>")

  win: ->
    console.log('win')    
    @$el.prepend("<li> Winner </li>")

  tie: ->
    @$el.prepend("<li> You tie </li>")
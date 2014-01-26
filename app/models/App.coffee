#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  restart: ->
    @get('dealerHand').discard()
    @get('playerHand').discard()
    deck = @get('deck')
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @trigger 'reset'


  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    


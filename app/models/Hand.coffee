class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: => 
    @add(@deck.pop()).last()
    @trigger 'end' if (@scores()> 21)

  stand: -> @trigger 'end'

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce and @models[0].attributes.revealed
      #debugger;
      if (score + 10) > 21 then [score] else [score + 10]
    else
      [score]

  blackJack: ->
    if (@scores() is 21) and not @isDealer
      @trigger 'win'

  dealerTurn: -> 
    @at(0).flip();
    @add(@deck.pop()).last() until @scores()[0] >= 17
    console.log('repeat')
    @trigger 'endBoth'
    

  discard:->
    @model.pop() if @model.length
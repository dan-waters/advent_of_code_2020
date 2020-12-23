require 'open-uri'

Deck = Struct.new(:cards) do
  def push(*cards)
    self.cards += cards
  end

  def pop
    self.cards.shift
  end

  def score
    return 0 if cards.empty?
    (1..cards.length).to_a.reverse.zip(cards).map do |pair|
      pair.inject(:*)
    end.sum
  end

  def count
    cards.count
  end
end

all_cards = open('decks.txt').read.split("\n\n")

player1, deck = all_cards.first.split(':')
player1_deck = Deck.new(deck.scan(/\d+/).map(&:to_i))

player2, deck = all_cards.last.split(':')
player2_deck = Deck.new(deck.scan(/\d+/).map(&:to_i))

while player1_deck.cards.any? && player2_deck.cards.any?
  card1 = player1_deck.pop
  card2 = player2_deck.pop
  if card1 > card2
    player1_deck.push(card1, card2)
  elsif card2 > card1
    player2_deck.push(card2, card1)
  else
    raise 'oh no a tie'
  end
end

puts player1_deck.score
puts player2_deck.score

# Reset
player1, deck = all_cards.first.split(':')
player1_deck = Deck.new(deck.scan(/\d+/).map(&:to_i))

player2, deck = all_cards.last.split(':')
player2_deck = Deck.new(deck.scan(/\d+/).map(&:to_i))


@played_games = {}
@game = 0

def play_game(deck_1, deck_2)
  @game += 1

  game = @game
  @played_games[game] = []

  while deck_1.cards.any? && deck_2.cards.any? do
    if @played_games[game].include?([deck_1.cards, deck_2.cards])
      return 1
    end

    @played_games[game] << [deck_1.cards.dup, deck_2.cards.dup]

    card_1 = deck_1.pop
    card_2 = deck_2.pop

    if card_1 <= deck_1.count && card_2 <= deck_2.count
      winner = play_game(Deck.new(deck_1.cards.take(card_1)), Deck.new(deck_2.cards.take(card_2)))
      if winner == 1
        deck_1.push(card_1, card_2)
      elsif winner == 2
        deck_2.push(card_2, card_1)
      else
        raise 'oh dear'
      end
    else
      if card_1 > card_2
        deck_1.push(card_1, card_2)
      elsif card_2 > card_1
        deck_2.push(card_2, card_1)
      else
        raise 'oh no a tie'
      end
    end
  end
  deck_1.cards.any? ? 1 : 2
end


play_game(player1_deck, player2_deck)


puts player1_deck.score
puts player2_deck.score
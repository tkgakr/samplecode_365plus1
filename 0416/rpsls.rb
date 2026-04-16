module Hand
    ROCK, PAPER, SCISSORS, LIZARD, SPOCK = *0..4
end

module Result
    WIN = "Win"
    LOSE = "Lose"
    DRAW = "Draw"
end

def match(hand1, hand2)
    winning_combinations = {
        Hand::ROCK => [Hand::SCISSORS, Hand::LIZARD],
        Hand::PAPER => [Hand::ROCK, Hand::SPOCK],
        Hand::SCISSORS => [Hand::PAPER, Hand::LIZARD],
        Hand::LIZARD => [Hand::SPOCK, Hand::PAPER],
        Hand::SPOCK => [Hand::SCISSORS, Hand::ROCK]
    }
    if hand1 == hand2
        Result::DRAW
    elsif winning_combinations[hand1].include?(hand2)
        Result::WIN
    else
        Result::LOSE
	end
end

puts match(Hand::ROCK, Hand::SPOCK)
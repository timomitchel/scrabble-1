gem 'minitest'
require_relative '../lib/scrabble'
require 'minitest/autorun'
require 'minitest/pride'

class ScrabbleTest < Minitest::Test
  def test_it_can_score_a_single_letter
    assert_equal 1, Scrabble.new.score("a")
    assert_equal 4, Scrabble.new.score("f")
  end

  def test_can_score_multiple_letters
    game = Scrabble.new.score("hello")
    assert_equal 8, game
  end

  def test_blank_or_nil_entries_result_in_0
    game_1 = Scrabble.new.score('')
    game_2 = Scrabble.new.score(nil)

    assert_equal 0, game_1
    assert_equal 0, game_2
  end

  def test_can_score_with_multipliers
    game = Scrabble.new

    assert_equal 9, game.score_with_multipliers('hello', [1,2,1,1,1])
    assert_equal 18, game.score_with_multipliers('hello', [1,2,1,1,1], 2)
    assert_equal 58, game.score_with_multipliers('sparkle', [1,2,1,3,1,2,1], 2)
  end

  def test_find_highest_word_score
    game = Scrabble.new

    assert_equal 'home', game.highest_scoring_word(['home', 'word', 'hello', 'sound'])
  end

  def test_highest_word_score_returns_word_with_fewest_letters_if_ties
    game = Scrabble.new

    assert_equal 'word', game.highest_scoring_word(['hello', 'word', 'sound'])
  end

  def test_seven_letter_words_best
    game = Scrabble.new

    assert_equal 'silence', game.highest_scoring_word(['home', 'word', 'silence'])
  end

  def test_picks_first_word_if_tie_between_length_and_score
    game = Scrabble.new

    assert_equal "word", game.highest_scoring_word(['hi', 'word', 'ward'])
  end
end

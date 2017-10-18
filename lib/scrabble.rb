require "pry"

class Scrabble

  def score(word)
    return 0 if word == "" or word == nil
    score_mapper(word).sum
  end

  def score_mapper(word)
    formatted = word.upcase.chars
    formatted.map do |char|
      point_values[char]
    end
  end

  def bonus(word)
    bonus = 0
    bonus = 10 if word.length > 6
    bonus
  end

  def score_multiplier(word, score_with_multipliers)
    score_mapper(word).each_with_index.map do |score, index|
      score * score_with_multipliers[index]
    end
  end

  def score_with_multipliers(word, score_with_multipliers, word_multiplier = 1)
    current_bonus = bonus(word)
    new_scores = score_multiplier(word, score_with_multipliers)
    (new_scores.sum + current_bonus) * word_multiplier
  end

  def word_mapper(words)
    words.map do |word|
      score_mapper(word)
    end
  end

  def word_score_summer(scores)
    scores.map do |score|
      score.sum
    end
  end

  def highest_scoring_word(words)
    scores = word_mapper(words)
    summed = word_score_summer(scores)
    highest_scorer = summed.zip(words).max
    highest_scorer[1]
  end

  def point_values
    {
      "A"=>1, "B"=>3, "C"=>3, "D"=>2,
      "E"=>1, "F"=>4, "G"=>2, "H"=>4,
      "I"=>1, "J"=>8, "K"=>5, "L"=>1,
      "M"=>3, "N"=>1, "O"=>1, "P"=>3,
      "Q"=>10, "R"=>1, "S"=>1, "T"=>1,
      "U"=>1, "V"=>4, "W"=>4, "X"=>8,
      "Y"=>4, "Z"=>10
    }
  end
end

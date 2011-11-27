class Word

## Constructor
  def initialize(val)
    @value = val.downcase
  end

## Class Methods
  def self.parse(words)
    [].tap do |output|
      words.each do |word|
        output << Word.new(word) unless word.strip.empty?
      end
    end
  end

## Instance Methods
  def <=>(b)
    self.value <=> b.value
  end

  def valid?
    valid_length? and valid_characters?
  end

  def value
    @value
  end

private

  def valid_characters?
    not (@value =~ /[^a-zA-Z]/)
  end

  def valid_length?
    @value.length > 1 and @value.length <= 10
  end
end

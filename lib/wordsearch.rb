class Wordsearch

## Constants
  HEIGHT = 10
  WIDTH  = 10

## Constructor
  def initialize(words, options={})
    @words   = words
    @options = options

    @array = []
    HEIGHT.times do 
      inner = []

      WIDTH.times do 
        inner << ''
      end

      @array << inner
    end
  end

## Instance Methods
  def allow_reverse?
    @options['allow_reverse'] || false
  end

  def build
    @words.each do |word|
      self.place_word(word)
    end

    self.fill_empty_spaces
  end

  def fill_empty_spaces
    base_number = 'a'.ord
    @array.each_with_index do |row, i|
      row.each_with_index do |col, j|
        @array[i][j] = (base_number + rand(26)).chr if col.empty?
      end
    end
  end

  def horizontal(word, col, row)
    return false if word.length > (WIDTH - row)

    word.length.times do |i|
      return false unless @array[col][row + i].empty?
    end

    if self.allow_reverse? and rand(1000) % 2 == 0
      word.reverse!
    end

    word.chars.each_with_index do |char, index|
      @array[col][row + index] = char
    end

    true
  end

  def place_word(word)
    while(true)
      row = rand(WIDTH)
      col = rand(HEIGHT)

      break if horizontal(word.value.clone, col, row)
    end
  end

  def rows
    @array
  end

  def title
    @options['title']
  end

  def to_s
    "".tap do |str|
      @array.each do |row|
        str << row.join(' ')
        str << "\n"
      end
    end
  end

end
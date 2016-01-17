#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class. 
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content,         - the string analyzed (provided)
  #* line_number      - the line number analyzed (provided)

  attr_reader :highest_wf_count
  attr_reader :highest_wf_words
  attr_reader :content
  attr_reader :line_number

  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #* calculate_word_frequency() - calculates result

  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    @highest_wf_count = 0
    @highest_wf_words = []
    calculate_word_frequency
  end

  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.

  def calculate_word_frequency()
    word_frequency = Hash.new(0)
    @content.split.each do |word|
      word_frequency[word.downcase] += 1
    end

    word_frequency.each do |word, frequency|
      if frequency > @highest_wf_count
        @highest_wf_count = frequency
        @highest_wf_words = [ word ]
      elsif frequency == @highest_wf_count
        @highest_wf_words.push word
      end
    end
  end

end

#  Implement a class called Solution. 
class Solution

  # Implement the following read-only attributes in the Solution class.
  #* highest_count_across_lines - a number with the value of the highest frequency of a word
  #* highest_count_words_across_lines - an array with the words with the highest frequency

  attr_reader :highest_count_across_lines
  attr_reader :highest_count_words_across_lines
  attr_reader :analyzers

  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers
  #* calculate_line_with_highest_frequency() - determines which line of
  #text has the highest number of occurrence of a single word
  #* print_highest_word_frequency_across_lines() - prints the words with the 
  #highest number of occurrences and their count
  
  def initialize()
    @analyzers = []
  end

  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines 
  #* Create an array of LineAnalyzers for each line in the file

  def analyze_file()
    if File.exist? 'test.txt'
      line_number = 1
      @analyzers = []
      File.foreach( 'test.txt' ) do |line|   
        @analyzers.push LineAnalyzer.new(line, line_number)
        line_number += 1
      end
    end
  rescue Exception => e
    puts e.message
  end

  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the highest number of occurences of a word across all lines
  #and stores this result in the highest_count_across_lines attribute.
  #* identifies the words that were used with the highest number of occurrences
  #and stores them in print_highest_word_frequency_across_lines.

  def calculate_line_with_highest_frequency()
    @highest_count_across_lines = 0
    @highest_count_words_across_lines = []
    analyzers.each do |analyzer|
      if analyzer.highest_wf_count > @highest_count_across_lines
        @highest_count_across_lines = analyzer.highest_wf_count
        @highest_count_words_across_lines = [ analyzer ]
      elsif analyzer.highest_wf_count == @highest_count_across_lines
        /analyzer.highest_wf_words.each do |word|/
        @highest_count_words_across_lines.push analyzer
        /end/
      end
    end
  end

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the result in the following format

  def print_highest_word_frequency_across_lines()
    puts "The following words have the highest word frequency per line:"
    analyzers.select { |analyzer| analyzer.highest_wf_count == @highest_count_across_lines }.each do |analyzer|
      puts "#{analyzer.highest_wf_words} (appears in line #{analyzer.line_number})"
    end
  end
end

solution = Solution.new
solution.analyze_file
solution.calculate_line_with_highest_frequency
solution.print_highest_word_frequency_across_lines
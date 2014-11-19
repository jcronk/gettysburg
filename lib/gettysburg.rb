require 'gettysburg/version'
require 'set'

module Gettysburg
  class Lexer
    @@regex_table = {
      us: /^USA?/,
      dba: /^DBA/,
      ordinal: /^\d+(ST|ND|RD|TH)/,
      o_prefix: /^O'/,
      mac: /^MA?C/,
      direction: /^[NS][EW]/,
      apostrophe: /^'/,
      apt_bldg_number_prefix: /^#/,
      po_box: /^PO BOX/,
      word_boundary: /^[&\s".,;:_\/()-]+/,
      word: /^[^&'\s".,;:#_\/()-]+/,
    }

    def scan(input_string)
      @index = 0
      tokens = []
      while @index < input_string.size
        tokens << get_token(input_string.slice(@index..-1))
      end
      tokens
    end

    def get_token(string)
      @@regex_table.each do |name, pattern|
        test_match = pattern.match(string)
        if test_match
          @index += test_match.end(0)
          return [name, test_match.to_s]
        end
      end
      # no matches in string
      raise "Nothing matched in '#{string}'"
    end
  end

  class Parser
    SMALL_WORDS = %w(and as at by for
                     if in of on or the to
                     v via vs ).to_set
    ABBREVIATIONS = %w(II III IV X XI XII XIII XIV
                       IX VI VII VIII CPA MD LLC
                       DBA LBA ISAOA GPS GP MSP
                       USA NC NA ATIMA ISAOAATIMA
                       UTA FCU FA FSA BAC LP HSBC FSB CTA).to_set
    @@lexer = Lexer.new

    def parse(string)
      token_list = @@lexer.scan(string)
      output = ''
      until token_list.empty?
        token = token_list.shift
        output << send(token[0], token, token_list)
      end
      output
    end

    # return full caps unless it's part of a word
    def process_abbreviation(token, token_list)
      return token[1] if token_list.empty? || token_list.first[0] == :word_boundary
      word_string = token[1] + token_list.shift[1]
      word_string.capitalize
    end

    def always_capitalize(token, token_list)
      token[1].capitalize
    end

    def ordinal(token, token_list)
      token[1].downcase
    end

    def apostrophe(token, token_list)
      return token[1] if token_list.empty? || token_list.first[0] == :word_boundary || token_list.first[1].size > 2
      "#{token[1]}#{token_list.shift[1]}".downcase
    end

    def po_box(token, token_list)
      'PO Box'
    end

    def apt_bldg_number_prefix(token, token_list)
      return token[1] if token_list.empty? || !token_list.find { |t| t[0] == :word }
      identifier = token[1]
      begin
        next_token = token_list.shift
        identifier << next_token[1]
      end until next_token[0] == :word
      identifier
    end

    def word_boundary(token, token_list)
      token[1]
    end

    def word(token, token_list)
      return token[1] if mixed_word?(token[1])
      return token[1].downcase if SMALL_WORDS.include?(token[1].downcase)
      return token[1].upcase if ABBREVIATIONS.include?(token[1].upcase)
      always_capitalize(token, token_list)
    end

    def mixed_word?(token)
      token.match(/\d/) && token.match(/[A-Z]/)
    end

    def o_prefix(token, token_list)
      always_capitalize(token, token_list)
    end

    def us(token, token_list)
      process_abbreviation(token, token_list)
    end

    def dba(token, token_list)
      process_abbreviation(token, token_list)
    end

    def abbreviation(token, token_list)
      process_abbreviation(token, token_list)
    end

    def direction(token, token_list)
      process_abbreviation(token, token_list)
    end

    def mac(token, token_list)
      always_capitalize(token, token_list)
    end
  end
end

class String
  def titlecase
    return self if self =~ /[A-Z]/ && self =~ /[a-z]/
    parser = Titlecaser::Parser.new
    parser.parse(self)
  end

  def titlecase!
    replace titlecase
  end
end

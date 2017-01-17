require 'sinatra'
require 'sinatra/reloader'
require 'slim'

# Tool to encrypt the message.
class CeasarCipher
  attr_reader :message, :shift

  def initialize(message = '', shift = 0)
    @message = message
    @shift = shift
  end

  def up_case_alph
    ('A'..'Z').to_a
  end

  def down_case_alph
    ('a'..'z').to_a
  end

  def alphabet
    down_case_alph + up_case_alph
  end

  def ceasar_cipher
    message.split(' ').collect { |word| encrypt(word) }.join(' ')
  end

  def encrypt(word)
    word.split('').collect { |c| shifting(c) }.join
  end

  def shifting(char)
    alphabet.include?(char) ? shift_process(char) : char
  end

  def shift_process(char)
    char = alphabet.index(char)
    char += shift
    char -= down_case_alph.count if upcased?(char)
    char = fix_shift(char) if char > alphabet.count
    alphabet[char]
  end

  def fix_shift(char)
    (char - alphabet.count) + down_case_alph.count
  end

  def upcased?(char)
    down_case_alph.include?(down_case_alph[char]) && char > down_case_alph.count
  end
end

get '/' do
  slim :index
end

put '/' do
  @encrypt = CeasarCipher.new(params['message'], params['shift'].to_i)
  slim :index
end

not_found do
  slim :not_found
end

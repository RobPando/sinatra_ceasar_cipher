require 'sinatra'
require 'sinatra/reloader'
require 'slim'

# Tool to encrypt the message.
class CeasarCipher
  attr_writer :message, :shift

  def initialize(message = '', shift = 0)
    @message = message
    @shift = shift
  end

  def ceasar_cipher
    encrypted = message.split(' ').collect { |word| encrypted_it(word) }.join(' ')
    encrypted
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

  def encrypted_it(word)
    word.split('').collect { |c| shift_it(c) }.join
  end

  def shift_it(char)
    if alphabet.include?(char)
      char = alphabet.index(char)
      char += shift
      char -= down_case_alph.count if down_case_alph.include?(down_case_alph[char]) && char > down_case_alph.count
      char = (char - alphabet.count) + down_case_alph.count if char > alphabet.count  

      char = alphabet[char]
    else
      char
    end
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





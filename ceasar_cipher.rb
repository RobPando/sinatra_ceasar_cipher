

def up_case_alph
  ('A'..'Z').to_a
end

def down_case_alph
  ('a'..'z').to_a
end

def alphabet
  down_case_alph + up_case_alph
end

def ceasar_cipher(phrase, shift)
  encrypted = phrase.split(' ').collect { |word| encrypted_it(shift, word) }.join(' ')
  encrypted
end

def encrypted_it(shift, word)
  word.split('').collect { |c| shift_it(shift, c) }.join
end

def shift_it(shift, char)
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


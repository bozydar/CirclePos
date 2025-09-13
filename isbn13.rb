def isbn13(isbn)
  raise ArgumentError, "isbn must be a string containing 12 digits" unless isbn =~ /^\d{12}$/

  result = isbn
    .chars
    .map(&:to_i)
    .each_slice(2)
    .sum { |it| it[0] + it[1] * 3 }
  result %= 10
  result = 10 - result
  result == 10 ? 0 : result
end

def check(description, &block)
  result = block.call.is_a?(TrueClass) ? "PASS" : "FAIL"
  printf("%-40s %s\n", description, result)
end

print("============TESTS============\n")
check('isbn13("978014300723")') { isbn13("978014300723") == 4 }
check('isbn13("000000000000")') { isbn13("000000000000") == 0 }
check('isbn13("100000000002")') { isbn13("100000000002") == 3 }
check('isbn13("100000000003")') { isbn13("100000000003") == 0 }
check('isbn13("garbage")') { (begin; isbn13("garbage"); rescue => ex; ex end).is_a?(ArgumentError) }
check('isbn13(nil)') { (begin; isbn13(nil); rescue => ex; ex end).is_a?(ArgumentError) }

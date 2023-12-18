/* REXX */

cmd = "tr ',' '\n' < /z/zuserid/aoc2023/day15solutioninput.txt"

x = bpxwunix(cmd,,file.,se.)


p1 = 0
do i = 1 to file.0
  current_value = 0
  do j = 1 to length(file.i)
    char = substr(file.i,j,1)
    ascii_code = ebcdic_to_ascii(char)
    current_value = current_value + ascii_code
    current_value = current_value * 17
    current_value = current_value // 256
  end
  p1 = p1 + current_value
end

say "Total sum:" p1

exit

ebcdic_to_ascii: procedure
  parse arg char
if char = "!" then return 33
if char = '"' then return 34
if char = "#" then return 35
if char = "$" then return 36
if char = "%" then return 37
if char = "&" then return 38
if char = "'" then return 39
if char = "(" then return 40
if char = ")" then return 41
if char = "*" then return 42
if char = "+" then return 43
if char = "," then return 44
if char = "-" then return 45
if char = "." then return 46
if char = "/" then return 47
if char = "0" then return 48
if char = "1" then return 49
if char = "2" then return 50
if char = "3" then return 51
if char = "4" then return 52
if char = "5" then return 53
if char = "6" then return 54
if char = "7" then return 55
if char = "8" then return 56
if char = "9" then return 57
if char = ":" then return 58
if char = ";" then return 59
if char = "<" then return 60
if char = "=" then return 61
if char = ">" then return 62
if char = "?" then return 63
if char = "@" then return 64
if char = "A" then return 65
if char = "B" then return 66
if char = "C" then return 67
if char = "D" then return 68
if char = "E" then return 69
if char = "F" then return 70
if char = "G" then return 71
if char = "H" then return 72
if char = "I" then return 73
if char = "J" then return 74
if char = "K" then return 75
if char = "L" then return 76
if char = "M" then return 77
if char = "N" then return 78
if char = "O" then return 79
if char = "P" then return 80
if char = "Q" then return 81
if char = "R" then return 82
if char = "S" then return 83
if char = "T" then return 84
if char = "U" then return 85
if char = "V" then return 86
if char = "W" then return 87
if char = "X" then return 88
if char = "Y" then return 89
if char = "Z" then return 90
if char = "[" then return 91
if char = "\" then return 92
if char = "]" then return 93
if char = "^" then return 94
if char = "_" then return 95
if char = "`" then return 96
if char = "a" then return 97
if char = "b" then return 98
if char = "c" then return 99
if char = "d" then return 100
if char = "e" then return 101
if char = "f" then return 102
if char = "g" then return 103
if char = "h" then return 104
if char = "i" then return 105
if char = "j" then return 106
if char = "k" then return 107
if char = "l" then return 108
if char = "m" then return 109
if char = "n" then return 110
if char = "o" then return 111
if char = "p" then return 112
if char = "q" then return 113
if char = "r" then return 114
if char = "s" then return 115
if char = "t" then return 116
if char = "u" then return 117
if char = "v" then return 118
if char = "w" then return 119
if char = "x" then return 120
if char = "y" then return 121
if char = "z" then return 122
if char = "{" then return 123
if char = "Â¬" then return 124
if char = "}" then return 125
if char = "|" then return 126
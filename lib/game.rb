# $board = "-" * 9
# $player = "x"

# def main
#     puts "Use the square number to make your play"
#     puts "i.e. enter 3 to place in the top righthand corner"
#     puts "3"
#     puts "-|-|x\n-|-|-\n-|-|-"
#     puts "ready player one"
#     puts displayBoard()
#     getPlay()
# end

# def getPlay
#     play = gets

#     position = play.to_i

#     if position.is_a? Integer
#         begin
#             place($player, position)
#         rescue IndexError => err
#             puts err.message
#             return getPlay()
#         end
        
#         puts displayBoard()

#         if won?($player)
#             puts "#{$player} wins!"
#             reset()
#         elsif draw?($board)
#             puts "Draw!"
#             reset()
#         else
#             getPlay()
#         end
#     else
#         puts "play must be a number"
#     end
# end

# def _play(player, play)
#     position = play.to_i

#     if position.is_a? Integer
#         begin
#             place(player, position)
#         rescue IndexError => err
#             return err.message
#         end

#         if won?(player)
#             return "#{player} wins!"
#         elsif draw?($board)
#             return "draw!"
#         else
#             return "next play"
#         end
#     else
#         puts "play must be a number"
#     end
# end

# def place(char, position)
#     index = position - 1
#     $board[index] == "-" ? $board[index] = char : raise(IndexError, "position #{position} occupied")
#     $board
# end

# def won?(char)
#     wins = [
#         "###......",
#         "...###...",
#         "......###",
#         "#..#..#..",
#         ".#..#..#.",
#         "..#..#..#",
#         "#...#...#",
#         "..#.#.#.."
#     ]
#     .map  {|pattern| pattern.gsub("#", char)}
#     .any? {|pattern| Regexp.new(pattern).match($board)}
# end

# def reset
#     $board = "---------"
# end

# def draw? board
#     !board.include? "-"
# end

# def displayBoard
#     $board
#     .clone
#     .split(//)
#     .each_slice(3)
#     .to_a
#     .map {|row| row.join("|")}
#     .join("\n")
# end
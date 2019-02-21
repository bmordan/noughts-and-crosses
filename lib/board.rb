$board = "-" * 9
$player = "x"

def main
    puts "Use the square number to make your play"
    puts "i.e. enter 3 to place in the top righthand corner"
    puts "3"
    puts "-|-|x\n-|-|-\n-|-|-"
    puts "ready player one"
    puts displayBoard()
    getPlay()
end

def getPlay
    play = gets

    position = play.to_i

    if position.is_a? Integer
        begin
            place($player, position)
        rescue IndexError => err
            puts err.message
            return getPlay()
        end
        
        puts displayBoard()

        if won?($player)
            puts "#{$player} wins!"
            reset()
        elsif draw?()
            puts "Draw!"
            reset()
        else
            $player = $player == "x" ? "o" : "x"
            getPlay()
        end
    else
        puts "play must be a number"
    end
end

def place(char, position)
    index = position - 1
    $board[index] == "-" ? $board[index] = char : raise(IndexError, "position #{position} occupied")
    $board
end

def won?(char)
    unless draw?()
        state = $board
        .clone
        .gsub("-","_")
        .gsub(char == "x" ? "o" : "x","_")
        
        wins = [
            "###______",
            "___###___",
            "______###",
            "#__#__#__",
            "_#__#__#_",
            "__#__#__#",
            "#___#___#",
            "__#_#_#__"
        ]
        .map  {|pattern| pattern.gsub("#", char)}
        .any? {|pattern| pattern == state}
    end
end

def reset
    $board = "---------"
    $player = "x"
end

def draw?
    !$board.include? "-"
end

def displayBoard
    $board
    .clone
    .split(//)
    .each_slice(3)
    .to_a
    .map {|row| row.join("|")}
    .join("\n")
end
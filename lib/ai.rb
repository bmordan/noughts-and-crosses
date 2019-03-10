def newBoard
      "---------"
end

def getEmpty board
      board
      .split('')
      .each
      .with_index
      .reduce([]) {|memo, (sq, i)| sq == '-' ? memo << i : memo}
      .map {|i| i + 1}
end

def getMove(board, player)
      possibleMoves = getEmpty(board)

      tree = createTree(board, player)

      possibleMoves
      .zip(tree)
      .map {|(position, branch)| traverseUntilScore(position, branch, 0)}
      .sort {|a, b| sortByScore(a, b)}
      .first
      .first
end

def sortByScore(a, b)
      score1 = a.last
      score2 = b.last
      if score1 > score2 then return -1 end
      if score1 == score2 then return 0 end
      if score1 < score2 then return 1 end
end

def traverseUntilScore(position, score, depth)
      if score.class == Integer then return [position, score - depth] end
      traverseUntilScore(position, score.first, depth + 1)
end

def createTree(board, player)
      getEmpty(board).map {|position| traverse(player, position, board)}         
end

def toggle(player)
      player == "x" ? "o" : "x"
end

def traverse(player, position, board)
      newBoard = makePlay(player, position, board)
      
      score = getScore(newBoard, player)
      return score unless score.nil?

      getEmpty(newBoard).map {|nextPosition| traverse(toggle(player), nextPosition, newBoard)}
end

def getScore(board, player)
      wins = [
            "###......",
            "...###...",
            "......###",
            "#..#..#..",
            ".#..#..#.",
            "..#..#..#",
            "#...#...#",
            "..#.#.#.."
        ]
        .map  {|pattern| pattern.gsub("#", player)}
        .any? {|pattern| Regexp.new(pattern).match(board)}
      
      if wins && player == "x" then return 100 end
      if wins && player == "o" then return -100 end
      if getEmpty(board).length == 0 then return 0 end
      nil
end

def makePlay(player, position, board)
      index = position - 1
      nextBoard = board.dup
      nextBoard[index] = player
      nextBoard
end

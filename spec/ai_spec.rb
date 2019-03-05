require_relative "../lib/ai.rb"

describe "ai" do
    it "Can get all the empty plays" do
        board = "-x-o-xoox"
        
        spaces = getEmpty(board)

        expect(spaces).to eq([1, 3, 5])
    end

    it "Can score a winner" do
        x_wins = "xxx------"
        o_wins = "ooo------"
        no_wins = "xoooxxoo-"
        draw = "xoooxxooo"

        expect(getScore(x_wins, "x")).to eq(100)
        expect(getScore(o_wins, "o")).to eq(-100)
        expect(getScore(no_wins, "x")).to eq(nil)
        expect(getScore(draw, "x")).to eq(0)
    end

    it "Can make a play" do
        board = "---------"
        expected = "--------x"
        expect(makePlay("x", 9, board)).to eq(expected)
    end

    it "Can traverse the tree of possibilities" do
        board = "o-xx-x-oo"
        expected = [[-100, -100], 100, [[100], -100]]

        expect(createTree(board, "x")).to eq(expected)
    end

    it "Can traverse the entire tree of possibilities" do
        board = "x--------"
        newTree = createTree(board, "x")
        expect(newTree.length).to eq(8)
    end

    it "Can extract the highest score" do
        scores = [[1, 0], [2, -100], [3, 100]]
        sortedScores = scores.sort {|a, b| sortByScore(a, b)}

        expect(sortedScores).to eq([[3, 100], [1, 0], [2, -100]])
    end

    it "Can do moves" do
        board = "xx-ox--oo"
        tree = [
            100,
            [
                [
                    0
                ],
                -100
            ],
            [
                [
                    0
                ],
                [
                    100
                ]
            ]
        ]
        expect(createTree(board, "x")).to eq(tree)
    end

    it "Can predict winning moves" do
        boards = [
            ["o-xx-x-oo", 5],
            ["xx-ox--oo", 3],
            ["o-xx--xoo", 5],
            ["-x-o-xoox", 3]
        ]
        
        boards.all? {|(board, expected)|
            expect(getMove(board, "x")).to eq(expected)
        }
    end
end

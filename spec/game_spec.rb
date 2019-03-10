require_relative '../lib/game.rb'

describe "The Game" do
    it "the board has 9 places" do
        expect($board.length).to eq(9)
    end

    it "can place a cross" do
        place("x", 3)
        expect($board).to eq("--x------")
    end

    it "will error if place is occupied" do
        expect{place("o", 3)}.to raise_error(IndexError)
    end

    it "will error with a message" do
        begin
            place("o", 3)
        rescue => exception
            expect(exception.message).to eq("position 3 occupied")
        end
    end

    it "can check for a win" do
        place("x", 1)
        expect(won?("x")).to eq(false)
        place("x", 2)
        expect(won?("x")).to eq(true)
    end

    it "can find matching patterns" do
        reset()
        place("o",1)
        place("o",2)
        place("o",4)
        expect(won?("o")).to eq(false)
        place("o",3)
        expect(won?("o")).to eq(true)
    end

    it "can check for a draw" do
        reset()
        expect($board).to eq("---------")
        expect($player).to eq("x")
        place("x",1)
        place("o",2)
        place("x",3)
        place("o",4)
        place("x",5)
        place("x",6)
        place("o",7)
        place("x",8)
        place("o",9)
        expect(won?("x")).to eq(false)
        expect(won?("o")).to eq(false)
        expect(draw?($board)).to eq(true)
    end

    it "can be display the board in the terminal" do
        board = displayBoard()
        expect(board).to eq("x|o|x\no|x|x\no|x|o")
    end
end
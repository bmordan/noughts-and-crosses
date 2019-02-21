require_relative '../lib/board.rb'

describe "The Board" do
    it "has 9 places" do
        expect($board.length).to eq(9)
    end

    it "can place crosses" do
        place("x", 3)
        expect($board).to eq("--x------")
        expect($player).to eq("o")
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

    it "will check for a win" do
        place("x", 1)
        expect(won?("x")).to eq(false)
        place("x", 2)
        expect(won?("x")).to eq(true)
    end

    it "will check for a draw" do
        reset()
        expect($board).to eq("---------")
        expect($player).to eq("x")
        place("x",1)
        place("o",2)
        place("x",3)
        place("o",4)
        place("x",5)
        place("o",6)
        place("x",7)
        place("o",8)
        place("x",9)
        expect(won?("x")).to eq(nil)
        expect(won?("o")).to eq(nil)
        expect(draw?()).to eq(true)
    end

    it "can be displayed in the terminal" do
        board = displayBoard()
        expect(board).to eq("x|o|x\no|x|o\nx|o|x")
    end
end
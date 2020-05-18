require 'tic-tac-toe.rb'

describe Game do

    describe "check_winner?" do
        it "does not accept any full row as a victory" do
            p1 = Players.new("Christian", "X")
            p2 = Players.new("Shannon", "O")
            subject.board[0], subject.board[2], subject.board[7] = "O", "O", "O"
            expect(subject.check_winner?(p1, p2)).to eq false
            subject.check_winner?(p1, p2)
        end
    end

    describe "play_game" do
        it "recognizes horizontal wins" do
            p1 = Players.new("Christian", "X")
            p2 = Players.new("Shannon", "O")
            subject.board[0], subject.board[1], subject.board[2] = "X", "X", "X"
            expect(subject).to receive(:game_over)
            subject.play_game(p1, p2)
        end

        it "recognizes vertical wins" do
            p1 = Players.new("Christian", "X")
            p2 = Players.new("Shannon", "O")
            subject.board[0], subject.board[3], subject.board[6] = "O", "O", "O"
            expect(subject).to receive(:game_over)
            subject.play_game(p1, p2)
        end

        it "recognizes diagonal wins" do
            p1 = Players.new("Christian", "X")
            p2 = Players.new("Shannon", "O")
            subject.board[0], subject.board[4], subject.board[8] = "X", "X", "X"
            expect(subject).to receive(:game_over)
            subject.play_game(p1, p2)
        end

         it "stops when count reaches 9" do
            p1 = Players.new("Christian", "X")
            p2 = Players.new("Shannon", "O")
            subject.count = 9
            expect(subject).to receive(:game_over)
            subject.play_game(p1,p2)
        end
    end
end
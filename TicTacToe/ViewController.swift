import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var a4: UIButton!
    @IBOutlet weak var a5: UIButton!
    @IBOutlet weak var a6: UIButton!
    @IBOutlet weak var a7: UIButton!
    @IBOutlet weak var a8: UIButton!
    @IBOutlet weak var a9: UIButton!
    @IBOutlet weak var gameStatusLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    var currentPlayer = 1 // Player 1 is X, Player 2 is O
    var boardState = Array(repeating: 0, count: 9) // 0 represents empty, 1 represents X, 2 represents O
    var gameActive = true // Flag to track if the game is active
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateGameStatusLabel()
    }

    @IBAction func boardtapaction(_ sender: UIButton) {
        guard let index = getIndex(for: sender) else {
            return
        }
        
        if boardState[index] == 0 && gameActive {
            boardState[index] = currentPlayer
            if currentPlayer == 1 {
                sender.setTitle("X", for: .normal)
                sender.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold) // Adjust font size and weight
            } else {
                sender.setTitle("O", for: .normal)
                sender.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold) // Adjust font size and weight
            }
            
            // Check win condition
            if checkWin(player: currentPlayer) {
                gameStatusLabel.text = "Player \(currentPlayer) wins!"
                gameActive = false
            } else if boardState.contains(0) {
                // Switch players if there are empty spots left
                currentPlayer = (currentPlayer % 2) + 1
                updateGameStatusLabel()
            } else {
                // Game ends in a draw
                gameStatusLabel.text = "It's a draw!"
                gameActive = false
            }
        }
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
        // Reset board state
        boardState = Array(repeating: 0, count: 9)
        
        // Reset button titles and styles
        let allButtons = [a1, a2, a3, a4, a5, a6, a7, a8, a9]
        for button in allButtons {
            button?.setTitle("", for: .normal)
            button?.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .heavy) // Reset font size and weight
        }
        
        // Reset game status
        gameStatusLabel.text = "Player 1's turn"
        gameActive = true
        currentPlayer = 1
    }
    
    func updateGameStatusLabel() {
        gameStatusLabel.text = "Player \(currentPlayer)'s turn"
    }
    
    func checkWin(player: Int) -> Bool {
        // Define win patterns
        let winPatterns = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
            [0, 4, 8], [2, 4, 6]             // Diagonals
        ]
        
        // Check each win pattern
        for pattern in winPatterns {
            if pattern.allSatisfy({ boardState[$0] == player }) {
                return true
            }
        }
        
        return false
    }
    
    // Helper function to get index of tapped button
    func getIndex(for button: UIButton) -> Int? {
        switch button {
        case a1:
            return 0
        case a2:
            return 1
        case a3:
            return 2
        case a4:
            return 3
        case a5:
            return 4
        case a6:
            return 5
        case a7:
            return 6
        case a8:
            return 7
        case a9:
            return 8
        default:
            return nil
        }
    }
}

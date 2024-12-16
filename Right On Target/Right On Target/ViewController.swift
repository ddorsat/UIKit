//
//  ViewController.swift
//  Right On Target
//
//  Created by Dmitry on 13.12.2024.
//

import UIKit

class ViewController: UIViewController {
    var game: Game!

    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!

    private func updateLabelWithSecretNumber(newText: String) {
        label.text = newText
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game(startValue: 1, endValue: 50, rounds: 5)
        updateLabelWithSecretNumber(newText: String(game.currentSecretValue))
    }

    @IBAction func checkNumber() {
        game.calculateScore(with: Int(slider.value))
        if game.isGameEnded {
            showAlertWith(score: game.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }

        updateLabelWithSecretNumber(newText: String(game.currentSecretValue))
    }

    private func showAlertWith(score: Int) {
        let alert = UIAlertController(
            title: "Игра окончена", message: "Вы заработали \(score) очков",
            preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "Начать заново", style: .default, handler: nil)
        )
        self.present(alert, animated: true, completion: nil)
    }
}

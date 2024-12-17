//
//  ViewController.swift
//  TransferApp
//
//  Created by Dmitry on 17.12.2024.
//

import UIKit

class ViewController: UIViewController, DataUpdateProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet var dataLabel: UILabel!

    @IBAction func editDataWithProperty(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen =
            storyboard.instantiateViewController(
                withIdentifier: "SecondViewController") as! SecondViewController

        editScreen.updatingData = dataLabel.text ?? ""
        self.navigationController?.pushViewController(
            editScreen, animated: true)
    }

    var updatedData: String = "Test data"

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updatedData)
    }

    private func updateLabel(withText text: String) {
        dataLabel.text = text
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toEditScreen":
            prepareEditScreen(segue)
        default: break
        }
    }

    private func prepareEditScreen(_ segue: UIStoryboardSegue) {
        guard
            let destinationController = segue.destination
                as? SecondViewController
        else {
            return
        }

        destinationController.updatingData = dataLabel.text ?? ""
    }

    func onDataUpdate(data: String) {
        updatedData = data
        updateLabel(withText: data)
    }

    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) {}
    @IBAction func editDataWithDelegate(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen =
            storyboard.instantiateViewController(
                withIdentifier: "SecondViewController") as! SecondViewController
        editScreen.updatingData = dataLabel.text ?? ""
        editScreen.handleUpdatedDataDelegate = self
        self.navigationController?.pushViewController(
            editScreen, animated: true)
    }

    @IBAction func editDataWithClosure(_ segue: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen =
            storyboard.instantiateViewController(
                withIdentifier: "SecondViewController") as! SecondViewController

        editScreen.updatingData = dataLabel.text ?? ""
        editScreen.completionHandler = { [unowned self] updatedValue in
            updatedData = updatedValue
            updateLabel(withText: updatedValue)
        }
        self.navigationController?.pushViewController(
            editScreen, animated: true)
    }
}

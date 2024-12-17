import UIKit

class SecondViewController: UIViewController {
    @IBOutlet var dataTextField: UITextField!
    var updatingData: String = ""

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
    }

    private func updateTextFieldData(withText text: String) {
        dataTextField.text = text
    }

    @IBAction func saveDataWithProperty(_ sender: UIButton) {
        self.navigationController?.viewControllers.forEach { viewController in
            (viewController as? ViewController)?.updatedData =
                dataTextField.text ?? ""
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toFirstScreen":
            prepareFirstScreen(segue)
        default: break
        }
    }

    private func prepareFirstScreen(_ segue: UIStoryboardSegue) {
        guard let destinationController = segue.destination as? ViewController
        else {
            return
        }
        destinationController.updatedData = dataTextField.text ?? ""
    }

    var handleUpdatedDataDelegate: DataUpdateProtocol?

    @IBAction func saveDataWithDelegate(_ sender: UIButton) {
        let updatedData = dataTextField.text ?? ""
        handleUpdatedDataDelegate?.onDataUpdate(data: updatedData)
        navigationController?.popViewController(animated: true)
    }

    var completionHandler: ((String) -> Void)?
    
    @IBAction func saveDataWithClosure(_ sender: UIButton) {
        let updatedData = dataTextField.text ?? ""
        completionHandler?(updatedData)
        navigationController?.popViewController(animated: true)
    }
}

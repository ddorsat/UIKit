//
//  ViewController.swift
//  Navigation App
//
//  Created by Dmitry on 17.12.2024.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    let storyboardInstance = UIStoryboard(name: "Main", bundle: nil)
    
    @IBAction func toGreenScene(_ sender: UIButton) {
        let nextViewController = storyboardInstance.instantiateViewController(withIdentifier: "greenViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func toYellowScene(_ sender: UIButton) {
        let nextViewController = storyboardInstance.instantiateViewController(withIdentifier: "yellowViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func toHomeScene(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func toPreviousScene(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


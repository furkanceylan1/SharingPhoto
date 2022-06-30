//
//  ViewController.swift
//  Sharing Photo
//
//  Created by Furkan Ceylan on 30.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var e_mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
    
    @IBAction func signupButtonClicked(_ sender: Any) {
    }
}


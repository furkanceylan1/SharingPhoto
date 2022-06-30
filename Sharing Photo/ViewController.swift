//
//  ViewController.swift
//  Sharing Photo
//
//  Created by Furkan Ceylan on 30.06.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var e_mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // User login created
    @IBAction func loginButtonClicked(_ sender: Any) {
        if e_mailTextField.text != "" && passwordTextField.text != ""{
            Auth.auth().signIn(withEmail: e_mailTextField.text!, password: passwordTextField.text!) { authdataresult, error in
                if error != nil{
                    // Error nil değilse
                    self.alertMessage(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error , Please try again.")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            self.alertMessage(titleInput: "Error", messageInput: "User e-mail or Password cannot be nil.")
        }
    }
    
    @IBAction func signupButtonClicked(_ sender: Any) {
        if e_mailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: e_mailTextField.text!, password: passwordTextField.text!) { authdataresult, error in
                if error != nil{
                    self.alertMessage(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error, Please try again.")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            alertMessage(titleInput: "Error", messageInput: "User e-mail or Password cannot be nil.")
        }
    }
    
    func alertMessage (titleInput : String, messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}


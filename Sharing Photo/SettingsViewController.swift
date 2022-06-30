//
//  SettingsViewController.swift
//  Sharing Photo
//
//  Created by Furkan Ceylan on 30.06.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toVC", sender: nil)
    }
    

}

//
//  ViewController.swift
//  WholesaleStore
//
//  Created by Abdullah Alsalamah on 03/05/2020.
//  Copyright © 2020 Abdullah Alsalamah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
class ViewController: UIViewController {

    @IBOutlet weak var enterEmail: UITextField!
    @IBOutlet weak var enterPassword: UITextField!
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = enterEmail.text, let password = enterPassword.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let err = error {
                    print(err.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


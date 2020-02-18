//
//  LoginViewController.swift
//  Instagram
//
//  Created by Tony Chen on 2/17/20.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func signInClicked(_ sender: Any) {
        var user = PFUser()
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginToFeed", sender: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
        
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        var user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        // other fields can be set just like with PFObject
        user["phone"] = "415-392-0202"
        user.signUpInBackground { (success, Error) in
            if success {
                self.performSegue(withIdentifier: "loginToFeed", sender: nil)
            } else {
                print(Error?.localizedDescription)
            }
        }
    }
}

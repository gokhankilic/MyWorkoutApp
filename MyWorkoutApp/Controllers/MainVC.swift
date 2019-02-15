//
//  ViewController.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 14.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import UIKit
import Parse

class MainVC: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButtpn: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    var loginMode = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil {
            performSegue(withIdentifier: "toProfileView", sender: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    @IBAction func loginOrSignupButtonTapped(_ sender: Any) {
        if loginMode {
            if let username = usernameTextField.text{
                if let password = passwordTextField.text {
                    PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
                        if error != nil {
                            print("Error")
                        }else{
                            if let userr = user as? PFUser{
                                self.performSegue(withIdentifier: "toProfileView", sender: self)
                            }
                        }
                    }
                }
            }
        }
        else {
            if usernameTextField.text != "" && passwordTextField.text != "" {
                let newUser = PFUser()
        
                if let username = usernameTextField.text{
                    if let password = passwordTextField.text {
                        newUser.username = username
                        newUser.password = password
                        newUser.email = username
                        newUser.signUpInBackground { (success, error) in
                            if error != nil {
                                if let errorDes = error?.localizedDescription{
                                    let alert = UIAlertController.init(title: "Error", message: errorDes, preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                                        alert.dismiss(animated: true, completion: nil)
                                    }))
                                }
                            }else {
                                if success{
                                    print("Sign up complated")
                                    self.performSegue(withIdentifier: "toProfileView", sender: self)
                                }else {
                                    print("Failed Sign Up")
                                }
                            }
                        }
                    }
                }
            }else {
                var alert = UIAlertController.init(title: "Error", message: "Invalid username or password", preferredStyle: .alert)
            
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (UIAlertAction) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func changeLoginModeTapped(_ sender: Any) {
        
        if loginMode {
            
            loginButtpn.setTitle("Sign Up", for: [])
            signupButton.setTitle("Log In", for: [])
            loginMode = false
            
        }else {
            loginButtpn.setTitle("Login", for: [])
            signupButton.setTitle("Sign Up", for: [])
            loginMode = true
            
            
            
        }
        
    }
    
   
}


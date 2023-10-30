//
//  LoginViewController.swift
//  Caviar_v0.1
//
//  Created by Nate Dixon on 9/25/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 43/255, green: 46/255, blue: 74/255, alpha: 1)
        
        setUpElements()
    }
    
    func setUpElements() {
        //Hide error label
        errorLabel.alpha = 0
        
        //style text fields + button
        Utilities.styleTextField(emailInput)
        Utilities.styleTextField(passwordInput)
        Utilities.styleFilledButton(loginButton)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginClick(_ sender: Any) {

        //validate text fields
        
        
        //create cleaned versions of text field
        let email = emailInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //signing in user
        Auth.auth().signIn(withEmail: email, password: password) {
            (result, error) in
            
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
                
            } else {
                
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
                
            }
        }
        
    }
}

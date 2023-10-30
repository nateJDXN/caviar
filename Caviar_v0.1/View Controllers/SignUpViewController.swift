//
//  SignUpViewController.swift
//  Caviar_v0.1
//
//  Created by Nate Dixon on 9/25/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore


class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameInput: UITextField!
    
    @IBOutlet weak var lastNameInput: UITextField!
    
    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
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
        Utilities.styleTextField(firstNameInput)
        Utilities.styleTextField(lastNameInput)
        Utilities.styleTextField(emailInput)
        Utilities.styleTextField(passwordInput)
        Utilities.styleFilledButton(signUpButton)
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
        //returns error message if !validateFields
    // MARK: - Validate Fields
    
    func validateFields() -> String? {
         
        //checks for empty fields
        if firstNameInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
              return "Please fill in all fields."
        }
        
        //checks if password is strong
        let cleanedEmail = emailInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedPassword = passwordInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        //fuck with the requirements at the bottom of Utilities file !!
        if Utilities.isEmailValid(cleanedEmail) == false {
            return "Incorrect Email format"
        }
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //insecure password
            return "Make sure your password contains 8 characters and contains a special character and a number."
        }
        
        return nil //if everything returns true
    }
    
    

    @IBAction func signUpClick(_ sender: Any) {
        
        //Validate field
        let error = validateFields()
        
        if error != nil {
            //something wrong with fields, show error
            showError(error!)
        } else {
            
            //Create cleaned versions of the data
            let firstName = firstNameInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Create user
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                //check for errors
                if err != nil {

                    //There was an error creating the usr
                    self.showError("Oops! Something went wrong, please try again.")
                    
                } else {
                    
                    // user was created successfully, store information
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "email":email, "password":password, "uid":result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            self.showError("Oops! Something went wrong, please try again")
                        }
                    }
                    
                    //Transition to home screen
                    self.successfulAuth()
                    
                }
            }
        
        //Switch to homescreen
        }
    }
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func successfulAuth() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
}

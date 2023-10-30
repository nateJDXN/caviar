//
//  ViewController.swift
//  Caviar_v0.1
//
//  Created by Nate Dixon on 9/25/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 43/255, green: 46/255, blue: 74/255, alpha: 1)
        
        setUpElements()
    }
    
    func setUpElements() {
        //style buttons
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
        
    }


}


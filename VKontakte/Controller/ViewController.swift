//
//  ViewController.swift
//  VKontakte
//
//  Created by Valya on 16.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    @IBOutlet var textLogin: UITextField!
    @IBOutlet var textPassword: UITextField!
    
    @IBAction func nextScene(_ sender: Any) {
        guard let login = textLogin.text,
              let password = textPassword.text,
              login == "",
              password == "" else {
            show(message: "Поля логин/пароль должны быть пустыми")
            return
        }
        
        performSegue(withIdentifier: "Login", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }

}




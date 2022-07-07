//
//  ViewController.swift
//  VKontakte
//
//  Created by Valya on 16.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageAnimate: UIImageView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var textLogin: UITextField!
    @IBOutlet var textPassword: UITextField!
    @IBOutlet var button: UIButton!
    
    @IBAction func nextScene(_ sender: Any) {
        guard let login = textLogin.text,
              let password = textPassword.text,
              login == "",
              password == "" else {
            show(message: "Поля логин/пароль должны быть пустыми")
            return
        }
        showAnimatingDotsInImageView()
        textLogin.isEnabled = false
        textPassword.isEnabled = false
        button.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.performSegue(withIdentifier: "Login", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func showAnimatingDotsInImageView() {
        
        let lay = CAReplicatorLayer()
        lay.frame = imageAnimate.bounds
        
        let circle = CALayer()
        circle.frame = CGRect(x: lay.frame.width/2-13.5, y: lay.frame.height/2-3.5, width: 7, height: 7)
        circle.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = UIColor(red: 110/255.0, green: 110/255.0, blue: 110/255.0, alpha: 1).cgColor
        lay.addSublayer(circle)
        lay.instanceCount = 3
        lay.instanceTransform = CATransform3DMakeTranslation(10, 0, 0)
        let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        anim.fromValue = 1.0
        anim.toValue = 0.2
        anim.duration = 1
        anim.repeatCount = .infinity
        circle.add(anim, forKey: nil)
        lay.instanceDelay = anim.duration / Double(lay.instanceCount)
        
        imageAnimate.layer.addSublayer(lay)
    }
}




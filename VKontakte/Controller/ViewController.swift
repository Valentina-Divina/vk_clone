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
        logoAnimation()
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
   
    
    func logoAnimation(){
        
        let layer = CAShapeLayer()
        
        
        layer.path = vkLogo.cgPath
        layer.lineWidth = 4
        layer.strokeColor = UIColor.black.cgColor
        
        layer.fillColor = UIColor.clear.cgColor
        
        layer.strokeEnd = 1
        layer.strokeStart = 0

        image.layer.addSublayer(layer)
        
        let strokeEndAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        strokeEndAnimation.fromValue = 0 // откуда начинаем анимацию
        strokeEndAnimation.toValue = 1
        strokeEndAnimation.duration = 4 // продолжительность анимации
        layer.add(strokeEndAnimation, forKey: nil)
        
    }
    
    let vkLogo: UIBezierPath = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 25.5, y: 34.6))
        path.addCurve(to: CGPoint(x: 8.1, y: 14.6), controlPoint1: CGPoint(x: 14.6, y: 34.6), controlPoint2: CGPoint(x: 8.4, y: 27.1))
        path.addLine(to: CGPoint(x: 13.6, y: 14.6))
        path.addCurve(to: CGPoint(x: 21, y: 28.4), controlPoint1: CGPoint(x: 13.8, y: 23.8), controlPoint2: CGPoint(x: 17.8, y: 27.6))
        path.addLine(to: CGPoint(x: 21, y: 14.6))
        path.addLine(to: CGPoint(x: 26.2, y: 14.6))
        path.addLine(to: CGPoint(x: 26.2, y: 22.5))
        path.addCurve(to: CGPoint(x: 33.8, y: 14.6), controlPoint1: CGPoint(x: 29.3, y: 22.2), controlPoint2: CGPoint(x: 32.6, y: 18.6))
        path.addLine(to: CGPoint(x: 38.9, y: 14.6))
        path.addCurve(to: CGPoint(x: 31.9, y: 24.6), controlPoint1: CGPoint(x: 38.1, y: 19.5), controlPoint2: CGPoint(x: 34.5, y: 23.1))
        path.addCurve(to: CGPoint(x: 40.1, y: 34.6), controlPoint1: CGPoint(x: 34.5, y: 25.8), controlPoint2: CGPoint(x: 38.6, y: 28.9))
        path.addLine(to: CGPoint(x: 34.4, y: 34.6))
        path.addCurve(to: CGPoint(x: 26.2, y: 27.4), controlPoint1: CGPoint(x: 33.2, y: 30.8), controlPoint2: CGPoint(x: 30.2, y: 27.8))
        path.addLine(to: CGPoint(x: 26.2, y: 34.6))
        path.addLine(to: CGPoint(x: 25.5, y: 34.6))
        path.apply(CGAffineTransform(scaleX: 4, y: 4))
        path.close()

        return path
    }()
    
    private func createVkLogopath() -> UIBezierPath {
        let bezier5Path = UIBezierPath()
        bezier5Path.move(to: CGPoint(x: 292, y: 77))
        bezier5Path.addLine(to: CGPoint(x: 336, y: 77))
        bezier5Path.addCurve(to: CGPoint(x: 336, y: 141), controlPoint1: CGPoint(x: 336, y: 77), controlPoint2: CGPoint(x: 336, y: 104.2))
        bezier5Path.addCurve(to: CGPoint(x: 338, y: 177), controlPoint1: CGPoint(x: 336.87, y: 156.71), controlPoint2: CGPoint(x: 338, y: 177))
        bezier5Path.addLine(to: CGPoint(x: 338, y: 293))
        bezier5Path.addCurve(to: CGPoint(x: 336, y: 299), controlPoint1: CGPoint(x: 338, y: 293), controlPoint2: CGPoint(x: 336.87, y: 296.38))
        bezier5Path.addCurve(to: CGPoint(x: 336, y: 337), controlPoint1: CGPoint(x: 336, y: 321.91), controlPoint2: CGPoint(x: 336, y: 337))
        bezier5Path.addLine(to: CGPoint(x: 76, y: 337))
        bezier5Path.addLine(to: CGPoint(x: 76, y: 77))
        bezier5Path.addLine(to: CGPoint(x: 292, y: 77))
        bezier5Path.addLine(to: CGPoint(x: 292, y: 77))
        bezier5Path.close()

        bezier5Path.addClip()

        bezier5Path.close()

        return bezier5Path
    }
    
}

//
//  ColorGameViewController.swift
//  VKontakte
//
//  Created by Valya on 28.06.2022.
//

import UIKit

class ColorGameViewController: UIViewController {
    
    let weater = WeatherApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allButton.append(colorButton1)
        allButton.append(colorButton2)
        allButton.append(colorButton3)
        randomizeColors()
        
        allButton.forEach { btn in
            
        }
        
        weater.weather()
    }
    
    @IBOutlet var colorLabel: UILabel!
    @IBOutlet var colorButton1: UIButton!
    @IBOutlet var colorButton2: UIButton!
    @IBOutlet var colorButton3: UIButton!
    
    var correctColors: UIColor? = nil
    var rounds: Int = 0
    var point: Int = 0
    var correctButtton: Int = 0
    var allColor: Int = 0
    
    var colorArray: [UIColor?] = []
    var hexStringArray: [String] = []
    var allButton: [UIButton] = []
    
    @IBAction func click(_ sender: UIButton) {
        if correctColors == sender.tintColor {
            point += 5
        }
        randomizeColors()
    }
    
    @IBAction func InfoAlert(_ sender: UIBarButtonItem) {
        let alert = UIAlertController (title: "Игра:  Угадай цвет",
                                       message: "Вам показывается HEX-код случайного цвета и 3 варианта цвета на выбор. При выборе правильного варианта Вам присваивается 5 очков. Игра длится 5 раундов.",
                                       preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: nil))
        self.present(alert, animated: true)
    }
    
    
    func randomizeColors() {
        if self.rounds < 5 {
            hexStringArray = []
            colorArray = []
            for i in 0...2 {
                let randomHexColor = getRandomHexColor ()
                hexStringArray.append(randomHexColor)
                let convertedHexColor = UIColor.init(hex: randomHexColor)
                colorArray.append(convertedHexColor)
                allButton[i].tintColor = convertedHexColor
            }
            
            let randomIndex = Int.random(in: 0...2)
            correctColors = colorArray[randomIndex]
            
            colorLabel.text = hexStringArray[randomIndex]
        } else {
            let alert = UIAlertController (title: "Игра окончена",
                                           message: "Заработано \(self.point) очков",
                                           preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Начать заново",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
            rounds = 0
            point = 0
        }
        rounds += 1
    }
    
    func getRandomHexColor() -> String {
        var createdHexColor: String = ""
        
        let colorItems: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]
        
        for _ in 0 ..< 6 { //  тут муть
            createdHexColor.append(colorItems.randomElement()!)
        }
        return createdHexColor
    }
    
}


extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        let lenght = hexSanitized.count
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        if lenght == 6 {
            r = CGFloat((rgb & 0xff0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00ff00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000ff) / 255.0
        } else if lenght == 8 {
            r = CGFloat((rgb & 0xff000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00ff0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000ff00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000ff) / 255.0
        } else {
            return nil
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
}

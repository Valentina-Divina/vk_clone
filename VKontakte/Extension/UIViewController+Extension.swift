//
//  UIViewController+Extension.swift
//  VKontakte
//
//  Created by Valya on 18.06.2022.
//

import Foundation
import UIKit

extension ViewController {
    func show(message: String) {
        let alertError = UIAlertController(title: "Ошибка",
                                        message: message,
                                        preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок",
                                     style: .default) { _ in
            self.textLogin.text = ""
            self.textPassword.text = ""
            
        }
        alertError.addAction(okAction)
        
        present(alertError, animated: true)
    }
}

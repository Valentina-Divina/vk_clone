//
//  hueta.swift
//  VKontakte
//
//  Created by Valya on 08.08.2022.
//

import Foundation
import Alamofire
import WebKit
import UIKit

class VkLoginVC: UIViewController {
    
    let session = SessionSingleton.shared
    var secondVC: TabViewController?
    
    // авторизация для получения токена
    // получение запросов при использовании токена из п.1
    @IBOutlet weak var webView: WKWebView!
    let appId = "51396938"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        var urlComponent = URLComponents()
        
        urlComponent.scheme = "https"
        urlComponent.host = "oauth.vk.com"
        urlComponent.path = "/authorize"
        
        urlComponent.queryItems = [URLQueryItem(name: "client_id", value: appId),
                                   URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html "),
                                   URLQueryItem(name: "display", value: "mobile"),
                                   URLQueryItem(name: "response_type", value: "token")]
        
        let url = urlComponent.url
        if UIApplication.shared.canOpenURL(url!) {
            let request = URLRequest(url: url!)
            webView.load(request)
        }
    }
}

extension VkLoginVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment.components(separatedBy: "&")
            .map{$0.components(separatedBy: "=")}
            .reduce([String:String]()) { res, param in
                
                var dict = res
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        if let token = params["access_token"]{
            self.session.token = token // токен добавлен в синглтон
//            print("TOKEN TAG", token)
            secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabView") as? TabViewController
            self.view.insertSubview((secondVC?.view)!, at: 9) // добавить потом проверку
        }
        decisionHandler(.cancel)
    }
}

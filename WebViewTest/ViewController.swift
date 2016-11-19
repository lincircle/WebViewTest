//
//  ViewController.swift
//  WebViewTest
//
//  Created by Yuhsuan on 19/11/2016.
//  Copyright © 2016 cgua. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate, WKNavigationDelegate {
    
    var _my_text_field: UITextField!
    
    var _web_view: WKWebView!
    
    var _activity_indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let full_screen_size = UIScreen.main.bounds.size
        //取得螢幕尺寸
        let go_width = 100.0
        
        let action_width = (Double(full_screen_size.width) - go_width) / 4
        //MARK: 建立五個 button
        //back
        var my_button = UIButton(frame: CGRect(x: 0, y: 20, width: action_width, height: action_width))
        
        my_button.setImage(UIImage(named:"back")!, for: .normal)
        
        my_button.addTarget(self, action: #selector(ViewController.back), for: .touchUpInside)
        
        self.view.addSubview(my_button)
        //forward
        my_button = UIButton(frame: CGRect(x: action_width, y: 20, width: action_width, height: action_width))
        
        my_button.setImage(UIImage(named:"forward")!, for: .normal)
        
        my_button.addTarget(self, action: #selector(ViewController.forward), for: .touchUpInside)
        
        self.view.addSubview(my_button)
        //refresh
        my_button = UIButton(frame: CGRect(x: action_width * 2, y: 20, width: action_width, height: action_width))
        
        my_button.setImage(UIImage(named:"refresh")!, for: .normal)
        
        my_button.addTarget(self, action: #selector(ViewController.reload), for: .touchUpInside)
        
        self.view.addSubview(my_button)
        //stop
        my_button = UIButton(frame: CGRect(x: action_width * 3, y: 20, width: action_width, height: action_width))
        
        my_button.setImage(UIImage(named:"stop")!, for: .normal)
        
        my_button.addTarget(self, action: #selector(ViewController.stop), for: .touchUpInside)
        
        self.view.addSubview(my_button)
        //前往
        my_button = UIButton(frame: CGRect(x: Double(full_screen_size.width) - go_width, y: 20, width: action_width, height: action_width))
        
        my_button.setTitle("前往", for: .normal)
        
        my_button.setTitleColor(.black , for: .normal)
        
        my_button.addTarget(self, action: #selector(ViewController.go), for: .touchUpInside)
        
        self.view.addSubview(my_button)
        
        _my_text_field = UITextField(frame: CGRect(x: 0, y: 20.0 + CGFloat(action_width), width: full_screen_size.width, height: 40))
        
        _my_text_field.text = "https://www.google.com"
        
        _my_text_field.clearButtonMode = .whileEditing
        
        _my_text_field.returnKeyType = .go
        
        _my_text_field.delegate = self
        
        self.view.addSubview(_my_text_field)
        //MARK: 建立 webview
        _web_view = WKWebView(frame: CGRect(x: 0, y: 60.0 + CGFloat(action_width), width: full_screen_size.width, height: full_screen_size.height - 60 - CGFloat(action_width)))
        
        _web_view.navigationDelegate = self
        
        self.view.addSubview(_web_view)
        //建立動畫
        _activity_indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        _activity_indicator.center = CGPoint(x: full_screen_size.width * 0.5, y: full_screen_size.height * 0.5)
        
        self.view.addSubview(_activity_indicator)
        
        self.go()
        
    }

    func back() {
        
        _web_view.goBack()
        
    }
    
    func forward() {
        
        _web_view.goForward()
        
    }
    
    func reload() {
        
        _web_view.reload()
        
    }
    
    func stop() {
        
        _web_view.stopLoading()
        
        _activity_indicator.stopAnimating()
        
    }
    
    func go() {
        
        self.view.endEditing(true)
        
        print(String(describing: _my_text_field.text))
        
        let url = URL(string: _my_text_field.text!)
        
        let url_request = URLRequest(url: url!)
        
        _web_view.load(url_request)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.go()
        
        return true
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        _activity_indicator.startAnimating()
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        _activity_indicator.stopAnimating()
        
        if let current_url = _web_view.url {
            
            _my_text_field.text = current_url.absoluteString
            
        }
    }


}


//
//  LaunchViewController.swift
//  ReadMe
//
//  Created by Son Nguyen on 10/21/17.
//  Copyright © 2017 Son Nguyen. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class LaunchViewController: UIViewController {
    
    var btnLogout : UIButton!
    @IBOutlet weak var  btnLogin : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogout = UIButton(type: .custom)
        btnLogout.frame = CGRect(x: 16, y: 300, width: 100, height: 30)
        btnLogout.backgroundColor = UIColor.red
        btnLogout.tintColor = .white
        btnLogout.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btnLogout.setTitle("Log out", for: .normal)
        btnLogout.titleLabel?.textColor = .black
        view.addSubview(btnLogout)
        
        btnLogout.isHidden = true
        btnLogout.addTarget(self, action: #selector(self.logoutButtonClicked),  for: .touchUpInside)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // Add a custom login button to your app
//        btnLogin = UIButton(type: .custom)
//        btnLogin.backgroundColor = UIColor.darkGray
//        btnLogin.frame = CGRect.init(x: 0, y: 0, width: 180, height: 40)
//        btnLogin.center = view.center
//        btnLogin.setTitle("Login with facebook", for: .normal)
//
        // Handle clicks on the button
        btnLogin.addTarget(self, action: #selector(self.loginButtonClicked),  for: .touchUpInside)
        
        // Add the button to the view
//        view.addSubview(btnLogin)
//        btnLogin.isHidden = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshView()
        
        //
        //        if let accessToken = AccessToken.current {
        //            // User is logged in, use 'accessToken' here.
        //            connection.add(MyProfileRequest()) { response, result in
        //                switch result {
        //                case .success(let response):
        //                    //response.
        //                    print("Custom Graph Request Succeeded: \(response)")
        //                    // print("My facebook id is \(response?["id"])")
        //                // print("My name is \(response.dictionaryValue?["name"])")
        //                case .failed(let error):
        //                    print("Custom Graph Request Failed: \(error)")
        //                }
        //            }
        //            connection.start()
        //
        //        }else{
        ////            let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        ////            loginButton.center = view.center
        ////
        ////            view.addSubview(loginButton)
        //        }
    }
    
    // Once the button is clicked, show the login dialog
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ .publicProfile, .email, .userFriends ], viewController: self) {
            loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                // new login
                AccessToken.current = accessToken
                print("Logged in!")
                self.refreshView()
               
            }
        }
    }
    
    @objc func logoutButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logOut()
        // AccessToken.current = nil
        refreshView()
    }
    
    func refreshView(){
        if AccessToken.current != nil {
            print("Login already")
            btnLogout.isHidden = false
            btnLogin.isHidden = true
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "go_home", sender: self)
            }
        } else {
            btnLogin.isHidden = false
            btnLogout.isHidden = true
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



//
//  LoginViewController.swift
//  EagleFastSwift
//
//  Created by ggx on 2017/7/18.
//  Copyright © 2017年 高广校. All rights reserved.
//

import UIKit
import SQLite
//import SweetAlert
//import Popover
//import Alamofire
//import SwiftyJSON
class LoginViewController: ViewControllerImpl {
    
    @IBOutlet weak var _textFieldPassword: UITextField!
    @IBOutlet weak var _textFieldAccount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "登陆"
        // Do any additional setup after loading the view.
    }
    
    //点击登陆按钮
    @IBAction func didActionBottomIndex(_ sender: UIButton) {
        let sqliteContext = SQLiteManager()
        
        
        sqliteContext.getUserInfoAccount(loginAccount: _textFieldAccount.text!, loginPsw: _textFieldPassword.text!) {
            (isCanLogin) in
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserLogin"), object: self)
            self.navigationController?.dismiss(animated: true, completion: nil)
            
        }
       
    }
    //注册按钮
    @IBAction func RegisterMethod(_ sender: UIButton) {
        self.navigationController?.pushViewController(UserRegViewController(nibName: "UserRegViewController", bundle: nil), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

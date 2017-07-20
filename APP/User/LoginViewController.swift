//
//  LoginViewController.swift
//  EagleFastSwift
//
//  Created by ggx on 2017/7/18.
//  Copyright © 2017年 高广校. All rights reserved.
//

import UIKit
//import Alamofire
//import SwiftyJSON
class LoginViewController: ViewControllerImpl {

    @IBOutlet weak var _textFieldPassword: UITextField!
    @IBOutlet weak var _textFieldAccount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //点击登陆按钮
    @IBAction func didActionBottomIndex(_ sender: UIButton) {
    
        CustomUtil.saveAcessToken(token: "1")
        //登陆成功，返回
        self.navigationController?.popViewController(animated: true)
//        EagleFastSwift
//        let url = "http://192.168.2.75/User/userLogin.php?username=ggx&password=123456"
////        let url = "http://192.168.1.116/build/Admin/User/login.php?&user_name=admin&user_pwd=123456"
//        
////
////
//        Alamofire.request(url,method: .post).responseJSON {
//            (response) in
//            if response.result.isSuccess{
//                print(JSON(response.result.value!))
////                print(response.value as Any)
//            }
//        }

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

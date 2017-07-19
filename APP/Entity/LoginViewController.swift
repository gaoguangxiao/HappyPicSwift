//
//  LoginViewController.swift
//  EagleFastSwift
//
//  Created by ggx on 2017/7/18.
//  Copyright © 2017年 高广校. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class LoginViewController: ViewControllerImpl {

    @IBOutlet weak var _textFieldPassword: UITextField!
    @IBOutlet weak var _textFieldAccount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //点击登陆按钮
    @IBAction func didActionBottomIndex(_ sender: UIButton) {
    
//        EagleFastSwift
//        http://192.168.2.75/test.php?username=ggx&password=123456
//        http://192.168.1.116/build/Admin/User/login.php?&user_name=admin&user_pwd=123456
        Alamofire.request("http://192.168.1.116/build/Admin/User/login.php?&user_name=admin&user_pwd=123456").responseJSON {
            (response) in
            if response.result.isSuccess{
                print(JSON(response.result.value!))
//                print(response.value as Any)
            }
        }
        

        
//        let requestComplete: (HTTPURLResponse?, Result<String>) ->
//            
//            Void = { response, result in
//            
//            print(result.value as Any)
//        }
//        
//        request.responseString {
//            response in requestComplete(response.response, response.result)
//            
//            
//        }
        
        
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

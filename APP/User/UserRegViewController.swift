//
//  UserRegViewController.swift
//  EagleFastSwift
//
//  Created by ggx on 2017/7/20.
//  Copyright © 2017年 高广校. All rights reserved.
//

import UIKit
import SQLite
class UserRegViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func RegisterMethod(_ sender: UIButton) {
        //1、注册成功直接登陆，向用户表插入字段数值
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let db = try? Connection("\(path)/EagleFastSwift.sqlite3")
        let users = Table("Users")
        
        let userId = Expression<String>("1")
        let userName = Expression<String>(self.userName.text!)
        let userPhone = Expression<String>(self.phone.text!)
        let password = Expression<String>(self.password.text!)
        //创建表
        try! db?.run(users.create(block: { (table) in
            table.column(userId)
            table.column(userName)
            table.column(userPhone, unique: true)
            table.column(password)
        }))
        
        print(db!)
        self.navigationController?.popToRootViewController(animated: true)
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

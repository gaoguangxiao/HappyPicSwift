//
//  UserRegViewController.swift
//  EagleFastSwift
//
//  Created by ggx on 2017/7/20.
//  Copyright © 2017年 高广校. All rights reserved.
//

import UIKit
//import SQLitema
//import SQLite
class UserRegViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func RegisterMethod(_ sender: UIButton) {
        let sqliteContext = SQLiteManager()
        let imageData = UIImageJPEGRepresentation(UIImage.init(named: "2.png")!, 0.8)
        
        sqliteContext.inserData(username:self.userName.text!, userphone: self.phone.text!, insertUserLogo: (imageData?.base64EncodedString())!, pswd: password.text!)

        self.navigationController?.popViewController(animated: true)
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

//
//  HomeViewController.swift
//  乐科图
//
//  Created by ggx on 2017/7/5.
//  Copyright © 2017年 高广校. All rights reserved.
//

import UIKit

class HomeViewController: ViewControllerImpl {

    
    @IBOutlet weak var _tableView: UITableView!
//    var tableView :UITableView?
    
//    va
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //检测用户是否登陆，跳转登陆界面
//        let islogin = CustomUtil.isUserLogin()
        if  !CustomUtil.isUserLogin(){
            let Vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
            Vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(Vc, animated: true)
        }
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

//
//  HomeViewController.swift
//  乐科图
//
//  Created by ggx on 2017/7/5.
//  Copyright © 2017年 高广校. All rights reserved.
//

import UIKit
import SQLite

import AVFoundation
enum KAction : Int{
    case stone
    case scissors
    case cloth
}
enum PayMethodsType: Int {
    case WeChat   = 0
    case QQ       = 1
    case AliPay   = 2
    case Delivery = 3
}
class HomeViewController: UIViewController {
    
    let rangeHome : NSInteger! = nil//房间等级
    
    
    var computerCount : NSInteger!
    var computerScore : NSInteger!
    var userCount : NSInteger!
    var userSrore : NSInteger!
    
    var myName = KAction.stone
    
    @IBOutlet weak var imageViewComputer: UIImageView!//电脑给的数值
    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var coperation: UIView!
    @IBOutlet weak var isResults: UILabel!
    @IBOutlet weak var computerScoreLabel: UILabel!
    @IBOutlet weak var userScoreLabel: UILabel!
    let sqliteContext = SQLiteManager()
    
    var timer:Timer!
    
    var imageList : Array<UIImage> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "猜拳"
        self.navigationController!.navigationBar.isTranslucent = false;
        
        userSrore = 0
        computerScore = 0
        //检测用户是否登陆，跳转登陆界面
        if  !CustomUtil.isUserLogin(){
            let Vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
            let userCenterNavi = UINavigationController.init(rootViewController: Vc)
            Vc.hidesBottomBarWhenPushed = true
            self.navigationController?.present(userCenterNavi, animated: true, completion: nil)
//            return
        }else{
            let userInfo = sqliteContext.geuUserInfo(id: CustomUtil.getToken())
            //进入游戏需要更新分数
            userSrore = NSString(string:userInfo.loginScore).integerValue
            computerScore = NSString(string: userInfo.logincomputerScore).integerValue
        }
        
        
        //电脑的分数，数据库没有这个字段就插入一个字段
        //        sqliteContext.insercolumn(column: "computerScore")
        updataShowScore()
        
        
        coperation.isHidden = true;
        imageList = [UIImage(named: "石头")!,UIImage(named: "剪刀")!,UIImage(named: "布")!]
        // 启用计时器，控制每秒执行一次tickDown方法
        timer = Timer.scheduledTimer(timeInterval: 0.1,
                                     target:self,selector:#selector(self.computerGame),
                                     userInfo:nil,repeats:true)
        
        
        AudioPlayer.share(soundFileName: "背景音乐.caf")
        
    }
    
    //电脑定时器调用时间
    func computerGame() {
        computerCount = Int(arc4random() % 3)
        //        print(computerCount)
        imageViewComputer.image =  imageList[computerCount];
        
    }
    
    
    @IBAction func TapButton(_ sender: UIButton) {
        myName = KAction(rawValue: sender.tag)!
        
        imageViewUser.image = imageList[myName.rawValue]
        userCount = myName.rawValue
        
        self.compareResult()
        
    }
    
    //比较结果
    func compareResult() {
        coperation.isHidden = false;
        //定时器停止
        timer.fireDate = NSDate.distantFuture
        //定时器停止的时候，将计数保存，重新赋值
        imageViewComputer.image =  imageList[computerCount];
        
        //        print(userCount,computerCount)
        if computerCount == userCount {
            isResults.text = "平局";
            AudioPlayer.share(soundFileName: "和局.aiff")
        }else if userCount-computerCount == -2 || userCount - computerCount == 1 {
            isResults.text = "输了";
            AudioPlayer.share(soundFileName: "失败.aiff")
            computerScore = computerScore + 1
            
        }else{
            AudioPlayer.share(soundFileName: "胜利.aiff")
            isResults.text = "赢了";
            userSrore = userSrore + 1
        }
        
        updataShowScore() //更新显示的分数
        
        //更新数据库/需要处理线程问题
        let queue = DispatchQueue(label:"com.eagleFast.app")
        queue.async(execute: {
            () -> Void in
            self.updateSqliteData()//更新数据库存储的分数
        })
        
    }
    
    //MARK:更新玩家和电脑的分数
    func updataShowScore(){
        computerScoreLabel.text = String(format: "分数: %.1d", computerScore);
        userScoreLabel.text = String(format: "分数: %.1d", userSrore);
        
    }
    
    //MARK:更新玩家和电脑的分数
    func updateSqliteData() {
        let userInfo = sqliteContext.geuUserInfo(id: CustomUtil.getToken())
        
        let newUserScore = String(format: "%.1d", userSrore)
        let newComputer =  String(format: "%.1d", computerScore)
        sqliteContext.updataSqliteScore(id: CustomUtil.getToken(), oldUserScore: userInfo.loginScore, newUserScore: newUserScore, oleComScore: userInfo.logincomputerScore, newComScore: newComputer)
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserLogin"), object: self)
            }
            
        }
        
        
    }
    @IBAction func returnGame(_ sender: UIButton){
        //            [clickMusic play];
        //            [backMusic play];
        timer.fireDate = NSDate.distantPast
        
        isResults.text = "";
        imageViewUser.image = UIImage.init(named:"");
        coperation.isHidden = true;
        //背景音乐
        AudioPlayer.share(soundFileName: "背景音乐.caf")
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

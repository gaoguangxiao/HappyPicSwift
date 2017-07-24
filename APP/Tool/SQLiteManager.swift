//
//  SQLiteManager.swift
//  GuessStone
//
//  Created by ggx on 2017/7/21.
//  Copyright © 2017年 高广校. All rights reserved.
//

import Foundation
import SQLite

struct SQLiteManager {
    private var db: Connection!
    private let users = Table("users") //表名

    private let userId = Expression<String>("userId")
    private let userName = Expression<String>("username")
    private let userPhone = Expression<String>("phone")
    private let score = Expression<String>("score")
    private let password = Expression<String>("password")
    private let computerScore = Expression<String>("computerScore")
    private let userLogo = Expression<String>("userLogo")
    
    init() {
         createdsqlite3()
    }
    
    //创建数据库文件 
//    使用 mutating 关键字修饰方法是为了能在该方法中修改 struct 或是 enum 的变量
    mutating func createdsqlite3(filePath : String = "/Documents") {
        let sqlFilePath = NSHomeDirectory() + filePath + "/EagleFastSwift.sqlite"
        print(sqlFilePath)
        do {
            db = try Connection(sqlFilePath)
            try! db?.run(users.create(ifNotExists:true, block:
            {
                (table) in
                table.column(userId, primaryKey: true)
                table.column(userName)
                table.column(userPhone, unique: true)
                table.column(score)
                table.column(userLogo)
                table.column(password)
                table.column(computerScore)
            }
            ))
        } catch {
            print(error)
        }
    }
    //插入数据
    func inserData(username:String,userphone:String,insertUserLogo:String,pswd:String) {
        do {
            //用户id，需要自增,那就得查询里面有多少用户
            let userData = readData().last;
            let str = NSString(string:(userData?.id)!).integerValue
            let newUserId = "\(str + 1)"
            
            let insert = users.insert(userId <- newUserId,userName <- username, userPhone <- userphone, password<-pswd,score<-"0",computerScore<-"0",userLogo<-insertUserLogo)
//            使用try!可以打破错误传播链条。错误抛出后传播给它的调用者，这样就形成了一个传播链条，但有的时候确实不想让错误传播下去，可以使用try!语句。
            try db?.run(insert)
        } catch {
            print(error)
        }
    }
    //向数据库插入一列 电脑分数
    func insercolumn(column:String){
        do {
            let addComumn = users.addColumn(computerScore,check:Expression<Bool>("computerScore") ,defaultValue: "0", collate: .rtrim)
            try db.run(addComumn)
        } catch{
            print(error)
        }
    }
    //向数据库插入一列 用户图片
    func insercolumnUserLogo(column:String){
        do {
            let addColumn = users.addColumn(userLogo, defaultValue: column, collate: .rtrim)
            
            try db.run(addColumn)
        } catch{
            print(error)
        }
    }
//   MARK:- 更新数据库用户的头像
    func updateUserLogo(id:String,oldUserLogo:String,userData:String) {
        do {
            let currUser = users.filter(id == userId)
            try db.run(currUser.update(userLogo <- userLogo.replace(oldUserLogo, with: userData)))
        } catch{
            print(error)
        }
    }
    //读取数据
    func readData() -> [(id:String,readUserName:String,readPswd:String,readScore:String)] {
        var userData = (id:"0",readUserName:"test",readPswd:"000000",readScore:"0")
        var userDataArr = [userData]
        for user in try!db.prepare(users) {
            userData.id = String(user[userId])
            userData.readUserName = user[userName]
            userData.readPswd     = user[password]
            userData.readScore = user[score]
            //向数组中加入元素
            userDataArr.append(userData)
        }
        return userDataArr
    }
    //MARK:读取指定的用户信息
    func geuUserInfo(id:String)->(logincomputerScore:String,loginUserName:String,loginUserLogo:String,loginScore:String){
        var userData = (logincomputerScore:"0",loginUserName:"test",loginUserLogo:"000000",loginScore:"0")
        for user in try!db.prepare(users.filter(id == userId)) {
            userData.logincomputerScore = user[computerScore]
            userData.loginUserName = user[userName]
            userData.loginUserLogo     = user[userLogo]
            userData.loginScore = user[score]
        }
        return userData
    }
//    MARK:根据账户和密码读取用信息,写block返回
    func getUserInfoAccount(loginAccount:String,loginPsw:String) -> (id:String,userRight:Bool,userPsw:Bool) {
        var  userRight = false
        var  userPsw = false
        for user in (try! db?.prepare(users.filter(userName == loginAccount))
            )!{
                userRight = true
                if user[password] == loginPsw {
                    userPsw = true
                    CustomUtil.saveAcessToken(token: user[userId])
                }
        }
        return (CustomUtil.getToken(),userRight,userPsw)
    }
//    MARK:带参数有返回值的闭包处理
    func getUserInfoAccount(loginAccount:String,loginPsw:String,complated:(_ userPsw:Bool) -> Void){
        var  userRight = false
        var  userPsw = false
        for user in (try! db?.prepare(users.filter(userName == loginAccount))
            )!{
                userRight = true
                if user[password] == loginPsw {
                    userPsw = true
                    CustomUtil.saveAcessToken(token: user[userId])
                }
        }
        
        if userRight,userPsw {
            complated (userPsw)
        }else{
            var alerttitle = "账号错误"
            if userRight {
                alerttitle = "密码错误"
            }
             _ = SweetAlert().showAlert(alerttitle)
        }
    }

    //更新数据 实际也就是玩家分数和电脑的分数
    func updataSqliteScore(id:String,oldUserScore:String,newUserScore:String,oleComScore:String,newComScore:String){
        do {
            let currUser = users.filter(id == userId)
            try db.run(currUser.update(score <- score.replace(oldUserScore, with: newUserScore),computerScore <- computerScore.replace(oleComScore, with: newComScore)))
        } catch{
            print(error)
        }
    }

    //删除数据
    func delData(id: String) {
        let currUser = users.filter(id == userId)
        do {
            try db.run(currUser.delete())
        } catch {
            print(error)
        }
    }
    
    
}

//
//  CustomUtil.swift
//  EagleFastSwift
//
//  Created by ggx on 2017/7/18.
//  Copyright © 2017年 高广校. All rights reserved.
//

import UIKit


let U_TOKEN = "TOKEN"
let USER_DEFAULT = UserDefaults.standard

class CustomUtil: NSObject {

    //是否登陆
    static func isUserLogin() -> Bool {
        if (USER_DEFAULT.value(forKey: U_TOKEN) != nil){
            return true
        }else {
            return false
        }
    }
    
    
}

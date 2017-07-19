//
//  UIViewController+Extension.swift
//  EagleFastSwift
//
//  Created by ggx on 2017/7/18.
//  Copyright © 2017年 高广校. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    
    internal convenience init(nibName:String?,barItem:UITabBarItem,title:String){
        self.init(nibName: nibName, bundle: nil)
        self.tabBarItem = barItem
        self.title = title
    }
    
    convenience init(hidesBottomBarWhenPushed b:Bool,nibName:String) {
        self.init(nibName: nibName,bundle:nil)
        self.hidesBottomBarWhenPushed = true
    }
    
//    convenience init(hid)
    
}

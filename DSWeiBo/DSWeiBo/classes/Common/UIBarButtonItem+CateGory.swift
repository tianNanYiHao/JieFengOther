//
//  UIBarButtonItem+CateGory.swift
//  DSWeiBo
//
//  Created by Lff on 16/11/28.
//  Copyright © 2016年 Lff. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem{
    //如果在func 中添加 class  就相当于oc中的 +  类方法
    
    /// 类方法修改导航条按钮
    ///
    /// - parameter iconName: 导航条图片名
    /// - parameter action:   导航条时间监听
    ///
    /// - returns: 返回barButtonItem
    class func createBarItem(iconName:String ,target :AnyObject? , action : Selector)->UIBarButtonItem {
        let Btn = UIButton()
        Btn.setImage(UIImage.init(named: iconName), for: .normal)
        Btn.setImage(UIImage.init(named: iconName+"_highlighted"), for: .highlighted)
        Btn.addTarget(target, action: action, for: .touchUpInside)
        Btn.sizeToFit()
        return UIBarButtonItem.init(customView: Btn)
    }
}


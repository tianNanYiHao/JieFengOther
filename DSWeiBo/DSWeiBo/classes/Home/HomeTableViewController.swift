//
//  HomeTableViewController.swift
//  DSWeiBo
//
//  Created by Lff on 16/11/7.
//  Copyright © 2016年 Lff. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //如果没有登录,就设置未登录界面
        if !useLogin
        {
            unloginView?.setupUNloginView(isHome: true, iconName: "visitordiscover_feed_image_house", message: "关注一些人,回这里看看有什么惊喜!")
            return
        }
        
        //初始化导航条
        setUpNav()
        
    }
    
    private func setUpNav(){
            //左边按钮 //写法二 : 添加分类方法编写
        //初始化左右按钮
            navigationItem.leftBarButtonItem = UIBarButtonItem.createBarItem(iconName: "navigationbar_friendattention", action: #selector(leftBtnClick))
            navigationItem.rightBarButtonItem = UIBarButtonItem.createBarItem(iconName: "navigationbar_pop", action: #selector(rightBtnClick))
        //初始化标题按钮
        
       }
   
    
    private func createBarItem(iconName:String , action : Selector)->UIBarButtonItem{
        let Btn = UIButton()
        Btn.setImage(UIImage.init(named: iconName), for: .normal)
        Btn.setImage(UIImage.init(named: iconName+"_highlighted"), for: .highlighted)
        Btn.addTarget(self, action: action, for: .touchUpInside)
        Btn.sizeToFit()
        return UIBarButtonItem.init(customView: Btn)
    }
    
    func leftBtnClick() {
        
    }
    func rightBtnClick() {
        
    }
    
}

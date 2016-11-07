//
//  MainViewController.swift
//  DSWeiBo
//
//  Created by Lff on 16/11/7.
//  Copyright © 2016年 Lff. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置当前控制器的颜色为原色
        tabBar.tintColor = UIColor.orange
        addChildViewController(HomeTableViewController(), "首页", "tabbar_home", "")
        addChildViewController(MessageTableViewController(), "消息", "tabbar_message_center", "")
        addChildViewController(DiscoverTableViewController(), "发现", "tabbar_discover", "")
        addChildViewController(ProfileTableViewController(), "我", "tabbar_profile", "tabbar_profile")
        
    }

    
    
    
    //MARK: - 私有的封装方法 : 创建导航设置图片以及标题
    private func addChildViewController(_ childController: UIViewController , _ titleName:String , _ imageDefaule:String , _ imageSelect:String) {
        childController.tabBarItem.image = UIImage.init(imageLiteralResourceName: imageDefaule)
        childController.tabBarItem.selectedImage = UIImage.init(imageLiteralResourceName: imageDefaule+"_highlighted")
        let nav = UINavigationController.init(rootViewController: childController)
        childController.tabBarItem.title = titleName
        childController.navigationItem.title = titleName
        addChildViewController(nav)
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

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
        
        
        //1获取字典
        let path =  Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil)
        //动态绑定
        if let jsonPath = path {
            //2 通过路径创建NSData
            let data = NSData.init(contentsOfFile: jsonPath)
            
            //3.序列化json数据,-->Array
            // do try 操作
            do {
                let dictArr =  try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                print(dictArr)
                for dict in dictArr as! [[String:String]]{
                    // 取字符(可从后台获取) 创建类
                    addChildViewController(dict["vcName"]!, dict["title"]!, dict["imageName"]!)
                }
            } catch {
                //处理异常
                print(error)
            }
        }
        
        
    }

    
    //MARK: - 私有的封装方法 : 创建导航设置图片以及标题
    private func addChildViewController(_ childControllerName: String , _ titleName:String , _ imageDefaule:String) {
        //动态获取命名空间 (从plist中获取) CFBundleExecutable
        let productName =  Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        //1 根据字符串创建类
        let className:AnyClass? = NSClassFromString(productName+"."+childControllerName)
        print(className)
        //2 绑定类的类型为 UIViewController  (将AnyClass 转换位 指定的类型)
        let classCtr = className as! UIViewController.Type
        //3 根据自定义的类 来创建对象
        let vc = classCtr.init()
        
        //设置vc
        vc.tabBarItem.image = UIImage.init(imageLiteralResourceName: imageDefaule)
        vc.tabBarItem.selectedImage = UIImage.init(imageLiteralResourceName: imageDefaule+"_highlighted")
        let nav = UINavigationController.init(rootViewController: vc)
        vc.tabBarItem.title = titleName
        vc.navigationItem.title = titleName
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

//
//  MainViewController.swift
//  DSWeiBo
//
//  Created by Lff on 16/11/7.
//  Copyright © 2016年 Lff. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    //MARK: - 懒加载
    private lazy var composBtn:UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named: "tabbar_compose_icon_add"), for: UIControlState.normal)
        btn.setImage(UIImage.init(named: "tabbar_compose_icon_add_highlighted"), for: UIControlState.highlighted)
        btn.setBackgroundImage(UIImage.init(named: "tabbar_compose_button"), for: UIControlState.normal)
        btn.setBackgroundImage(UIImage.init(named: "tabbar_compose_button_highlighted"), for: UIControlState.highlighted)
        btn.addTarget(self, action: #selector(compoesBtnClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置当前控制器的颜色为原色
//        tabBar.tintColor = UIColor.orange
        
        //1.动态创建子控制器
        addCompos()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpComposBtn()
    }
    
    //MARK: - 设置中间按钮  
    //注意:简体按钮事件的方法 不能是私有方法,这个方式是UIApplication 发送过来的
    //按钮的点击事件 是由 运行循环(RunLoop) 监听  并且以 消息机制 发送的 , 所以监听方法不能是私有的
    private func setUpComposBtn()->(){
        tabBar.addSubview(composBtn)
        let width = UIScreen.main.bounds.width/CGFloat(viewControllers!.count)
        let x = width*2
        composBtn.frame = CGRect.init(origin: .init(x: x, y: 0), size: CGSize.init(width: width, height: 49))
        
    }
    
    //MARK:- 监听按钮事件
    func compoesBtnClick(){
        print(#function)
    }
    
    
    //MARKL - 动态创建子控制器
    private func addCompos()->(){
        
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

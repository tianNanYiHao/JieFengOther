//
//  HomeTableViewController.swift
//  DSWeiBo
//
//  Created by Lff on 16/11/7.
//  Copyright © 2016年 Lff. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation


class HomeTableViewController: BaseTableViewController {

    ///懒加载 - 自定义转场管理类
    //一定要定义一个属性来保存自定义转场对象,否则会报错
    private lazy var popoverAnimator : PopoverAnimator = {
        let pop = PopoverAnimator()
        pop.presentedFrame = CGRect.init(x: 80, y: 56, width: 150, height: 400)
        return pop
    }()
    
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
        
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(changeBtnState), name: NSNotification.Name(rawValue: LffPopoverViewWillShow), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeBtnState), name: NSNotification.Name(rawValue: LffPopoverViewWillDismiss), object: nil)
        
    }
    //移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func changeBtnState(){
        let titleBtn = navigationItem.titleView as! TitleButton
        titleBtn.isSelected = !titleBtn.isSelected
    }
    private func setUpNav(){
            //左边按钮 //写法二 : 添加分类方法编写
        //初始化左右按钮
            navigationItem.leftBarButtonItem = UIBarButtonItem.createBarItem(iconName: "navigationbar_friendattention", target: self, action: #selector(leftBtnClick))
            navigationItem.rightBarButtonItem = UIBarButtonItem.createBarItem(iconName: "navigationbar_pop",target: self, action: #selector(rightBtnClick))
        //初始化标题按钮
        let titleButtonView = TitleButton.init(frame: CGRect.zero)
        titleButtonView.setTitle("肉包子打嘟嘟 ", for: UIControlState.normal)
        titleButtonView.addTarget(self, action: #selector(titleBtnClick(btn:)), for: UIControlEvents.touchUpInside)
        navigationItem.titleView = titleButtonView
        
       }
    func titleBtnClick(btn : UIButton){
        //1.修改箭头方向
//        btn.isSelected = !btn.isSelected
        
        //2.弹出菜单
        let sb = UIStoryboard.init(name: "PopoverViewControllers", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        //2.1 设置转场代理
        //默认的情况下,modal会移除以前控制器的view,替换为弹出的ViewController的view
        //自定义转场动画,就不会移除以前控制器的view
        vc?.transitioningDelegate = popoverAnimator
        //2.2 设置转场样式 -> 自定义
        vc?.modalPresentationStyle = UIModalPresentationStyle.custom
        present(vc!, animated: true, completion: nil)
    }
    
    func leftBtnClick() {
        print(#function)
    }
    func rightBtnClick() {
        let sb = UIStoryboard.init(name: "QRcodeViewController", bundle: nil)
        let pc = sb.instantiateInitialViewController()
        present(pc!, animated: true, completion: nil)
    }

}



//
//  PopoverPresentationController.swift
//  DSWeiBo
//
//  Created by Lff on 16/11/29.
//  Copyright © 2016年 Lff. All rights reserved.
//

import UIKit

///自定义一个转场控制器
class PopoverPresentationController: UIPresentationController {

    //蒙版
    
  /// 懒加载蒙版View
  private lazy var bgView : UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(white: 0.0, alpha: 0.2)
        bgView.frame = UIScreen.main.bounds
        let tag = UITapGestureRecognizer.init(target: self, action: #selector(dismiss))
        bgView.addGestureRecognizer(tag)
        return bgView
    }()
    
    //定义属性-弹出框frame
    var presentedFrame = CGRect.zero
    
    
   /// 初始化方法,返回用于创建负责转场动画的对象
   ///
   /// - parameter presentedViewController:  被展现的控制器
   /// - parameter presentingViewController: 发起的控制器
   ///
   /// - returns: 负责转场动画的对象
   override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    
    }
    
    ///即将布局转场子视图时调用
    override func containerViewWillLayoutSubviews() {
        
        if presentedFrame == CGRect.zero{
            //重置presentedView的frame
            presentedView?.frame = CGRect.init(x: 80, y: 56, width: 200, height: 200)
        }else{
             presentedView?.frame = presentedFrame
        }
        
        //插入蒙版
        containerView?.insertSubview(bgView, at: 0)
    }
    
    func dismiss(){
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}

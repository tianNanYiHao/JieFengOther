//
//  PopoverAnimator.swift
//  DSWeiBo
//
//  Created by Lff on 16/11/30.
//  Copyright © 2016年 Lff. All rights reserved.
//

import UIKit
//定义常量 保存通知的名称
let LffPopoverViewWillShow  = "LffPopoverViewWillShow"
let LffPopoverViewWillDismiss = "LffPopoverViewWillDismiss"

class PopoverAnimator: NSObject , UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning
{
    //记录当前是否展开
    var isPresened:Bool = false
    //定义属性-弹出框frame
    var presentedFrame = CGRect.zero
    
    //实现代理,告诉系统 谁来负责转场动画 (返回一个 UIPresentationController)
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let pc = PopoverPresentationController.init(presentedViewController: presented, presenting: presenting)
        pc.presentedFrame = presentedFrame
        return pc
    }
    
    
    //MARK: - 只要重置弹出和消失动画的执行者为自定义控制器,那么系统默认的动画将不会实现,所有动画效果均由程序猿自己编写设置
    //设置弹出动画的执行者为当前控制器
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresened = true
       //发送通知, 即将展开
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: LffPopoverViewWillShow), object: self)
        return self
    }
    
    //设置dismiss动画的执行者为当前控制器
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresened = false
        //发送通知,即将压扁
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: LffPopoverViewWillDismiss), object: self)
        return self
    }
    
    //设置动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    //设置转场动画的自定义实现
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //拉申
        if isPresened{
            //1.拿到展示图
            let toview = transitionContext.view(forKey: UITransitionContextViewKey.to)
            toview?.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.0)
            //2.将视图添加到容器上
            transitionContext.containerView.addSubview(toview!)
            //  2.1 重置锚点
            toview?.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0.0)
            //3.执行动画
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                //4.清空trainsform
                toview?.transform = CGAffineTransform.identity
                //5.动画执行完毕,一定要告诉系统,否则出现未知错误
                transitionContext.completeTransition(true)//
            })
        }else{//压扁
            //1.拿到展示图
            let formview = transitionContext.view(forKey: UITransitionContextViewKey.from)
            //3.执行动画
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                formview?.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.0)  //注意: 由于CGFloat 是不准确的,所以写成 (scaleX: 1.0, y: 0.0) 会没有动画 这是个系统坑
                //5.动画执行完毕,一定要告诉系统,否则出现未知错误
                transitionContext.completeTransition(true)//
            })
        }
    }
    
    
    
}

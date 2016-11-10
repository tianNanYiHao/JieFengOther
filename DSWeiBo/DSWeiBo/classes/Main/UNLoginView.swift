//
//  UNLoginView.swift
//  DSWeiBo
//
//  Created by Lff on 16/11/9.
//  Copyright © 2016年 Lff. All rights reserved.
//

import UIKit

class UNLoginView: UIView {

    //MARK: - 懒加载控件
    /// 转盘
    private lazy var iconView : UIImageView = {
        let view = UIImageView.init(image: UIImage.init(named: ""))
        return view
    }()
    /// 图标
    private lazy var homeIcon : UIImageView = {
        let hv = UIImageView.init(image: UIImage.init(named: ""))
        return hv
    }()
    /// 文本
    private lazy var messageLab : UILabel = {
        let lb = UILabel()
        return lb
    }()
    /// 登录按钮
    private lazy var loginBtn : UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        return btn
    }()
    /// 注册按钮
    private lazy var registerBtn : UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        return btn
    }()
    
    
    ///重写init方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        //1. 添加子控件
        addSubview(iconView)
        addSubview(homeIcon)
        addSubview(messageLab)
        addSubview(loginBtn)
        addSubview(registerBtn)
        
        
        //2.布局子空间
       
        
        
        
    }
    
    
    
    
    //  switf推荐我们自定义一个控件 要么使用纯代码,要么仅使用xib/sb
    //如果我们使用纯代码 重写了父类的方法, 那么下面的方法强制要实现
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

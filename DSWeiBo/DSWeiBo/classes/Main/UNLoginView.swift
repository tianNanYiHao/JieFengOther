//
//  UNLoginView.swift
//  DSWeiBo
//
//  Created by Lff on 16/11/9.
//  Copyright © 2016年 Lff. All rights reserved.
//

import UIKit
import SnapKit


class UNLoginView: UIView {

    //MARK: - 懒加载控件
    /// 转盘
    private lazy var iconView : UIImageView = {
        let view = UIImageView.init(image: UIImage.init(named: "visitordiscover_feed_image_smallicon"))
        return view
    }()
    /// 遮罩
    private lazy var maskview : UIImageView = {
        let view = UIImageView.init(image: UIImage.init(named: "visitordiscover_feed_mask_smallicon"))
        return view
    }()
    
    /// 图标
    private lazy var homeIcon : UIImageView = {
        let hv = UIImageView.init(image: UIImage.init(named: "visitordiscover_feed_image_house"))
        return hv
    }()
    /// 文本
    private lazy var messageLab : UILabel = {
        let lb = UILabel()
        lb.text = "的说法范萨范德德萨范德德萨范德德萨范德德萨范德萨"
        lb.numberOfLines = 0
        lb.textAlignment = NSTextAlignment.center
        lb.textColor = UIColor.darkGray
        return lb
    }()
    /// 登录按钮
    private lazy var loginBtn : UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setTitle("登陆", for: UIControlState.normal)
        btn.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        btn.setBackgroundImage(UIImage.init(named: "common_button_white_disable"), for: UIControlState.normal)
        return btn
    }()
    /// 注册按钮
    private lazy var registerBtn : UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setTitle("注册", for: UIControlState.normal)
        btn.setTitleColor(UIColor.orange, for: .normal)
        btn.setBackgroundImage(UIImage.init(named: "common_button_white_disable"), for: UIControlState.normal)
        return btn
    }()
    
    
    ///重写init方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        //1. 添加子控件
        addSubview(iconView)
        addSubview(maskview)
        addSubview(homeIcon)
        addSubview(messageLab)
        addSubview(loginBtn)
        addSubview(registerBtn)
        
        //2.布局子控件
        iconView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        maskview.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo((UIApplication.shared.keyWindow?.bounds.width)!)
            make.height.equalTo((UIApplication.shared.keyWindow?.bounds.height)!)
        }
        homeIcon.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        messageLab.snp.makeConstraints { (make) in
            make.width.equalTo(224)
            make.top.equalTo(iconView.snp.bottom).offset(10)
            make.centerX.equalTo(iconView)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.right.equalTo(messageLab)
            make.top.equalTo(messageLab.snp.bottom).offset(10)
            make.size.equalTo(CGSize.init(width: 100, height: 30))
        }
        registerBtn.snp.makeConstraints { (make) in
            make.left.equalTo(messageLab)
            make.top.equalTo(messageLab.snp.bottom).offset(10)
            make.size.equalTo(CGSize.init(width: 100, height: 30))
        }
        
        
        
        
        func setuoUNloginView(isHome:Bool ,iconName:String , message:String){
            iconView.isHidden = !isHome
            
        }
        
        
    }
    
    
    
    
    //  switf推荐我们自定义一个控件 要么使用纯代码,要么仅使用xib/sb
    //如果我们使用纯代码 重写了父类的方法, 那么下面的方法强制要实现
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

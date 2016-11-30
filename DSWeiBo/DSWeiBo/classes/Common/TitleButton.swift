//
//  TitleButton.swift
//  DSWeiBo
//
//  Created by Lff on 16/11/28.
//  Copyright © 2016年 Lff. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(UIColor.darkGray, for: .normal)
        setImage(UIImage.init(named: "navigationbar_arrow_down"), for: UIControlState.normal)
        setImage(UIImage.init(named: "navigationbar_arrow_up"), for: .selected)
        self.sizeToFit()
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    ///对自定义的按钮重新布局
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.size.width
    }

}

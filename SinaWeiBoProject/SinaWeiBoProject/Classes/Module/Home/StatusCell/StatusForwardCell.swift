//
//  StatusForwardCell.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/14.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit

class StatusForwardCell: StatusCell {


    
    //重写父类的 - 微博数据视图模型
    /// 不需要 super ,父类的 didset 仍然能够正常执行  --> 只需要设置子类的控件内容
    override var statusViewModel:StatusViewModel?{
        
        didSet{
        forwardLabel.text = statusViewModel?.forwardText
        }
    }
    
    override func setupUI() {
        
        
        super.setupUI()
        
        // 1.添加控件
        contentView.insertSubview(forwardButton, belowSubview: statusPicture)
        contentView.insertSubview(forwardLabel, aboveSubview: forwardButton)
//
        //2. 布局
        // 1. 背景按钮
        forwardButton.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: nil, offset: CGPoint(x: -HMStatusCellMargin, y: HMStatusCellMargin))
        
        forwardButton.ff_AlignVertical(type: ff_AlignType.TopRight, referView: bottomView, size: nil)
        
        // 2.转发文字
        forwardLabel.ff_AlignInner(type: ff_AlignType.TopLeft, referView: forwardButton, size: nil, offset: CGPoint(x: HMStatusCellMargin, y: HMStatusCellMargin))
        
        
        // 3. 转发配图
        let cons = statusPicture.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: forwardLabel, size: CGSize(width: HMStatusPictureMaxWith, height: HMStatusPictureMaxWith), offset: CGPoint(x: 0, y: HMStatusCellMargin))
        
        pictureViewWidthCons = statusPicture.ff_Constraint(cons, attribute: NSLayoutAttribute.Width)
        pictureViewHeighthCons = statusPicture.ff_Constraint(cons, attribute: NSLayoutAttribute.Height)
        pictureViewTopCons = statusPicture.ff_Constraint(cons, attribute: NSLayoutAttribute.Top)
        
    }
    
    //MARK: - 懒加载控件
    
    //1.背景图片
    private lazy var forwardButton:UIButton = {
    
        let button = UIButton()
        button.backgroundColor = UIColor ( red: 0.9805, green: 0.9805, blue: 0.9805, alpha: 1.0 )
        return button
    }()
    
    //2. 转发文字
    private lazy var forwardLabel:UILabel = UILabel(title: "转发微博转发微博转发微博转发微博转发微博转发微博转发微博转发微博转发微博", color: UIColor.darkGrayColor(), fonSize: 14, layoutWith: UIScreen.mainScreen().bounds.width - 2 * HMStatusCellMargin)
    
    

}

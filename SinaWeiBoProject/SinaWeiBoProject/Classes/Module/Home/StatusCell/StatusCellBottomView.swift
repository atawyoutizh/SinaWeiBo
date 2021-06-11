//
//  StatusCellBottomView.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/12.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit

class StatusCellBottomView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
    
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        //1.添加控件 
        addSubview(forwardButton)
        addSubview(commentButton)
        addSubview(linkButton)
        
        //2. 设置布局
        ff_HorizontalTile([forwardButton,commentButton,linkButton], insets: UIEdgeInsetsZero)
        
//        ff_VerticalTile([forwardButton,commentButton,linkButton], insets: UIEdgeInsetsZero)
    }
    
    //MARK: - 懒加载控件
    
    private lazy var forwardButton:UIButton  = UIButton(title: " 转发", imageName: "timeline_icon_retweet", color: UIColor.darkGrayColor(), fontSize: 12)
     private lazy var commentButton:UIButton  = UIButton(title: " 评论", imageName: "timeline_icon_comment", color: UIColor.darkGrayColor(), fontSize: 12)
     private lazy var linkButton:UIButton  = UIButton(title: " 赞", imageName: "timeline_icon_unlike", color: UIColor.darkGrayColor(), fontSize: 12)
    
}

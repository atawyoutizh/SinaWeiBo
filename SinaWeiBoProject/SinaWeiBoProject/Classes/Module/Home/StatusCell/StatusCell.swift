//
//  StatusCell.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/12.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit


// 控件之间的距离
let HMStatusCellMargin :CGFloat = 12
// 头像的大小
let HMStatusIocnWith:CGFloat = 35


// 默认图片大小 
let HMStatusPictureItemWith:CGFloat = 90

// 默认的图片间距
let HMStatusPictureItemMargin:CGFloat = 10
//每行的最大图片数量
let HMStatusPictureMaxCount:CGFloat = 3
//配图视图的最大尺寸
let HMStatusPictureMaxWith = HMStatusPictureMaxCount * HMStatusPictureItemWith + (HMStatusPictureMaxCount-1) * HMStatusPictureItemMargin



class StatusCell: UITableViewCell {


    //微博数据 视图模型
    var statusViewModel:StatusViewModel?{
        didSet{
            //模型数值被设置之后，马上要产生的连锁反应 - 界面UI发生变化
            topView.statusViewModel = statusViewModel
            contentLabel.text = statusViewModel?.status.text
            
            // 提示：在自动布局系统中，随机修改表格越苏，使用自动计算行高 很容易出问题
            // 通过测试，提前确定方法的可行性
            pictureViewHeighthCons?.constant = HMStatusPictureItemWith * CGFloat(random() % 4)
        }
    }
    // 宽度约束
    var pictureViewWidthCons:NSLayoutConstraint?
    // 高度约束
    var pictureViewHeighthCons:NSLayoutConstraint?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
//        backgroundColor = UIColor.redColor()
        // 顶部视图
        let topSepView = UIView()
        topSepView.backgroundColor = UIColor(white: 0.88, alpha: 1.0)
        
        //1. 添加控件
        contentView.addSubview(topSepView)
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(statusPicture)
        contentView.addSubview(bottomView)
    
        //2. 设置布局
        let with = UIScreen.mainScreen().bounds.width
        //1. 顶部分割视图
        topSepView.ff_AlignInner(type: ff_AlignType.TopLeft, referView: contentView, size: CGSize(width: with, height: 10))
        //2. 顶部视图
        topView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: topSepView, size: CGSize(width: with, height: HMStatusCellMargin + HMStatusIocnWith), offset:CGPoint(x: 0, y: 10))
        //3. 文本标签
        contentLabel.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: topView, size: nil, offset: CGPoint(x: HMStatusCellMargin, y: HMStatusCellMargin))
        //4. 配图视图
        
        let cons = statusPicture.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: CGSize(width: HMStatusPictureMaxWith, height: HMStatusPictureMaxWith), offset: CGPoint(x: 0, y: HMStatusPictureItemMargin))
        
        pictureViewWidthCons = statusPicture.ff_Constraint(cons, attribute: NSLayoutAttribute.Width)
        pictureViewHeighthCons = statusPicture.ff_Constraint(cons, attribute: NSLayoutAttribute.Height)
        
        
        // 5. 底部视图
        bottomView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: statusPicture, size: CGSize(width: with, height: 44), offset: CGPoint(x: -HMStatusCellMargin, y: HMStatusCellMargin))
     
        // 指定底部视图相对 底边 约束
//        bottomView.ff_AlignInner(type: ff_AlignType.BottomRight, referView: contentView, size: nil)
        
        
    }
    
    //MARK: - 懒加载控件 - 从上到下，从左到右 的顺序来些代码，便于后期的维护
    //1.顶部视图
    private lazy var topView:StatusCellTopView = StatusCellTopView()
    
    //2. 文本标签
    private lazy var contentLabel:UILabel = UILabel(title: nil, color: UIColor.grayColor() , fonSize: 15 ,layoutWith:(UIScreen.mainScreen().bounds.width - HMStatusCellMargin * 2))
    
    //3. 配图视图
    private lazy var statusPicture:StatusPictureView = StatusPictureView()
    
    // 4.底部视图
    private lazy var bottomView:StatusCellBottomView = StatusCellBottomView()
    
}












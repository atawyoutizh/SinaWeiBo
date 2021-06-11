//
//  StatusCellTopView.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/12.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit

class StatusCellTopView: UIView {

    
    var statusViewModel:StatusViewModel?{
    
        didSet{
            
            //TODO: 设置界面数据
            
            nameLabel.text = statusViewModel!.status.user?.name
            iconView.sd_setImageWithURL(statusViewModel?.userIconUrl)
            
            //vip 
            vipView.image = statusViewModel?.userVipImage
            
            //会员图标
            memberView.image = statusViewModel?.userMemberImage
            
        }
    }
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    
    private func setupUI(){
    
    //1. 添加控件 
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(memberView)
        addSubview(timeLabel)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        addSubview(vipView)
    
    
    //2. 自动布局
        let offset = CGPoint(x: HMStatusCellMargin, y: 0)
        
        iconView.ff_AlignInner(type: ff_AlignType.TopLeft, referView: self, size: CGSize.init(width: HMStatusIocnWith, height: HMStatusIocnWith), offset: CGPoint.init(x: HMStatusCellMargin, y: HMStatusCellMargin))
    
        nameLabel.ff_AlignHorizontal(type: ff_AlignType.TopRight, referView: iconView, size: nil, offset: offset)
        memberView.ff_AlignHorizontal(type: ff_AlignType.TopRight, referView: nameLabel, size: nil, offset: offset)
        
        timeLabel.ff_AlignHorizontal(type: ff_AlignType.BottomRight, referView: iconView, size: nil, offset: offset)
        
        sourceLabel.ff_AlignHorizontal(type: ff_AlignType.BottomRight, referView: timeLabel, size: nil, offset: offset)
    
        vipView.ff_AlignInner(type: ff_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: 8, y: 8))
    }
    
    //MARK: - 懒加载控件
    //头像
    private lazy var iconView:UIImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    // 名称
    private lazy var nameLabel:UILabel = UILabel(title: nil, color: UIColor.grayColor(), fonSize: 14)
    // 会员头像
    private lazy var memberView:UIImageView = UIImageView(image: UIImage(named: "common_icon_membership_level1"))
    //时间
    private lazy var timeLabel:UILabel = UILabel(title: "刚刚", color: UIColor.grayColor(), fonSize: 10)
    // 来源
    private lazy var sourceLabel:UILabel = UILabel(title: "来自新浪微博", color: UIColor.orangeColor(), fonSize: 10)
    // Vip头像
    private lazy var vipView:UIImageView = UIImageView(image: UIImage(named: "avatar_vip"))
}

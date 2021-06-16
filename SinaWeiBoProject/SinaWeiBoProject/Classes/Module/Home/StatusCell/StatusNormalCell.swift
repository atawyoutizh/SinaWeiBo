//
//  StatusNormalCell.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/14.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit

class StatusNormalCell: StatusCell {

    
    override func setupUI() {
        super.setupUI()
        
        //4. 配图视图
        let cons = statusPicture.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: CGSize(width: HMStatusPictureMaxWith, height: HMStatusPictureMaxWith), offset: CGPoint(x: 0, y: HMStatusCellMargin))
        pictureViewWidthCons = statusPicture.ff_Constraint(cons, attribute: NSLayoutAttribute.Width)
        pictureViewHeighthCons = statusPicture.ff_Constraint(cons, attribute: NSLayoutAttribute.Height)
        pictureViewTopCons = statusPicture.ff_Constraint(cons, attribute: NSLayoutAttribute.Top)
    }

}

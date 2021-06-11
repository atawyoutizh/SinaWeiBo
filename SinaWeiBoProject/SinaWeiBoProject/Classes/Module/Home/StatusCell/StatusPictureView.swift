//
//  StatusPictureView.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/13.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit

class StatusPictureView: UICollectionView {

   
    // 构造函数的调用是底层自动转发的 init()  --> initWithFrame --- initWithFrame:layout
   // 默认的 layout 没有被初始化
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        
        backgroundColor = UIColor.grayColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

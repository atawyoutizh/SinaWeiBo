//
//  StatusPictureView.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/13.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit
import SDWebImage

private let HMStatusPictureViewCellId = "HMStatusPictureViewCellId"

class StatusPictureView: UICollectionView {

    
    //微博数据 视图模型
    var statusViewModel:StatusViewModel?{
    
        didSet{
            sizeToFit()
            //MARK: ★★★★★-->>>>> 刷新数据
            reloadData()
        }
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
       return  calcViewSize()
    }
    
    private func calcViewSize() -> CGSize{
    
        // 1.准备工作 
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        //设置默认大小
        layout.itemSize = CGSize(width: HMStatusPictureItemWith, height: HMStatusPictureItemWith)
        
        //2. 根据图片数量来计算大小 
        let count = statusViewModel?.thumbnailURLs?.count ?? 0
        
        //1.没有图片
        if count == 0{
            return CGSizeZero
        }
        //,--->1张图片
        if count == 1{
            let size = CGSize(width: 150, height: 150)
            layout.itemSize = size
            return size
        }
        
        // 3.  --->4 张图片
        if count == 4 {
            let w = 2 * HMStatusPictureItemWith + HMStatusPictureItemMargin
            return CGSize(width: w, height: w)
        }
        // 4》其他
        /*
        2 ,3 
        5 ,6
        7 ,8 ,9
        
        */
        // 计算显示图片的行数
        let row = CGFloat ((count-1) / Int(HMStatusPictureMaxCount) + 1)
        let h = row * HMStatusPictureItemWith + (row - 1) * HMStatusCellMargin
        let w = HMStatusPictureMaxWith
        
        return CGSize(width: w, height: h)
    }

    // 构造函数的调用是底层自动转发的 init()  --> initWithFrame --- initWithFrame:layout
   // 默认的 layout 没有被初始化
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        
        backgroundColor = UIColor(red: 250.0/255, green: 250.0/255, blue: 250.0/255, alpha: 1)
        
        // 设置布局 的间距
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = HMStatusPictureItemMargin
        layout.minimumLineSpacing = HMStatusPictureItemMargin
        
        // 指定数据源 - 让自己当自己的数据源
        // 1.在自动以 View 中，代码逻辑相对简单，可以考虑自己充当自己的数据源 
        // 2. dataSource & delegate 本事都是弱引用，自己充当自己的代理不会产生循环引用
        // 3, 除了配图视图，自定义 pickerView （省市联动）
        dataSource = self
        
        // 注册可重用cell 
        registerClass(StatusPictureViewCell.self, forCellWithReuseIdentifier: HMStatusPictureViewCellId)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatusPictureView: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return statusViewModel?.thumbnailURLs?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HMStatusPictureViewCellId, forIndexPath: indexPath) as! StatusPictureViewCell
        
        cell.imageUrl = statusViewModel!.thumbnailURLs![indexPath.item]
        return cell
    }
}

class StatusPictureViewCell: UICollectionViewCell {
    
        var imageUrl:NSURL?{
        didSet{
            iconView.sd_setImageWithURL(imageUrl)
        }
    }
    
    //MARK: - cell 的构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconView)
        iconView.ff_Fill(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - 懒加载
    private let iconView:UIImageView = UIImageView()
}





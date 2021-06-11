//
//  NewFeatureViewController.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/11.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit

private let HMNewFeatureCellID = "HMNewFeatureCellID"

private let HMcollectionViewCellNum = 4

class NewFeatureViewController: UICollectionViewController {
    
    init(){
        //调用父类的方法
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 注册可重用  Cell
        self.collectionView!.registerClass(NewFeatureCell.self, forCellWithReuseIdentifier: HMNewFeatureCellID)
        
        // 布局
        prepareLayout()
    }

//      错误：
//       'UICollectionViewLayout' (0x10227b318) to
//        UICollectionViewFlowLayout
    
    //准备布局
    private func prepareLayout(){
        
        //获取当前布局属性
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = UIScreen.mainScreen().bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView?.pagingEnabled = true
        collectionView?.bounces = false
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return HMcollectionViewCellNum
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HMNewFeatureCellID, forIndexPath: indexPath) as! NewFeatureCell
        
        cell.imageIndex = indexPath.item
        
        return cell
    }
    
    // indexPath 参数是之前显示的 cell  的indexPath
     override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        //取 当前显示 cell 的indexPath
        let path = collectionView.indexPathsForVisibleItems().last!
        
        //判断是否是最后一个 
        if path.item == HMcollectionViewCellNum - 1{
        
            // 1.获取cell 
            let cell = collectionView.cellForItemAtIndexPath(path) as! NewFeatureCell
            cell.showStartButton()
        }
    }
}

// 新特性 Cell ,private 保证 cell 只被当前控制器使用
private class NewFeatureCell:UICollectionViewCell{

    // 图像索引属性 
    var imageIndex:Int = 0{
        didSet{
            iconView.image = UIImage(named: "new_feature_\(imageIndex+1)")
            startButton.hidden = true
        }
    }
    
    //动画显示启动按钮
    private func showStartButton(){
        startButton.hidden = false
        startButton.transform = CGAffineTransformMakeScale(0, 0)
        
        //hDamping 弹性系数 ，0~1 越小越弹
        // Velocity ： 初始速度
        UIView.animateWithDuration(2.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: [], animations: { () -> Void in
            self.startButton.transform = CGAffineTransformIdentity
            }) { (_) -> Void in
        }
    }
    
    //frame 的大小 来自于 layout 和 item 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    //设置界面元素
    private func setupUI(){
        //1.添加控件
        addSubview(iconView)
        addSubview(startButton)
        //2.指定布局
        iconView.frame = bounds
        
        // 设置按钮的位置
        startButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: startButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: startButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -150))
        
    }

    //MARK - 懒加载属性
    private lazy var iconView = UIImageView()
    
    //开始体验的 按钮
    private lazy var startButton:UIButton = {
    
        let button = UIButton()
        
        button.setTitle("开始体验", forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted)
        
        button.addTarget(self, action: "startMainViewController", forControlEvents: UIControlEvents.TouchUpInside)
        
        button.sizeToFit()
        return button
    }()
    
    //监听按钮的点击
    private func startMainViewController(){
    
        //利用通知，通知AppDelegate 要更改控制器
        NSNotificationCenter.defaultCenter().postNotificationName(HMSwitchRootViewControllerNotification, object: nil)
    }
    
    
    
    
    
    
}



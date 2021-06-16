//
//  HomeTableViewController.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/5.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeTableViewController: BaseTableViewController {
    
    private var statusListViewModel = StatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !UserAccountViewModel.sharedUserAccount.userLogin{
            visitorView?.setupInfo(nil, message: "关注一些人，会这里看看有什么惊喜")
            return
        }
        
        self.tableView.registerClass(StatusForwardCell.self, forCellReuseIdentifier: HMStatusForWardCellID)
        
        self.tableView.registerClass(StatusNormalCell.self, forCellReuseIdentifier: HMNormalViewCellID)
    
        // 以下两句就可以自动处理行高 ，条件:
        
        // 提示，如果不是呀 自动计算行高 UITableViewAutomaticDimension  一定不要设置底部约束
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = 300
        
        //取消分割线
        tableView.separatorStyle  = UITableViewCellSeparatorStyle.None
        loadData()
        
    }
    
    //加载数据
    func loadData(){
        statusListViewModel.loadStatus().subscribeError({ (error) -> Void in
            SVProgressHUD.showInfoWithStatus("您的网络不给力")
            }) { () -> Void in
                // 刷新表格
                self.tableView.reloadData()
        }
    }
}

// 类似于 OC 的匪类，同时可以将遵守的协议方法大，分离出来
extension HomeTableViewController{

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statusListViewModel.status.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let viewModel = statusListViewModel.status[indexPath.row] as! StatusViewModel
        
        /*
        1.
        dequeueReusableCellWithIdentifier: indexpath --一定会返回一个cell,必须注册可重用cell
        注册: registerClass/registerNib(XIB) 在SB 中制定
        如果缓冲区cell  不存在，会使用原型cell 实例化一个新的cell
        2.
        dequeueReusableCellWithIdentifier  ,会查询可重用cell ,如果注册 原型cell  ,能够查询到，否则，返回 nil
        需要后续判断 if (cell == nil) .是在 ios 5.0 开发使用的
        */
        let cell = tableView.dequeueReusableCellWithIdentifier(viewModel.cellID, forIndexPath: indexPath) as! StatusCell
        
        //获取微博数据
        
        cell.statusViewModel = viewModel
        return cell;
    }
    
    /**
    默认情况下，会计算多有行的行高，原因 ：UITableView 继承自 UIScrollerView
    UIscrollreView 的滚动依赖于 contenSize  ---> 把所有行高计算出来， 才能准确的知道 contentSize
    如果设置了预估行高，会根据预估行高，来计算需要显示行的尺寸
    
    提示： 如果行高是固定的，千万不要实现此代理方法，行高的代理方法，在每个版本的 Xcode 和 ios  模拟器上执行的效率都不一样 
    苹果在底层一直在左优化
    */
    // 计算每个cell 的行高
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
         printLog("返回缓存行高")
        
        //0. 获得模型
        let viewModel = statusListViewModel.status[indexPath.row] as! StatusViewModel
        
        // 1.判断视图模型的行高 是否为 0，如果不为 0.表示行高已经缓存
        if viewModel.rowHeight > 0{
        
            return viewModel.rowHeight
        }
        
        //1. 获得 cell  ，不能使用indexPath  的方法，否则会出现死循环
        let cell = tableView.dequeueReusableCellWithIdentifier(viewModel.cellID) as! StatusCell
        
        // 3. 记录行高 
        viewModel.rowHeight = cell.rowHeight(viewModel)
        
        //2. 返回行高
        return viewModel.rowHeight
    }
}



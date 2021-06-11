//
//  HomeTableViewController.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/5.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit
import SVProgressHUD

private let HMHomeViewCell = "HMHomeViewCell"

class HomeTableViewController: BaseTableViewController {
    
    private var statusListViewModel = StatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !UserAccountViewModel.sharedUserAccount.userLogin{
            visitorView?.setupInfo(nil, message: "关注一些人，会这里看看有什么惊喜")
            return
        }
        
        loadData()
        self.tableView.registerClass(StatusCell.self, forCellReuseIdentifier: HMHomeViewCell)
    
    
        // 以下两句就可以自动处理行高 ，条件:
        
        // 提示，如果不是呀 自动计算行高 UITableViewAutomaticDimension  一定不要设置底部约束
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = 300
        
        
        //取消分割线
        tableView.separatorStyle  = UITableViewCellSeparatorStyle.None
        
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statusListViewModel.status.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /*
        1.
        dequeueReusableCellWithIdentifier: indexpath --一定会返回一个cell,必须注册可重用cell
         注册: registerClass/registerNib(XIB) 在SB 中制定
        如果缓冲区cell  不存在，会使用原型cell 实例化一个新的cell 
        2.
        dequeueReusableCellWithIdentifier  ,会查询可重用cell ,如果注册 原型cell  ,能够查询到，否则，返回 nil 
        需要后续判断 if (cell == nil) .是在 ios 5.0 开发使用的
        */
       let cell = tableView.dequeueReusableCellWithIdentifier(HMHomeViewCell, forIndexPath: indexPath) as! StatusCell

        //获取微博数据
        let statusViewModel = statusListViewModel.status[indexPath.item] as! StatusViewModel
        
        cell.statusViewModel = statusViewModel
        return cell;
    }
}

// 类似于 OC 的匪类，同时可以将遵守的协议方法大，分离出来
extension HomeTableViewController{

}












import UIKit

import ReactiveCocoa

/// 微博列表的师徒模型 - 分离网络方法
class StatusListViewModel: NSObject {
    
    var status:[AnyObject] = [StatusViewModel]()
    
///  加载微博数据
    func loadStatus() ->RACSignal{
    
        // RACSignal 在订阅的时候，会对 self  进行强引用，sendCompleted  说明信号完成，会释放对 self  的强引用
        // 以下代码 不存在循环引用，但是为了保险，可以使用 [weak self] 防范 
        // 这时候需要 将 下面的self 改成  self?
        return RACSignal.createSignal({[weak self] (subscriber) -> RACDisposable! in
            
            //网络工具，执行的时候，会对 self 进行强引用，网络访问结束后，会对 self 的引用释放
            NetworkTools.sharedTools.loadStatus().subscribeNext({ (result) -> Void in
                
                //1. 获取 result 中的  statues  字典数组
                guard let array = result["statuses"] as? [[String:AnyObject]] else {
                    
                    printLog("没有正确的数据")
                    return
                }
//                printLog(array)
                
                //2. 字典转模型
                //2.1 遍历数组
                
                for dict in array{
                    self?.status.append(StatusViewModel(status:Status(dict: dict)))
                }
                
                printLog(self?.status)
                //3.通知调用方
                subscriber.sendCompleted()
                
                }, error: { (error) -> Void in
                    subscriber.sendError(error)
                    
                    print(error)
                }) {}
            
            return nil
        })
    }
}
















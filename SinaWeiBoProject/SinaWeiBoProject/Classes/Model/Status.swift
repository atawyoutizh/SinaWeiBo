
/*

返回字段说明
返回值字段	字段类型	字段说明
created_at	string	微博创建时间
id	int64	微博ID
mid	int64	微博MID
idstr	string	字符串型的微博ID
text	string	微博信息内容
source	string	微博来源
favorited	boolean	是否已收藏，true：是，false：否
truncated	boolean	是否被截断，true：是，false：否
in_reply_to_status_id	string	（暂未支持）回复ID
in_reply_to_user_id	string	（暂未支持）回复人UID
in_reply_to_screen_name	string	（暂未支持）回复人昵称
thumbnail_pic	string	缩略图片地址，没有时不返回此字段
bmiddle_pic	string	中等尺寸图片地址，没有时不返回此字段
original_pic	string	原始图片地址，没有时不返回此字段
geo	object	地理信息字段 详细
user	object	微博作者的用户信息字段 详细
retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
reposts_count	int	转发数
comments_count	int	评论数
attitudes_count	int	表态数
mlevel	int	暂未支持
visible	object	微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
pic_ids	object	微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
ad	object array	微博流内的推广微博ID

*/

import UIKit

/// 微博模型
class Status: NSObject {
    
    ///创建时间
    var created_at:String?
    /// 微博ID
    var id:Int = 0
    /// 微博内容
    var text:String?
    
    /// 微博来源
    var source:String?
    
    /// 配图URL 字符串的数组
    var pic_urls: [[String:String]]?
    
    ///  用户
    var user:User?
    
    
    /// 如果是原创有图，在 pic_url 数组宏记录
    /// 如果是“转发微博” 有图，在 retweeted_status.pic_url 数组中记录
    /// 如果"转发微博" 有图，pic_url 数组中没有图 
    /// 被转发的原创微博对象
    var retweeted_status:Status?
    
    
    //MARK: - 构造函数
    // NSArray & NSDictionary  在swift 中极少用， contenOfFile 加载 plist  才会使用
    init(dict:[String:AnyObject]){
    
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {

        //1.判断 key  是否是 "User"
        if key == "user" {
            // 如果 key 是user ,vale 是字典
            // 调用 User 的构造函数创建User 对象属性
            user = User(dict: value as! [String:AnyObject])
            return
        }
        
        //2. 判断 key 是否是 retweeted_status
        if key == "retweeted_status" {
        
            retweeted_status = Status(dict: value as! [String:AnyObject])
            return
        }
        // 这里一定要注意：一定要调用父类的 suoer 否则会 在key == 处报错
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    
    override var description: String {
        let keys = ["created_at","id","text","source","user","pic_urls","retweeted_status"]
        return dictionaryWithValuesForKeys(keys).description        
    }
    
    
    
    
}

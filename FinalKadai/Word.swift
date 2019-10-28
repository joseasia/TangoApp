import RealmSwift

class Task: Object {
    // 管理用 ID。プライマリーキー
    @objc dynamic var id = 0
    
    // 単語
    @objc dynamic var word1 = ""
    
    // 意味
    @objc dynamic var word2 = ""
    
    // 例文
    @objc dynamic var example = ""
    
    // 発音
    @objc dynamic var pronounce = ""
    
    // 投稿時間 Classes
    @objc dynamic var date = Date()
    
    //画像String
    @objc dynamic var imageString = ""
    
    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "id"
    }
}

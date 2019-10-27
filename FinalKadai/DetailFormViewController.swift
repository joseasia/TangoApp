//
//  DetailFormViewController.swift
//  FinalKadai
//
//  Created by 佐藤　由羽太 on 2019/10/27.
//  Copyright © 2019 jose_asia. All rights reserved.
//

import UIKit
import Eureka
import ImageRow
import RealmSwift

class DetailFormViewController: FormViewController {
    
    
    var selectedImg = UIImage()
    
    var task:Task!
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()


        form +++ Section("覚えたい単語")
            <<< TextRow(){ row in
                row.tag = "word1"
                row.title = "単語"
                row.placeholder = "[覚えたい単語]"
                row.value = ""
            }
            <<< TextRow(){
                $0.tag = "word2"
                $0.title = "意味"
                $0.placeholder = "[意味]"
                $0.value = ""
            }
            +++ Section("発音")
            <<< TextRow(){ row in
                row.tag = "pronounce"
                row.title = ""
                row.placeholder = "[発音]"
                row.value = ""
            }
            +++ Section("例文")
            <<< TextAreaRow(){ row in
                row.tag = "example"
                row.placeholder = "[自身で考えた例文 / 辞書の例文 / 覚えたい単語をTwitterで検索して出てきた例文など]"
                row.value = ""
            }
            +++ Section("単語のイメージ")
            <<< ImageRow() {
                
                $0.title = "画像を登録"
                $0.tag = "image"
                $0.value = UIImage(named: "camera")
                $0.sourceTypes = [.PhotoLibrary, .Camera]
                $0.clearAction = .no
                $0.onChange { [unowned self] row in
                    self.selectedImg = row.value!
                }
            }
//            +++ SelectableSection<ListCheckRow<String>>("品詞", selectionType: .singleSelection(enableDeselection: true))
//        
//            let continents = ["名詞", "動詞", "形容詞", "副詞", "接続詞"]
//            for option in continents {
//                form.last! <<< ListCheckRow<String>(option){ listRow in
//                listRow.tag = "wordClass"
//                listRow.title = option
//                listRow.selectableValue = option
//                listRow.value = nil
//            }
//        }
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        
        let word1Row = form.rowBy(tag: "word1") as! TextRow
        let word1 = word1Row.value
        
        let word2Row = form.rowBy(tag: "word2") as! TextRow
        let word2 = word2Row.value
        
        let pronounceRow = form.rowBy(tag: "pronounce") as! TextRow
        let pronounce = pronounceRow.value
        
        let exampleRow = form.rowBy(tag: "example") as! TextAreaRow
        let example = exampleRow.value
        
        let imageRow = form.rowBy(tag: "image") as! ImageRow
        let imageData = imageRow.value!.jpegData(compressionQuality: 0.5)
        let imageString = imageData!.base64EncodedString(options: .lineLength64Characters)
                
        if word1 != ""{
            try! realm.write {
                self.task.word1 = word1 ?? ""
                self.task.word2 = word2 ?? ""
                self.task.pronounce = pronounce ?? ""
                self.task.example = example ?? ""
                self.task.imageString = imageString
                self.task.date = NSDate()
                self.realm.add(self.task, update: true)
            }
        
        super.viewWillDisappear(animated)
        }else{
        super.viewWillDisappear(animated)
        }
    
}

}

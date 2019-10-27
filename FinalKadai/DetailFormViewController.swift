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

    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ Section("覚えたい単語")
            <<< TextRow(){ row in
                row.tag = "word1"
                row.title = "単語"
                row.placeholder = "[覚えたい単語]"
            }
            <<< TextRow(){
                $0.tag = "word2"
                $0.title = "意味"
                $0.placeholder = "[意味]"
            }
            +++ Section("発音")
            <<< TextRow(){ row in
                row.title = ""
                row.placeholder = "[発音]"
            }
            +++ Section("例文")
            <<< TextAreaRow(){ row in
                row.placeholder = "[自身で考えた例文 / 辞書の例文 / 覚えたい単語をTwitterで検索して出てきた例文など]"
            }
            +++ Section("単語のイメージ")
            <<< ImageRow() {
                
                $0.title = "画像を登録"
                
                $0.sourceTypes = [.PhotoLibrary, .Camera]
                $0.clearAction = .no
                $0.onChange { [unowned self] row in
                    self.selectedImg = row.value!
                }
            }
            +++ SelectableSection<ListCheckRow<String>>("品詞", selectionType: .singleSelection(enableDeselection: true))
        
            let continents = ["名詞", "動詞", "形容詞", "副詞", "接続詞"]
            for option in continents {
                form.last! <<< ListCheckRow<String>(option){ listRow in
                listRow.title = option
                listRow.selectableValue = option
                listRow.value = nil
            }
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

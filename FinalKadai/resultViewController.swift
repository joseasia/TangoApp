//
//  ResultViewController.swift
//  FinalKadai
//
//  Created by 佐藤　由羽太 on 2019/10/17.
//  Copyright © 2019 jose_asia. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var wordLabel1: UILabel!
    @IBOutlet weak var wordLabel2: UILabel!
    
    var task:Task!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPage))
        self.view.addGestureRecognizer(tapGesture)

        wordLabel1.text = task.word1
        wordLabel2.text = task.word2
    }
    
    @objc func dismissPage(_ animated: Bool){
        self.dismiss(animated: true, completion: nil)
    }

//    @IBAction func tst(_ sender: Any) {
////        let text = task.word1
////
////        if let language = NSLinguisticTagger.dominantLanguage(for: text) {
////            let locale = Locale(identifier: "ja_JP")
////            let languageJa = locale.localizedString(forLanguageCode: language)!
////            print(languageJa)
////        } else {
////            print("Unknown language")
////        }
//        let text = task.word1
//        
//        if text != ""{
//            let language = NSLinguisticTagger.dominantLanguage(for: text)
//            let locale = Locale(identifier: "ja_JP")
//            let languageJa = locale.localizedString(forLanguageCode: language!)!
//            print(languageJa)
//        }
//    }
    

    
    

}

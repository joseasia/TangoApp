//
//  InputViewController.swift
//  FinalKadai
//
//  Created by 佐藤　由羽太 on 2019/10/19.
//  Copyright © 2019 jose_asia. All rights reserved.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {
    
    var task:Task!
    let realm = try! Realm()

    @IBOutlet weak var textInputBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPage))
        self.view.addGestureRecognizer(tapGesture)
        
        if task.word1 != ""{
            textInputBox.text = task.word1 + " " + task.word2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textInputBox.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        let word = textInputBox.text
        let wordArray = word?.components(separatedBy: CharacterSet.whitespaces)
        
        if word!.contains(" "){
            try! realm.write {
                self.task.word1 = wordArray![0]
                self.task.word2 = wordArray![1]
                self.task.date = NSDate()
                self.realm.add(self.task, update: true)
            }
        }else{
            try! realm.write {
                self.task.word1 = word!
                self.task.date = NSDate()
                self.realm.add(self.task, update: true)
            }
        }
        
        super.viewWillDisappear(animated)
    }
    

    @objc func dismissPage(_ animated: Bool){
        view.endEditing(true)
        //画面を戻す
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
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

//
//  InputViewController.swift
//  FinalKadai
//
//  Created by 佐藤　由羽太 on 2019/10/19.
//  Copyright © 2019 jose_asia. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class InputViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var textField: TextField!
    
    var task:Task!
    let realm = try! Realm()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPage))
        self.view.addGestureRecognizer(tapGesture)
        
        if task.word1 != ""{
            textField.text = task.word1 + " " + task.word2
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    //return が押された際に、キーボードを閉じて、画面も閉じる
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString text: String) -> Bool {
        if text == "\n"{
            textField.resignFirstResponder()
            self.dismiss(animated: true, completion: nil)
            return false
        }
        return true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        let word = textField.text
        let wordArray = word?.components(separatedBy: CharacterSet.whitespaces)
        
        if word!.contains(" "){
            try! realm.write {
                self.task.word1 = wordArray![0]
                self.task.word2 = wordArray![1]
                self.task.date = Date()
                self.realm.add(self.task, update: true)
            }
        }else if word != ""{
            try! realm.write {
                self.task.word1 = word!
                self.task.date = Date()
                self.realm.add(self.task, update: true)
            }
        }
        
        setNotification(task: task)
        
        super.viewWillDisappear(animated)
    }
    
    func setNotification(task: Task) {
        let content = UNMutableNotificationContent()
        // タイトルと内容を設定(中身がない場合メッセージ無しで音だけの通知になるので「(xxなし)」を表示する)
        if task.word1 == "" {
            content.title = "(タイトルなし)"
        } else {
            content.title = task.word1
        }
        content.body = "を覚えてますか？"
        content.sound = UNNotificationSound.default
        

        
        let trigger1 = UNTimeIntervalNotificationTrigger(timeInterval: 60*60*24*1, repeats: false) //1日後
        let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: 60*60*24*4, repeats: false) //4日後
        let trigger3 = UNTimeIntervalNotificationTrigger(timeInterval: 60*60*24*7, repeats: false) //7日後
        let trigger4 = UNTimeIntervalNotificationTrigger(timeInterval: 60*60*24*11, repeats: false) //11日後
        let trigger5 = UNTimeIntervalNotificationTrigger(timeInterval: 60*60*24*15, repeats: false) //15日後
        let trigger6 = UNTimeIntervalNotificationTrigger(timeInterval: 60*60*24*20, repeats: false) //20日後

        
        // identifier, content, triggerからローカル通知を作成（identifierが同じだとローカル通知を上書き保存）
        let request1 = UNNotificationRequest(identifier: "A" + String(task.id), content: content, trigger: trigger1)
        let request2 = UNNotificationRequest(identifier: "B" + String(task.id), content: content, trigger: trigger2)
        let request3 = UNNotificationRequest(identifier: "C" + String(task.id), content: content, trigger: trigger3)
        let request4 = UNNotificationRequest(identifier: "D" + String(task.id), content: content, trigger: trigger4)
        let request5 = UNNotificationRequest(identifier: "E" + String(task.id), content: content, trigger: trigger5)
        let request6 = UNNotificationRequest(identifier: "F" + String(task.id), content: content, trigger: trigger6)


        
        // ローカル通知を登録
        let center = UNUserNotificationCenter.current()
        center.add(request1) { (error) in
            print(error ?? "ローカル通知登録 OK")// error が nil ならローカル通知の登録に成功したと表示します。errorが存在すればerrorを表示します。
            }

        center.add(request2) { (error) in
            print(error ?? "ローカル通知登録 OK")// error が nil ならローカル通知の登録に成功したと表示します。errorが存在すればerrorを表示します。
        }
        
        center.add(request3) { (error) in
            print(error ?? "ローカル通知登録 OK")// error が nil ならローカル通知の登録に成功したと表示します。errorが存在すればerrorを表示します。
        }
        
        center.add(request4) { (error) in
            print(error ?? "ローカル通知登録 OK")// error が nil ならローカル通知の登録に成功したと表示します。errorが存在すればerrorを表示します。
        }
        
        center.add(request5) { (error) in
            print(error ?? "ローカル通知登録 OK")// error が nil ならローカル通知の登録に成功したと表示します。errorが存在すればerrorを表示します。
        }
        
        center.add(request6) { (error) in
            print(error ?? "ローカル通知登録 OK")// error が nil ならローカル通知の登録に成功したと表示します。errorが存在すればerrorを表示します。
        }
        
        
    
        // 未通知のローカル通知一覧をログ出力
        center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
            for request in requests {
                print("/---------------")
                print(request)
                print("---------------/")
            }
        }
    }
    
    
    

    @objc func dismissPage(_ animated: Bool){
        view.endEditing(true)
        //画面を戻す
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

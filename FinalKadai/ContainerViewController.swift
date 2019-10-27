//
//  ContainerViewController.swift
//  FinalKadai
//
//  Created by 佐藤　由羽太 on 2019/10/21.
//  Copyright © 2019 jose_asia. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications
import SwipeCellKit

class ContainerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
    var imgView:UIImageView!
    
    var defaultOptions = SwipeOptions()
    var isSwipeRightEnabled = true
    var buttonDisplayMode: ButtonDisplayMode = .imageOnly
    var buttonStyle: ButtonStyle = .backgroundColor
    var usesTallCells = false
    
    
    var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
//        //cellの高さを可変にして、テキストを折り返すために設定
//        tableView.estimatedRowHeight = 60 //見積もり高さ
//        tableView.rowHeight = UITableView.automaticDimension //自動設定
        
//        view.layoutMargins.left = 32
        
//        UIImageView.appearance().tintColor = .white
        
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        
        cell.delegate = self

        // Cellにword1を設定する
        let task = taskArray[indexPath.row]
        cell.word1Label.text = task.word1
        
        
        let lastData = task.date
        let now = Date()
        
        let lastDataStartOfDay = Calendar.current.startOfDay(for: lastData as Date)
        let nowStartOfDay = Calendar.current.startOfDay(for: now)
        let elapseDay = Calendar.current.dateComponents([.day], from: lastDataStartOfDay, to: nowStartOfDay).day!

        cell.word2Label.text = "\(elapseDay.description)日前"


        //cellの高さを可変にして、テキストを折り返すために設定
        cell.textLabel!.numberOfLines = 0 //0に設定
        cell.textLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping //折り返しアリに設定
        
        cell.imageView!.contentMode = .scaleAspectFit


        return cell
    }
    
    
   
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellSegue", sender: nil)
    }
//
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let editAction = UIContextualAction(style: .normal,title: "", handler: { (action: UIContextualAction, view: UIView, success :(Bool) -> Void) in
//
//
//            let inputViewController = self.storyboard?.instantiateViewController(withIdentifier: "Input") as! InputViewController
//
//            inputViewController.task = self.taskArray[(indexPath.row)]
//
//            self.present(inputViewController, animated: false, completion: nil)
//
//            success(true)
//
//        })
//        editAction.backgroundColor = .gray
//        editAction.image = UIImage(named: "pen2")
//
//        let removeAction = UIContextualAction(style: .normal, title: "", handler: { (action: UIContextualAction, view: UIView, success :(Bool) -> Void) in
//
//            let task = self.taskArray[indexPath.row]
//
//            let center = UNUserNotificationCenter.current()
//            center.removePendingNotificationRequests(withIdentifiers: [String(task.id)])
//
//            try!self.realm.write {
//                self.realm.delete(self.taskArray[indexPath.row])
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            }
//
//            center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
//                for request in requests {
//                    print("/---------------")
//                    print(request)
//                    print("---------------/")
//                }
//            }
//
//            success(true)
//
//        })
//
//        removeAction.backgroundColor = .red
//        removeAction.image =  UIImage(named: "trash2")
//
//        return UISwipeActionsConfiguration(actions: [editAction,removeAction])
//    }
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "commentSegue"{
            
            let inputViewController:InputViewController = segue.destination as! InputViewController
            
            let task = Task()
            let allTasks = realm.objects(Task.self)
            if allTasks.count != 0 {
                task.id = allTasks.max(ofProperty: "id")! + 1
            }
            
            inputViewController.task = task
        }else{
            
            let resultViewController:ResultViewController = segue.destination as! ResultViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow
            resultViewController.task = taskArray[indexPath!.row]
        }
        
    }
    
    
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
}



extension ContainerViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        if orientation == .left {
            guard isSwipeRightEnabled else { return nil }
            
            let read = SwipeAction(style: .default, title: nil) { action, indexPath in
//                let updatedStatus = !email.unread
//                email.unread = updatedStatus
//
//                let cell = tableView.cellForRow(at: indexPath) as! Cell
//                cell.setUnread(updatedStatus, animated: true)
            }
            
            read.hidesWhenSelected = true
//            read.accessibilityLabel = email.unread ? "Mark as Read" : "Mark as Unread"
//
//            let descriptor: ActionDescriptor = email.unread ? .read : .unread
//            configure(action: read, with: descriptor)
            
            return [read]
        } else {
            let flag = SwipeAction(style: .default, title: nil, handler: nil)
            flag.hidesWhenSelected = true
            configure(action: flag, with: .flag)
            
            let delete = SwipeAction(style: .destructive, title: nil) { action, indexPath in
                
                //追加した
                let task = self.taskArray[indexPath.row]
                
                            let center = UNUserNotificationCenter.current()
                            center.removePendingNotificationRequests(withIdentifiers: [String(task.id)])
                
                            try!self.realm.write {
                                self.realm.delete(self.taskArray[indexPath.row])
//                                tableView.deleteRows(at: [indexPath], with: .fade)
                            }
                            center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
                                for request in requests {
                                    print("/---------------")
                                    print(request)
                                    print("---------------/")
                                }
                            }
                //ここまで
                
            }
            configure(action: delete, with: .trash)
            
            let cell = tableView.cellForRow(at: indexPath) as! Cell
            let closure: (UIAlertAction) -> Void = { _ in cell.hideSwipe(animated: true) }
            let more = SwipeAction(style: .default, title: nil) { action, indexPath in
                let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                controller.addAction(UIAlertAction(title: "Reply", style: .default, handler: closure))
                controller.addAction(UIAlertAction(title: "Forward", style: .default, handler: closure))
                controller.addAction(UIAlertAction(title: "Mark...", style: .default, handler: closure))
                controller.addAction(UIAlertAction(title: "Notify Me...", style: .default, handler: closure))
                controller.addAction(UIAlertAction(title: "Move Message...", style: .default, handler: closure))
                controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: closure))
                self.present(controller, animated: true, completion: nil)
            }
            configure(action: more, with: .more)
            
            return [delete, flag, more]
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = orientation == .left ? .selection : .destructive
        options.transitionStyle = defaultOptions.transitionStyle
        
        switch buttonStyle {
        case .backgroundColor:
            options.buttonSpacing = 1
        case .circular:
            options.buttonSpacing = 4
            #if canImport(Combine)
            if #available(iOS 13.0, *) {
                options.backgroundColor = UIColor.systemGray6
            } else {
                options.backgroundColor = #colorLiteral(red: 0.9467939734, green: 0.9468161464, blue: 0.9468042254, alpha: 1)
            }
            #else
            options.backgroundColor = #colorLiteral(red: 0.9467939734, green: 0.9468161464, blue: 0.9468042254, alpha: 1)
            #endif
        }
        
        return options
    }
    
    func configure(action: SwipeAction, with descriptor: ActionDescriptor) {
        action.title = descriptor.title(forDisplayMode: buttonDisplayMode)
        action.image = descriptor.image(forStyle: buttonStyle, displayMode: buttonDisplayMode)

        switch buttonStyle {
        case .backgroundColor:
            action.backgroundColor = descriptor.color(forStyle: buttonStyle)
        case .circular:
            action.backgroundColor = .white
            action.textColor = descriptor.color(forStyle: buttonStyle)
            action.font = .systemFont(ofSize: 13)
            action.transitionDelegate = ScaleTransition.default
        }
    }
}




class Cell: SwipeTableViewCell {
    
    @IBOutlet var word1Label: UILabel!
    @IBOutlet var word2Label: UILabel!
    
    
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


//
//  ViewController.swift
//  FinalKadai
//
//  Created by 佐藤　由羽太 on 2019/10/16.
//  Copyright © 2019 jose_asia. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
    var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Cellにword1を設定する
        let task = taskArray[indexPath.row]
        cell.textLabel?.text = task.word1
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellSegue", sender: nil)
    }
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "編集", handler: { (action: UIContextualAction, view: UIView, success :(Bool) -> Void) in
            
            let inputViewController = self.storyboard?.instantiateViewController(withIdentifier: "Input") as! InputViewController
            
            inputViewController.task = self.taskArray[(indexPath.row)]
            
            self.present(inputViewController, animated: false, completion: nil)

            success(true)
            
        })
        
        let removeAction = UIContextualAction(style: .normal,title: "削除",handler: { (action: UIContextualAction, view: UIView, success :(Bool) -> Void) in
            
            try!self.realm.write {
                self.realm.delete(self.taskArray[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            success(true)
            
        })
        
        return UISwipeActionsConfiguration(actions: [editAction,removeAction])
    }
    
    
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


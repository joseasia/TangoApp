//
//  ViewController.swift
//  FinalKadai
//
//  Created by 佐藤　由羽太 on 2019/10/16.
//  Copyright © 2019 jose_asia. All rights reserved.
//

import UIKit
import RealmSwift
import MaterialComponents.MaterialButtons

class ViewController: UIViewController {
    
    @IBOutlet weak var addButton: MDCFloatingButton!
    
    let realm = try! Realm()
    
    var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: false)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addButton.setBackgroundColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
//        addButton.setTitle("+", for: .normal)
        addButton.setTitle("+", for: .normal)
        addButton.sizeToFit()
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.tintColor = .darkGray
    
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
        }

 
}

}

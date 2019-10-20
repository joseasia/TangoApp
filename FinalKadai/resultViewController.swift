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

        wordLabel1.text = task.word1
        wordLabel2.text = task.word2
    }
    


}

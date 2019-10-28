//
//  TextField.swift
//  FinalKadai
//
//  Created by 佐藤　由羽太 on 2019/10/21.
//  Copyright © 2019 jose_asia. All rights reserved.
//

import UIKit

class TextField: UITextField {

    let underline: UIView = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.frame.size.height = 30
        
        composeUnderline() // 下線のスタイルセットおよび追加処理
        
        self.borderStyle = .none
        self.placeholder = "[覚えたい外国語] [日本語意味]"
        
    }
    
    private func composeUnderline() {
        self.underline.frame = CGRect(
            x: 0,                    // x, yの位置指定は親要素,
            y: self.frame.height,    // この場合はCustomTextFieldを基準にする
            width: self.frame.width,
            height: 0.5)
        
        self.underline.backgroundColor = UIColor.gray
        
        self.addSubview(self.underline)
        self.bringSubviewToFront(self.underline)
    }

}

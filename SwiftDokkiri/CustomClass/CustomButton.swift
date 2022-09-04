//
//  CustomButton.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2022/08/22.
//  Copyright © 2022 藤田優作. All rights reserved.
//

import Foundation
import UIKit


class CustomButton: UIButton{

    //コードによるボタンの生成時に呼ばれる
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit() //ここに追加
    }

    //storyboardによる生成時に呼ばれる
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit() //ここに追加
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchStartAnimation() //ここに追加
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchEndAnimation() //ここに追加
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        //ここに動作が中断された時の動作を書く
        touchEndAnimation() //ここに追加
    }
}

// MARK: - Private functions
extension CustomButton {

    //影付きのボタンの生成
    internal func commonInit(){
        self.layer.shadowOffset = CGSize(width: 1, height: 1 )
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1.0
    }
    
     //ボタンが押された時のアニメーション
     internal func touchStartAnimation() {
         UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {() -> Void in
             self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95);
             self.alpha = 0.9
         },completion: nil)
     }

     //ボタンから手が離れた時のアニメーション
     internal func touchEndAnimation() {
         UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {() -> Void in
             self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
             self.alpha = 1
         },completion: nil)
     }
}

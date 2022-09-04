//
//  Sound2ViewController.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2020/04/14.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMotion

class JudgementViewController: UIViewController,AVAudioPlayerDelegate {
    
    var audioPlayer: AVAudioPlayer!
    //CMMotionManagerのインスタンスを生成
    let motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound(name: "explosion")
        
        // Do any additional setup after loading the view.
        //データの取得を開始します。データを取得したらwithHnadlerに指定したhandlerが実行されます。
//        motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: OperationQueue.current!,withHandler: { [weak self] (motion, error) in
//            guard let motion = motion, error == nil else { return }
//            //外で定義する(class直下で宣言)
//            let xAngle = motion.attitude.roll * 180 / Double.pi
//            let yAngle = motion.attitude.pitch * 180 / Double.pi
//            //メソッドの外で宣言する
//            var x = pow(xAngle, 2)
//            var y = pow(xAngle, 2)
//            // 係数を使って感度を調整する。
//            let coefficient: CGFloat = 0.01
//            //              print("attitude roll : \(motion.attitude.roll * 180 / Double.pi)")
//            //              print("attitude pitch: \(motion.attitude.pitch * 180 / Double.pi)")
//            //              print("attitude yaw  : \(motion.attitude.yaw * 180 / Double.pi)")
//            //更新周期を設定する
//            self?.motionManager.accelerometerUpdateInterval = 0.1
//            //5秒後に遷移する
//        }
//        )
    }
    
    
    func playSound(name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType:"mp3") else {
            print("音源ファイルが見つかりません")
            return
        }
        do {
            // AVAudioPlayerのインスタンス化
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            // AVAudioPlayerのデリゲートをセット
            audioPlayer.delegate = self
            // 音声の再生
            audioPlayer.play()
        } catch {
            
        }
    }
    
    
    
    @IBAction func nextButton(_ sender: Any) {
        
        var xAngle = motionManager.deviceMotion?.attitude.roll ?? 0 * 180 / Double.pi
        var yAngle = motionManager.deviceMotion?.attitude.pitch ?? 0 * 180 / Double.pi
        //        print("attitude roll :\(x)")
        //        print("attitude pitch :\(y)")
        var x = pow(xAngle, 2) * 100
        var y = pow(xAngle, 2) * 100
        var x1 = x
        var y1 = y
        print("attitude roll :\(x)")
        print("attitude pitch :\(y)")
        if x1+y1 < 1 {
            //            let nextView = storyboard.instantiateViewController(withIdentifier: "Scene1ViewController")
            //            self.present(nextView, animated: true, completion: nil)
            self.performSegue(withIdentifier: "Scene1", sender: nil)
        }else if x1+y1 < 4 {
            //            let storyboard = self.storyboard!
            //            let nextView = storyboard.instantiateViewController(withIdentifier: "Scene2ViewController")
            //            self.present(nextView, animated: true, completion: nil)
            self.performSegue(withIdentifier: "Scene2", sender: nil)
        }else {
            //            let storyboard = self.storyboard!
            //            let nextView = storyboard.instantiateViewController(withIdentifier: "Scene3ViewController")
            //            self.present(nextView, animated: true, completion: nil)
            self.performSegue(withIdentifier: "Scene3", sender: nil)
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

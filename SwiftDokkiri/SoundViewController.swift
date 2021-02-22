//
//  SoundViewController.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2019/03/18.
//  Copyright © 2019 藤田優作. All rights reserved.
//

import UIKit
import AVFoundation


class SoundViewController: UIViewController, AVAudioPlayerDelegate {

    private var audioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
 
       //mp3音声(SOUND.mp3)の再生
        //playSound(name: "explosion")
        random()
    }
    
    var a = Int.random(in: 0..<10)
    func random() {
        if a <= 4{
                                //値渡しのコード
                                //セグエでなく画像で変える
            let image1:UIImage = UIImage(named:"skull-765477_1920")!
            self.imageView.image = image1
            playSound(name: "explosion")

            print("image1",image1)
        }else{
                    let image2:UIImage = UIImage(named:"angel-2401263_1920")!
            self.imageView.image = image2
                //UIImageView(image: image2)
                   playSound(name: "bgm_maoudamashii_healing10")
                //next.imageView = UIImage(named: "angel-2401263_1920")
                                print("image2",image2)
                            }
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
}


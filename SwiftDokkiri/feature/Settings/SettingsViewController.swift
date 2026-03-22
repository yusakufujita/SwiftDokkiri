//
//  SettingsViewController.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2024/01/01.
//  Copyright © 2024 藤田優作. All rights reserved.
//

import UIKit
import PhotosUI

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var vibrationSwitch: UISwitch!
    @IBOutlet weak var pushButtonBackgroundButton: UIButton!
    @IBOutlet weak var judgementBackgroundButton: UIButton!
    @IBOutlet weak var pushButtonPreviewImageView: UIImageView!
    @IBOutlet weak var judgementPreviewImageView: UIImageView!
    @IBOutlet weak var pushButtonOverlayView: UIView!
    @IBOutlet weak var judgementOverlayView: UIView!
    @IBOutlet weak var pushButtonChangeButton: UIButton!
    @IBOutlet weak var judgementChangeButton: UIButton!
    
    // 選択対象の画面を保存するためのプロパティ
    private var selectedScreen: String?
    
    var settingsRepository: SettingsRepositoryProtocol!
    var resultRepository: ResultRepositoryProtocol!
    var hapticManager: HapticManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // デバッグ: viewDidLoadが呼ばれたことを確認
        print("SettingsViewController - viewDidLoad called")
        setupGradientBackground()

        // 依存注入
        settingsRepository = appDelegate.settingsRepository
        resultRepository = appDelegate.resultRepository
        hapticManager = appDelegate.hapticManager
        setupUI()
        loadSettings()
        
        // デバッグ: ナビゲーションスタックの状態を確認
        if let navController = self.navigationController {
            print("SettingsViewController - Navigation Stack Count: \(navController.viewControllers.count)")
            for (index, vc) in navController.viewControllers.enumerated() {
                print("  [\(index)]: \(type(of: vc))")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 戻るボタンを確実に表示する
        self.navigationItem.hidesBackButton = false
        
        // 背景画像ボタンのタイトルを更新（設定が変更された可能性があるため）
        updateBackgroundButtonTitles()
        
        // ナビゲーションバーを表示し、背景色をクリーム色に設定
        if let navController = self.navigationController {
            navController.setNavigationBarHidden(false, animated: animated)
            // ナビゲーションバーの背景色をクリーム色に設定
            let creamColor = UIColor(red: 1.0, green: 0.95, blue: 0.9, alpha: 1.0)
            navController.navigationBar.backgroundColor = creamColor
            navController.navigationBar.barTintColor = creamColor
            // ナビゲーションコントローラーのビューの背景色もクリーム色に設定（黒い部分をなくす）
            navController.view.backgroundColor = creamColor
            // 影を削除してスッキリ見せる
            navController.navigationBar.shadowImage = UIImage()
            navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navController.navigationBar.isTranslucent = false
            // タイトルとボタンの文字色を濃い色に設定（クリーム色の背景でも見やすくする）
            let darkColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0) // 濃いグレー
            navController.navigationBar.titleTextAttributes = [
                .foregroundColor: darkColor,
                .font: UIFont.boldSystemFont(ofSize: 17)
            ]
            navController.navigationBar.tintColor = darkColor
        }
        
        // デバッグ: ナビゲーションスタックの状態を確認
        if let navController = self.navigationController {
            print("SettingsViewController - Navigation Stack Count: \(navController.viewControllers.count)")
            for (index, vc) in navController.viewControllers.enumerated() {
                print("  [\(index)]: \(type(of: vc))")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 戻るボタンを確実に表示する（viewDidAppearでも設定）
        self.navigationItem.hidesBackButton = false
        // ナビゲーションバーを表示する
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupUI() {
        self.navigationItem.hidesBackButton = false
        navigationItem.title = "設定"
        
        // スイッチの設定変更時のアクションを設定
        soundSwitch.addTarget(self, action: #selector(soundSwitchChanged(_:)), for: .valueChanged)
        vibrationSwitch.addTarget(self, action: #selector(vibrationSwitchChanged(_:)), for: .valueChanged)
        
        // 背景画像選択ボタンの設定
        pushButtonBackgroundButton.addTarget(self, action: #selector(pushButtonBackgroundButtonTapped(_:)), for: .touchUpInside)
        judgementBackgroundButton.addTarget(self, action: #selector(judgementBackgroundButtonTapped(_:)), for: .touchUpInside)
        
        // 変更ボタンの設定
        pushButtonChangeButton.addTarget(self, action: #selector(pushButtonBackgroundButtonTapped(_:)), for: .touchUpInside)
        judgementChangeButton.addTarget(self, action: #selector(judgementBackgroundButtonTapped(_:)), for: .touchUpInside)
        
        // 変更ボタンに角丸を追加
        pushButtonChangeButton.layer.cornerRadius = 25
        pushButtonChangeButton.layer.masksToBounds = true
        
        judgementChangeButton.layer.cornerRadius = 25
        judgementChangeButton.layer.masksToBounds = true
        
        // オーバーレイビューの設定（初期状態では非表示、タップ時に表示）
        setupOverlayViews()
    }
    
    private func setupOverlayViews() {
        // オーバーレイビューを常に表示（透明度を下げて画像も見えるように）
        pushButtonOverlayView.alpha = 0.4
        judgementOverlayView.alpha = 0.4
        
        // 変更ボタンは常に見えるように
        pushButtonChangeButton.alpha = 1.0
        judgementChangeButton.alpha = 1.0
    }
    
    private func loadSettings() {
        soundSwitch.isOn = settingsRepository.isSoundEnabled
        vibrationSwitch.isOn = settingsRepository.isVibrationEnabled
        
        // 背景画像ボタンのタイトルを更新
        updateBackgroundButtonTitles()
    }
    
    private func updateBackgroundButtonTitles() {
        // PushButton画面のタイトル
        if settingsRepository.pushButtonCustomBackgroundImagePath != nil {
            pushButtonBackgroundButton.setTitle("背景画像を選択", for: .normal)
        } else {
            pushButtonBackgroundButton.setTitle("背景画像を選択", for: .normal)
        }
        
        // Judgement画面のタイトル
        if settingsRepository.judgementCustomBackgroundImagePath != nil {
            judgementBackgroundButton.setTitle("背景画像を選択", for: .normal)
        } else {
            judgementBackgroundButton.setTitle("背景画像を選択", for: .normal)
        }
        
        // プレビュー画像を更新
        updatePreviewImages()
    }
    
    private func updatePreviewImages() {
        // PushButton画面のプレビュー
        if let customImagePath = settingsRepository.pushButtonCustomBackgroundImagePath,
           let customImage = settingsRepository.loadCustomBackgroundImage(path: customImagePath) {
            pushButtonPreviewImageView.image = customImage
        } else {
            pushButtonPreviewImageView.image = UIImage(named: "cat-4644008_1920")
        }
        
        // Judgement画面のプレビュー
        if let customImagePath = settingsRepository.judgementCustomBackgroundImagePath,
           let customImage = settingsRepository.loadCustomBackgroundImage(path: customImagePath) {
            judgementPreviewImageView.image = customImage
        } else {
            judgementPreviewImageView.image = UIImage(named: "horrorman")
        }
        
        // プレビュー画像に角丸とボーダーを追加
        pushButtonPreviewImageView.layer.cornerRadius = 8
        pushButtonPreviewImageView.layer.masksToBounds = true
        pushButtonPreviewImageView.layer.borderWidth = 2
        pushButtonPreviewImageView.layer.borderColor = UIColor.systemBlue.cgColor
        
        judgementPreviewImageView.layer.cornerRadius = 8
        judgementPreviewImageView.layer.masksToBounds = true
        judgementPreviewImageView.layer.borderWidth = 2
        judgementPreviewImageView.layer.borderColor = UIColor.systemPurple.cgColor
    }
    
    @objc private func soundSwitchChanged(_ sender: UISwitch) {
        settingsRepository.isSoundEnabled = sender.isOn
        hapticManager.selection()
    }
    
    @objc private func vibrationSwitchChanged(_ sender: UISwitch) {
        settingsRepository.isVibrationEnabled = sender.isOn
        // 設定変更時に振動を試す（設定がONの場合のみ）
        if sender.isOn {
            hapticManager.selection()
        }
    }
    
    @objc private func pushButtonBackgroundButtonTapped(_ sender: UIButton) {
        hapticManager.selection()
        selectedScreen = "pushButton"
        presentPhotoPicker()
    }
    
    @objc private func judgementBackgroundButtonTapped(_ sender: UIButton) {
        hapticManager.selection()
        selectedScreen = "judgement"
        presentPhotoPicker()
    }
    
    private func presentPhotoPicker() {
        if #available(iOS 14.0, *) {
            var configuration = PHPickerConfiguration()
            configuration.filter = .images
            configuration.selectionLimit = 1
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            
            present(picker, animated: true)
        } else {
            // iOS 13以前の場合はUIImagePickerControllerを使用
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = false
            
            present(picker, animated: true)
        }
    }
}

// MARK: - PHPickerViewControllerDelegate
@available(iOS 14.0, *)
extension SettingsViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let result = results.first,
              let screen = selectedScreen else {
            return
        }
        
        result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
            guard let self = self,
                  let image = object as? UIImage,
                  error == nil else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(
                        title: "エラー",
                        message: "画像の読み込みに失敗しました。",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
                return
            }
            
            DispatchQueue.main.async {
                // 画像を保存
                if let imagePath = self.settingsRepository.saveCustomBackgroundImage(image, forScreen: screen) {
                    // カスタム画像パスを設定
                    if screen == "pushButton" {
                        self.settingsRepository.pushButtonCustomBackgroundImagePath = imagePath
                    } else {
                        self.settingsRepository.judgementCustomBackgroundImagePath = imagePath
                    }
                    
                    // プレビュー画像を更新
                    self.updatePreviewImages()
                    self.hapticManager.success()
                } else {
                    let alert = UIAlertController(
                        title: "エラー",
                        message: "画像の保存に失敗しました。",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
    }
}

// MARK: - UIImagePickerControllerDelegate
extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage,
              let screen = selectedScreen else {
            return
        }
        
        // 画像を保存
        if let imagePath = settingsRepository.saveCustomBackgroundImage(image, forScreen: screen) {
            // カスタム画像パスを設定
            if screen == "pushButton" {
                settingsRepository.pushButtonCustomBackgroundImagePath = imagePath
            } else {
                settingsRepository.judgementCustomBackgroundImagePath = imagePath
            }
            
            // プレビュー画像を更新
            updatePreviewImages()
            hapticManager.success()
        } else {
            let alert = UIAlertController(
                title: "エラー",
                message: "画像の保存に失敗しました。",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        hapticManager.selection()
    }
}

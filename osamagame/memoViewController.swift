//
//  memoViewController.swift
//  osamagame
//
//  Created by ポロリア on 2016/11/19.
//  Copyright © 2016年 nakamura. All rights reserved.
//

import UIKit


class memoViewController: UIViewController {

    //人数カウント
    var iCount: Int = 1
    
    @IBOutlet weak var nameInputBox: UITextField!
    
    @IBOutlet weak var nameDescriptionLabel: UILabel!
    
    @IBAction func tappedStartButton(_ sender: UIButton) {}
    
    override func viewDidLoad() {
        
        let ud = UserDefaults.standard
        
        // 保存されている値を削除
        ud.removeObject(forKey: "names")
        
        // 空のarrayをset(for エラー回避)
        ud.setValue([], forKey: "names")
        
        nameDescriptionLabel.text = String(iCount) + "人目の名前を入力してください！！"
        
        super.viewDidLoad()
        
    }
    
    // createボタンが押されたときの処理処理
    @IBAction func tappedCreateButton(_ sender: Any) {
        
        //名前が未入力の時はアラート
        if nameInputBox.text == "" {
            
            // 名前未入力のalert
            showAlert(message: "名前を入力してください")
            
        }else{
            
            //画面の名前を変数に
            let nameText:String = nameInputBox.text!
            
            // 保存用
            let ud = UserDefaults.standard
            //名前と性別を入れる。性別は後で・・・
            var names: [[String: Any]] = ud.object(forKey: "names") as! [[String : Any]]
            
            //追加
            names.append( [
                "name": nameText,
                "seibetu": true
                ])
            
            // 保存する
            ud.setValue(names, forKey: "names")
            
            // 保存完了のalert
            showAlert(message: "保存が完了しました!")
            
            //人数をカウント
            iCount = iCount + 1
            
            //画面に説明文をセット。
            nameDescriptionLabel.text = String(iCount) + "人目の名前を入力してください！！"
            
            //名前入力をクリア
            nameInputBox.text = ""
        }
        
    }
    
    // アラートを表示させるための関数(引数として表示させたいmessageをString型で受け取る)
    func showAlert(message: String) {
        // アラートを表示させるための準備 (alertControllerをオブジェクト化)
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        // アラートを閉じるための準備
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        
        // 作成したアラートオブジェクトにcloseイベントを追加
        alert.addAction(close)
        // 作成したアラートを表示
        present(alert, animated: true, completion: nil)
    }
    
    
 }

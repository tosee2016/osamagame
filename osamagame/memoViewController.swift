//
//  memoViewController.swift
//  osamagame
//
//  Created by ポロリア on 2016/11/19.
//  Copyright © 2016年 nakamura. All rights reserved.
//

import UIKit

class memoViewController: UIViewController {

    @IBOutlet weak var nameInputBox: UITextField!

    @IBAction func tappedStartButton(_ sender: UIButton) {
    }
    
    // STARTボタンが押されたときの処理tappedStartButton

    
    // createボタンが押されたときの処理処理
    @IBAction func tappedCreateButton(_ sender: Any) {
        
        
        // テキストボックスに入力された問題文をnameText定数に格納
        let nameText:String = nameInputBox.text!
        
        // iphone端末内にデータを保存するために使用するuser defaultsをオブジェクト化(使えるようにする)
        let ud = UserDefaults.standard
        
        // これまで格納されていた問題をnames配列に格納し、
        var names: [[String: Any]] = ud.object(forKey: "names") as! [[String : Any]]
        
        // 今、ユーザーに入力してもらった問題文をnames配列に追加する
        names.append( [
            "name": nameText,
            "answer": true
            ])
        
        // 最後に、新たに問題が追加されたnames配列をuser defaultsを使ってiphone端末内に保存する
        ud.setValue(names, forKey: "names")
        
        // 保存完了のalert
        showAlert(message: "保存が完了しました!")
        // textboxを空にする
        nameInputBox.text = ""
    }
    

    
    override func viewDidLoad() {
        
        let ud = UserDefaults.standard
        
        // 保存されている値を削除
        ud.removeObject(forKey: "names")
        
        // 空のarrayをset(for エラー回避)
        ud.setValue([], forKey: "names")
        
        super.viewDidLoad()
        
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

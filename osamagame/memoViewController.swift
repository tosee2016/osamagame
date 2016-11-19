//
//  memoViewController.swift
//  osamagame
//
//  Created by ポロリア on 2016/11/19.
//  Copyright © 2016年 nakamura. All rights reserved.
//

import UIKit

class memoViewController: UIViewController {

    @IBOutlet weak var questionInputBox: UITextField!
    @IBOutlet weak var answerControl: UISegmentedControl!
    
    // backボタンが押されたときの処理
    @IBAction func tappedBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // createボタンが押されたときの処理処理
    @IBAction func tappedCreateButton(_ sender: Any) {
        
        // ユーザーが選んだまる・ばつを格納しておくための変数answer
        var answer: Bool = true
        
        // その問題の解答(true or false)を判定
        if answerControl.selectedSegmentIndex == 0 {
            // choose false
            answer = false
        }
        else {
            // choose true
            answer = true
        }
        
        // テキストボックスに入力された問題文をquestionText定数に格納
        let questionText:String = questionInputBox.text!
        
        // iphone端末内にデータを保存するために使用するuser defaultsをオブジェクト化(使えるようにする)
        let ud = UserDefaults.standard
        
        // これまで格納されていた問題をquestions配列に格納し、
        var questions: [[String: Any]] = ud.object(forKey: "questions") as! [[String : Any]]
        
        // 今、ユーザーに入力してもらった問題文をquestions配列に追加する
        questions.append( [
            "question": questionText,
            "answer": answer
            ])
        
        // 最後に、新たに問題が追加されたquestions配列をuser defaultsを使ってiphone端末内に保存する
        ud.setValue(questions, forKey: "questions")
        
        // 保存完了のalert
        showAlert(message: "保存が完了しました!")
        // textboxを空にする
        questionInputBox.text = ""
    }
    
    // deleteボタンが押されたときの処理
    @IBAction func tappedDeleteAllQuestionButton(_ sender: UIButton) {
        let ud = UserDefaults.standard
        
        // 保存されている値を削除
        ud.removeObject(forKey: "questions")
        
        // 空のarrayをset(for エラー回避)
        ud.setValue([], forKey: "questions")
        
        showAlert(message: "削除が完了しました!")
    }
    
    override func viewDidLoad() {
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

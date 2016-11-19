//
//  ViewController.swift
//  MarubatsuApp
//
//  Created by NOWALL on 2016/10/12.
//  Copyright © 2016年 NOWALL. All rights reserved.
//

import UIKit

class memo1ViewController: UIViewController {
    
    
    @IBOutlet weak var firstPeople: UILabel!
    @IBOutlet weak var secondPeople: UILabel!
    
    
    @IBOutlet weak var Xgame: UILabel!
    // 表示中の問題番号を格納するための変数
    var currentQuestionNum: Int = 0
    // 正解数を格納するための変数
    var currentYesNum: Int = 0
    
    var resultNameNum1: Int = 0
    var resultNameNum2: Int = 0
    
    
    
    let resultTextarrey: [String] = [
        "行動１",
        "行動２"
    ]
    
    
    // まるボタンを押したときに呼ばれる関数
    @IBAction func tappedNextButton(_ sender: UIButton) {
        
        // 問題の正誤を判定 (関数の引数としてtrueをわたす)
        showQuestion()
    }
    
    
    // ロードされたときに呼び出される関数
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let ud = UserDefaults.standard
        
        // iPhone端末内にnamesというkeyで何も保存されていなかったら、空のarrayを保存する(エラー回避)
        if (ud.object(forKey: "names") == nil) {
            ud.setValue([], forKey: "names")
        }
        
        // ランダムで配列の要素を取得する
        let resultNum = Int( arc4random_uniform(UInt32(resultTextarrey.count)) )
        Xgame.text = resultTextarrey[resultNum]
        
    }
    
    // 画面が表示されたときに呼ばれす関数
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showQuestion()
    }
    
    // 問題を表示するための関数
    func showQuestion() {
        
        // UserDefaultsを使って、iPhone端末内に保存されている問題を取り出し、names定数に格納
        let ud = UserDefaults.standard
        let names:[[String: Any]] = ud.object(forKey: "names") as! [[String: Any]]
        
        
        // 名前を設定
        if (names.count > currentQuestionNum) {
            
            // ランダムで配列の要素を取得する
            resultNameNum1 = Int( arc4random_uniform(UInt32(names.count)) )
            resultNameNum2 = Int( arc4random_uniform(UInt32(names.count)) )
            
            while resultNameNum1 == resultNameNum2 {
                print(resultNameNum1)
                print(resultNameNum2)
                
                resultNameNum1 = Int( arc4random_uniform(UInt32(names.count)) )
                resultNameNum2 = Int( arc4random_uniform(UInt32(names.count)) )
                
                
            }
            
            let name1 = names[resultNameNum1]
            let name2 = names[resultNameNum2]
            
            //let name1 = names[resultNameNum2]
            
            firstPeople.text = name1["name"] as? String
            secondPeople.text = name2["name"] as? String
            
            
        } else {
            // 問題がなかった場合の処理
            firstPeople.text = "No Question. Let's Create it!"
        }
        
        
    }
    
}

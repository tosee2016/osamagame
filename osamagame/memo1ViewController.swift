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
    
    //名前用
    var resultNameNum1: Int = 0
    var resultNameNum2: Int = 0
    
    //行動用
    var resultNum: Int = 0
    
    //行動
    let resultTextarrey: [String] = [
        "１分間、変顔で楽しませる！",
        "自分のソックス、靴下を鼻先に持ってきて、大きく深呼吸！",
        "奇抜な髪形にされる！",
        "冬のドライブ中に・・・負けた人のところだけ窓を開ける！",
        "好きな曲のサビを歌う！",
        "即興作詞で歌う！",
        "今まで言われたことのある似ている有名人で一番かっこいい or かわいい有名人の名前を発表!",
        "猫語で歌う！",
        "むちゃぶりものまね！",
        "個人経営のラーメン屋でスープを一口だけ飲んで「なるほどね」と言い店をでる！！",
        "2人でファミレスに入り「二名様ですか？」と聞かれた際に「え？一人ですけど」とツレを見えてない設定で話す！！",
        "街中で髭がふさふさのお年寄りに対し、キリスト教の十字架をかかげて拝み倒す罰ゲーム",
        "母親に電話し、相手が声を出す前に「お前のことがずっと好きだった、俺の女にしてやるからいますぐ俺の家までこいよ」と告る！！",
        "人通りの多い広めの道路で向かい側にいる相手と大声で告白しあう！！"
        ]
    
    
    // 次ボタン
    @IBAction func tappedNextButton(_ sender: UIButton) {
        showPeople()
    }
    
    // ロードされたときに呼び出される関数
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 画面が表示されたときに呼ばれる関数
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showPeople()
    }
    
    // 画面に名前と行動を表示
    func showPeople() {
        
        // UserDefaultsを使って、iPhone端末内に保存されている問題を取り出し、names定数に格納
        let ud = UserDefaults.standard
        let names:[[String: Any]] = ud.object(forKey: "names") as! [[String: Any]]
        
        
        // ランダムで配列の要素を取得する
        resultNameNum1 = Int( arc4random_uniform(UInt32(names.count)) )
        resultNameNum2 = Int( arc4random_uniform(UInt32(names.count)) )
        
        //同じ名前の人を取得しないように、名前番号が同じ時は名前番号を取得し直し
        while resultNameNum1 == resultNameNum2 {
            resultNameNum1 = Int( arc4random_uniform(UInt32(names.count)) )
            resultNameNum2 = Int( arc4random_uniform(UInt32(names.count)) )
        }
        
        let name1 = names[resultNameNum1]
        let name2 = names[resultNameNum2]
        
        //名前設定
        firstPeople.text = name1["name"] as? String
        secondPeople.text = name2["name"] as? String
        
        //行動を取得
        resultNum = Int( arc4random_uniform(UInt32(resultTextarrey.count)) )
        
        //行動ラベルに設定
        Xgame.text = resultTextarrey[resultNum]
        
    }
    
}



import UIKit
import Social //FaceBookを使用に必要

class ViewController: UIViewController {
    
    // フェイスブック用
    var myComposeView : SLComposeViewController!
    
    
    @IBAction func topfacebookButton(_ sender: Any) {
        
        //facebook連携
        // ServiceTypeをFacebookに指定.
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        
        // 投稿するテキストを指定.
        myComposeView.setInitialText("Facebook Test")
        
        // 投稿する画像を指定.Top画面は不要
        //myComposeView.add(gazou.image)
        
        // myComposeViewの画面遷移.
        self.present(myComposeView, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

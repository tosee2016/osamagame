import UIKit
import AVFoundation

@available(iOS 10.0, *)
class cameraViewController: UIViewController {
    
    
    @IBOutlet weak var cameraView: UIView!

    var stillImageOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    //カメラセッション
    var captureSession: AVCaptureSession!
    //デバイス
    var cameraDevices: AVCaptureDevice!
    //画像のアウトプット
    var imageOutput: AVCaptureStillImageOutput!
    
    // ボタンを押した時呼ばれる
    @IBAction func takeIt(_ sender: AnyObject) {
        // フラッシュとかカメラの細かな設定
        let settingsForMonitoring = AVCapturePhotoSettings()
        settingsForMonitoring.flashMode = .auto
        settingsForMonitoring.isAutoStillImageStabilizationEnabled = true
        settingsForMonitoring.isHighResolutionPhotoEnabled = false
        // シャッターを切る
        stillImageOutput?.capturePhoto(with: settingsForMonitoring, delegate: self as! AVCapturePhotoCaptureDelegate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //セッションの作成
        captureSession = AVCaptureSession()
        
        //デバイス一覧の取得
        let devices = AVCaptureDevice.devices()
        
        //バックカメラをcameraDevicesに格納
        for device in devices! {
            if (device as AnyObject).position == AVCaptureDevicePosition.back {
                cameraDevices = device as! AVCaptureDevice
            }
        }
        
        //バックカメラからVideoInputを取得
        let videoInput: AVCaptureInput!
        do {
            videoInput = try AVCaptureDeviceInput.init(device: cameraDevices)
        } catch {
            videoInput = nil
        }
        
        //セッションに追加
        captureSession.addInput(videoInput)
        
        //出力先を生成
        imageOutput = AVCaptureStillImageOutput()
        
        //セッションに追加
        captureSession.addOutput(imageOutput)
        
        //画像を表示するレイヤーを生成
        let captureVideoLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: captureSession)
        captureVideoLayer.frame = self.view.bounds
        captureVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        //Viewに追加
        self.view.layer.addSublayer(captureVideoLayer)
        
        //セッション開始
        captureSession.startRunning()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraStart(sender: AnyObject) {
        //ビデオ出力に接続
        let captureVideoConnection = imageOutput.connection(withMediaType: AVMediaTypeVideo)
        
        //接続から画像を取得
        self.imageOutput.captureStillImageAsynchronously(from: captureVideoConnection) { (imageDataBuffer, error) -> Void in
            //取得したImageのDataBufferをJPEGを変換
            let capturedImageData: NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer) as NSData
            //JPEGからUIImageを作成
            let Image: UIImage = UIImage(data: capturedImageData as Data)!
            //アルバムに追加
            UIImageWriteToSavedPhotosAlbum(Image, self, nil, nil)
        }
    }
    
    
}

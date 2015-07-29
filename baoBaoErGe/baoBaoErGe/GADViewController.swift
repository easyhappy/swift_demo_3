import UIKit
import GoogleMobileAds

class GADViewController: UIView{
    
    var bannerView: GADBannerView!
    var tip: UILabel!
    var numberImage: UIImage!
    var numberImageView: UIImageView!
    var secondsCountDown = 5
    var secondsDownTimer: NSTimer!
    var delegate: VideoPlayerViewController!
    init(rootView: UIViewController) {
        bannerView = GADBannerView()
        tip = UILabel()
        tip.text = "正在加载中...."

        tip.textAlignment = NSTextAlignment.Center
        tip.textColor = UIColor.blackColor()
        bannerView.rootViewController = rootView
        bannerView.adUnitID = "ca-app-pub-9813832992624910/7601701989"
        var width: CGFloat = 400
        var height: CGFloat = 150
        // (0.0, 0.0, 375.0, 667.0)
        tip.frame = CGRectMake(0, 0, width, 20)
        //bannerView.frame = CGRectMake((rootView.view.frame.height-width)/4, (rootView.view.frame.width-height)/4, width, height)
        bannerView.frame = CGRectMake(0, 20, width, height)
        
        numberImage  = UIImage(named: "5.png")
        numberImageView = UIImageView(image: numberImage)
        numberImageView.frame = CGRectMake(width-45, 20, 40, 40)
        
        super.init(frame: CGRectMake((rootView.view.frame.height-width)/2, (rootView.view.frame.width-height)/2, width, height))
        self.addSubview(bannerView)
        self.addSubview(tip)
        self.addSubview(numberImageView)
        var request:GADRequest = GADRequest()
        request.testDevices = [""]
        bannerView.loadRequest(request)
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(61, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }

    func showGAD(delegate: VideoPlayerViewController){
        self.delegate = delegate
        secondsCountDown = 5
        self.hidden = false
        secondsDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimeLabel", userInfo: nil, repeats: true)
    }

    func updateTimeLabel(){
        secondsCountDown -= 1
        numberImageView.image = UIImage(named: "\(secondsCountDown).png")
    
        if secondsCountDown == 0{
            self.hidden = true
            secondsDownTimer.invalidate()
            secondsCountDown = 5
            delegate.playVideo()
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(){
        var request:GADRequest = GADRequest()
        request.testDevices = [""]
        bannerView.loadRequest(request)
    }
}
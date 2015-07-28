import UIKit
import GoogleMobileAds

class GADViewController: UIView{
    
    var bannerView: GADBannerView!
    var tip: UILabel!
    init(rootView: UIViewController) {
        bannerView = GADBannerView()
        tip = UILabel()
        tip.text = "正在加载中...."
        tip.textAlignment = NSTextAlignment.Center
        tip.textColor = UIColor.whiteColor()
        bannerView.rootViewController = rootView
        bannerView.adUnitID = "ca-app-pub-9813832992624910/7601701989"
        var width: CGFloat = 400
        var height: CGFloat = 150
        // (0.0, 0.0, 375.0, 667.0)
        tip.frame = CGRectMake((rootView.view.frame.width-width)/4, (rootView.view.frame.width-height)/4-20, width, 20)
        bannerView.frame = CGRectMake(0, 0, width, height)
        super.init(frame: CGRectMake((rootView.view.frame.width-width)/4, (rootView.view.frame.height-height)/4, width, height))
        self.addSubview(bannerView)
        self.addSubview(tip)
        var request:GADRequest = GADRequest()
        request.testDevices = [""]
        bannerView.loadRequest(request)
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(61, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
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
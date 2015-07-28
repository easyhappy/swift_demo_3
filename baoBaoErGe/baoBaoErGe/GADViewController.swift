import UIKit
import GoogleMobileAds

class GADViewController: UIView{
    
    var bannerView: GADBannerView!
    init(rootView: UIViewController) {
        bannerView = GADBannerView()
        bannerView.rootViewController = rootView
        bannerView.adUnitID = "ca-app-pub-9307633717110161/9204839139"
        var width: CGFloat = 400
        var height: CGFloat = 200
        // (0.0, 0.0, 375.0, 667.0)
        bannerView.frame = CGRectMake((rootView.view.frame.height-width)/4, (rootView.view.frame.width-height)/4, width, height)
        super.init(frame: CGRectMake((rootView.view.frame.height-width)/4, (rootView.view.frame.width-height)/4, width, height))
        self.addSubview(bannerView)
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
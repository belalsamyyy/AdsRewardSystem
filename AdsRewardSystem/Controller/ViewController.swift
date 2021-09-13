//
//  ViewController.swift
//  AdsRewardSystem
//
//  Created by Belal Samy on 12/09/2021.
//
import UIKit
import GoogleMobileAds
import youtube_ios_player_helper
import DesignX

class ViewController: UIViewController, GADFullScreenContentDelegate {
  
  // Video player
  let videoUrl = "https://www.youtube.com/watch?v=4B7UfUX2wz4"
  var videoPlayer = YTPlayerView()
    
  // Video state
  enum VideoState {
    case notStarted
    case playing
    case paused
    case ended
  }
    
  // The countdown timer.
  @IBOutlet weak var timeRemainingLabel: UILabel!
    
  var timer: Timer?
  var video = VideoState.notStarted
  var timeRemaining = 30 // seconds
  var pauseDate: Date?
  var previousFireDate: Date?
    
  // coins
  @IBOutlet weak var coinCountLabel: UILabel!
  let rewardValue = 10

  // The banner ad
    private var bannerAd: GADBannerView = {
        let banner = GADBannerView()
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        banner.load(GADRequest())
        banner.backgroundColor = .lightGray
        return banner
    }()
    
  // The interstitial ad
  var interstitialAd: GADInterstitialAd?
    
  // The rewarded video ad
  var rewardedAd: GADRewardedAd?
    
    
//MARK: - viewDidLoad
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    coinCountLabel.text = "Coins: \(Defaults.coins)"
    loadBannerAd()
    
    // youtube video player
    startYoutubeVideo(url: videoUrl)
    
    // Pause timer when application is backgrounded.
    NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)

    // Resume timer when application is returned to foreground.
    NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)

    // start the timer
    startTimer()
  }
    
    
// MARK: - Timer
    
    fileprivate func startTimer() {
        video = .playing
        loadRewardVideoAd()
        
        print("time remaining: \(timeRemaining)")
        timeRemainingLabel.text = "time remaining: \(timeRemaining)"
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick(_:)), userInfo: nil, repeats: true)
    }
    
    @objc func tick(_ timer: Timer) {
        timeRemaining -= 1
        if timeRemaining > 0 {
            print("time remaining: \(timeRemaining)")
            timeRemainingLabel.text = "time remaining: \(timeRemaining)"
        } else {
          endTimer()
        }
    }
    
    fileprivate func endTimer() {
        video = .ended
        print("The timer ends !")
        timeRemainingLabel.text = "The timer ends !"
        self.showToast(message: "earn \(rewardValue) coins", font: .systemFont(ofSize: 18))

        timer?.invalidate()
        timer = nil
        earnCoins(rewardValue)
      }
    
    
//MARK: - Youtube Video player
    
    func startYoutubeVideo(url: String) {
        view.addSubview(videoPlayer)
        videoPlayer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        videoPlayer.layout(X: .center(nil), W: .equal(nil, 0.95), Y: .top(timeRemainingLabel, 0), H: .fixed(250))
        
        // youtube video
        videoPlayer.delegate = self
        videoPlayer.load(withVideoId: url.youtubeID!, playerVars: ["playsinline": "1"])
        print("Youtube ID: \(url.youtubeID!)")
    }
    
    
// MARK: - GADFullScreenContentDelegate
    
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("ad presented.")
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad dismissed.")
    }

    func ad(_ ad: GADFullScreenPresentingAd,didFailToPresentFullScreenContentWithError error: Error) {
      print("Ad failed to present with error: \(error.localizedDescription).")
      let alert = UIAlertController(title: "Ad failed to present", message: "The Ad could not be presented.", preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "Try Again", style: .cancel, handler: { [weak self] action in self?.loadRewardVideoAd() })
      alert.addAction(alertAction)
      self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Pause || and Resume ...
        
        @objc func applicationDidEnterBackground(_ notification: Notification) {
          // Pause the timer if it is currently playing.
          if video != .playing {
            return
          }
          video = .paused

          // Record the relevant pause times.
          pauseDate = Date()
          previousFireDate = timer?.fireDate

          // Prevent the timer from firing while app is in background.
          timer?.fireDate = Date.distantFuture
        }

        @objc func applicationDidBecomeActive(_ notification: Notification) {
          // Resume the timer if it is currently paused.
          if video != .paused {
            return
          }
          video = .playing

          // Calculate amount of time the app was paused.
          let pauseTime = (pauseDate?.timeIntervalSinceNow)! * -1

          // Set the timer to start firing again.
          timer?.fireDate = (previousFireDate?.addingTimeInterval(pauseTime))!
        }
    
  //MARK: - Ads
    
    fileprivate func loadBannerAd() {
        bannerAd.rootViewController = self
        view.addSubview(bannerAd)
        bannerAd.layout(XW: .leadingAndCenter(nil, 0), Y: .bottomToSafeArea(nil, 0), H: .fixed(75))
    }
    
    
  fileprivate func loadInterstitialAd() {
    let request = GADRequest()
    GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3940256099942544/4411468910", request: request) { (ad, error) in
      if let error = error {
        print("Failed to load interstitial ad with error: \(error.localizedDescription)")
        return
      }
      
      print("Interstitial Loading Succeeded")
      self.interstitialAd = ad
      self.interstitialAd?.fullScreenContentDelegate = self
    }
  }
  
    
  fileprivate func loadRewardVideoAd() {
    GADRewardedAd.load(withAdUnitID: "ca-app-pub-3940256099942544/1712485313", request: GADRequest())  { (ad, error) in
      if let error = error {
        print("Rewarded ad failed to load with error: \(error.localizedDescription)")
        return
      }
      print("Reward Video Loading Succeeded")
      self.rewardedAd = ad
      self.rewardedAd?.fullScreenContentDelegate = self
    }
  }

    
  fileprivate func earnCoins(_ coins: NSInteger) {
      print("Reward received with \(rewardValue) coins")
      Defaults.coins += coins
      coinCountLabel.text = "Coins: \(Defaults.coins)"
  }
    
 fileprivate func loseCoins(_ coins: NSInteger) {
    Defaults.coins -= coins
    coinCountLabel.text = "Coins: \(Defaults.coins)"
 }

  // MARK: - actions
    
  @IBAction func interstitialAdTapped(_ sender: Any) {

    DispatchQueue.background(background: {
        // do something in background
        self.loadInterstitialAd()

    }, completion:{
        // when background job finished, do something in main thread
        if let ad = self.interstitialAd {
            //success
            ad.present(fromRootViewController: self)
        } else {
          // the Ad failed to present .. show alert message
          let alert = UIAlertController(title: "Interstitial ad isn't available yet.", message: "The Interstitial ad cannot be shown at this time",preferredStyle: .alert)
          let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] action in
              self?.loadInterstitialAd()
          })
          alert.addAction(alertAction)
          self.present(alert, animated: true, completion: nil)
        }
    })
  }
    

  @IBAction func rewardVideoTapped(_ sender: AnyObject) {

    DispatchQueue.background(background: {
        // do something in background
        self.loadRewardVideoAd()

    }, completion:{
        // when background job finished, do something in main thread
        if let ad = self.rewardedAd {
           // reward the user
           ad.present(fromRootViewController: self) {
           self.earnCoins(self.rewardValue)
         }
          
         } else {
            
          // the Ad failed to present .. show alert message
          let alert = UIAlertController(title: "Rewarded ad isn't available yet.", message: "The rewarded ad cannot be shown at this time",preferredStyle: .alert)
          let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] action in
              self?.loadRewardVideoAd()
          })
          alert.addAction(alertAction)
          self.present(alert, animated: true, completion: nil)
        }
    })

  }

}


extension ViewController: YTPlayerViewDelegate {
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return UIColor.black
    }
    
//    func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? {
//        // Create a Custom loading view
//        // let customLoadingView = UIView()
//        // return customLoadingView
//    }
    
}

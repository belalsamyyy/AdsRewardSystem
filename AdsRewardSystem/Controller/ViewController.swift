//
//  ViewController.swift
//  AdsRewardSystem
//
//  Created by Belal Samy on 12/09/2021.
//

import GoogleMobileAds
import UIKit
import DesignX

class ViewController: UIViewController, GADFullScreenContentDelegate {
 
  // coins label
  @IBOutlet weak var coinCountLabel: UILabel!

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
    
  //MARK: - functions
    
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
           let reward = ad.adReward
           print("Reward received with \(reward.amount) coins")
           self.earnCoins(NSInteger(truncating: reward.amount))
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

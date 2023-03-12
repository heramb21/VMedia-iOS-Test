//
//  ViewController.swift
//  VMediaTest
//
//  Created by Heramb on 01/03/23.
//

import UIKit
import PKHUD

class TVGuideViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var presenter: ViewToPresenterChannelsProtocol?
    
    var timeIntervals: [String] {
      return [
        "", "00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00", "07:00", "08:00", "09:00", "10:00", "11:00", "12:00",
        "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00"
      ]
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
            guard let guideCollectionView = self.collectionView else { return }
            let TVCNib = UINib(nibName: "TVGuideCollectionViewCell", bundle: Bundle.main)
            guideCollectionView.register(TVCNib, forCellWithReuseIdentifier: "TVGuideCell")

            let timeNib = UINib(nibName: "TimeCollectionViewCell", bundle: Bundle.main)
            guideCollectionView.register(timeNib, forCellWithReuseIdentifier: "timeCell")

            let channelNib = UINib(nibName: "ChannelCollectionViewCell", bundle: Bundle.main)
            guideCollectionView.register(channelNib, forCellWithReuseIdentifier: "channelCell")

            let programNib = UINib(nibName: "ProgramCollectionViewCell", bundle: Bundle.main)
            guideCollectionView.register(programNib, forCellWithReuseIdentifier: "programCell")


            guideCollectionView.backgroundColor = UIColor.lightGray
            let layout = TVGuideCollectionViewLayout()
            guideCollectionView.setCollectionViewLayout(layout, animated: false)
            guideCollectionView.dataSource = self
            guideCollectionView.delegate = self
    }
    
    // MARK: - Actions
    @objc func refresh() {
        presenter?.refresh()
    }
}

extension TVGuideViewController: PresenterToViewChannelsProtocol {
    func onFetchChannelsSuccess() {
        print("View receives the response from Presenter and updates itself.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.layoutSubviews()
        }
    }
    
    func onFetchChannelsFailure(error: String) {
        print("View receives the response from Presenter with error: \(error)")
    }
    
    func showHUD() {
        HUD.show(.progress, onView: self.view)
    }
    
    func hideHUD() {
        HUD.hide()
    }
    
    func deselectRowAt(row: Int) {
        print("deselectRowAt: \(row)")
    }
    
    
}

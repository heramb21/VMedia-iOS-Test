//
//  TVGuideVCExtension.swift
//  VMediaTest
//
//  Created by Heramb on 13/03/23.
//

import Foundation
import UIKit

// MARK: - UICollectionViewDataSource

extension TVGuideViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
      if let count = self.presenter?.ChannelsStrings?.count {
      return count + 1 // Number of channels + Time headers
    }
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if section == 0 {
      return timeIntervals.count
    } else {
        let linkedPrograms = self.presenter?.ProgramItems?.filter { $0.recentAirTime?.channelID == self.presenter?.ChannelsID?[section]}
        if let count = linkedPrograms?.count {
        return count + 1
      }
    }
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: TVGuideCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVGuideCell", for: indexPath) as! TVGuideCollectionViewCell
    cell.titleLabel.text = ""

    if indexPath.section == 0 { // Time
      let timeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeCell", for: indexPath) as! TimeCollectionViewCell
      let time = self.timeIntervals[indexPath.row]
      timeCell.timeLabel.text = time
      return timeCell
    } else if indexPath.row == 0 { // Channels
      let channelCell = collectionView.dequeueReusableCell(withReuseIdentifier: "channelCell", for: indexPath) as! ChannelCollectionViewCell
      if let channel = self.presenter?.ChannelsStrings?[indexPath.section - 1] {
        channelCell.configureWith(channel: channel)
        return channelCell
      }
      cell.backgroundColor = UIColor.orange
    } else {
      if let channel = self.presenter?.ChannelsStrings?[indexPath.section - 1] {
          let linkedPrograms = self.presenter?.ProgramItems?.filter { $0.recentAirTime?.channelID == self.presenter?.ChannelsID?[indexPath.section]}
          if let program = linkedPrograms?[indexPath.row - 1] {
          let programCell = collectionView.dequeueReusableCell(withReuseIdentifier: "programCell", for: indexPath) as! ProgramCollectionViewCell
          programCell.configureWith(program: program)
          return programCell
        }
      }
    }
    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension TVGuideViewController: UICollectionViewDelegate {

}

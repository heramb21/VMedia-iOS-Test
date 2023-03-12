//
//  TVGuideCollectionViewCell.swift
//  VMediaTest
//
//  Created by Heramb on 12/03/23.
//

import UIKit

class TVGuideCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
    }

    func setup() {
      self.titleLabel.text = "1"
      self.backgroundColor = UIColor.orange
    }
}

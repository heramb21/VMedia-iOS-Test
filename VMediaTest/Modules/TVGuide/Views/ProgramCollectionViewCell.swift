//
//  ProgramCollectionViewCell.swift
//  EPG
//
//  Created by Jerald Abille on 3/22/18.
//  Copyright © 2018 Jerald Abille. All rights reserved.
//

import UIKit

class ProgramCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var scheduleLabel: UILabel!
  @IBOutlet weak var durationLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }

  func setup() {
    self.backgroundColor = UIColor.white
    self.layer.borderWidth = 0.5
    self.layer.borderColor = UIColor.lightGray.cgColor
  }

  func configureWith(program: ProgramItem) {
      self.titleLabel.text = program.name
      self.scheduleLabel.text = "\(program.startTime ?? Date())"
      self.durationLabel.text = "\(program.length ?? 0)"
    
    self.scheduleLabel.textColor = UIColor.gray
    self.durationLabel.textColor = UIColor.gray
  }
}

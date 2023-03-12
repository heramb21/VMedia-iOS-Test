//
//  TVGuideCollectionViewLayout.swift
//  VMediaTest
//
//  Created by Heramb on 12/03/23.
//

import UIKit

class TVGuideCollectionViewLayout: UICollectionViewLayout {
  let cellWidth = 120.0
  let cellHeight = 120.0
  var cellAttributesDictionary = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
  var contentSize = CGSize.zero
  var dataSourceDidUpdate = true

  var channels: [Channel]?
  var programs: [ProgramItem]?

  override var collectionViewContentSize: CGSize {
    return self.contentSize
  }

  override func prepare() {
    if !dataSourceDidUpdate {
      let xOffset = collectionView!.contentOffset.x
      let yOffset = collectionView!.contentOffset.y

      if let sectionCount = collectionView?.numberOfSections, sectionCount > 0 {
        for section in 0...sectionCount - 1 {
          if let rowCount = collectionView?.numberOfItems(inSection: section), rowCount > 0 {
            // The first row.
            if section == 0 {
              for item in 0...rowCount - 1 {
                let indexPath = IndexPath(item: item, section: section)
                if let attributes = cellAttributesDictionary[indexPath] {
                  var frame = attributes.frame
                  if item == 0 {
                    frame.origin.x = xOffset
                  }
                  frame.origin.y = yOffset
                  attributes.frame = frame
                }
              }
            } else {
              let indexPath = IndexPath(item: 0, section: section)
              if let attributes = cellAttributesDictionary[indexPath] {
                var frame = attributes.frame
                frame.origin.x = xOffset
                attributes.frame = frame
              }
            }
          }
        }
      }
      return
    }

    dataSourceDidUpdate = false

    if let sectionCount = collectionView?.numberOfSections, sectionCount > 0 {
      for section in 0...sectionCount - 1 {
        var channel: Channel?
        if section > 0 {
          if let ch = self.channels?[section - 1] {
            channel = ch
          }
        }
        if let rowCount = collectionView?.numberOfItems(inSection: section), rowCount > 0 {
          for item in 0...rowCount - 1 {
            var program: ProgramItem?
            if section > 0 && item > 0 {
              if let _ = channel {
                  if let prog = self.programs?[item - 1] {
                  program = prog
                }
              }
            }

            let cellIndex = IndexPath(item: item, section: section)
            var xPos = Double(item) * cellWidth
            let yPos = Double(section) * cellHeight

            let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: cellIndex)
            cellAttributes.frame = CGRect(x: xPos, y: yPos, width: cellWidth, height: cellHeight)

            if let _ = program {
//                xPos = (cellWidth * (TimeInterval(program?.startTime) / 60 / 60) + cellWidth)
                xPos = cellWidth
                let width = ((program?.length ?? 0) / 60 / 60) * 120
                cellAttributes.frame = CGRect(x: xPos, y: yPos, width: Double(width), height: cellHeight)
            }

            if section == 0 && item == 0 {
              cellAttributes.zIndex = 4
            } else if section == 0 {
              cellAttributes.zIndex = 3
            } else if item == 0 {
              cellAttributes.zIndex = 2
            } else {
              cellAttributes.zIndex = 1
            }

            cellAttributesDictionary[cellIndex] = cellAttributes
          }
        }
      }
    }

    let contentWidth = Double(collectionView!.numberOfItems(inSection: 0)) * cellWidth
    let contentHeight = Double(collectionView!.numberOfSections) * cellHeight
    self.contentSize = CGSize(width: contentWidth, height: contentHeight + 30)
  }

  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var attributesInRect = [UICollectionViewLayoutAttributes]()
    for cellAttributes in cellAttributesDictionary.values {
      if rect.intersects(cellAttributes.frame) {
        attributesInRect.append(cellAttributes)
      }
    }
    return attributesInRect
  }

  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cellAttributesDictionary[indexPath]!
  }

  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
}

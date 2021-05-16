//
//  Borders.swift
//  snake-1
//
//  Created by Logan Melton on 21/5/13.
//

import Foundation
import SpriteKit

let view = SKView.self

class Border: SKSpriteNode {
  var borderSize = CGSize(width: 5, height: 5)
  var borderName: String = "gameBoard"
  var borderWidth: CGFloat!
  var borderHeight: CGFloat!
  
  init() {
    super.init(texture: nil, color: .white, size: borderSize)
    self.physicsBody = SKPhysicsBody(rectangleOf: self.borderSize)
    self.physicsBody?.isDynamic = false
    self.physicsBody?.contactTestBitMask = 2
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


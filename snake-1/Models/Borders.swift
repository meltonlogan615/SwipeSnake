//
//  Borders.swift
//  snake-1
//
//  Created by Logan Melton on 21/5/13.
//

import Foundation
import SpriteKit

class Border: SKSpriteNode {
  let borderSize = CGSize(width: 5, height: 5)
  
  init() {
    super.init(texture: nil, color: .white, size: self.borderSize)
    self.name = "border"
    
    self.physicsBody = SKPhysicsBody(rectangleOf: self.borderSize)
    
//    self.physicsBody?.categoryBitMask = PhysicsCategories.border
    self.physicsBody?.contactTestBitMask = 2
//    self.physicsBody?.collisionBitMask = PhysicsCategories.none
    
    self.physicsBody?.isDynamic = false
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


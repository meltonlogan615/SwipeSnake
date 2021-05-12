//
//  Food.swift
//  snake-1
//
//  Created by Logan Melton on 21/5/11.
//

import Foundation
import SpriteKit

let view = GameScene()

class Food: SKSpriteNode {
  let foodName:          String = "food"
  var countActive:          Int = 0
  var countEaten:           Int = 0
  var foodColor:        CGColor = UIColor.red.cgColor
  var foodSize:          CGSize = CGSize(width: 20, height: 20)
  var foodTestBitMask:   UInt32 = 1
  var foodSpin:         CGFloat = 3
  var foodDecreaseSpin: CGFloat = 0
  
  init() {
    super.init(texture: nil, color: UIColor(cgColor: foodColor), size: foodSize)
    self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
    self.physicsBody?.angularVelocity = foodSpin
    self.physicsBody?.angularDamping = foodDecreaseSpin
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func eatFood() {
    self.removeFromParent()
    countActive -= 1
    countEaten  += 1
  }
}
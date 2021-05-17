//
//  Snake.swift
//  snake-1
//
//  Created by Logan Melton on 21/5/2.
//

import Foundation
import SpriteKit

class SnakeSegment: SKSpriteNode {
  var snakeName:        String = "snake"
  var segmentColor:    CGColor = UIColor.cyan.cgColor
  var segmentSize:      CGSize = CGSize(width: 20, height: 20)
  var speedMultiplier: CGFloat = 1.0
  var length:              Int = 0 // number of snakeSegments
  var snakeTestBitMask: UInt32 = 1
  var initialLocation:  CGPoint!
  var currentVelocity: CGVector!
  var snakeLocation:   CGPoint!
 
  init() {
    super.init(texture: nil, color: UIColor(cgColor: self.segmentColor), size: self.segmentSize)
    self.name = snakeName
    self.physicsBody = SKPhysicsBody(rectangleOf: self.segmentSize)
    self.physicsBody?.contactTestBitMask = self.snakeTestBitMask
    self.physicsBody?.restitution = 1
    self.physicsBody?.allowsRotation = false
    self.physicsBody?.isDynamic = true
    self.physicsBody?.linearDamping = 0
    self.physicsBody?.angularDamping = 0
  
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

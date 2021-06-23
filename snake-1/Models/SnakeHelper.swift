//
//  SnakeHelper.swift
//  snake-1
//
//  Created by Logan Melton on 21/6/10.
//

import Foundation
import SpriteKit

enum SnakeWorldObjects: CGFloat {
  case snake
  case food
  case border
  case labels
}

enum PhysicsCategories {
  static let none:       UInt32 = 0
  static let snake:      UInt32 = 0b1
  static let food:       UInt32 = 0b10
  static let border:     UInt32 = 0b100
}



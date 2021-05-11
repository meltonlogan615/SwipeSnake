//
//  Food.swift
//  snake-1
//
//  Created by Logan Melton on 21/5/11.
//

import Foundation
import SpriteKit

struct Food {
  var foodCount = 0
  var foodEaten = 0
  var position = 0
  
  mutating func eatFood() {
    foodCount -= 1
    foodEaten += 1
  }
}

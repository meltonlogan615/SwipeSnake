//
//  Labels.swift
//  snake-1
//
//  Created by Logan Melton on 21/5/13.
//

import Foundation
import SpriteKit

class Labels: SKLabelNode {
  var fontFamily: String = "Courier"
  var zIndex:     CGFloat = 2
  
  override init() {
    super.init()
    self.fontName = fontFamily
    self.horizontalAlignmentMode = .center
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class GameOver: Labels {
  override init() {
    super.init()
    self.text = "Game Over"
    self.fontSize = 48
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class FinalScore: Labels {
  override init() {
    super.init()
    self.fontSize = 24
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class NewGame: Labels {
  override init() {
    super.init()
    self.text = "New Game"
    self.name = "New Game"
    self.fontSize = 24
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class Score: Labels {
  override init() {
    super.init()
    self.text = "Score: 0"
    self.fontSize = 16
    self.horizontalAlignmentMode = .left
    self.position = CGPoint(x: 12, y: 55)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

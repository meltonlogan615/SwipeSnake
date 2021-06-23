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
//  var zIndex:     CGFloat = SnakeWorldObjects.labels.rawVal
  
  override init() {
    super.init()
    self.fontName = fontFamily
    self.horizontalAlignmentMode = .center
    self.zPosition = SnakeWorldObjects.labels.rawValue
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

//MARK: - End of Game Labels
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

class TopScores: Labels {
  override init() {
    super.init()
    self.text = "High Scores"
    self.name = "High Scores"
    fontSize = 24
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

//MARK: - Score Label in bottom left corner
class Score: Labels {
  override init() {
    super.init()
    self.text = "Score: 0"
    self.fontSize = 24
    self.horizontalAlignmentMode = .left
    self.position = CGPoint(x: 12, y: 24)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}



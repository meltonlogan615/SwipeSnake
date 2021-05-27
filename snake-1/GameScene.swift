//
//  GameScene.swift
//  snake-1
//
//  Created by Logan Melton on 21/5/1.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  
  // game basics
  var timer: Timer?
  var isGameOver = false
  
  // game nodes
  var food = Food()
  var snake = SnakeSegment()
  var additionalSegment = SnakeSegment()
  var snakeSegmentPosition: Int!
  var completeSnake: FullSnake!
  var currentDirection: CGVector!
  var snakeCurrentPosition: CGPoint!
  var snakePositions = [CGPoint]()
  
  // scoring
  let scoreLabel = Score()
  var score = 0 {
    didSet {
      scoreLabel.text = "Score: \(score)"
    }
  }
  
  // for use later when adding user defaults to keep track of high scores
  var highScore = 0
  
  // Swipe vars
  var startSwipe: CGPoint!
  var endSwipe: CGPoint!
  
  // End Game Labels
  let gameOverLabel = GameOver()
  let finalScoreLabel = FinalScore()
  let newGameLabel = NewGame()
  
  
  override func didMove(to view: SKView) {
    // world settings
    physicsWorld.gravity = .zero
    physicsWorld.contactDelegate = self
    startNewGame()
  }
  
  //MARK: - Put a ring on it 🪐
  func makeGameBoard() {
    guard let scene = scene else { return }
    let topGameBorderSize = CGSize(width: scene.frame.width, height: 10)
    let topGameBorder = SKSpriteNode(color: .white, size: topGameBorderSize)
    topGameBorder.position = CGPoint(x: scene.frame.width / 2, y: scene.frame.maxY)
    topGameBorder.physicsBody = SKPhysicsBody(rectangleOf: topGameBorder.size)
    topGameBorder.name = "gameBoard"
    topGameBorder.physicsBody?.isDynamic = false
    topGameBorder.physicsBody?.contactTestBitMask = 2
    addChild(topGameBorder)
    
    let leftGameBorderSize = CGSize(width: 10, height: scene.frame.height)
    let leftGameBorder = SKSpriteNode(color: .white, size: leftGameBorderSize)
    leftGameBorder.position = CGPoint(x: 0, y: scene.frame.height / 2 )
    leftGameBorder.physicsBody = SKPhysicsBody(rectangleOf: leftGameBorder.size)
    leftGameBorder.name = "gameBoard"
    leftGameBorder.physicsBody?.isDynamic = false
    leftGameBorder.physicsBody?.contactTestBitMask = 2
    addChild(leftGameBorder)
    
    let rightBorderSize = CGSize(width: 10, height: scene.frame.height)
    let rightGameBorder = SKSpriteNode(color: .white, size: rightBorderSize)
    rightGameBorder.position = CGPoint(x: scene.frame.maxX, y: scene.frame.height / 2)
    rightGameBorder.name = "gameBoard"
    rightGameBorder.physicsBody = SKPhysicsBody(rectangleOf: rightGameBorder.size)
    rightGameBorder.physicsBody?.isDynamic = false
    rightGameBorder.physicsBody?.contactTestBitMask = 2
    addChild(rightGameBorder)
    
    let bottomBorderSize = CGSize(width: scene.frame.width, height: 10)
    let bottomGameBorder = SKSpriteNode(color: .white, size: bottomBorderSize)
    bottomGameBorder.position = CGPoint(x: scene.frame.width / 2, y: 0)
    bottomGameBorder.name = "gameBoard"
    bottomGameBorder.physicsBody = SKPhysicsBody(rectangleOf: bottomGameBorder.size)
    bottomGameBorder.physicsBody?.isDynamic = false
    bottomGameBorder.physicsBody?.contactTestBitMask = 2
    addChild(bottomGameBorder)
  }
  
  func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(increaseScore), userInfo: nil, repeats: true)
  }
  
  @objc func increaseScore() {
    score += 1
//    snake.speedMultiplier += 0.01
  }
  
  //MARK: - Shake Yer Snake Maker 🐍
  func makeNewSnake() {
    guard let scene = scene else { return }
    snake.position = CGPoint(x: Int.random(in: 20...Int(scene.frame.width - 20)), y: Int.random(in: 20...Int(scene.frame.height - 20)))
    snakeCurrentPosition = snake.position
    // sets the initial direction of the new snake
    if snake.position.x >= scene.frame.width / 2 {
      snake.currentVelocity = CGVector(dx: -(30 * snake.speedMultiplier), dy: 0)
      snake.physicsBody?.velocity = snake.currentVelocity
    } else if snake.position.x < scene.frame.width / 2 {
      snake.currentVelocity = CGVector(dx: 30 * snake.speedMultiplier, dy: 0)
      snake.physicsBody?.velocity = snake.currentVelocity
    }
    completeSnake = FullSnake(allSegments: [snake])
    completeSnake.allSegments.append(snake)
    addChild(completeSnake.allSegments[0])
  }
  
  //Add
  func extendSnake() {
    additionalSegment = SnakeSegment()
    additionalSegment.position = snakePositions[0]
    additionalSegment.name = "snakeBody"
    additionalSegment.physicsBody = SKPhysicsBody(rectangleOf: additionalSegment.size)
    //    additionalSegment.physicsBody?.isDynamic = false
    additionalSegment.physicsBody?.linearDamping = 0
    completeSnake.allSegments.append(additionalSegment)
    addChild(completeSnake.allSegments.last!)
  }
  
  
  //MARK: - Kitchen Time 🥞
  func makeFood() {
    guard let scene = scene else { return }
    if !isGameOver && food.countActive < 1 {
      food.position = CGPoint(x: Int.random(in: 20...Int(scene.frame.width - 20)), y: Int.random(in: 20...Int(scene.frame.height - 20)))
      food.countActive += 1
      addChild(food)
    }
  }
  
  //MARK: - Game Creation
  func startNewGame() {
    food.countActive = 0
    isGameOver = false
    removeAllChildren()
    addScoreLabel()
    makeGameBoard()
    makeNewSnake()
    snake.physicsBody?.isDynamic = true
    makeFood()
    startTimer()
  }
  
  //MARK: - Change Direction
  //TODO: - Once there are multiple snake segments, this will need to be updated to where if swipe direction is the inverse of current direction, it is rendered invalid and the player must make 90deg turns to get to their destination
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let start = touches.first else { return }
    startSwipe = start.location(in: self)
    for touch in touches {
      let location = touch.location(in: self)
      let touchedNode = atPoint(location)
      if touchedNode.name == "New Game" {
        score = 0
        startNewGame()
      }
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let end = touches.first else { return }
    endSwipe = end.location(in: self)
    
    if abs(startSwipe.x - endSwipe.x) > abs(startSwipe.y - endSwipe.y) {
      if startSwipe.x > endSwipe.x {
        for i in 0..<completeSnake.allSegments.count {
          completeSnake.allSegments[i].physicsBody?.velocity = CGVector(dx: -30 * snake.speedMultiplier, dy: 0)
        }
      } else if startSwipe.x < endSwipe.x {
        for i in 0..<completeSnake.allSegments.count {
          completeSnake.allSegments[i].physicsBody?.velocity = CGVector(dx: 30 * snake.speedMultiplier, dy: 0)
        }
      }
    } else if abs(startSwipe.x - endSwipe.x) < abs(startSwipe.y - endSwipe.y) {
      if startSwipe.y > endSwipe.y {
        for i in 0..<completeSnake.allSegments.count {
          completeSnake.allSegments[i].physicsBody?.velocity = CGVector(dx: 0, dy: -30 * snake.speedMultiplier)
        }
      } else if startSwipe.y < endSwipe.y {
        for i in 0..<completeSnake.allSegments.count {
          completeSnake.allSegments[i].physicsBody?.velocity = CGVector(dx: 0, dy: 30 * snake.speedMultiplier)
        }
      }
    }
  }
  
  
  // MARK: - Collision-Contact Detection - Totally stolen from @twostraws
  // Source: https://www.hackingwithswift.com/read/11/5/collision-detection-skphysicscontactdelegate
  func collisionBetween(hungrySnake: SKNode, object: SKNode) {
    if object.name == "food" {
      food.eatFood()
//      snake.speedMultiplier += 0.15
      score += 20
      extendSnake()
      makeFood()
    } else if object.name == "gameBoard"  {
      endGame()
    }
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    if contact.bodyA.node!.name == "snake" {
      collisionBetween(hungrySnake: contact.bodyA.node!, object: contact.bodyB.node!)
    } else if contact.bodyB.node!.name == "snake" {
      collisionBetween(hungrySnake: contact.bodyB.node!, object: contact.bodyA.node!)
    }
  }
  
  
  // TODO: - Create End Game Method
  func endGame() {
    guard let scene = scene else { return }
    snake.physicsBody?.isDynamic = false
    timer?.invalidate()
    isGameOver = true
    
    // Game Over Label
    gameOverLabel.position = CGPoint(x: scene.frame.width / 2, y: scene.frame.height / 2 + 50)
    addChild(gameOverLabel)
    
    // Final Score Label
    finalScoreLabel.text = "Final Score: \(score)"
    finalScoreLabel.position = CGPoint(x: scene.frame.width / 2, y: scene.frame.height / 2)
    addChild(finalScoreLabel)
    
    newGameLabel.position = CGPoint(x: scene.frame.width / 2, y: scene.frame.height / 2 - 50)
    addChild(newGameLabel)
    // TODO: - add button to show high scores
    
  }
  
  // MARK: - Score Label
  func addScoreLabel() {
    addChild(scoreLabel)
  }
  
  // TODO: - Use update method to set the position of each of the trailing segments to the last position of the segment before it.
  override func update(_ currentTime: TimeInterval) {
    snakePositions.insert(snake.position, at: 0)
    if snakePositions.count > 10_000 {
      snakePositions.remove(at: 9_999)
    }
    if completeSnake.allSegments.count > 2 {
      for i in 2..<completeSnake.allSegments.count {
        completeSnake.allSegments[i].position = snakePositions[i * 25]
      }
    }
  }
  
}


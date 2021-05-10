//
//  GameScene.swift
//  snake-1
//
//  Created by Logan Melton on 21/5/1.
//

import SpriteKit

enum Collisions: UInt32 {
  case snakeSegment = 1
  case food = 2
  case wall = 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
  
  // game basics
  var timer: Timer?
  var isGameOver = false
  
  // food
  var food: SKSpriteNode!
  var foodCount = 0
  var foodEaten = 0
  
  // snake
  var snakeSegment: SKSpriteNode!
  var fullSnake: [SKSpriteNode]!
  var snakeSpeedMultiplier = 1.0
  var snakeCurrentVelocity: CGVector!
  
  // scoring
  var scoreLabel: SKLabelNode!
  var score = 0 {
    didSet {
      scoreLabel.text = "Score: \(score)"
    }
  }

  // Swipe vars
  var startSwipe: CGPoint!
  var endSwipe: CGPoint!

  // scene view sizes && borders
  var gameBorder: SKSpriteNode!
  //let playableArea = SKScene()
  

  
  override func didMove(to view: SKView) {
    scene?.scaleMode = .aspectFit
    physicsWorld.gravity = .zero
    physicsWorld.contactDelegate = self
    startNewGame()
    
    scoreLabel = SKLabelNode(fontNamed: "Arial")
    scoreLabel.text = "Score: 0"
    scoreLabel.fontSize = 16
    scoreLabel.horizontalAlignmentMode = .left
    scoreLabel.position = CGPoint(x: view.frame.width / 8, y: view.frame.height / 8)
    scoreLabel.zPosition = 2
    addChild(scoreLabel)
    
  }
  
  //MARK: - Put a ring on it
  func makeGameBoard() {
    guard let view = view else { return }

    let topGameBorder = SKSpriteNode(color: .white, size: CGSize(width: view.frame.width, height: 5))
    topGameBorder.name = "gameBoard"
    topGameBorder.physicsBody = SKPhysicsBody(rectangleOf: topGameBorder.size)
    topGameBorder.physicsBody?.isDynamic = false
    topGameBorder.physicsBody?.contactTestBitMask = 2
    topGameBorder.position = CGPoint(x: view.frame.width / 2, y: view.frame.maxY - 45)
    print("Top X = \(topGameBorder.position.x) \n Top Y = \(topGameBorder.position.y)")
    addChild(topGameBorder)

    let leftGameBorder = SKSpriteNode(color: .white, size: CGSize(width: 10, height: view.frame.height))
    leftGameBorder.physicsBody = SKPhysicsBody(rectangleOf: leftGameBorder.size)
    leftGameBorder.physicsBody?.isDynamic = false
    leftGameBorder.physicsBody?.contactTestBitMask = 2
    leftGameBorder.position = CGPoint(x: 0, y: view.frame.height / 2 - 40)
    addChild(leftGameBorder)
    
    let rightGameBorder = SKSpriteNode(color: .white, size: CGSize(width: 10, height: view.frame.height))
    rightGameBorder.name = "gameBoard"
    rightGameBorder.physicsBody = SKPhysicsBody(rectangleOf: rightGameBorder.size)
    rightGameBorder.physicsBody?.isDynamic = false
    rightGameBorder.physicsBody?.contactTestBitMask = 2
    rightGameBorder.position = CGPoint(x: view.frame.maxX, y: view.frame.height / 2 - 40)
    addChild(rightGameBorder)
    
    let bottomGameBorder = SKSpriteNode(color: .white, size: CGSize(width: view.frame.width, height: 5))
    bottomGameBorder.physicsBody = SKPhysicsBody(rectangleOf: bottomGameBorder.size)
    bottomGameBorder.physicsBody?.isDynamic = false
    bottomGameBorder.physicsBody?.contactTestBitMask = 2
    bottomGameBorder.position = CGPoint(x: view.frame.width / 2, y: 35)
    addChild(bottomGameBorder)
  }
  
  func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(increaseScore), userInfo: nil, repeats: true)
  }
  
  @objc func increaseScore() {
    score += 1
  }
  
  //MARK: - Snake Maker
  func makeNewSnake() {
    guard let view = view else { return }
    snakeSegment = SKSpriteNode(color: .cyan, size: CGSize(width: 20, height: 20))
    snakeSegment.name = "snake"
    snakeSegment.position = CGPoint(x: Int.random(in: 50...Int(view.frame.width - 50)), y: Int.random(in: 50...Int(view.frame.height - 50)))
    snakeSegment.physicsBody = SKPhysicsBody(rectangleOf: snakeSegment.size)
    snakeSegment.physicsBody?.contactTestBitMask = 1
    snakeSegment.physicsBody?.restitution = 1.0
    snakeSegment.physicsBody?.allowsRotation = false
    snakeSegment.physicsBody?.isDynamic = true
    
    // sets the initial direction of snake movement based on initial start position
    if snakeSegment.position.x >= view.frame.width / 2 {
      snakeCurrentVelocity = CGVector(dx: -(30 * snakeSpeedMultiplier), dy: 0)
      snakeSegment.physicsBody?.velocity = snakeCurrentVelocity
    } else if snakeSegment.position.x < view.frame.width / 2 {
      snakeCurrentVelocity = CGVector(dx: 30 * snakeSpeedMultiplier, dy: 0)
      snakeSegment.physicsBody?.velocity = snakeCurrentVelocity
    }
    snakeSegment.physicsBody?.linearDamping = 0
    snakeSegment.physicsBody?.angularDamping = 0
    
    addChild(snakeSegment)
  }
  
  //MARK: - Kitchen Time
  func makeFood() {
    guard let view = view else { return }
    if !isGameOver && foodCount < 1
    {
      food = SKSpriteNode(color: .red, size: CGSize(width: 20, height: 20))
      food.name = "food"
      food.position = CGPoint(x: Int.random(in: 1...Int(view.frame.width - 10)), y: Int.random(in: 10...Int(view.frame.height - 10)))
      food.physicsBody = SKPhysicsBody(rectangleOf: food.size)
      food.physicsBody?.contactTestBitMask = 1
      food.physicsBody?.angularVelocity = 2
      foodCount += 1
      print(food.position)
      addChild(food)
    }
  }
  
  //MARK: - Game Creation
  func startNewGame() {
    makeGameBoard()
    makeNewSnake()
    makeFood()
    startTimer()
  }
  
  //MARK: - Change Direction
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let start = touches.first else { return }
    startSwipe = start.location(in: self)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let end = touches.first else { return }
    endSwipe = end.location(in: self)
    
    if abs(startSwipe.x - endSwipe.x) > abs(startSwipe.y - endSwipe.y) {
      if startSwipe.x > endSwipe.x {
        snakeSegment.physicsBody?.velocity = CGVector(dx: -30 * snakeSpeedMultiplier, dy: 0)
      } else if startSwipe.x < endSwipe.x {
        snakeSegment.physicsBody?.velocity = CGVector(dx: 30 * snakeSpeedMultiplier, dy: 0)
      }
    } else if abs(startSwipe.x - endSwipe.x) < abs(startSwipe.y - endSwipe.y) {
      if startSwipe.y > endSwipe.y {
        snakeSegment.physicsBody?.velocity = CGVector(dx: 0, dy: -30 * snakeSpeedMultiplier)
      } else if startSwipe.y < endSwipe.y {
        snakeSegment.physicsBody?.velocity = CGVector(dx: 0, dy: 30 * snakeSpeedMultiplier)
      }
    }
    
  }
  
  
  
  // MARK: - Contact Detection
  func didBegin(_ contact: SKPhysicsContact) {
    print("BOOM!!!")
    food.removeFromParent()
    foodCount -= 1
    foodEaten += 1
    snakeSpeedMultiplier += 0.15
    score += 20
    makeFood()
  }
  
  
  
  
  /*
   Other things. Set the rate of speed of the snake based on the timer.
   increase speed slowly as the snake gets longer
   moveSnake() changes the positions of the snakeSegments by one
   changeDirection() swipe gestures to change the direction of the snake
   
   */
}


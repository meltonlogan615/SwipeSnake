//
//  GameViewController.swift
//  snake-1
//
//  Created by Logan Melton on 21/5/1.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let view = self.view as! SKView? {
      // Load the SKScene from 'GameScene.sks'
      if let scene = SKScene(fileNamed: "GameScene") {
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFit
        
        // Present the scene
        view.presentScene(scene)
      }
      
      view.ignoresSiblingOrder = true
      view.showsPhysics = true
      view.showsFPS = true
      view.showsNodeCount = true
    }
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .allButUpsideDown
    } else {
      return .all
    }
  }
  
  override var prefersStatusBarHidden: Bool {
    return false
  }
}

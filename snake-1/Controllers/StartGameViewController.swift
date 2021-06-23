//
//  StartGameViewController.swift
//  snake-1
//
//  Created by Logan Melton on 21/5/15.
//

import UIKit



class StartGameViewController: UIViewController {
  
  @IBOutlet var gameTitleLabel: UILabel!
  var timer: Timer?
  let gameTitle = "Swipe Snake"
  
  override func viewDidLoad() {
    super.viewDidLoad()
   startTimer()
  }
  
  func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(typeOut), userInfo: nil, repeats: false)
  }
  @objc func typeOut() {
    for i in gameTitle {
      gameTitleLabel.text! += "\(i)"
      RunLoop.current.run(until: Date()+0.2)
    }
  }
  
  @IBAction func startGameButtonPressed(_ sender: UIButton) {
    let gameVC = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
    navigationController?.pushViewController(gameVC, animated: true)
  }
  
}

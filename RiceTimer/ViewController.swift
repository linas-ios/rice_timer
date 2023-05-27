//
//  ViewController.swift
//  RiceTimer
//
//  Created by Linas Nutautas on 24/05/2023.
//

import UIKit

class ViewController: UIViewController {


  let riceTimer = ["White": 10, "Brown": 7, "Wild": 4]
  var timer: Timer?
  var timeRemaining: Int?

  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var segmentControl: UISegmentedControl!
  @IBOutlet weak var riceTypeImage: UIImageView!
  @IBOutlet weak var timerLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    configureSegmentControl()
    configureStartButton()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    timer?.invalidate()
  }


  @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {

    switch sender.selectedSegmentIndex {
    case 0:
      riceTypeImage.image = UIImage(named: "white")
      timerLabel.text = String(riceTimer["White"] ?? 0)
    case 1:
      riceTypeImage.image = UIImage(named: "brown")
      timerLabel.text = String(riceTimer["Brown"] ?? 0)
    case 2:
      riceTypeImage.image = UIImage(named: "wild")
      timerLabel.text = String(riceTimer["Wild"] ?? 0)
    default:
      print("Error")
    }
  }


  @IBAction func startButtonTapped(_ sender: UIButton) {
    guard let selectedRice = segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex),
          let initialTime = riceTimer[selectedRice] else {
      return
    }

    timer?.invalidate()

    var timeRemaining = initialTime
    timerLabel.text = String(timeRemaining)

    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
      if timeRemaining > 0 {
        timeRemaining -= 1
        self?.timerLabel.text = String(timeRemaining)
      } else {
        timer.invalidate()
        self?.showAlert(title: "Done!", message: "Your rice cooking it's done!") {
          self?.timerLabel.text = String(self?.riceTimer[selectedRice] ?? 0)
        }
      }
    }
  }



  func configureSegmentControl() {
    riceTypeImage.image = UIImage(named: "white")
    let notSelectedColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
    let selectedColor = [NSAttributedString.Key.foregroundColor: UIColor.black]
    segmentControl.setTitleTextAttributes(notSelectedColor, for: .normal)
    segmentControl.setTitleTextAttributes(selectedColor, for: .selected)

  }

  func configureStartButton() {
    startButton.layer.cornerRadius = 15
    startButton.clipsToBounds = true
  }


  func showAlert(title: String, message: String, completion: @escaping () -> Void) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
      completion()
    }
    alert.addAction(okAction)
    present(alert, animated: true, completion: nil)
  }

}




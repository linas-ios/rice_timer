//
//  ViewController.swift
//  RiceTimer
//
//  Created by Linas Nutautas on 24/05/2023.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var segmentControl: UISegmentedControl!
  @IBOutlet weak var riceTypeImage: UIImageView!


  override func viewDidLoad() {
    super.viewDidLoad()
    configureSegmentControl()
    configureStartButton()


  }

  @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {

    switch sender.selectedSegmentIndex {
    case 0:
      riceTypeImage.image = UIImage(named: "white")
    case 1:
      riceTypeImage.image = UIImage(named: "brown")
    case 2:
      riceTypeImage.image = UIImage(named: "wild")
    default:
      print("Error")
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


}


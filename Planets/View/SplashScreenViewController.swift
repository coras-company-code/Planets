//
//  SplashScreenViewController.swift
//  GameOfThrones
//
//

import UIKit

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func buttonTapped(_ sender: Any) {
        performSegue(withIdentifier: K.SegueIdentifiers.planetListSegue, sender: nil)
    }
}

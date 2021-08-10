//
//  PlanetViewController.swift
//  Planets
//
//  Created by M_931521 on 23/06/2021.
//

import UIKit

class DetailViewController: UIViewController {
    var planet: PlanetModel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var climateStaticLabel: UILabel!
    @IBOutlet weak var climateLabel: UILabel!
    @IBOutlet weak var gravityStaticLabel: UILabel!
    @IBOutlet weak var gravityLabel: UILabel!
    @IBOutlet weak var populationStaticLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
            if planet != nil {
                updateUI() }
        }
    
        
        func updateUI() {
            nameLabel.text = planet.name
            climateLabel.text = planet.climate
            gravityLabel.text = planet.gravity
            populationLabel.text = planet.population
        }

}

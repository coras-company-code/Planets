//
//  ViewController.swift
//  Planets
//
//  Created by M_931521 on 23/06/2021.
//

import UIKit

class PlanetsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var planets: [PlanetModel] = [
        PlanetModel(name: "Earth", climate: "Dry", gravity: 1, population: 7000000000000000),
        PlanetModel(name: "Mars", climate: "Extreme", gravity: 10, population: 0),
        PlanetModel(name: "Pluto", climate: "Dry", gravity: 1, population: 1)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}


// MARK:- TableView Methods
extension PlanetsViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if planets.count == 0 {
            return 1
        } else {
            return planets.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifiers.planetCell, for: indexPath)
        cell.textLabel?.text = planets[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if planets.count > 0 {
            performSegue(withIdentifier: K.SegueIdentifiers.detailSegue, sender: indexPath)
        } else {
            return
        }
    }
    
    //Navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == K.SegueIdentifiers.detailSegue {
            let planetViewController = segue.destination
                as! DetailViewController
            let indexPath = sender as! IndexPath
               let planet = planets[indexPath.row]
            planetViewController.planet = planet
        }
        
       }
}



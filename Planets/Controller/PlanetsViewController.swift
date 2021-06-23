//
//  ViewController.swift
//  Planets
//
//  Created by M_931521 on 23/06/2021.
//

import UIKit

class PlanetsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var planetManager = PlanetManager()
    var planets: [PlanetModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupCells(tableView: tableView)
        planetManager.delegate = self
        planetManager.fetchPlanets()
    }
    
    //MARK: - Helper Methods
    func setupCells(tableView: UITableView) {
        tableView.register((UINib(nibName: K.CellIdentifiers.nothingFoundCell, bundle: nil)), forCellReuseIdentifier: K.CellIdentifiers.nothingFoundCell)
        tableView.register((UINib(nibName: K.CellIdentifiers.loadingCell, bundle: nil)), forCellReuseIdentifier: K.CellIdentifiers.loadingCell)
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
        
        if planetManager.isLoading {
            return tableView.dequeueReusableCell(withIdentifier: K.CellIdentifiers.loadingCell, for: indexPath) as! LoadingCell
        } else if planets.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier: K.CellIdentifiers.nothingFoundCell, for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifiers.planetCell, for: indexPath)
            cell.textLabel?.text = planets[indexPath.row].name
            return cell
        }
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

// MARK:- Planet Manager Delegate
extension PlanetsViewController: PlanetManagerDelegate {
    
    func didUpdatePlanets(planets: [PlanetModel]) {
        self.planets += planets
        planetManager.performedRequest = true
        planetManager.isLoading = false
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}



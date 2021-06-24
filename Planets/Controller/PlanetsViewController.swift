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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupCells(tableView: tableView)
        loadItems()
        planetManager.delegate = self
        planetManager.fetchPlanets()
    }
}

// MARK:- TableView Methods
extension PlanetsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if planets.count == 0 || planetManager.isLoading {
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
    
    //MARK - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.SegueIdentifiers.detailSegue {
            let planetViewController = segue.destination
                as! DetailViewController
            let indexPath = sender as! IndexPath
            let planet = planets[indexPath.row]
            planetViewController.planet = planet
        }
    }
    
    //MARK - Helper Methods
    func setupCells(tableView: UITableView) {
        tableView.register((UINib(nibName: K.CellIdentifiers.nothingFoundCell, bundle: nil)), forCellReuseIdentifier: K.CellIdentifiers.nothingFoundCell)
        tableView.register((UINib(nibName: K.CellIdentifiers.loadingCell, bundle: nil)), forCellReuseIdentifier: K.CellIdentifiers.loadingCell)
    }
}

// MARK:- Planet Manager Delegate
extension PlanetsViewController: PlanetManagerDelegate {
    
    func didUpdatePlanets(planets: [PlanetModel]) {
        if planets.count > 0 {
            self.planets = planets
            saveItems()
        }
        planetManager.performedRequest = true
        planetManager.isLoading = false
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - Model Manupulation Methods

extension  PlanetsViewController {
    func loadItems(){
        let decoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: dataFilePath!)
            planets = try decoder.decode([PlanetModel].self, from: data)
        } catch {
            print("Error decoding items, \(error)")
        }
        tableView.reloadData()
    }

    func saveItems(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(planets)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding items, \(error)")
        }
    }
}





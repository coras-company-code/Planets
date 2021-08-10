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
        //planetManager.delegate = self
//        planetManager.loadItems(from: dataFilePath)
        
        planetManager.fetchPlanets() { (planets) in //this needs to save and load inside this function
//            self.planets = planets
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
            
            self.assignResidents(to: planets) {(planetsWithResidents) in
                if !planetsWithResidents.isEmpty {
                    print(planetsWithResidents)
                    self.planets = planetsWithResidents
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
               
            }
        }
        
    }
    
    func assignResidents(to planetsWithoutResidents: [PlanetModel], completion: @escaping ([PlanetModel]) -> ())  {
        var planets: [PlanetModel] = []
        for planet in planetsWithoutResidents {
            returnResidentArray(residentURls: planet.residentURLs) { (residents) in
                let newPlanet = self.combine(planet: planet, residents: residents)
                planets.append(newPlanet)
                
            }
        }
        completion(planets)
    }
    
    func returnResidentArray(residentURls: [String], completion: @escaping ([ResidentModel]) -> ()) {
        var residents: [ResidentModel] = []
        for url in residentURls {
            self.planetManager.performResidentRequest(urlString: url) {(resident) in
                if resident != nil {
                residents.append(resident!)
                //print(residents)
                completion(residents)
                }
            }
        }
        //return residents
    }
    
    func combine(planet: PlanetModel, residents: [ResidentModel]) -> PlanetModel {
        let planet = PlanetModel(name: planet.name, climate: planet.climate, gravity: planet.gravity, population: planet.gravity, residentURLs: planet.residentURLs, residentDetails: residents)
        print(planet)
        return planet
    }
    
   
    
    
    
    //fetch them
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
            let planet = planets[indexPath.row]
            cell.textLabel?.text = planet.name
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

//// MARK:- Planet Manager Delegate
//extension PlanetsViewController: PlanetManagerDelegate {
//    //this used to accept nil as a paramenter and then check for it but, this functuon shouldnt be called if its is nil!
//    func didUpdatePlanets(planets: [PlanetModel]) {
//        self.planets = planets
//      //  saveItems(planets, to: dataFilePath)
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
//}







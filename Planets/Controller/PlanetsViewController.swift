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
    var planetsAndResidents: [PlanetModel] = []
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupCells(tableView: tableView)
        //planetManager.delegate = self
//        planetManager.loadItems(from: dataFilePath)
        
        planetManager.fetchPlanets() { (planets) in //this needs to save and load inside this function
            self.planets = planets //this would happen after with new planets (see below comments)
            
            for planet in planets {
                self.planetManager.assignResidents(to: planet) { (planett) in
                    //ideally want to add these new planets to an array, and then after completion, set self.planets to this array
                    //is there away of having a return from the completion??
                    //as i want the array with the new planets with residents to be set as the self.planets *(this needs to happen outside the for loop but after completion)*
                    //then wouldnt need two seperate arrays, i.e planets and planetsWithResidents
                    self.planetsAndResidents.append(planett)
                    //self.planets = self.planetsAndResidents //this works then crashes
                }
                //want the array after the looping and completion to be here to print and set as planets
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
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
            let planet = planetsAndResidents[indexPath.row]//this will the be changed back to planets array
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







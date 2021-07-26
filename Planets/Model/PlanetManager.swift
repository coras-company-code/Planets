//
//  PlanetManager.swift
//  Planets
//
//  Created by M_931521 on 23/06/2021.
//

import Foundation

protocol PlanetManagerDelegate {
    func didUpdatePlanets(planets: [PlanetModel])
}

class PlanetManager {
    var delegate: PlanetManagerDelegate?
    let planetsURL = K.planetsURL
    let pageNumber = 1
    //do i need both of these?:
    var performedRequest = false
    var isLoading = true
   
    func fetchPlanets() {
        let urlString = "\(planetsURL)page=\(pageNumber)"
        performRequest(urlString: urlString) { (parsedDataArray) in
            self.performedRequest = true
            self.isLoading = false
            if let planets = parsedDataArray as? [PlanetModel]  {
            self.delegate?.didUpdatePlanets(planets: planets)
            print(planets)
            }
        }
    }
    
    func performRequest(urlString: String, completion: @escaping ([Any]?) -> Void)  {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    completion(nil)
                    return
                }
                
                if let planets = self.parseJSON(planetsData: data!) {
                    completion(planets)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(planetsData: Data) -> [PlanetModel]? {
        
        var planets: [PlanetModel] = []
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Results.self, from: planetsData)
            
            
            for result in decodedData.results {
                let residents: [ResidentModel] = []
                //let residents = fetchResidents(urls: result.residentURLs) //this will return an array
                let planet = PlanetModel(name: result.name, climate: result.climate, gravity: result.gravity, population: result.gravity, residentURLs: result.residentURLs, residentDetails: residents)
                planets.append(planet)
            }
        } catch {
            print("Parsing Error:\(error)")
        }
        return planets
    }
 
    //MARK: - Model Manupulation Methods

    func loadItems(from filePath: URL?) {
            let decoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: filePath!)
                let planets = try decoder.decode([PlanetModel].self, from: data)
                self.delegate?.didUpdatePlanets(planets: planets)
            } catch {
                print("Error decoding items, \(error)")
            }
        }
}

func saveItems(_ items: [PlanetModel], to filePath: URL? ){
            let encoder = PropertyListEncoder()
            do {
                let data = try encoder.encode(items)
                try data.write(to: filePath!)
            } catch {
                print("Error encoding items, \(error)")
            }
        }

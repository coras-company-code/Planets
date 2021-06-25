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
    var performedRequest = false
    var isLoading = true
   
    func fetchPlanets() {
        let urlString = "\(planetsURL)page=\(pageNumber)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    self.delegate?.didUpdatePlanets(planets: [])
                    return
                }
                
                if let planets = self.parseJSON(planetsData: data!) {
                    self.delegate?.didUpdatePlanets(planets: planets)
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
            
            for planet in decodedData.results {
                planets.append(planet)
            }
            
            
            //            if decodedData.count > 0 {
            //                self.pageNumber += 1
            //                planets += decodedData
            //            } else {
            //                resultsToFetch = false
            //                print("No (additional) results returned")
            //            }
        } catch {
            print("Parsing Error:\(error)")
        }
        
        return planets
        
        //    func fetchAdditonalResults(row: Int, lastPlanet: Int) {
        //        if row == lastPlanet - 1 && resultsToFetch {
        //            fetchPlanets()
        //        }
        //    }
    }
    
}

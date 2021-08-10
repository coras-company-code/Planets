//
//  PlanetManager.swift
//  Planets
//
//  Created by M_931521 on 23/06/2021.
//

import Foundation

protocol PlanetManagerDelegate: AnyObject {
    func didUpdatePlanets(planets: [PlanetModel])
}


//enum NetworkError: Error {
//    case networkError
//}

class PlanetManager {
    weak var delegate: PlanetManagerDelegate?
    let planetsURL = K.planetsURL
    let pageNumber = 1
    var performedRequest = false //Note to self: do i need both of these?
    var isLoading = true
   
    func fetchPlanets(completion: @escaping ([PlanetModel]) -> Void) {
        let urlString = "\(planetsURL)page=\(pageNumber)"
        performRequest(urlString: urlString) { (parsedDataArray) in
            
            
            if let parsedData = parsedDataArray as? [PlanetModel]  {
                completion(parsedData)
            }
//            if let parsedData = parsedDataArray as? [PlanetModel]  {
//                var planets: [PlanetModel] = []
//                //let planet = parsedData[0]
//                for planet in parsedData {
//                    self.fetchResidents(urls: planet.residentURLs) { (residents) in
//                            let planet = PlanetModel(name: planet.name, climate: planet.climate, gravity: planet.gravity, population: planet.gravity, residentURLs: planet.residentURLs, residentDetails: residents)
//                            planets.append(planet)
//                            completion(planets)
//                        print(planets)
//                        //cant access:
//                       // print(planet.residentDetails?[1].gender!)
//                        //print(residents)
//                    }
//                }
//
//            }
            self.performedRequest = true
            self.isLoading = false
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
            
            for planet in decodedData.results {
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
        
        func saveItems(_ items: [PlanetModel], to filePath: URL? ){
            let encoder = PropertyListEncoder()
            do {
                let data = try encoder.encode(items)
                try data.write(to: filePath!)
            } catch {
                print("Error encoding items, \(error)")
            }
        }
    
}

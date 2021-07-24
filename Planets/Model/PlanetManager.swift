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
            //print(planets)
            }
        }
    }
    
    func performRequest(urlString: String, completion: @escaping ([Any]?) -> Void) {
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
                
//                self.parseJSON(planetsData: data!) { (parsedPlanets) in //dont think i need a completion here as it does rely on the server
//                    if let planets = parsedPlanets {
//                        completion(planets)
//                    }
//                }
            }
            task.resume()
        }
    }
    
    func parseJSON(planetsData: Data) -> [PlanetModel]? {
        var planets: [PlanetModel] = []
        var residents: [ResidentModel] = []
        let decoder = JSONDecoder()
        do {
            
            let decodedData = try decoder.decode(Results.self, from: planetsData)
            
            for result in decodedData.results {
                residents.append(fetchResidents(urls: result.residentURLs))
                    print(residents)
                //let residents = [fetchResidents(urls: result.residentURLs)] //will this return a array or single
               // print(residents)
                let planet = PlanetModel(name: result.name, climate: result.climate, gravity: result.gravity, population: result.gravity, residentURLs: result.residentURLs, residentDetails: nil)
                    
                planets.append(planet)
            }
        } catch {
            print("Parsing Planet Error:\(error)")
        }
        return planets
        
        

    }
    
   //func fetchResidents(urls: [String], completion: @escaping (Any?) -> Void) {
    func fetchResidents(urls: [String]) -> ResidentModel {
        var resident: ResidentModel!
            for url in urls {
                let urlString = url
                performResidentRequest(urlString: urlString){ (parsedResident) in
                   
                    
                    resident = parsedResident!
                    
                   
//                    if let resident = parsedResident! {
//                    residents.append(resident)
//                    }
                    //why does the above work and not below
//                    if let resident = parsedResident! {
//                        print("Here")
//                        print(resident)
//                        residents.append(resident)
//                    }
                    
//                    print("Here")
//                    print(residents)
                }
                
            }
        return resident
        }

    
    
  func performResidentRequest(urlString: String, completion: @escaping (ResidentModel?) -> Void) {
        if let url = URL(string: urlString) {

            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url) { (data, response, error) in

                if error != nil {
                    print(error!)
                    completion(nil)
                    return
                }
             
                if let resident = self.parseJSON(residentData: data!) {
                    completion(resident)
                }

            }
            task.resume()
        }
    }
    
    

    func parseJSON(residentData: Data) -> ResidentModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ResidentModel.self, from: residentData)
            let resident = ResidentModel(name: decodedData.name, height: decodedData.height, gender: decodedData.gender)
            return resident
        } catch {
            print("Parsing Resident Error:\(error)")
            return nil
        }
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

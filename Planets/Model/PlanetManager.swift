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
                if let planets =
                    self.parseJSON(planetsData: data!) {
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
                //i would like it to be here they are fetched but for now it is in the planet view controller when you click on a cell
             //  need to fetch residents and then add to the planet model
//                planet.residentsList = fetchResidents(urls: planet.residents)
                planets.append(planet)
            }
        } catch {
            print("Parsing Planet Error:\(error)")
        }
        
        return planets

    }
    
    //func fetchResidents(urls: [String]) -> [ResidentModel] {
    func fetchResidents(urls: [String]) {
        var residents: [ResidentModel] = []
        for url in urls {
            let urlString = url
            performResidentRequest(urlString: urlString)
            //performResidentRequest(urlString: urlString){ (parsedData) in
                //print(parsedData)
                //residents.append(parsedData as! ResidentModel)
            //}
        }
        //return residents
    }

    
    
//    func performResidentRequest(urlString: String, completion: @escaping (Any?) -> Void) {
    func performResidentRequest(urlString: String) {
//
        if let url = URL(string: urlString) {

            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url) { (data, response, error) in

                if error != nil {
                    print(error!)
                    //completion(nil)
                    return
                }
                if let resident = data {
                    print(resident)
                }
//                if let resident =
//                    self.parseJSON(planetsData: data!) {
//                    completion(resident)
                //}
            }
            task.resume()
        }
    }
    
    
//
//    func parseJSON(residentData: Data) -> ResidentModel? {
//
//        let resident: ResidentModel? = nil
//        let decoder = JSONDecoder()
//        do {
//
//            let decodedData = try decoder.decode(ResidentModel.self, from: residentData)
//            print(decodedData)
//
//        } catch {
//            print("Parsing Resident Error:\(error)")
//        }
//
//        return resident
//
//    }
    
    
    
    
    
    
    
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

//
//  ResidentManager.swift
//  Planets
//
//  Created by M_931521 on 26/07/2021.
//

import Foundation

extension PlanetManager {
//
//    func fetchResidents(url: String, completion: @escaping (ResidentModel) -> ()) {
//        let urlString = url
//        performRequest(urlString: urlString) { (resident) in
//            completion(resident)
//        }
            
//            for url in urls {
//                let urlString = url
//                performResidentRequest(urlString: urlString)  { (resident) in
//                    var residents: [ResidentModel] = []
//
//                    if resident != nil {
//                        residents.append(resident!)
//
//                    }
//                    completion(residents)
//
//                }
//            }
    //}
    
    func performResidentRequest(urlString: String, completion: @escaping (ResidentModel?) -> ())  {

        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    completion(nil)
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
    
  
    
    func returnResidentArray(residentURls: [String], completion: @escaping ([ResidentModel]) -> ()) {
        var residents: [ResidentModel] = []
        for url in residentURls {
            self.performResidentRequest(urlString: url) {(resident) in
                if resident != nil {
                residents.append(resident!)
                //print(residents)
                completion(residents)
                }
            }
        }
        //return residents
    }
    
//    func combine(planet: PlanetModel, residents: [ResidentModel]) -> PlanetModel {
//        let planet = PlanetModel(name: planet.name, climate: planet.climate, gravity: planet.gravity, population: planet.gravity, residentURLs: planet.residentURLs, residentDetails: residents)
//        print(planet)
//        return planet
//    }
    
    func combine(planet: PlanetModel, residents: [ResidentModel]) -> PlanetModel {
        let planet = PlanetModel(name: planet.name, climate: planet.climate, gravity: planet.gravity, population: planet.gravity, residentURLs: planet.residentURLs, residentDetails: residents)
        //print(planet)
        return planet
    }
    
    func assignResidents(to planetsWithoutResidents: [PlanetModel])  {
        //var planets: [PlanetModel] = []
        var residents: [ResidentModel] = []
        for planet in planetsWithoutResidents {
            planetManager.returnResidentArray(residentURls: planet.residentURLs) { (residentss) in
                residents = residentss
                let newPlanet = self.planetManager.combine(planet: planet, residents: residentss)
                print(self.planets)
                self.planets.append(newPlanet)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
       
       // print(planets)
        //return planets
        
    }
}

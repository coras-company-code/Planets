//
//  ResidentManager.swift
//  Planets
//
//  Created by M_931521 on 26/07/2021.
//

import Foundation

extension PlanetManager {

    
    //This accepts one planet and returns as a new planetModel - leaves the looping through the planets for where its called
    // as looping was returning multiple of each planet 
    func assignResidents(to planet: PlanetModel, completion: @escaping (PlanetModel) -> ())   {
        //var planets: [PlanetModel] = []
        fetchReidents(residentURls: planet.residentURLs) { (parsedResidents) in
            let newPlanet = self.combine(planet: planet, residents: parsedResidents)
            //print(newPlanet)
            completion(newPlanet)
            
        }
    }
    
    //This one accepts all the planets, and returns all the new planets in an array
    func assignResidents(to planets: [PlanetModel], completion: @escaping ([PlanetModel]) -> ())   {
        var planets: [PlanetModel] = []
        
        for planet in planets {
            fetchReidents(residentURls: planet.residentURLs) { (parsedResidents) in
                let newPlanet = self.combine(planet: planet, residents: parsedResidents)
                planets.append(newPlanet)
                completion(planets)
            }
        }
    }
    
    //return array of resident Models (objects)
    func fetchReidents(residentURls: [String], completion: @escaping ([ResidentModel]) -> ()) {
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
    }
    
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
    

}

//
//  ResidentManager.swift
//  Planets
//
//  Created by M_931521 on 26/07/2021.
//

import Foundation

extension PlanetManager {
  
    func fetchResidents(urls: [String], completion: @escaping ([ResidentModel]?) -> ()) {
       
            for url in urls {
                let urlString = url
                performResidentRequest(urlString: urlString)  { (resident) in
                    var residents: [ResidentModel] = []
                    if resident != nil {
                        residents.append(resident!) //print(resident!) residents are adding to the array
                    }
                    completion(residents)
                }
            }
    }
    
    //Before
//    func fetchResidents(urls: [String]) -> [ResidentModel] {
//        var residents: [ResidentModel] = []
//            for url in urls {
//                let urlString = url
//                performResidentRequest(urlString: urlString)  { (resident) in
//                    if resident != nil {
//                        residents.append(resident!) //print(resident!) residents are adding to the array
//                    }
//                }
//            }
//        print(residents) //how do i get whats above out to here? (i.e the apending residents)
//        return residents
//    }
    
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
        
}

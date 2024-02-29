//
//  ViewModel.swift
//  GamgeStream
//
//  Created by Tulio Rangel on 21/12/22.
//

import Foundation

class ViewModel: ObservableObject {
 
// 1.
    @Published var gamesInfo = [Game]()
  
    
    init() {
        let url = URL(string: "https://gamestreamapi.herokuapp.com/api/games")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // 2.
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            do {
                if let jsonData = data {
                    // 3.
                    print("tamañoJSON: \(jsonData)")
                    
                    let decodedData = try JSONDecoder().decode([Game].self, from: jsonData)
                    
                    print("JSONDecodificado: \(decodedData)")
                    
                    DispatchQueue.main.async {
                        //Llenar propiedad games info con el arreglo de datos decodificados de nuestro json original
                        self.gamesInfo.append(contentsOf: decodedData)
                       
                    }
                    
                    
                } else {
                    print("No existen datos en el json recuperado")
                }
            } catch {
                print("Error: \(error)")
            }
        }.resume()
    }
    

}

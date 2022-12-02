//
//  Networking.swift
//  Code9-Mobile-2022-iOS
//
//  Created by Zolt Varga on 4/24/22.
//

import UIKit

// All what is connected with internet is going over this class.
class Networking {
    
    // MARK: - Public interface
    
    func fetchClients(completion: @escaping ([Client]?) -> Void) {
        // 1. Read JSON file from disk what simulate fetching data from internet/url/API
        if let url = Bundle.main.url(forResource: "generated", withExtension: "json") {
            do {
                // 2. Try to decode the responce to swift readable code
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Client].self, from: data)
                
                // 3. Simulate the async response with some delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    completion(jsonData)
                }
            } catch {
                // 4. If fetch got error return it
                print("error:\(error)")
                completion(nil)
            }
        } else {
            // 5. If reading the data from disk failed
            completion(nil)
        }
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            print("Download Finished of image: \(response?.suggestedFilename ?? url.lastPathComponent)")
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
    
    // MARK: - Private helper methods
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        // 1. iOS native way to download 
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

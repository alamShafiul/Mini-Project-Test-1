//
//  ApiClass.swift
//  Test Project - 1
//
//  Created by Admin on 12/1/23.
//

import Foundation

class ApiCaller {
    static let shared = ApiCaller()
    private init() {}
    
    var delegate: ReloadProtocol?
    
    func getDataFromAPI(category: String?) -> NewsModel? {
        var result: NewsModel!
        var tailURL = ""
        if let category = category {
            tailURL = "&category=\(category)"
        }
        guard let url = URL(string: Constants.apiLink+tailURL) else {
            return nil
        }
        
        let session = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                guard let data = data else { return }
                do {
                    result = try JSONDecoder().decode(NewsModel.self, from: data)
                    self?.delegate?.reloadNews(val: result.articles)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        session.resume()
        
        return result
        
    }
}

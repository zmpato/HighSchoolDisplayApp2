//
//  NetworkService.swift
//  HighSchoolDisplayApp
//
//  Created by Zak Mills on 1/25/24.
//

import Foundation

enum ServiceErrors: Error {
    case APICallError
    case URLError
}

class NetworkService {
    
    func getSchoolInfo() async throws -> [SchoolModel] {
        let endpoint = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
        guard let url = URL(string: endpoint) else { throw ServiceErrors.URLError }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([SchoolModel].self, from: data)
            
        } catch {
            throw ServiceErrors.APICallError
        }
    }
}

extension ServiceErrors: LocalizedError {
    var description: String? {
        switch self {
        case .APICallError:
            return "API Call Error"
            
        case .URLError:
            return "URL ERROR"
            
        }
    }
}

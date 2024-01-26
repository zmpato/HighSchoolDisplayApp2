//
//  MainViewModel.swift
//  HighSchoolDisplayApp
//
//  Created by Zak Mills on 1/25/24.
//

import Foundation
import SwiftUI

@MainActor
class MainViewModel: ObservableObject {
    
    enum State {
        case unknown
        case loading
        case success(data: [SchoolModel])
        case failure(error: Error)
    }
    @Published private(set) var state: State = .unknown
    var model = SchoolModel.self
    let networkService: NetworkService
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchViewData() async {
        self.state = .loading
        Task {
            do {
                let data = try await networkService.getSchoolInfo()
                self.state = .success(data: data)
            } catch {
                self.state = .failure(error: ServiceErrors.APICallError)
            }
        }
    }
}


//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

// MARK: - ProfileService

protocol ProfileService: AnyObject {
    func getProfile(completion: ((Result<Profile, Error>) -> Void)?)
}

// MARK: - ProfileServiceImpl

final class ProfileServiceImpl: ProfileService {
    // MARK: Lifecycle

    init(networkProvider: NetworkProvider, dataService: DataService) {
        self.networkProvider = networkProvider
        self.dataService = dataService
    }

    // MARK: Internal

    func getProfile(completion: ((Result<Profile, Error>) -> Void)?) {
        guard let userId = Int(dataService.appState.accessToken ?? "") else {
            return
        }

        networkProvider.make(
            UserRequest.getProfile(id: userId),
            completion: { (result: Result<Profile, Error>) in
                switch result {
                case let .success(data):
                    completion?(Result.success(data))
                case let .failure(error):
                    completion?(Result.failure(error))
                }
            },
            keyDecodingStrategy: .convertFromSnakeCase
        )
    }

    // MARK: Private

    private let networkProvider: NetworkProvider

    private let dataService: DataService
}

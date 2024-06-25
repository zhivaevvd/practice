
import Foundation

protocol ProfileService: AnyObject {
    func getProfile(completion: ((Result<Profile, Error>) -> Void)?)
}

final class ProfileServiceImpl: ProfileService {
    init(networkProvider: NetworkProvider, dataService: DataService) {
        self.networkProvider = networkProvider
        self.dataService = dataService
    }

    func getProfile(completion: ((Result<Profile, Error>) -> Void)?) {
//        guard let userId = Int(dataService.appState.accessToken ?? "") else {
//            return
//        }
//
        networkProvider.mock(
            UserRequest.getProfile(id: 1),
            completion: { (result: Result<Profile, Error>) in
                switch result {
                case let .success(data):
                    completion?(Result.success(data))
                case let .failure(error):
                    completion?(Result.failure(error))
                }
            },
            keyDecodingStrategy: .useDefaultKeys
        )
    }

    private let networkProvider: NetworkProvider

    private let dataService: DataService
}

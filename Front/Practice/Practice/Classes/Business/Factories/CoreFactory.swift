
import Foundation

enum CoreFactory {
    static let requestBuilder: RequestBuilder = RequestBuilderImpl(dataService: Self.dataService)

    static let networkProvider: NetworkProvider = NetworkProviderImpl(requestBuilder: requestBuilder)

    static let snacker: Snacker = SnackerImpl()

    static let dataService: DataService = DataServiceImpl()

    static func buildAuthService() -> AuthService {
        AuthServiceImpl(networkProvider: Self.networkProvider, dataService: Self.dataService)
    }

    static func buildScheduleService() -> ScheduleService {
        ScheduleServiceImpl(networkProvider: Self.networkProvider, dataService: Self.dataService)
    }

    static func buildCreateScheduleService() -> CreateScheduleService {
        CreateScheduleServiceImpl(networkProvider: Self.networkProvider, dataService: Self.dataService)
    }

    static func buildProfileService() -> ProfileService {
        ProfileServiceImpl(networkProvider: Self.networkProvider, dataService: Self.dataService)
    }
}

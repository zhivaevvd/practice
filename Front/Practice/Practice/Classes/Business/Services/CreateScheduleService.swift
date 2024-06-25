
import Foundation

// MARK: - HistoryService

protocol CreateScheduleService: AnyObject {

}

// MARK: - CatalogServiceImpl

final class CreateScheduleServiceImpl: CreateScheduleService {

    // MARK: Lifecycle

    init(networkProvider: NetworkProvider, dataService: DataService) {
        self.networkProvider = networkProvider
        self.dataService = dataService
    }

    // MARK: Private

    private let networkProvider: NetworkProvider

    private let dataService: DataService
}

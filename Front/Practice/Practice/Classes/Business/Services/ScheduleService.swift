
import Foundation

// MARK: - CatalogService

protocol ScheduleService: AnyObject {
    func getSchedule(for groupId: Int?, completion: ((Result<[Schedule], Error>) -> Void)?)
    func getGroups(for teacherId: Int?, completion: ((Result<GroupsResponse, Error>) -> Void)?)
    func getTeachers(completion: ((Result<TeachersResponse, Error>) -> Void)?)
    func getLessons(for teacherId: Int?, completion: ((Result<LessonsResponse, Error>) -> Void)?)
    func getClasses(completion: ((Result<ClassesResponse, Error>) -> Void)?)
}

// MARK: - CatalogServiceImpl

final class ScheduleServiceImpl: ScheduleService {
    // MARK: Lifecycle

    init(networkProvider: NetworkProvider, dataService: DataService) {
        self.networkProvider = networkProvider
        self.dataService = dataService
    }

    // MARK: Internal

    func getSchedule(for groupId: Int?, completion: ((Result<[Schedule], Error>) -> Void)?) {
        networkProvider.mock(ScheduleRequest.getSchedule(groupId: groupId)) { (result: Result<[Schedule], Error>) in
            switch result {
            case .success:
                completion?(result)
            case let .failure(error):
                completion?(Result.failure(error))
            }
        }
    }
    
    func getGroups(for teacherId: Int?, completion: ((Result<GroupsResponse, Error>) -> Void)?) {
        networkProvider.mock(ScheduleRequest.getGroups(teacherId: teacherId)) { (result: Result<GroupsResponse, Error>) in
            switch result {
            case .success:
                completion?(result)
            case let .failure(error):
                completion?(Result.failure(error))
            }
        }
    }
    
    func getTeachers(completion: ((Result<TeachersResponse, Error>) -> Void)?) {
        networkProvider.mock(ScheduleRequest.getTeachers) { (result: Result<TeachersResponse, Error>) in
            switch result {
            case .success:
                completion?(result)
            case let .failure(error):
                completion?(Result.failure(error))
            }
        }
    }
    
    func getLessons(for teacherId: Int?, completion: ((Result<LessonsResponse, Error>) -> Void)?) {
        networkProvider.mock(ScheduleRequest.getLessons(teacherId: teacherId)) { (result: Result<LessonsResponse, Error>) in
            switch result {
            case .success:
                completion?(result)
            case let .failure(error):
                completion?(Result.failure(error))
            }
        }
    }
    
    func getClasses(completion: ((Result<ClassesResponse, Error>) -> Void)?) {
        networkProvider.mock(ScheduleRequest.classes) { (result: Result<ClassesResponse, Error>) in
            switch result {
            case .success:
                completion?(result)
            case let .failure(error):
                completion?(Result.failure(error))
            }
        }
    }

    // MARK: Private

    private let networkProvider: NetworkProvider

    private let dataService: DataService
}

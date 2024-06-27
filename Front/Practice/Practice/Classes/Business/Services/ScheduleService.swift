//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

// MARK: - ScheduleService

protocol ScheduleService: AnyObject {
    func getSchedule(for groupId: Int?, completion: ((Result<[Schedule], Error>) -> Void)?)
    func getGroups(completion: ((Result<GroupsResponse, Error>) -> Void)?)
    func getTeachers(completion: ((Result<TeachersResponse, Error>) -> Void)?)
    func getLessons(for teacherId: Int?, completion: ((Result<LessonsResponse, Error>) -> Void)?)
    func getClasses(completion: ((Result<ClassesResponse, Error>) -> Void)?)
    func createSchedule(payload: CreateSchedulePayload, completion: ((Result<SuccessResponse, Error>) -> Void)?)
    func editSchedule(scheduleId: Int, payload: CreateSchedulePayload, completion: ((Result<SuccessResponse, Error>) -> Void)?)
    func deleteSchedule(id: Int, completion: ((Result<SuccessResponse, Error>) -> Void)?)
}

// MARK: - ScheduleServiceImpl

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

    func getGroups(completion: ((Result<GroupsResponse, Error>) -> Void)?) {
        networkProvider.make(ScheduleRequest.getGroups) { (result: Result<GroupsResponse, Error>) in
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

    func createSchedule(payload: CreateSchedulePayload, completion: ((Result<SuccessResponse, Error>) -> Void)?) {
        networkProvider.mock(ScheduleRequest.createSchedule(payload: payload)) { (result: Result<SuccessResponse, Error>) in
            switch result {
            case .success:
                completion?(result)
            case let .failure(error):
                completion?(Result.failure(error))
            }
        }
    }
    
    func editSchedule(scheduleId: Int, payload: CreateSchedulePayload, completion: ((Result<SuccessResponse, Error>) -> Void)?) {
        networkProvider.mock(ScheduleRequest.editSchedule(scheduleId: scheduleId, payload: payload)) { (result: Result<SuccessResponse, Error>) in
            switch result {
            case .success:
                completion?(result)
            case let .failure(error):
                completion?(Result.failure(error))
            }
        }
    }
    
    func deleteSchedule(id: Int, completion: ((Result<SuccessResponse, Error>) -> Void)?) {
        networkProvider.mock(ScheduleRequest.deleteSchedule(scheduleId: id)) { (result: Result<SuccessResponse, Error>) in
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

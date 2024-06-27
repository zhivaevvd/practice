//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import AutoLayoutSugar
import UIKit

// MARK: - CreateScheduleVC

final class CreateScheduleVC: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        if editableSchedule == nil {
            title = L10n.CreateSchedule.title
        } else {
            title = L10n.CreateSchedule.editTitle
        }
        
        mainView.setDeleteButtonHidden(editableSchedule == nil)
        
        navigationController?.navigationBar.prefersLargeTitles = false

        view.addSubview(mainView)
        mainView.safeArea { $0.pinToSuperview(with: .init(top: 40, left: 20, bottom: 0, right: 20)) }
        

        configureActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.setLessonsEnabled(false)
        
        getGroups()
        getClasses()
        
        if editableSchedule == nil {
            getTeachers()
        } else {
            mainView.setTeacherEnable(false)
            mainView.setLessonsEnabled(true)
            getLessons(teacherId: editableSchedule?.teacher.id)
            
            let payload: CreateSchedule = .init(
                teacher: editableSchedule?.teacher,
                lesson: lessons.first(where: { $0.id == editableSchedule?.lessonId }),
                class: editableSchedule?.class,
                group: editableSchedule?.group,
                date: editableSchedule?.date,
                pairNumber: editableSchedule?.pairNumber,
                scheduleId: editableSchedule?.scheduleId
            )

            mainView.model = payload
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mainView.model.reset()
    }

    // MARK: Internal

    var scheduleService: ScheduleService?

    var snacker: Snacker?

    var dataService: DataService?
    
    var editableSchedule: Schedule?

    // MARK: Private

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.translatesAutoresizingMaskIntoConstraints = false

        return datePicker
    }()

    private let mainView: CreateScheduleView = {
        let view = CreateScheduleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var teachers: [Teacher] = []
    private var lessons: [Lesson] = []
    private var groups: [Group] = []
    private var classes: [Class] = []

    private var pairs: [Pair] = [
        .init(id: 1),
        .init(id: 2),
        .init(id: 3),
        .init(id: 4),
        .init(id: 5),
        .init(id: 6),
        .init(id: 7),
    ]

    private func getTeachers() {
        scheduleService?.getTeachers(completion: { [weak self] result in
            switch result {
            case let .success(response):
                self?.teachers = response.teachers
            case .failure:
                self?.snacker?.show(snack: L10n.Schedule.teachersError, with: .error)
            }
        })
    }

    private func getLessons(teacherId: Int? = nil) {
        scheduleService?.getLessons(for: teacherId, completion: { [weak self] result in
            switch result {
            case let .success(response):
                self?.lessons = response.lessons
            case .failure:
                self?.snacker?.show(snack: L10n.Schedule.lessonsError, with: .error)
            }
        })
    }

    private func getGroups() {
        scheduleService?.getGroups(completion: { [weak self] result in
            switch result {
            case let .success(response):
                self?.groups = response.groups
            case .failure:
                self?.snacker?.show(snack: L10n.Schedule.groupsError, with: .error)
            }
        })
    }

    private func getClasses() {
        scheduleService?.getClasses(completion: { [weak self] result in
            switch result {
            case let .success(response):
                self?.classes = response.classes
            case .failure:
                self?.snacker?.show(snack: L10n.Schedule.classesError, with: .error)
            }
        })
    }

    private func saveSchedule(with payload: CreateSchedule) {
        guard mainView.model.validate() else {
            snacker?.show(snack: L10n.Common.fieldsError, with: .error)
            return
        }

        let body: CreateSchedulePayload = CreateSchedulePayload(
            teacherId: payload.teacher!.id,
            classId: payload.class!.id,
            groupId: payload.group!.id,
            lessonId: payload.lesson!.id,
            date: payload.date!,
            pairNumber: payload.pairNumber!
        )
        
        if editableSchedule == nil {
            createSchedule(with: body)
        } else {
            guard let scheduleId = editableSchedule?.scheduleId else {
                return
            }
            editSchedule(with: body, and: scheduleId)
        }
    }
    
    private func deleteSchedule(id: Int) {
        scheduleService?.deleteSchedule(id: id, completion: { [weak self] result in
            self?.handleSuccessResult(result, forceModelReset: true)
        })
    }
    
    private func createSchedule(with body: CreateSchedulePayload) {
        scheduleService?.createSchedule(payload: body, completion: { [weak self] result in
            self?.handleSuccessResult(result)
        })
    }
    
    private func editSchedule(with body: CreateSchedulePayload, and id: Int) {
        scheduleService?.editSchedule(scheduleId: id, payload: body, completion: { [weak self] result in
            self?.handleSuccessResult(result)
        })
    }
    
    private func handleSuccessResult(_ result: Result<SuccessResponse, Error>, forceModelReset: Bool = false) {
        switch result {
        case let .success(response):
            if response.success {
                snacker?.show(
                    snack: L10n.Common.success,
                    with: .init(textColor: .white, backgroundColor: .green, font: .systemFont(ofSize: 14))
                )
                if editableSchedule == nil || forceModelReset {
                    mainView.model.reset()
                }
            } else if let error = response.error {
                snacker?.show(snack: error, with: .error)
            } else {
                snacker?.show(snack: L10n.Common.error, with: .error)
            }
        case let .failure(error):
            snacker?.show(snack: error.localizedDescription, with: .error)
        }
    }

    private func configureActions() {
        configureTeacherTap()
        configureLessonTap()
        configureGroupTap()
        configureClassTap()
        configureDateTap()
        configurePairTap()
        configureSaveAction()
    }
}

// MARK: Configure user actions

private extension CreateScheduleVC {
    func configureTeacherTap() {
        mainView.teacherTapAction = { [weak self] selected in
            guard let self = self else { return }
            let sheet = SelectSheet()
            sheet.selected = selected
            sheet.model = self.teachers
            sheet.tapAction = { item in
                guard let teacher = item as? Teacher else {
                    return
                }

                self.presentedViewController?.dismiss(animated: true, completion: {
                    self.mainView.model.teacher = teacher
                    self.getLessons(teacherId: teacher.id)
                    self.mainView.setLessonsEnabled(true)
                })
            }

            self.present(VCFactory.buildBottomSheetController(with: sheet, onEveryTapOut: {
                self.presentedViewController?.dismiss(animated: true)
            }), animated: true)
        }
    }

    func configureLessonTap() {
        mainView.lessonTapAction = { [weak self] selected in
            guard let self = self else { return }
            let sheet = SelectSheet()
            sheet.selected = selected
            sheet.model = self.lessons
            sheet.tapAction = { item in
                guard let lesson = item as? Lesson else {
                    return
                }

                self.presentedViewController?.dismiss(animated: true, completion: {
                    self.mainView.model.lesson = lesson
                })
            }

            self.present(VCFactory.buildBottomSheetController(with: sheet, onEveryTapOut: {
                self.presentedViewController?.dismiss(animated: true)
            }), animated: true)
        }
    }

    func configureGroupTap() {
        mainView.groupTapAction = { [weak self] selected in
            guard let self = self else { return }
            let sheet = SelectSheet()
            sheet.selected = selected
            sheet.model = self.groups
            sheet.tapAction = { item in
                guard let group = item as? Group else {
                    return
                }

                self.presentedViewController?.dismiss(animated: true, completion: {
                    self.mainView.model.group = group
                })
            }

            self.present(VCFactory.buildBottomSheetController(with: sheet, onEveryTapOut: {
                self.presentedViewController?.dismiss(animated: true)
            }), animated: true)
        }
    }

    func configureClassTap() {
        mainView.classTapAction = { [weak self] selected in
            guard let self = self else { return }
            let sheet = SelectSheet()
            sheet.selected = selected
            sheet.model = self.classes
            sheet.tapAction = { item in
                guard let classroom = item as? Class else {
                    return
                }

                self.presentedViewController?.dismiss(animated: true, completion: {
                    self.mainView.model.class = classroom
                })
            }

            self.present(VCFactory.buildBottomSheetController(with: sheet, onEveryTapOut: {
                self.presentedViewController?.dismiss(animated: true)
            }), animated: true)
        }
    }

    func configureDateTap() {
        mainView.dateTapAction = { [weak self] in
            guard let self = self else { return }
            let containerView: UIView = {
                let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            containerView.addSubview(datePicker)
            datePicker.pinToSuperview()
            present(
                VCFactory.buildBottomSheetController(
                    with: containerView,
                    onEveryTapOut: {
                        self.presentedViewController?.dismiss(animated: true)
                        self.mainView.model.date = self.datePicker.date
                    }
                ),
                animated: true
            )
        }
    }

    func configurePairTap() {
        mainView.pairNumberAction = { [weak self] pairNumber in
            guard let self = self else { return }

            var selected: Pair?
            if let pairNumber {
                selected = .init(id: pairNumber)
            }

            let sheet = SelectSheet()
            sheet.selected = selected
            sheet.model = self.pairs
            sheet.tapAction = { item in
                guard let pair = (item as? Pair)?.id else {
                    return
                }

                self.presentedViewController?.dismiss(animated: true, completion: {
                    self.mainView.model.pairNumber = pair
                })
            }

            self.present(
                VCFactory.buildBottomSheetController(
                    with: sheet,
                    onEveryTapOut: {
                        self.presentedViewController?.dismiss(animated: true)
                    }
                ),
                animated: true
            )
        }
    }

    func configureSaveAction() {
        mainView.saveAction = { [weak self] payload in
            self?.saveSchedule(with: payload)
        }
        
        mainView.deleteAction = { [weak self] id in
            self?.deleteSchedule(id: id)
        }
    }
}

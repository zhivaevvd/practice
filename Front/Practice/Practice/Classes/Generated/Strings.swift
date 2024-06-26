//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// MARK: - L10n

// swiftlint:disable superfluous_disable_command file_length implicit_return

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
    internal enum Action {
        /// Назад
        internal static let back = L10n.tr("Localizable", "action.back")
        /// Отменить
        internal static let cancel = L10n.tr("Localizable", "action.cancel")
        /// Удаление
        internal static let delete = L10n.tr("Localizable", "action.delete")
        /// Удалить
        internal static let deleteAction = L10n.tr("Localizable", "action.deleteAction")
        /// Ошибка
        internal static let error = L10n.tr("Localizable", "action.error")
        /// Вы не можете удалить активный заказ
        internal static let errorMsg = L10n.tr("Localizable", "action.errorMsg")
        /// Выход
        internal static let exit = L10n.tr("Localizable", "action.exit")
        /// Выйти
        internal static let exitAction = L10n.tr("Localizable", "action.exitAction")
        /// Ок
        internal static let ok = L10n.tr("Localizable", "action.ok")
    }

    internal enum Auth {
        /// Войти
        internal static let action = L10n.tr("Localizable", "auth.action")
        /// Логин
        internal static let login = L10n.tr("Localizable", "auth.login")
        /// Пароль
        internal static let password = L10n.tr("Localizable", "auth.password")
    }

    internal enum Common {
        /// Поле пустое
        internal static let emptyField = L10n.tr("Localizable", "common.emptyField")
        /// Что-то пошло не так \n Повторите попытку позже
        internal static let error = L10n.tr("Localizable", "common.error")
        /// Ошибка
        internal static let errorSimple = L10n.tr("Localizable", "common.errorSimple")
        /// Одно или несколько полей не заполненно
        internal static let fieldsError = L10n.tr("Localizable", "common.fieldsError")
        /// Сохранить
        internal static let save = L10n.tr("Localizable", "common.save")
        /// Успешно!
        internal static let success = L10n.tr("Localizable", "common.success")
    }

    internal enum CreateSchedule {
        /// Составить расписание
        internal static let title = L10n.tr("Localizable", "createSchedule.title")
    }

    internal enum Profile {
        /// Профиль
        internal static let title = L10n.tr("Localizable", "profile.title")
    }

    internal enum Question {
        /// Хотите удалить заказ из истории?
        internal static let delete = L10n.tr("Localizable", "question.delete")
        /// Хотите выйти?
        internal static let exit = L10n.tr("Localizable", "question.exit")
    }

    internal enum Schedule {
        /// Не удалось загрузить аудитории
        internal static let classesError = L10n.tr("Localizable", "schedule.classesError")
        /// Аудитория:
        internal static let classroom = L10n.tr("Localizable", "schedule.classroom")
        /// Дата:
        internal static let date = L10n.tr("Localizable", "schedule.date")
        /// Группа:
        internal static let group = L10n.tr("Localizable", "schedule.group")
        /// Не удалось загрузить группы
        internal static let groupsError = L10n.tr("Localizable", "schedule.groupsError")
        /// Дисциплина:
        internal static let lesson = L10n.tr("Localizable", "schedule.lesson")
        /// Не удалось загрузить дисциплины
        internal static let lessonsError = L10n.tr("Localizable", "schedule.lessonsError")
        /// Пара:
        internal static let pair = L10n.tr("Localizable", "schedule.pair")
        /// Преподаватель:
        internal static let teacher = L10n.tr("Localizable", "schedule.teacher")
        /// Не удалось загрузить преподавателей
        internal static let teachersError = L10n.tr("Localizable", "schedule.teachersError")
        /// Расписание
        internal static let title = L10n.tr("Localizable", "schedule.title")
    }

    /// Plural format key: "%#@VARIABLE@"
    internal static func ageValue(_ p1: Int) -> String {
        L10n.tr("Localizable", "age-value", p1)
    }
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

// MARK: - BundleToken

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
            return Bundle.module
        #else
            return Bundle(for: BundleToken.self)
        #endif
    }()
}

// swiftlint:enable convenience_type

// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
    /// Plural format key: "%#@VARIABLE@"
    internal static func ageValue(_ p1: Int) -> String {
        return L10n.tr("Localizable", "age-value", p1)
    }

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
        /// Аудитория:
        internal static let classroom = L10n.tr("Localizable", "schedule.classroom")
        /// Дисциплина:
        internal static let lesson = L10n.tr("Localizable", "schedule.lesson")
        /// Преподаватель:
        internal static let teacher = L10n.tr("Localizable", "schedule.teacher")
        /// Расписание
        internal static let title = L10n.tr("Localizable", "schedule.title")
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

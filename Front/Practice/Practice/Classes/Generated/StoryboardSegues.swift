//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// MARK: - StoryboardSegue

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardSegue {}

// MARK: - SegueType

// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

internal protocol SegueType: RawRepresentable {}

internal extension UIViewController {
    func perform<S: SegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
        let identifier = segue.rawValue
        performSegue(withIdentifier: identifier, sender: sender)
    }
}

internal extension SegueType where RawValue == String {
    init?(_ segue: UIStoryboardSegue) {
        guard let identifier = segue.identifier else { return nil }
        self.init(rawValue: identifier)
    }
}

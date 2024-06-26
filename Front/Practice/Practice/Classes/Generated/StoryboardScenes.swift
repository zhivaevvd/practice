//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// MARK: - StoryboardScene

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length implicit_return

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
    internal enum Auth: StoryboardType {
        internal static let storyboardName = "Auth"

        internal static let initialScene = InitialSceneType<AuthVC>(storyboard: Auth.self)

        internal static let auth = SceneType<AuthVC>(storyboard: Auth.self, identifier: "Auth")
    }

    internal enum CreateSchedule: StoryboardType {
        internal static let storyboardName = "CreateSchedule"

        internal static let initialScene = InitialSceneType<UIKit.UINavigationController>(storyboard: CreateSchedule.self)

        internal static let createSchedule = SceneType<UIKit.UINavigationController>(
            storyboard: CreateSchedule.self,
            identifier: "CreateSchedule"
        )
    }

    internal enum Profile: StoryboardType {
        internal static let storyboardName = "Profile"

        internal static let initialScene = InitialSceneType<UIKit.UINavigationController>(storyboard: Profile.self)

        internal static let profile = SceneType<UIKit.UINavigationController>(storyboard: Profile.self, identifier: "Profile")
    }

    internal enum Schedule: StoryboardType {
        internal static let storyboardName = "Schedule"

        internal static let initialScene = InitialSceneType<UIKit.UINavigationController>(storyboard: Schedule.self)

        internal static let schedule = SceneType<UIKit.UINavigationController>(storyboard: Schedule.self, identifier: "Schedule")
    }

    internal enum Storyboard: StoryboardType {
        internal static let storyboardName = "Storyboard"
    }

    internal enum TabBar: StoryboardType {
        internal static let storyboardName = "TabBar"

        internal static let initialScene = InitialSceneType<TabBarVC>(storyboard: TabBar.self)

        internal static let tabBar = SceneType<TabBarVC>(storyboard: TabBar.self, identifier: "TabBar")
    }
}

// MARK: - StoryboardType

// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

internal protocol StoryboardType {
    static var storyboardName: String { get }
}

internal extension StoryboardType {
    static var storyboard: UIStoryboard {
        let name = storyboardName
        return UIStoryboard(name: name, bundle: BundleToken.bundle)
    }
}

// MARK: - SceneType

internal struct SceneType<T: UIViewController> {
    internal let storyboard: StoryboardType.Type
    internal let identifier: String

    internal func instantiate() -> T {
        let identifier = self.identifier
        guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
        }
        return controller
    }

    @available(iOS 13.0, tvOS 13.0, *)
    internal func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
        storyboard.storyboard.instantiateViewController(identifier: identifier, creator: block)
    }
}

// MARK: - InitialSceneType

internal struct InitialSceneType<T: UIViewController> {
    internal let storyboard: StoryboardType.Type

    internal func instantiate() -> T {
        guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
            fatalError("ViewController is not of the expected class \(T.self).")
        }
        return controller
    }

    @available(iOS 13.0, tvOS 13.0, *)
    internal func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
        guard let controller = storyboard.storyboard.instantiateInitialViewController(creator: block) else {
            fatalError("Storyboard \(storyboard.storyboardName) does not have an initial scene.")
        }
        return controller
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

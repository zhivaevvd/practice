//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

protocol UILoadable: AnyObject {
    func startLoading(with parameters: LoaderParameters)
    func stopLoadingProgress()
}

//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

struct ErrorResponse: Decodable {
    let message: String
    let fields: [FieldError]?
}

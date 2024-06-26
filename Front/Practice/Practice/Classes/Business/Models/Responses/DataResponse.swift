//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

struct DataResponse<T: Decodable>: Decodable {
    let data: T
}

//
//  LessonsResponse.swift
//  Practice
//
//  Created by Влад Живаев on 25.06.2024.
//

import Foundation

struct LessonsResponse: Decodable {
    let lessons: [Lesson]
}

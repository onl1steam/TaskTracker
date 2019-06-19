//
//  Status.swift
//  TaskTracker
//
//  Created by Рыжков Артем on 19.06.2019.
//  Copyright © 2019 Рыжков Артем. All rights reserved.
//

import Foundation

enum Status: String {
    case all = "Все"
    case new = "Новая"
    case inProgress = "В процессе"
    case finished = "Завершена"
    
    var presentationString: String {
        switch self {
        case .all:
            return "Все"
        case .new:
            return "Новые"
        case .inProgress:
            return "В процессе"
        case .finished:
            return "Завершенные"
        }
    }
    
}

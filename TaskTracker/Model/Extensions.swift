//
//  Extensions.swift
//  TaskTracker
//
//  Created by Рыжков Артем on 17.06.2019.
//  Copyright © 2019 Рыжков Артем. All rights reserved.
//

import Foundation

// Преобразование Date в String
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}

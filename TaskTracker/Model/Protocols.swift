//
//  Protocols.swift
//  TaskTracker
//
//  Created by Рыжков Артем on 18.06.2019.
//  Copyright © 2019 Рыжков Артем. All rights reserved.
//

import Foundation

protocol ChildViewControllerDelegate
{
    func childViewControllerResponse()
    func childViewControllerFilterResponse(status: Status)
}

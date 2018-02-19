//
//  Coordinator.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/19/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation

protocol Coordinator {
    func start()
    var childCoordinators : [Coordinator] {get set}
    func addChildCoordinator(coordinator:Coordinator)
    func removeChildCoordinator(coordinator:Coordinator)
}

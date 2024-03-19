//
//  Coordinator.swift
//  Cross_Test
//
//  Created by 박현준 on 3/19/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
    func popViewController(animated: Bool)
}

extension Coordinator {
    func popViewController(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
}

//
//  UITableView+Extensions.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import UIKit

// MARK: - Reusable & Registration Cell

extension UITableView {

    public func register<Cell: UITableViewCell>(cellType type: Cell.Type) {
        register(type, forCellReuseIdentifier: String(describing: type))
    }

    func dequeueReusableCell<Cell: UITableViewCell>(cellType type: Cell.Type, for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as? Cell else {
            fatalError("Not found cell - \(type.self) - to dequeueReusableCell")
        }
        return cell
    }
}


//
//  AlertHandler.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import UIKit

// Responsible to display alert dialogs
protocol AlertHandler {}

extension AlertHandler where Self: UIViewController {
    typealias AlertButton = (title: String, style: UIAlertAction.Style, handler: AlertHandler)
    typealias AlertHandler = ((UIAlertAction) -> Void)?
    
    func showDialog(withTitle title: String?, message: String?, buttons: [AlertButton]) {
        
        var actions: [UIAlertAction] = []
        
        for (title, style, handler) in buttons {
            let action = UIAlertAction(title: title, style: style, handler: handler)
            actions.append(action)
        }
        
        presentAlert(alert(withTitle: title, message: message, actions: actions))
    }
    
    private func alert(withTitle title: String?, message: String?, actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach({ alert.addAction($0) })
        return alert
    }
    
    private func presentAlert(_ alertController: UIAlertController) {
        var viewController: UIViewController? = self
        while viewController?.presentedViewController != nil {
            viewController = viewController?.presentedViewController
        }
        viewController?.present(alertController, animated: true, completion: nil)
    }
}

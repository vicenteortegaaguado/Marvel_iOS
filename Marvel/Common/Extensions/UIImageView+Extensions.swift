//
//  UIImageView+Extensions.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import UIKit

extension UIImageView {
    
    func load(url: URL?, placeholder: UIImage?) {
        image = placeholder
        guard let url = url else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}

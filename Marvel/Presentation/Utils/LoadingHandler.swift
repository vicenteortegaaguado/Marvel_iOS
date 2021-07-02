//
//  LoadingHandler.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import UIKit

// Responsible to display and hide activity indicator
protocol LoadingHandler {
    var isLoading: Bool { get }
    func showLoading()
    func hideLoading()
}

private let topAnchorIdentifier: String = "topAnchorLoadingView"
private let kIndicatorViewTag = 99
private let kIndicatorColor = UIColor.white
private let kBackgroundLayerColor = UIColor.gray

extension LoadingHandler where Self: UIViewController {
    
    var isLoading: Bool { view.viewWithTag(kIndicatorViewTag) != nil }
    
    func showLoading() {
        let loadingView = createIndicatorView()
        view.isUserInteractionEnabled = false
        view.addSubview(loadingView)
        
        
        let topMargin = (navigationController?.navigationBar.frame.height ?? 0) + loadingView.frame.height
        let topAnchor = loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -topMargin)
        topAnchor.identifier = topAnchorIdentifier
        topAnchor.isActive = true
        
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            topAnchor.constant = 16
            self?.view.layoutIfNeeded()
        }
    }
    
    func hideLoading() {
        guard let loadingView = view.viewWithTag(kIndicatorViewTag) else { return }
        view.isUserInteractionEnabled = true

        let topMargin = (navigationController?.navigationBar.frame.height ?? 0) + loadingView.frame.height
        view.constraints.first(where: { $0.identifier == topAnchorIdentifier })?.constant = -topMargin

        UIView.animate(withDuration: 0.2, delay: 0.2) { [weak self] in
            self?.view.layoutIfNeeded()
        } completion: { _ in
            loadingView.removeFromSuperview()
        }
    }
    
    private func createIndicatorView() -> UIView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = kIndicatorColor
        indicator.startAnimating()
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = kIndicatorViewTag
        view.backgroundColor = kBackgroundLayerColor
        view.layer.cornerRadius = (indicator.frame.height + 16) / 2
        view.addSubview(indicator)
        indicator.setConstraintsFillToSuperview(top: 8, leading: 8, trailing: -8, bottom: -8)
        
        return view
    }
}


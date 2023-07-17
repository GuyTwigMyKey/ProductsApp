//
//  ProductsVC.swift
//  ProductsApp
//
//  Created by Guy Twig on 16/07/2023.
//

import SwiftUI

class ProductsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let productView = ProductsView()
        let hostingController = UIHostingController(rootView: productView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

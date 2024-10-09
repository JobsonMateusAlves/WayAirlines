//
//  FlightDetailViewController.swift
//  
//
//  Created by Jobson Mateus on 09/10/24.
//

import UIKit

class FlightDetailViewController: UIViewController {
    
    private let viewModel: FlightDetailViewModelProtocol
    
    init(viewModel: FlightDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.flight.flightId
        view.backgroundColor = .black
    }
}

//
//  FlightsHistoryViewController.swift
//  
//
//  Created by Jobson Mateus on 07/10/24.
//

import UIKit

class FlightsHistoryViewController: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private let viewModel: FlightsHistoryViewModelProtocol
    
    init(viewModel: FlightsHistoryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupLayout()
        self.setupTableView()
        self.viewModel.list(status: .all) { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(FlightTableViewCell.self, forCellReuseIdentifier: "FlightTableViewCell")
    }
}

extension FlightsHistoryViewController {
    private func setupLayout() {
        self.view.addSubview(self.tableView)
        self.setupTableViewLayoutConstraints()
    }
    
    private func setupTableViewLayoutConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}

extension FlightsHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FlightTableViewCell", for: indexPath) as? FlightTableViewCell else {
            return UITableViewCell()
        }
        
        cell.bind(flight: viewModel.flights[indexPath.row])
        
        return cell
    }
}

//
//  FlightsHistoryViewController.swift
//  
//
//  Created by Jobson Mateus on 07/10/24.
//

import UIKit
import DomainLayer

class FlightsHistoryViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(Colors.primaryColor, for: .normal)
        button.contentHorizontalAlignment = .trailing
        return button
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

        title = "Voos"
        
        setupLayout()
        setupTableView()
        setupButton()
        viewModel.list { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FlightTableViewCell.self, forCellReuseIdentifier: "FlightTableViewCell")
    }
    
    private func setupButton() {
        filterButton.setTitle(viewModel.flightStatus.rawValue, for: .normal)
        filterButton.addTarget(self, action: #selector(showFilter), for: .touchUpInside)
    }
    
    @objc func showFilter() {
        let controller = FilterViewController(items: viewModel.statusItems.map({ $0.rawValue }), delegate: self)
        self.present(controller, animated: true)
        
        controller.headerLabel.text = "Selecione uma opção para filtrar"
    }
}

extension FlightsHistoryViewController {
    private func setupLayout() {
        view.addSubview(filterButton)
        view.addSubview(tableView)
        setupFilterButtonLayout()
        setupTableViewLayout()
    }
    
    private func setupFilterButtonLayout() {
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filterButton.heightAnchor.constraint(equalToConstant: 40),
            filterButton.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    private func setupTableViewLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.filterButton.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}

extension FlightsHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FlightTableViewCell", for: indexPath) as? FlightTableViewCell else {
            return UITableViewCell()
        }
        
        cell.bind(flight: viewModel.flights[indexPath.row])
        
        return cell
    }
}

extension FlightsHistoryViewController: FilterViewControllerDelegate {
    func didSelect(item: String) {
        viewModel.changeFlightStatus(status: FlightStatus(rawValue: item) ?? .all)
        setupButton()
        
        viewModel.list { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

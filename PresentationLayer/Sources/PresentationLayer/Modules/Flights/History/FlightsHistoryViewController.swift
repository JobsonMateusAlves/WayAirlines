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
        tableView.backgroundColor = .black
        return tableView
    }()
    
    lazy var filterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = Colors.primaryColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(Colors.primaryColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.contentHorizontalAlignment = .leading
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
        
        view.backgroundColor = .black
        
        setupLayout()
        setupTableView()
        setupFilterButton()
        viewModel.list { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FlightTableViewCell.self, forCellReuseIdentifier: "FlightTableViewCell")
    }
    
    private func setupFilterButton() {
        filterImageView.image = Images.filter
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
        view.addSubview(filterImageView)
        view.addSubview(filterButton)
        view.addSubview(tableView)
        
        setupFilterImageViewLayout()
        setupFilterButtonLayout()
        setupTableViewLayout()
    }
    
    private func setupFilterImageViewLayout() {
        NSLayoutConstraint.activate([
            filterImageView.centerYAnchor.constraint(equalTo: filterButton.centerYAnchor),
            filterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filterImageView.heightAnchor.constraint(equalToConstant: 20),
            filterImageView.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func setupFilterButtonLayout() {
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterButton.leadingAnchor.constraint(equalTo: filterImageView.trailingAnchor, constant: 8),
            filterButton.heightAnchor.constraint(equalToConstant: 40),
            filterButton.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    private func setupTableViewLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: filterButton.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(flight: viewModel.flights[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FlightsHistoryViewController: FilterViewControllerDelegate {
    func didSelect(item: String) {
        viewModel.changeFlightStatus(status: FlightStatus(rawValue: item) ?? .all)
        setupFilterButton()
        
        viewModel.list { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

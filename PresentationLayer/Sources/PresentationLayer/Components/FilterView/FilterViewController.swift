//
//  HeaderView.swift
//  
//
//  Created by Jobson Mateus on 08/10/24.
//

import UIKit

protocol FilterViewControllerDelegate: AnyObject {
    func didSelect(item: String)
}

class FilterViewController: UIViewController {
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.primaryColor
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        return tableView
    }()
    
    var items: [String] = []
    weak var delegate: FilterViewControllerDelegate?
    
    init(items: [String], delegate: FilterViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        self.items = items
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupTableView()
        
        tableView.reloadData()
        view.backgroundColor = .black
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilterItemTableViewCell.self, forCellReuseIdentifier: "FilterItemTableViewCell")
    }
}

extension FilterViewController {
    private func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(headerLabel)
        
        setupHeaderLabelLayout()
        setupTableViewLayout()
    }
    
    private func setupHeaderLabelLayout() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8),
            headerLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupTableViewLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterItemTableViewCell", for: indexPath) as? FilterItemTableViewCell else {
            return UITableViewCell()
        }
        
        cell.bind(item: items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(item: items[indexPath.row])
        dismiss(animated: true)
    }
}

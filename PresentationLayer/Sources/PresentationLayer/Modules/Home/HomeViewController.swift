//
//  HomeViewController.swift
//  
//
//  Created by Jobson Mateus on 09/10/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var nextFlightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.primaryColor
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    // MARK: Flight
    lazy var flightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    // MARK: Departure
    lazy var departureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var departureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.secondaryColor
        label.textAlignment = .center
        return label
    }()
    
    lazy var departureTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.primaryColor
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    // MARK: Arrival
    lazy var arrivalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var arrivalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.secondaryColor
        label.textAlignment = .center
        return label
    }()
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.secondaryColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var newFlightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar novo Voo", for: .normal)
        button.setTitleColor(Colors.primaryColor, for: .normal)
        return button
    }()

    private let viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        view.backgroundColor = .black
        
        viewModel.getNextFlight { [weak self] in
            self?.setData()
        }
    }
    
    func setData() {
        view.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        setupNextFlightLayout()
        titleLabel.text = "Próximos voos:"
        
        guard let flight = viewModel.flight else {
            setupEmptyLabelLayout()
            emptyLabel.text = "Nenhum voo a realizar encontrado"
            return
        }
        
        setupNextFlightContentLayout()
        
        departureTimeLabel.text = "Partida: \(flight.departureDateTime.toString())"
        
        departureImageView.image = Images.airplaneDeparture
        arrivalImageView.image = Images.airplaneArrival
        arrowImageView.image = Images.arrowRight
        
        departureImageView.tintColor = Colors.secondaryColor
        arrivalImageView.tintColor = Colors.secondaryColor
        arrowImageView.tintColor = Colors.secondaryColor
        
        departureLabel.text = flight.departureAirportAbbreviation
        arrivalLabel.text = flight.arrivalAirportAbbreviation
    }
    
    func setupNewFlightButton() {
        newFlightButton.addTarget(self, action: #selector(newFlight), for: .touchUpInside)
    }
    
    @objc func newFlight() {
        
    }
}

extension HomeViewController {
    
    private func setupNextFlightLayout() {
        view.addSubview(nextFlightView)
        nextFlightView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            nextFlightView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nextFlightView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextFlightView.widthAnchor.constraint(greaterThanOrEqualToConstant: 150),
            nextFlightView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            nextFlightView.widthAnchor.constraint(lessThanOrEqualToConstant: 250)
        ])
        
        nextFlightView.layer.cornerRadius = 8
        nextFlightView.layer.borderColor = Colors.primaryColor.cgColor
        nextFlightView.layer.borderWidth = 1
        
        setupTitleLabelLayout()
        setupNewFlightButtonLayout()
    }
    
    private func setupTitleLabelLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: nextFlightView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: nextFlightView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: nextFlightView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupEmptyLabelLayout() {
        nextFlightView.addSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            emptyLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 16),
            emptyLabel.leadingAnchor.constraint(equalTo: nextFlightView.leadingAnchor, constant: 16),
            emptyLabel.trailingAnchor.constraint(equalTo: nextFlightView.trailingAnchor, constant: -16),
            emptyLabel.bottomAnchor.constraint(equalTo: nextFlightView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupNextFlightContentLayout() {
        nextFlightView.addSubview(stackView)
        nextFlightView.addSubview(flightStackView)
        nextFlightView.addSubview(departureTimeLabel)
        
        setupStackView()
        setupDepartureStackView()
        setupArrivalStackView()
        
        setupFlightStackView()
    }
    
    private func setupStackView() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.centerXAnchor.constraint(equalTo: nextFlightView.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 64),
            stackView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        stackView.addArrangedSubview(departureStackView)
        stackView.addArrangedSubview(arrowImageView)
        stackView.addArrangedSubview(arrivalStackView)
    }
    
    private func setupDepartureStackView() {
        departureStackView.addArrangedSubview(departureImageView)
        departureStackView.addArrangedSubview(departureLabel)
    }
    
    private func setupArrivalStackView() {
        arrivalStackView.addArrangedSubview(arrivalImageView)
        arrivalStackView.addArrangedSubview(arrivalLabel)
    }
    
    private func setupFlightStackView() {
        NSLayoutConstraint.activate([
            departureTimeLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            departureTimeLabel.leadingAnchor.constraint(equalTo: nextFlightView.leadingAnchor, constant: 16),
            departureTimeLabel.trailingAnchor.constraint(equalTo: nextFlightView.trailingAnchor, constant: -16),
            departureTimeLabel.bottomAnchor.constraint(lessThanOrEqualTo: nextFlightView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupNewFlightButtonLayout() {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = Colors.primaryButtonColor
        backgroundView.addSubview(newFlightButton)
        view.addSubview(backgroundView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: nextFlightView.bottomAnchor, constant: 16),
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            newFlightButton.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            newFlightButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            newFlightButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            newFlightButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16)
        ])
        
        backgroundView.layer.cornerRadius = 8
        backgroundView.layer.masksToBounds = true
    }
}


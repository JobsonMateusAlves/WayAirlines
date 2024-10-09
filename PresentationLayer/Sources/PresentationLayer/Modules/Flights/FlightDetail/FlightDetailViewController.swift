//
//  FlightDetailViewController.swift
//  
//
//  Created by Jobson Mateus on 09/10/24.
//

import UIKit

class FlightDetailViewController: UIViewController {
    
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
    
    // MARK: Flight
    lazy var flightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    lazy var flightStatusTagView: TagView = {
        let view = TagView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var flightCompletionStatusTagView: TagView = {
        let view = TagView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var airplaneNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.primaryColor
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .left
        return label
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
    
    lazy var originLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.primaryColor
        label.font = .systemFont(ofSize: 12, weight: .semibold)
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
    
    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.primaryColor
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    lazy var destinationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.primaryColor
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
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

        title = "Voo \(viewModel.flight.flightId)"
        view.backgroundColor = .black
        
        setupLayout()
        setData()
    }
    
    func setData() {
        originLabel.text = "Origem: \(viewModel.flight.departureAirport)"
        destinationLabel.text = "Destino: \(viewModel.flight.arrivalAirport)"
        departureTimeLabel.text = "Partida: \(viewModel.flight.departureDateTime.toString())"
        arrivalTimeLabel.text = "Chegada: \(viewModel.flight.arrivalDateTime.toString())"
        airplaneNameLabel.text = viewModel.flight.airplaneName
        
        if let flightStatus = viewModel.flight.status {
            flightStatusTagView.bind(tag: flightStatus.rawValue, color: flightStatus.color)
        }
        
        flightCompletionStatusTagView.bind(tag: viewModel.flight.completionStatus, color: .red)
        
        departureImageView.image = Images.airplaneDeparture
        arrivalImageView.image = Images.airplaneArrival
        arrowImageView.image = Images.arrowRight
        
        departureImageView.tintColor = Colors.secondaryColor
        arrivalImageView.tintColor = Colors.secondaryColor
        arrowImageView.tintColor = Colors.secondaryColor
        
        departureLabel.text = viewModel.flight.departureAirportAbbreviation
        arrivalLabel.text = viewModel.flight.arrivalAirportAbbreviation
    }
}

extension FlightDetailViewController {
    func setupLayout() {
        view.addSubview(stackView)
        view.addSubview(flightStackView)
        view.addSubview(flightStatusTagView)
        view.addSubview(flightCompletionStatusTagView)
        
        setupStackView()
        setupDepartureStackView()
        setupArrivalStackView()
        
        setupFlightStackView()
        setupFlightStatusTagView()
        setupFlightCompletionStatusTagView()
    }
    
    func setupStackView() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 64),
            stackView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        stackView.addArrangedSubview(departureStackView)
        stackView.addArrangedSubview(arrowImageView)
        stackView.addArrangedSubview(arrivalStackView)
    }
    
    func setupDepartureStackView() {
        departureStackView.addArrangedSubview(departureImageView)
        departureStackView.addArrangedSubview(departureLabel)
    }
    
    func setupArrivalStackView() {
        arrivalStackView.addArrangedSubview(arrivalImageView)
        arrivalStackView.addArrangedSubview(arrivalLabel)
    }
    
    func setupFlightStackView() {
        NSLayoutConstraint.activate([
            flightStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            flightStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            flightStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        flightStackView.addArrangedSubview(airplaneNameLabel)
        flightStackView.addArrangedSubview(originLabel)
        flightStackView.addArrangedSubview(destinationLabel)
        flightStackView.addArrangedSubview(departureTimeLabel)
        flightStackView.addArrangedSubview(arrivalTimeLabel)
    }
    
    func setupFlightStatusTagView() {
        NSLayoutConstraint.activate([
            flightStatusTagView.topAnchor.constraint(equalTo: flightStackView.bottomAnchor, constant: 16),
            flightStatusTagView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    func setupFlightCompletionStatusTagView() {
        NSLayoutConstraint.activate([
            flightCompletionStatusTagView.centerYAnchor.constraint(equalTo: flightStatusTagView.centerYAnchor),
            flightCompletionStatusTagView.leadingAnchor.constraint(equalTo: flightStatusTagView.trailingAnchor, constant: 16)
        ])
    }
}


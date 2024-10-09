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
    
    lazy var statusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 16
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
            flightStatusTagView.bind(tag: flightStatus.rawValue.capitalized, color: flightStatus.color)
        }
        flightStatusTagView.isHidden = viewModel.flight.status == nil
        
        flightCompletionStatusTagView.bind(tag: viewModel.flight.completionStatus.value, color: viewModel.flight.completionStatus.color)
        flightCompletionStatusTagView.isHidden = viewModel.flight.completionStatus == .canceled
        
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
    private func setupLayout() {
        view.addSubview(stackView)
        view.addSubview(flightStackView)
        view.addSubview(flightStatusTagView)
        view.addSubview(flightCompletionStatusTagView)
        view.addSubview(statusStackView)
        
        setupStackView()
        setupDepartureStackView()
        setupArrivalStackView()
        
        setupFlightStackView()
        setupStatusStackView()
    }
    
    private func setupStackView() {
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
    
    private func setupStatusStackView() {
        NSLayoutConstraint.activate([
            statusStackView.topAnchor.constraint(equalTo: flightStackView.bottomAnchor, constant: 16),
            statusStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statusStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16)
        ])
        
        statusStackView.addArrangedSubview(flightStatusTagView)
        statusStackView.addArrangedSubview(flightCompletionStatusTagView)
    }
}


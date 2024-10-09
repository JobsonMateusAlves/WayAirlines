//
//  FlightTableViewCell.swift
//
//
//  Created by Jobson Mateus on 07/10/24.
//

import UIKit
import DomainLayer

class FlightTableViewCell: UITableViewCell {
    
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
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var flightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.primaryColor
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    lazy var flightStatusTagView: TagView = {
        let view = TagView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.primaryColor
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func bind(flight: Flight) {
        flightLabel.text = "Voo \(flight.flightId)"
        departureTimeLabel.text = "Partida: \(flight.departureDateTime.toString())"
        arrivalTimeLabel.text = "Chegada: \(flight.arrivalDateTime.toString())"
        if let flightStatus = flight.status {
            flightStatusTagView.bind(tag: flightStatus.rawValue.capitalized, color: flightStatus.color)
        }
        flightStatusTagView.isHidden = flight.status == nil
        
        departureImageView.image = Images.airplaneDeparture
        arrivalImageView.image = Images.airplaneArrival
        arrowImageView.image = Images.arrowRight
        
        departureImageView.tintColor = Colors.secondaryColor
        arrivalImageView.tintColor = Colors.secondaryColor
        arrowImageView.tintColor = Colors.secondaryColor
        
        departureLabel.text = flight.departureAirportAbbreviation
        arrivalLabel.text = flight.arrivalAirportAbbreviation
    }
}

extension FlightTableViewCell {
    private func setupLayout() {
        addSubview(flightStackView)
        addSubview(stackView)
        
        setupFlightStackView()
        setupFlightStatusTagView()
        setupStackView()
        setupDepartureStackView()
        setupArrivalStackView()
    }
    
    private func setupFlightStackView() {
        NSLayoutConstraint.activate([
            flightStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            flightStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            flightStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            flightStackView.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -8),
        ])
        
        flightStackView.addArrangedSubview(flightLabel)
        flightStackView.addArrangedSubview(departureTimeLabel)
        flightStackView.addArrangedSubview(arrivalTimeLabel)
    }
    
    private func setupStackView() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
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
    
    private func setupFlightStatusTagView() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flightStatusTagView)
        flightStackView.addArrangedSubview(view)
        
        NSLayoutConstraint.activate([
            flightStatusTagView.topAnchor.constraint(equalTo: view.topAnchor),
            flightStatusTagView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            flightStatusTagView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -8),
            flightStatusTagView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

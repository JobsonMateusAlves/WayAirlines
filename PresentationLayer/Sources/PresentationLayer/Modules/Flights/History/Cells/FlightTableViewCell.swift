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
        self.setupLayout()
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func bind(flight: Flight) {
        self.flightLabel.text = "Voo \(flight.flightId)"
        self.departureTimeLabel.text = "Partida: \(flight.departureDateTime.toString())"
        self.arrivalTimeLabel.text = "Chegada: \(flight.arrivalDateTime.toString())"
        if let flightStatus = flight.status {
            self.flightStatusTagView.bind(tag: flightStatus.rawValue, color: flightStatus.color)
        }
        
        self.departureImageView.image = Images.airplaneDeparture
        self.arrivalImageView.image = Images.airplaneArrival
        self.arrowImageView.image = Images.arrowRight
        
        self.departureImageView.tintColor = Colors.secondaryColor
        self.arrivalImageView.tintColor = Colors.secondaryColor
        self.arrowImageView.tintColor = Colors.secondaryColor
        
        self.departureLabel.text = flight.departureAirportAbbreviation
        self.arrivalLabel.text = flight.arrivalAirportAbbreviation
    }
}

extension FlightTableViewCell {
    func setupLayout() {
        self.addSubview(self.flightStackView)
        self.addSubview(self.stackView)
        
        self.setupFlightStackView()
        self.setupFlightStatusTagView()
        self.setupStackView()
        self.setupDepartureStackView()
        self.setupArrivalStackView()
    }
    
    func setupFlightStackView() {
        NSLayoutConstraint.activate([
            self.flightStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.flightStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            self.flightStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.flightStackView.trailingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: -8),
        ])
        
        self.flightStackView.addArrangedSubview(self.flightLabel)
        self.flightStackView.addArrangedSubview(self.departureTimeLabel)
        self.flightStackView.addArrangedSubview(self.arrivalTimeLabel)
    }
    
    func setupStackView() {
        NSLayoutConstraint.activate([
            self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.stackView.heightAnchor.constraint(equalToConstant: 64),
            self.stackView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        self.stackView.addArrangedSubview(self.departureStackView)
        self.stackView.addArrangedSubview(self.arrowImageView)
        self.stackView.addArrangedSubview(self.arrivalStackView)
    }
    
    func setupDepartureStackView() {
        self.departureStackView.addArrangedSubview(self.departureImageView)
        self.departureStackView.addArrangedSubview(self.departureLabel)
    }
    
    func setupArrivalStackView() {
        self.arrivalStackView.addArrangedSubview(self.arrivalImageView)
        self.arrivalStackView.addArrangedSubview(self.arrivalLabel)
    }
    
    func setupFlightStatusTagView() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.flightStatusTagView)
        self.flightStackView.addArrangedSubview(view)
        
        NSLayoutConstraint.activate([
            self.flightStatusTagView.topAnchor.constraint(equalTo: view.topAnchor),
            self.flightStatusTagView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.flightStatusTagView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -8),
            self.flightStatusTagView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//
//  File.swift
//  
//
//  Created by Jobson Mateus on 06/10/24.
//

import Foundation
import DomainLayer

public struct Flight: Codable {
    let flightId: String
    let status: String
    let completionStatus: String
    let startDate: String
    let endDate: String
    let departureTime: String
    let arrivalTime: String
    let departureAirport: String
    let arrivalAirport: String
    let airplaneName: String
    
    enum CodingKeys: String, CodingKey {
        case flightId = "flight_id"
        case status
        case completionStatus = "completion_status"
        case startDate = "start_date"
        case endDate = "end_date"
        case departureTime = "departure_time"
        case arrivalTime = "arrival_time"
        case departureAirport = "departure_airport"
        case arrivalAirport = "arrival_airport"
        case airplaneName = "airplane_name"
    }
}

extension Flight {
    func toDomain() -> DomainLayer.Flight {
        DomainLayer.Flight(
            flightId: flightId,
            status: DomainLayer.Flight.Status(rawValue: status),
            completionStatus: completionStatus,
            departureDateTime: Date.from(string: "\(startDate) \(departureTime)") ?? Date(),
            arrivalDateTime: Date.from(string: "\(endDate) \(arrivalTime)") ?? Date(),
            departureAirport: departureAirport,
            arrivalAirport: arrivalAirport,
            airplaneName: airplaneName
        )
    }
}

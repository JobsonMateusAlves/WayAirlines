//
//  File.swift
//  
//
//  Created by Jobson Mateus on 06/10/24.
//

import Foundation

public struct Flight: Equatable {
    public enum Status: String {
        case completed = "CONCLUIDO"
        case canceled = "CANCELADO"
    }
    
    public let flightId: String
    public let status: Status?
    public let completionStatus: String
    public let departureDateTime: Date
    public let arrivalDateTime: Date
    public let departureAirport: String
    public let arrivalAirport: String
    public let departureAirportAbbreviation: String
    public let arrivalAirportAbbreviation: String
    public let airplaneName: String
    
    public init(flightId: String, status: Status?, completionStatus: String, departureDateTime: Date, arrivalDateTime: Date, departureAirport: String, arrivalAirport: String, departureAirportAbbreviation: String, arrivalAirportAbbreviation: String, airplaneName: String) {
        self.flightId = flightId
        self.status = status
        self.completionStatus = completionStatus
        self.departureDateTime = departureDateTime
        self.arrivalDateTime = arrivalDateTime
        self.departureAirport = departureAirport
        self.arrivalAirport = arrivalAirport
        self.departureAirportAbbreviation = departureAirportAbbreviation
        self.arrivalAirportAbbreviation = arrivalAirportAbbreviation
        self.airplaneName = airplaneName
    }
}

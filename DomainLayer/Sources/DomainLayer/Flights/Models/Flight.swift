//
//  File.swift
//  
//
//  Created by Jobson Mateus on 06/10/24.
//

import Foundation

public struct Flight: Equatable {
    public let flightId: String
    public let status: String
    public let completionStatus: String
    public let startDate: String
    public let endDate: String
    public let departureTime: String
    public let arrivalTime: String
    public let departureAirport: String
    public let arrivalAirport: String
    public let airplaneName: String
    
    public init(flightId: String, status: String, completionStatus: String, startDate: String, endDate: String, departureTime: String, arrivalTime: String, departureAirport: String, arrivalAirport: String, airplaneName: String) {
        self.flightId = flightId
        self.status = status
        self.completionStatus = completionStatus
        self.startDate = startDate
        self.endDate = endDate
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.departureAirport = departureAirport
        self.arrivalAirport = arrivalAirport
        self.airplaneName = airplaneName
    }
}

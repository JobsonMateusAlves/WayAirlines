//
//  File.swift
//  
//
//  Created by Jobson Mateus on 09/10/24.
//

import XCTest
@testable import DomainLayer

final class GetNextFlightLeavingUseCaseTests: XCTestCase {
    let oldFlights = [
        DomainLayer.Flight(
            flightId: "AB123",
            status: nil,
            completionStatus: DomainLayer.Flight.CompletionStatus.onTime,
            departureDateTime: Date.from(string: "2024-09-10 10:00")!,
            arrivalDateTime: Date.from(string: "2024-09-10 16:00")!,
            departureAirport: "JFK - John F. Kennedy International Airport",
            arrivalAirport: "LAX - Los Angeles International Airport",
            departureAirportAbbreviation: "JFK",
            arrivalAirportAbbreviation: "LAX",
            airplaneName: "Boeing 737"
        ),
        DomainLayer.Flight(
            flightId: "AB123",
            status: nil,
            completionStatus: DomainLayer.Flight.CompletionStatus.onTime,
            departureDateTime: Date.from(string: "2024-08-10 10:00")!,
            arrivalDateTime: Date.from(string: "2024-08-10 16:00")!,
            departureAirport: "JFK - John F. Kennedy International Airport",
            arrivalAirport: "LAX - Los Angeles International Airport",
            departureAirportAbbreviation: "JFK",
            arrivalAirportAbbreviation: "LAX",
            airplaneName: "Boeing 737"
        )
    ]
    
    let flights = [
        DomainLayer.Flight(
            flightId: "AB123",
            status: nil,
            completionStatus: DomainLayer.Flight.CompletionStatus.onTime,
            departureDateTime: Date.from(string: "2024-08-10 10:00")!,
            arrivalDateTime: Date.from(string: "2024-08-10 16:00")!,
            departureAirport: "JFK - John F. Kennedy International Airport",
            arrivalAirport: "LAX - Los Angeles International Airport",
            departureAirportAbbreviation: "JFK",
            arrivalAirportAbbreviation: "LAX",
            airplaneName: "Boeing 737"
        ),
        DomainLayer.Flight(
            flightId: "AB123",
            status: nil,
            completionStatus: DomainLayer.Flight.CompletionStatus.onTime,
            departureDateTime: Date.from(string: "2024-11-10 10:00")!,
            arrivalDateTime: Date.from(string: "2024-11-10 16:00")!,
            departureAirport: "JFK - John F. Kennedy International Airport",
            arrivalAirport: "LAX - Los Angeles International Airport",
            departureAirportAbbreviation: "JFK",
            arrivalAirportAbbreviation: "LAX",
            airplaneName: "Boeing 737"
        ),
        DomainLayer.Flight(
            flightId: "AB123",
            status: nil,
            completionStatus: DomainLayer.Flight.CompletionStatus.onTime,
            departureDateTime: Date.from(string: "2024-12-10 10:00")!,
            arrivalDateTime: Date.from(string: "2024-12-10 16:00")!,
            departureAirport: "JFK - John F. Kennedy International Airport",
            arrivalAirport: "LAX - Los Angeles International Airport",
            departureAirportAbbreviation: "JFK",
            arrivalAirportAbbreviation: "LAX",
            airplaneName: "Boeing 737"
        )
    ]
    
    func testGetNextFlightLeaving() {
        let expectation = expectation(description: "Next flight")
        DateSystem.shared.set(date: Date.from(string: "2024-10-09 12:00")!)
        let nextFlight = DomainLayer.Flight(
            flightId: "AB123",
            status: nil,
            completionStatus: DomainLayer.Flight.CompletionStatus.onTime,
            departureDateTime: Date.from(string: "2024-11-10 10:00")!,
            arrivalDateTime: Date.from(string: "2024-11-10 16:00")!,
            departureAirport: "JFK - John F. Kennedy International Airport",
            arrivalAirport: "LAX - Los Angeles International Airport",
            departureAirportAbbreviation: "JFK",
            arrivalAirportAbbreviation: "LAX",
            airplaneName: "Boeing 737"
        )
        
        let repository = FlightsRepositoryMock()
        repository.flights = self.flights
        
        let sut = FlightsUseCaseFactory.makeGetNextFlightLeaving(with: repository)
        sut.execute { flight, error in
            XCTAssertEqual(flight, nextFlight)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetNextFlightLeavingEmpty() {
        let expectation = expectation(description: "Next flight")
        DateSystem.shared.set(date: Date.from(string: "2024-10-09 12:00")!)
        
        let repository = FlightsRepositoryMock()
        repository.flights = self.oldFlights
        
        let sut = FlightsUseCaseFactory.makeGetNextFlightLeaving(with: repository)
        sut.execute { flight, error in
            XCTAssertEqual(flight, nil)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}

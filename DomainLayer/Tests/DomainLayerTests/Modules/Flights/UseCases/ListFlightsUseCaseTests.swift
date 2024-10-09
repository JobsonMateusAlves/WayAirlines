//
//  File.swift
//  
//
//  Created by Jobson Mateus on 09/10/24.
//

import XCTest
@testable import DomainLayer

final class FlightsRepositoryTests: XCTestCase {
    let flights = [
        DomainLayer.Flight(
            flightId: "AB123",
            status: DomainLayer.Flight.Status.completed,
            completionStatus: DomainLayer.Flight.CompletionStatus.delayed,
            departureDateTime: Date.from(string: "2024-08-01 10:00")!,
            arrivalDateTime: Date.from(string: "2024-08-01 18:00")!,
            departureAirport: "JFK - John F. Kennedy International Airport",
            arrivalAirport: "LAX - Los Angeles International Airport",
            departureAirportAbbreviation: "JFK",
            arrivalAirportAbbreviation: "LAX",
            airplaneName: "Boeing 737"
        ),
        DomainLayer.Flight(
            flightId: "AB123",
            status: DomainLayer.Flight.Status.canceled,
            completionStatus: DomainLayer.Flight.CompletionStatus.canceled,
            departureDateTime: Date.from(string: "2024-09-01 10:00")!,
            arrivalDateTime: Date.from(string: "2024-09-01 16:00")!,
            departureAirport: "JFK - John F. Kennedy International Airport",
            arrivalAirport: "LAX - Los Angeles International Airport",
            departureAirportAbbreviation: "JFK",
            arrivalAirportAbbreviation: "LAX",
            airplaneName: "Boeing 737"
        ),
        DomainLayer.Flight(
            flightId: "AB123",
            status: DomainLayer.Flight.Status.completed,
            completionStatus: DomainLayer.Flight.CompletionStatus.onTime,
            departureDateTime: Date.from(string: "2024-09-08 10:00")!,
            arrivalDateTime: Date.from(string: "2024-09-08 16:00")!,
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
            departureDateTime: Date.from(string: "2024-10-09 10:00")!,
            arrivalDateTime: Date.from(string: "2024-10-09 16:00")!,
            departureAirport: "JFK - John F. Kennedy International Airport",
            arrivalAirport: "LAX - Los Angeles International Airport",
            departureAirportAbbreviation: "JFK",
            arrivalAirportAbbreviation: "LAX",
            airplaneName: "Boeing 737"
        )
        
    ]
    
    func testListAllFlights() {
        let expectation = expectation(description: "All flights")
        DateSystem.shared.set(date: Date.from(string: "2024-10-09 12:00")!)
        
        let repository = FlightsRepositoryMock()
        repository.flights = self.flights
        
        let sut = FlightsUseCaseFactory.makeListFlights(with: repository)
        sut.execute(status: .all) { flights, error in
            XCTAssertEqual(flights?.count, self.flights.count)
            XCTAssertEqual(flights, self.flights)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testListCompletedFlights() {
        let expectation = expectation(description: "Completed flights")
        DateSystem.shared.set(date: Date.from(string: "2024-10-09 12:00")!)
        
        let completedFlights = [
            DomainLayer.Flight(
                flightId: "AB123",
                status: DomainLayer.Flight.Status.completed,
                completionStatus: DomainLayer.Flight.CompletionStatus.delayed,
                departureDateTime: Date.from(string: "2024-08-01 10:00")!,
                arrivalDateTime: Date.from(string: "2024-08-01 18:00")!,
                departureAirport: "JFK - John F. Kennedy International Airport",
                arrivalAirport: "LAX - Los Angeles International Airport",
                departureAirportAbbreviation: "JFK",
                arrivalAirportAbbreviation: "LAX",
                airplaneName: "Boeing 737"
            ),
            DomainLayer.Flight(
                flightId: "AB123",
                status: DomainLayer.Flight.Status.completed,
                completionStatus: DomainLayer.Flight.CompletionStatus.onTime,
                departureDateTime: Date.from(string: "2024-09-08 10:00")!,
                arrivalDateTime: Date.from(string: "2024-09-08 16:00")!,
                departureAirport: "JFK - John F. Kennedy International Airport",
                arrivalAirport: "LAX - Los Angeles International Airport",
                departureAirportAbbreviation: "JFK",
                arrivalAirportAbbreviation: "LAX",
                airplaneName: "Boeing 737"
            )
        ]
        let repository = FlightsRepositoryMock()
        repository.flights = self.flights
        
        let sut = FlightsUseCaseFactory.makeListFlights(with: repository)
        sut.execute(status: .completed) { flights, error in
            XCTAssertEqual(flights?.count, completedFlights.count)
            XCTAssertEqual(flights, completedFlights)
            XCTAssertNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testListCanceledFlights() {
        let expectation = expectation(description: "Canceled flights")
        DateSystem.shared.set(date: Date.from(string: "2024-10-09 12:00")!)
        
        let canceledFlights = [
            DomainLayer.Flight(
                flightId: "AB123",
                status: DomainLayer.Flight.Status.canceled,
                completionStatus: DomainLayer.Flight.CompletionStatus.canceled,
                departureDateTime: Date.from(string: "2024-09-01 10:00")!,
                arrivalDateTime: Date.from(string: "2024-09-01 16:00")!,
                departureAirport: "JFK - John F. Kennedy International Airport",
                arrivalAirport: "LAX - Los Angeles International Airport",
                departureAirportAbbreviation: "JFK",
                arrivalAirportAbbreviation: "LAX",
                airplaneName: "Boeing 737"
            )
        ]
        let repository = FlightsRepositoryMock()
        repository.flights = self.flights
        
        let sut = FlightsUseCaseFactory.makeListFlights(with: repository)
        sut.execute(status: .canceled) { flights, error in
            XCTAssertEqual(flights?.count, canceledFlights.count)
            XCTAssertEqual(flights, canceledFlights)
            XCTAssertNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testListInProgressFlights() {
        let expectation = expectation(description: "InProgress flights")
        DateSystem.shared.set(date: Date.from(string: "2024-10-09 12:00")!)
        
        let inProgressFlights = [
            DomainLayer.Flight(
                flightId: "AB123",
                status: nil,
                completionStatus: DomainLayer.Flight.CompletionStatus.onTime,
                departureDateTime: Date.from(string: "2024-10-09 10:00")!,
                arrivalDateTime: Date.from(string: "2024-10-09 16:00")!,
                departureAirport: "JFK - John F. Kennedy International Airport",
                arrivalAirport: "LAX - Los Angeles International Airport",
                departureAirportAbbreviation: "JFK",
                arrivalAirportAbbreviation: "LAX",
                airplaneName: "Boeing 737"
            )
        ]
        let repository = FlightsRepositoryMock()
        repository.flights = self.flights
        
        let sut = FlightsUseCaseFactory.makeListFlights(with: repository)
        sut.execute(status: .inProgress) { flights, error in
            XCTAssertEqual(flights, inProgressFlights)
            XCTAssertNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testListPendingFlights() {
        let expectation = expectation(description: "Pending flights")
        DateSystem.shared.set(date: Date.from(string: "2024-10-09 12:00")!)
        
        let pendingFlights = [
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
            )
        ]
        let repository = FlightsRepositoryMock()
        repository.flights = self.flights
        
        let sut = FlightsUseCaseFactory.makeListFlights(with: repository)
        sut.execute(status: .pending) { flights, error in
            XCTAssertEqual(flights?.count, pendingFlights.count)
            XCTAssertEqual(flights, pendingFlights)
            XCTAssertNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}

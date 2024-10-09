//
//  File.swift
//  
//
//  Created by Jobson Mateus on 06/10/24.
//

import XCTest
import DomainLayer
@testable import DataLayer

final class FlightsRepositoryTests: XCTestCase {
    func testListFlightsWithSuccess() async {
        let provider = FlightsProviderMock()
        provider.listResult = [
            Flight(
                flightId: "AB123",
                status: "CONCLUIDO",
                completionStatus: "ATRASOU",
                startDate: "2024-08-01",
                endDate: "2024-08-01",
                departureTime: "10:00",
                arrivalTime: "14:00",
                departureAirport: "JFK - John F. Kennedy International Airport",
                arrivalAirport: "LAX - Los Angeles International Airport",
                airplaneName: "Boeing 737"
            )
        ]
        
        let domainLayerFlight = DomainLayer.Flight(
            flightId: "AB123",
            status: DomainLayer.Flight.Status.completed,
            completionStatus: DomainLayer.Flight.CompletionStatus.delayed,
            departureDateTime: Date.from(string: "2024-08-01 10:00")!,
            arrivalDateTime: Date.from(string: "2024-08-01 14:00")!,
            departureAirport: "JFK - John F. Kennedy International Airport",
            arrivalAirport: "LAX - Los Angeles International Airport",
            departureAirportAbbreviation: "JFK",
            arrivalAirportAbbreviation: "LAX",
            airplaneName: "Boeing 737"
        )
        
        let sut = FlightsDataFactory.makeRepository(with: provider)
        do {
            let result = try await sut.list()
            XCTAssertEqual(result, [domainLayerFlight])
            XCTAssertEqual(provider.listCallCount, 1)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testListFlightsWithFailure() async {
        let provider = FlightsProviderMock()
        provider.listError = NSError(domain: "ListError", code: 1, userInfo: [
            NSLocalizedDescriptionKey: "List Error"
        ])
        let sut = FlightsDataFactory.makeRepository(with: provider)
        
        do {
            let _ = try await sut.list()
            XCTFail("Should return error")
        } catch {
            XCTAssertEqual(provider.listCallCount, 1)
            XCTAssertEqual(error.localizedDescription, "List Error")
        }
    }
}

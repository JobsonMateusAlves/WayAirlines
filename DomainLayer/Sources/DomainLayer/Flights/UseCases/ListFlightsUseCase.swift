//
//  File.swift
//  
//
//  Created by Jobson Mateus on 07/10/24.
//

import Foundation

protocol ListFlightsUseCaseProtocol {
    func execute(now: Date, status: FlightStatus, completion: @escaping ([Flight]?, String?) -> Void)
}

public class ListFlightsUseCase: ListFlightsUseCaseProtocol {
    
    let repository: FlightsRepositoryProtocol
    
    public init(repository: FlightsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(now: Date, status: FlightStatus, completion: @escaping ([Flight]?, String?) -> Void) {
        Task {
            do {
                let result = try await self.repository.list().filter({
                    switch status {
                    case .completed:
                        $0.status == .completed
                    case .canceled:
                        $0.status == .canceled
                    case .inProgress:
                        $0.departureDateTime < now && $0.arrivalDateTime > now
                    case .pending:
                        now < $0.departureDateTime
                    }
                })
                completion(result, nil)
            } catch {
                completion(nil, error.localizedDescription)
            }
        }
        
    }
}

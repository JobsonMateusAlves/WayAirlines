//
//  File.swift
//  
//
//  Created by Jobson Mateus on 07/10/24.
//

import Foundation

public protocol ListFlightsUseCaseProtocol {
    func execute(status: FlightStatus, completion: @escaping ([Flight]?, String?) -> Void)
}

class ListFlightsUseCase: ListFlightsUseCaseProtocol {
    
    let repository: FlightsRepositoryProtocol
    
    init(repository: FlightsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(status: FlightStatus, completion: @escaping ([Flight]?, String?) -> Void) {
        Task { @MainActor in
            do {
                let now = DateSystem.shared.getNow()
                var result = try await self.repository.list()
                if status != .all {
                    result = result.filter({
                        switch status {
                        case .completed:
                            $0.status == .completed
                        case .canceled:
                            $0.status == .canceled
                        case .inProgress:
                            $0.departureDateTime < now && $0.arrivalDateTime > now
                        case .pending:
                            now < $0.departureDateTime
                        case .all:
                            true
                        }
                    })
                }
                
                completion(result, nil)
            } catch {
                completion(nil, error.localizedDescription)
            }
        }
        
    }
}

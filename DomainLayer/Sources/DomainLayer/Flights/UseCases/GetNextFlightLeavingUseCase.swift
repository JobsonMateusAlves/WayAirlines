//
//  File.swift
//  
//
//  Created by Jobson Mateus on 07/10/24.
//

import Foundation

protocol GetNextFlightLeavingUseCaseProtocol {
    func execute(completion: @escaping (Flight?, String?) -> Void)
}

public class GetNextFlightLeavingUseCase: GetNextFlightLeavingUseCaseProtocol {
    
    let repository: FlightsRepositoryProtocol
    
    public init(repository: FlightsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(completion: @escaping (Flight?, String?) -> Void) {
        Task {
            do {
                let results = try await self.repository.list()
                let flight = results.sorted(by: { $0.departureDateTime < $1.departureDateTime })
                    .first(where: { $0.status == nil && $0.departureDateTime > Date() })
                
                completion(flight, nil)
            } catch {
                completion(nil, error.localizedDescription)
            }
        }
        
    }
}

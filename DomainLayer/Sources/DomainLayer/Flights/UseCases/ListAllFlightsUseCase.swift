//
//  File.swift
//  
//
//  Created by Jobson Mateus on 07/10/24.
//

import Foundation

protocol ListAllFlightsUseCaseProtocol {
    func execute(completion: @escaping ([Flight]?, String?) -> Void)
}

public class ListAllFlightsUseCase: ListAllFlightsUseCaseProtocol {
    
    let repository: FlightsRepositoryProtocol
    
    public init(repository: FlightsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(completion: @escaping ([Flight]?, String?) -> Void) {
        Task {
            do {
                let result = try await self.repository.list()
                completion(result, nil)
            } catch {
                completion(nil, error.localizedDescription)
            }
        }
        
    }
}

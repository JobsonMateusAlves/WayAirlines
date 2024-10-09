//
//  File.swift
//  
//
//  Created by Jobson Mateus on 07/10/24.
//

import Foundation

public enum Status: String, CaseIterable {
    case all = "Todos"
    case completed = "Concluído"
    case canceled = "Cancelado"
    case inProgress = "Em viagem"
    case pending = "A realizar"
}

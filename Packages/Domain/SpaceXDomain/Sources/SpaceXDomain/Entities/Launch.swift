//
//  File.swift
//  
//
//  Created by Alex Schäfer on 12.02.24.
//

import Foundation

/// Entity `Launch`
public struct Launch: Identifiable, Equatable {
    public let id: String
    public let details: String
    public let rocketId: String?
    public let date: Date?

    public init(id: String, details: String, rocketId: String?, date: Date?) {
        self.id = id
        self.details = details
        self.rocketId = rocketId
        self.date = date
    }
}


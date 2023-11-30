//
//  ProfileViewModel.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 28.11.2023.
//

import Foundation

protocol ProfileViewModelProtocol {
    var user: User { get }
    var numberOfSections: [Int] { get }
}

struct ProfileViewModel: ProfileViewModelProtocol {
    var numberOfSections: [Int] = [1, 6, 3]
    
    private(set) var user = User(userID: UUID(),
                                 name: "Jon",
                                 surname: "Snow",
                                 email: "winteriscoming@got.com",
                                 phoneNumber: "+1234567890",
                                 bonuses: 25,
                                 paymentCards: [],
                                 orders: []
    )

}

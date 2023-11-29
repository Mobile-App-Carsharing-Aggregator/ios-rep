//
//  ProfileViewModel.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 28.11.2023.
//

import Foundation

protocol ProfileViewModelProtocol {
    var numberOfSections: [Int] { get }
}

struct ProfileViewModel: ProfileViewModelProtocol {
    var numberOfSections: [Int] = [1, 6, 3]
    
    

}

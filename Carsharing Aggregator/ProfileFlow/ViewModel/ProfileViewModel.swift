//
//  ProfileViewModel.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 28.11.2023.
//

import Foundation

protocol ProfileViewModelProtocol {
    var fullName: String { get }
    var numberOfSections: [Int] { get }
    func viewWillAppear()
}

struct ProfileViewModel: ProfileViewModelProtocol {
    var numberOfSections: [Int] = [2, 1, 2]
    // MARK: - Observables
    @Observable
    private(set) var fullName: String = ""
    
    // MARK: - Properties
    weak var coordinator: ProfileCoordinator?
    private let userService = DefaultUserService.shared
    private var user: User?
    
    // MARK: - Methods
    func viewWillAppear() {
        getUser()
    }
    
    private  func getUser() {
//        let user = User(userID: UUID(),
//                    name: "Jon",
//                    surname: "Snow",
//                    email: "winteriscoming@got.com",
//                    phoneNumber: "+1234567890",
//                    bonuses: 25,
//                    paymentCards: [],
//                    orders: []
//        )
        DefaultUserService.shared.getUser { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("Получены данные пользователя: \(user)")
                    fullName = "\(user.firstName) \(user.lastName)"
                case .failure(let error):
                    print("Ошибка при получении профиля пользователя: \(error)")
                    fullName = "Jon Snow"
                }
            }
        }
        
    }
}

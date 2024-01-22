//
//  ProfileViewModel.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 28.11.2023.
//

import Foundation
import UIKit

protocol ProfileViewModelProtocol {
    var fullName: String { get }
    var numberOfSections: [Int] { get }
    func viewWillAppear()
    func logout()
    func deleteAccount()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    var numberOfSections: [Int] = [2, 1, 2]
    // MARK: - Observables
    @Observable
    private(set) var fullName: String = ""
    @Observable
    private(set) var deleteUserSuccess: String = ""
    
    // MARK: - Properties
    weak var coordinator: ProfileCoordinator?
    private let userService = DefaultUserService.shared
    private var user: UserProfile?
    
    // MARK: - Methods
    func viewWillAppear() {
        getUser()
    }
    
    func openReviews(on vc: UIViewController) {
        guard let user = user else { return }
        coordinator?.openReviews(on: vc, for: user)
    }
    
    func openSettings(on vc: UIViewController) {
        coordinator?.openSettings(on: vc)
    }
    
    func openSearchHistory(on vc: UIViewController) {
        coordinator?.openSearchHistory(on: vc)
    }
    
    func logout() {
        TokenStorage.shared.deleteToken()
    }
    
    func checkProfile() -> Bool {
        if TokenStorage.shared.getToken() != nil {
            return true
        } else {
            return false
        }
    }
    
    func transferToLoginFlow() {
        coordinator?.startAuthFlow()
    }
    
    func deleteAccount() {
        guard let user else {
            deleteUserSuccess = "Ошибка удаления, не найден профиль для удаления, повторите процедуру логина"
            return
        }
        DefaultUserService.shared.deleteUser(withUserId: user.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.deleteUserSuccess = "Ваши данные удалены, надеемся увидеть вас снова!"
                case .failure(let error):
                    self?.deleteUserSuccess = "Ошибка удаления: \(error.localizedDescription)"
                }
            }
        }
    }
    
    private func getUser() {
        DefaultUserService.shared.getUser { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("Получены данные пользователя: \(user)")
                    self.fullName = "\(user.firstName) \(user.lastName)"
                    self.user = user
                case .failure(let error):
                    print("Ошибка при получении профиля пользователя: \(error)")
                    self.fullName = "John Snow"
                }
            }
        }
    }
}

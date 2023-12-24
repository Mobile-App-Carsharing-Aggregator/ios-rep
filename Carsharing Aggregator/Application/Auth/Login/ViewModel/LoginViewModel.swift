import Foundation
import Combine


protocol LoginViewModelProtocol: AnyObject {
   //func openRegister()
    func coordinatorDidFinish()
}

class LoginViewModel: LoginViewModelProtocol {
    weak var coordinator: LoginCoordinator?
    @Published var email: String = ""
    @Published var password: String = ""
    
    var isEmailEmptyPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { $0.isValid(validType: .email) }
            .eraseToAnyPublisher()
    }
    
    var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { $0.isValid(validType: .password) }
            .eraseToAnyPublisher()
    }
    
    var areFieldsEmptyPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            isEmailEmptyPublisher,
            isEmailEmptyPublisher
        )
        .map { $0 && $1 }
        .eraseToAnyPublisher()
    }
    
    var areFieldsValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            isEmailValidPublisher,
            isPasswordValidPublisher
        )
        .map { $0 && $1 }
        .eraseToAnyPublisher()
    }
    
    var isSubmitEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            areFieldsEmptyPublisher,
            areFieldsValidPublisher
        )
        .map { $0 && $1 }
        .eraseToAnyPublisher()
    }
    
    func coordinatorDidFinish() {
        coordinator?.coordinatorDidFinish()
    }
}

import Foundation
import Combine
enum ValidFieldType: String {
    case name
    case surname
    case email
    case password
    case confirmPassword
}

class RegistrationViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""

    var isNameEmptyPublisher: AnyPublisher<Bool, Never> {
        $name
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isValidNamePublisher: AnyPublisher<Bool, Never> {
        $name
            .map { $0.isValid(validType: .name) }
            .eraseToAnyPublisher()
    }
    
    var isSurnameEmptyPublisher: AnyPublisher<Bool, Never> {
        $surname
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isValidSurnamePublisher: AnyPublisher<Bool, Never> {
        $surname
            .map { $0.isValid(validType: .surname) }
            .eraseToAnyPublisher()
    }
    
    var isEmailEmptyPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isValidEmailPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { $0.isValid(validType: .email) }
            .eraseToAnyPublisher()
    }
    
    var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isValidPasswordPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { $0.isValid(validType: .password) }
            .eraseToAnyPublisher()
    }
    
    var isConfrimPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $confirmPassword
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isValidConfirmPasswordPublisher: AnyPublisher<Bool, Never> {
        $confirmPassword
            .map { $0.isValid(validType: .confirmPassword(self.password)) }
            .eraseToAnyPublisher()
    }
    
    var areFieldsNotEmpty: AnyPublisher<Bool, Never> {
            let firstCombined = Publishers.CombineLatest3(
                isNameEmptyPublisher,
                isSurnameEmptyPublisher,
                isEmailEmptyPublisher
            )
            .map {
                return !$0.0 && !$0.1 && !$0.2
            }
            
            let secondCombined = Publishers.CombineLatest(
                isPasswordEmptyPublisher,
                isConfrimPasswordEmptyPublisher
            )
            .map {
                return !$0.0 && !$0.1
            }
            
            return Publishers.CombineLatest(firstCombined, secondCombined)
                .map { $0.0 && $0.1 }
                .eraseToAnyPublisher()
        }

    var areFieldsValid: AnyPublisher<Bool, Never> {
        let firstCombined = Publishers.CombineLatest3(
            isValidNamePublisher,
            isValidSurnamePublisher,
            isValidEmailPublisher
            )
            .map { $0.0 && $0.1 && $0.2 }
        
        let secondCombined = Publishers.CombineLatest(
            isValidPasswordPublisher,
            isValidConfirmPasswordPublisher
            )
            .map {
                return $0.0 && $0.1 }
        
        return Publishers.CombineLatest(firstCombined, secondCombined)
            .map { $0.0 && $0.1 }
            .eraseToAnyPublisher()
    }
    
    var isSubmitEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(areFieldsValid, areFieldsNotEmpty)
            .map { $0.0 && $0.1 }
            .eraseToAnyPublisher()
    }

}

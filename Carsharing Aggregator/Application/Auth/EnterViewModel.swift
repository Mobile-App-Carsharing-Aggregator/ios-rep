import Foundation
import Combine

class EnterViewModel {
    var coordinator: LoginCoordinator
    var loginViewModel: LoginViewModel!
    private var userService = DefaultUserService.shared
    var registrationViewModel: RegistrationViewModel!
    
    var onError: ((String) -> Void)?
    
    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func isSubmitRegistrationEnabled() {
        guard let registrationViewModel else { return }
        let registrationModel = UserRegistration(email: registrationViewModel.email,
                                                 firstName: registrationViewModel.name,
                                                 lastName: registrationViewModel.surname,
                                                 password: registrationViewModel.password,
                                                 confirmPassword: registrationViewModel.confirmPassword)
        print(registrationModel)
        userService.createUser(with: registrationModel) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                UIProgressHUD.show()
                switch result {
                case .success(_):
                    let loginModel = UserLogin(email: registrationModel.email, password: registrationModel.password)
                    self.login(loginModel: loginModel)
                case .failure(let error):
                    UIProgressHUD.dismiss()
                    if case NetworkError.customError(let errorMessage) = error {
                        self.onError?(errorMessage)
                    } else {
                        switch error {
                        case .customError(let errorMessage):
                            self.onError?(errorMessage)

                        case .httpStatusCode(let statusCode):
                            let statusMessage = "Ошибка HTTP: \(statusCode)"
                            self.onError?(statusMessage)

                        case .urlSessionError:
                            self.onError?("Ошибка сессии URL")

                        case .urlRequestError(let error):
                            self.onError?("Ошибка запроса: \(error.localizedDescription)")

                        case .decode:
                            self.onError?("Ошибка декодирования данных")

                        default:
                            self.onError?("Неизвестная ошибка")
                        }
                    }
                    
                }
            }
        }
    }
    
    func isSubmitLoginEnabled() {
        guard let loginViewModel else { return }
        let loginModel = UserLogin(email: loginViewModel.email, password: loginViewModel.password)
        login(loginModel: loginModel)
        print("login tapped")
        
    }
    
    private func login(loginModel: UserLogin) {
        userService.userLogin(with: loginModel) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                UIProgressHUD.show()
                switch result {
                case .success(let token):
                    print("TOKEN: \(token)")
                    TokenStorage.shared.saveToken(token.authToken)
                    coordinator.startTabBarFlow()
                    UIProgressHUD.dismiss()
                case .failure(let error):
                    UIProgressHUD.dismiss()
                    if case NetworkError.customError(let errorMessage) = error {
                        self.onError?(errorMessage)
                    } else {
                        switch error {
                        case .customError(let errorMessage):
                            self.onError?(errorMessage)
                            
                        case .httpStatusCode(let statusCode):
                            let statusMessage = "Ошибка HTTP: \(statusCode)"
                            self.onError?(statusMessage)
                            
                        case .urlSessionError:
                            self.onError?("Ошибка сессии URL")
                            
                        case .urlRequestError(let error):
                            self.onError?("Ошибка запроса: \(error.localizedDescription)")
                            
                        case .decode:
                            self.onError?("Ошибка декодирования данных")
                            
                        default:
                            self.onError?("Неизвестная ошибка")
                        }
                    }
                    
                }
            }
        }
    }

}

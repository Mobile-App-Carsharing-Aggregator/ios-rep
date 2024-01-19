import Foundation
import Combine

class EnterViewModel {
    var coordinator: LoginCoordinator
    var loginViewModel: LoginViewModel!
    private var userService = DefaultUserService.shared
    var registrationViewModel: RegistrationViewModel!
    private var cancellables: Set<AnyCancellable> = []
    
    var onError: ((String) -> Void)?
    
    @Published private(set) var isLoading = false
    @Published private(set) var currentButtonState: EnterButtonState = .login
    
    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
    }
    
    func changeCurrentButtonState() {
        currentButtonState = (currentButtonState == .login) ? .registration : .login
    }
    
    func isSubmitRegistrationEnabled() {
        guard let registrationViewModel else { return }
        let registrationModel = UserRegistration(email: registrationViewModel.email,
                                                 firstName: registrationViewModel.name,
                                                 lastName: registrationViewModel.surname,
                                                 password: registrationViewModel.password,
                                                 confirmPassword: registrationViewModel.confirmPassword)
        isLoading = true
        userService.createUser(with: registrationModel) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .success(_):
                    let loginModel = UserLogin(email: registrationModel.email, password: registrationModel.password)
                    self.login(loginModel: loginModel)
                case .failure(let error):
                    isLoading = false
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
    }
    
    private func login(loginModel: UserLogin) {
        isLoading = true
        userService.userLogin(with: loginModel) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .success(let token):
                    print("TOKEN: \(token)")
                    TokenStorage.shared.saveToken(token.authToken)
                    coordinator.startTabBarFlow()
                    isLoading = false
                case .failure(let error):
                    isLoading = false
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

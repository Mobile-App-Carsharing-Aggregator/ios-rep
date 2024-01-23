import UIKit
import Combine

class RegistrationView: UIView {
    var registrationViewModel: RegistrationViewModel!
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - UI Properties
    private lazy var termsOfService: UILabel = {
        let label = UILabel.createTermsLabel()
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
        return label
    }()
    private lazy var nameTextField = MyTextField(placeholder: "Имя", isSecure: false, keyboardType: .other, textContentType: .other)
    private lazy var surnameTextField = MyTextField(placeholder: "Фамилия", isSecure: false, keyboardType: .other, textContentType: .other)
    private lazy var emailTextField = MyTextField(placeholder: "Example@mail.ru", isSecure: false, keyboardType: .email, textContentType: .email)
    private lazy var passwordTextField = MyTextField(placeholder: "Пароль", isSecure: true, keyboardType: .password, textContentType: .password)
    private lazy var confirmPasswordTextField = MyTextField(placeholder: "Пароль еще раз", isSecure: true, keyboardType: .password,
        textContentType: .password)
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        return scrollView
    }()
    
    private let nameSublabel = UILabel(placeholderString: "  Имя  ")
    private let surnameSublabel = UILabel(placeholderString: "  Фамилия  ")
    private let emailSublabel = UILabel(placeholderString: "  Example@mail.ru  ")
    private let passwordSublabel = UILabel(placeholderString: "  Пароль  ")
    private let confirmSublabel = UILabel(placeholderString: "  Пароль еще раз  ")
    
    private let emptyNameFieldWarning = UILabel(warningString: "Поле обязательное для заполнения")
    private let emptySurnameFieldWarning = UILabel(warningString: "Поле обязательное для заполнения")
    private let emptyEmailFieldWarning = UILabel(warningString: "Поле обязательное для заполнения")
    private let emptyPasswordFieldWarning = UILabel(warningString: "Поле обязательное для заполнения")
    private let emptyConfirmFieldWarning = UILabel(warningString: "Поле обязательное для заполнения")
    
    private let incorrectNameWarning = UILabel(warningString: "Допустимые символы: пробел, кириллические \nи латинские буквы")
    private let incorrectSurnameWarning = UILabel(warningString: "Допустимые символы: пробел, кириллические \nи латинские буквы")
    private let emailWarninigLabel = UILabel(warningString: "Используйте только латинские буквы, цифры,\n знак подчеркивания, точку и минус.")
    private let passwordWarningLabel = UILabel(warningString: "Должно быть не менее 10 символов")
    private let confirmWarningLabel = UILabel(warningString: "Пароли должны совпадать")
    
    private let orLabel = UILabel.createOptionLabel(string: "или")
    
    private lazy var vkLogoButton = UIButton(
        with: UIImage.vkLogo ?? UIImage(),
        target: self,
        action: #selector(vkLogoButtonDidTapped)
    )
    
    private lazy var yandexLogoButton = UIButton(
        with: UIImage.yandexLogo ?? UIImage(),
        target: self,
        action: #selector(yandexLogoButtonDidTapped)
    )
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.backgroundColor = .clear
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Targets and functions
    private func addStartTarget() {
        nameTextField.addTarget(self, action: #selector(textFieldDidStart(_:)), for: .editingDidBegin)
        surnameTextField.addTarget(self, action: #selector(textFieldDidStart(_:)), for: .editingDidBegin)
        emailTextField.addTarget(self, action: #selector(textFieldDidStart(_:)), for: .editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(textFieldDidStart(_:)), for: .editingDidBegin)
        confirmPasswordTextField.addTarget(self, action: #selector(textFieldDidStart(_:)), for: .editingDidBegin)
    }
    
    private func addEndingTargets() {
        nameTextField.addTarget(self, action: #selector(textFIeldDidEnd(_:)), for: .editingDidEnd)
        surnameTextField.addTarget(self, action: #selector(textFIeldDidEnd(_:)), for: .editingDidEnd)
        emailTextField.addTarget(self, action: #selector(textFIeldDidEnd(_:)), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(textFIeldDidEnd(_:)), for: .editingDidEnd)
        confirmPasswordTextField.addTarget(self, action: #selector(textFIeldDidEnd(_:)), for: .editingDidEnd)
    }
    private func didStartTyping(in textField: UITextField, with sublLabel: UILabel) {
        textField.placeholder = ""
        textField.layer.borderWidth = 2
        sublLabel.enterSublabelAnimation()
    }
    
    @objc private func textFieldDidStart(_ textField: UITextField) {
        switch textField {
        case nameTextField: didStartTyping(in: nameTextField, with: nameSublabel)
        case surnameTextField: didStartTyping(in: surnameTextField, with: surnameSublabel)
        case emailTextField: didStartTyping(in: emailTextField, with: emailSublabel)
        case passwordTextField: didStartTyping(in: passwordTextField, with: passwordSublabel)
        case confirmPasswordTextField: didStartTyping(in: confirmPasswordTextField, with: confirmSublabel)
        default:
            break
        }
    }
    
    @objc private func labelTapped() {
        print("OPEN LINK")
    }
    @objc private func vkLogoButtonDidTapped() {
        print("VK TAPPED")
    }
    
    @objc private func yandexLogoButtonDidTapped() {
        print("YANDEX TAPPED")
    }
    
    @objc private func textFIeldDidEnd(_ textField: UITextField) {
        switch textField {
        case nameTextField: registrationViewModel.name = textField.text ?? ""
            textFieldDidEnd(nameTextField, and: nameSublabel)
            observeField(for: registrationViewModel.$name,
                         isEmptyPublisher: registrationViewModel.isNameEmptyPublisher,
                         isValidPublisher: registrationViewModel.isValidNamePublisher,
                         textField: surnameTextField,
                         previousTextField: nameTextField,
                         emptyWarningLabel: emptyNameFieldWarning, validWarningLabel: incorrectNameWarning)
        case surnameTextField: registrationViewModel.surname = textField.text ?? ""
            textFieldDidEnd(surnameTextField, and: surnameSublabel)
            observeField(for: registrationViewModel.$surname,
                         isEmptyPublisher: registrationViewModel.isSurnameEmptyPublisher,
                         isValidPublisher: registrationViewModel.isValidSurnamePublisher,
                         textField: emailTextField, previousTextField: surnameTextField,
                         emptyWarningLabel: emptySurnameFieldWarning, validWarningLabel: incorrectSurnameWarning)
        case emailTextField: registrationViewModel.email = textField.text ?? ""
            textFieldDidEnd(emailTextField, and: emailSublabel)
            observeField(for: registrationViewModel.$email,
                         isEmptyPublisher: registrationViewModel.isEmailEmptyPublisher,
                         isValidPublisher: registrationViewModel.isValidEmailPublisher,
                         textField: passwordTextField, previousTextField: emailTextField,
                         emptyWarningLabel: emptyEmailFieldWarning, validWarningLabel: emailWarninigLabel)
        case passwordTextField: registrationViewModel.password = textField.text ?? ""
            textFieldDidEnd(passwordTextField, and: passwordSublabel)
            observeField(for: registrationViewModel.$password,
                         isEmptyPublisher: registrationViewModel.isPasswordEmptyPublisher, 
                         isValidPublisher: registrationViewModel.isValidPasswordPublisher,
                         textField: confirmPasswordTextField, previousTextField: passwordTextField, 
                         emptyWarningLabel: emptyPasswordFieldWarning, validWarningLabel: passwordWarningLabel)
        case confirmPasswordTextField: registrationViewModel.confirmPassword = textField.text ?? ""
            textFieldDidEnd(confirmPasswordTextField, and: confirmSublabel)
            observeConfirmField()
        default:
            break
        }
    }
    
    private func textFieldDidEnd(_ textField: UITextField, and sublabel: UILabel) {
            sublabel.isHidden = true
            textField.layer.borderWidth = 1
        }

    func setupDelegate() {
        nameTextField.delegate = self
        surnameTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        emailTextField.delegate = self
    }
    private func setTextFieldBorderColor(isValid: Bool, for textField: UIView) {
        if !isValid {
            textField.layer.borderColor = UIColor.red.cgColor
        } else {
            textField.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    private func updateConstraintsForTextField(_ textField: UITextField,
                                               relativeTo previousTextField: UITextField?,
                                               isEmpty: Bool, isValid: Bool,
                                               offsetEmpty: CGFloat, offsetValid: CGFloat) {
        let previousTextField = previousTextField ?? scrollView
        let offset = isEmpty ? offsetEmpty : offsetValid
        setTextFieldBorderColor(isValid: isValid, for: previousTextField)
      
        textField.snp.remakeConstraints { make in
            make.top.equalTo(previousTextField.snp.bottom).offset(offset)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(nameTextField.snp.height)
            make.width.equalTo(nameTextField.snp.width)
        }
    }
    
    private func updateConstraintsForLabel(_ label: UILabel, relativeTo previousTextField: UITextField, isEmpty: Bool, offset: CGFloat) {
        label.snp.remakeConstraints { make in
            make.top.equalTo(previousTextField.snp.bottom).offset(offset)
            make.leading.equalTo(previousTextField.snp.leading)
        }
    }
   
    private func updateConstraintsForEmptyTextField(_ textField: UITextField, relativeTo previousTextField: UITextField?, isEmpty: Bool) {
        let previousTextField = previousTextField ?? scrollView
        let offset = isEmpty ? 33 : 16
        previousTextField.layer.borderColor = isEmpty ? UIColor.red.cgColor : UIColor.black.cgColor
        textField.snp.remakeConstraints { make in
            make.top.equalTo(previousTextField.snp.bottom).offset(offset)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(nameTextField.snp.height)
            make.width.equalTo(nameTextField.snp.width)
        }
       termsOfService.snp.remakeConstraints { make in
           make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(offset)
           make.leading.equalTo(confirmPasswordTextField.snp.leading)
       }
    }
    private func updateForEmptyConfirmTextField(_ label: UILabel, relativeTo previousTextField: UITextField, isEmpty: Bool) {
        let offset = 33
        confirmPasswordTextField.layer.borderColor = isEmpty ? UIColor.red.cgColor : UIColor.black.cgColor
        label.snp.remakeConstraints { make in
            make.top.equalTo(previousTextField.snp.bottom).offset(offset)
            make.leading.equalTo(previousTextField.snp.leading)
        }
    }
    
    private func updateConstraintsForValidTextField(_ textField: UITextField, relativeTo previousTextField: UITextField?, isValid: Bool) {
        let previousTextField = previousTextField ?? scrollView
        let offset = isValid ? 16 : 53
        let termsOffset = isValid ? 16 : 53
        setTextFieldBorderColor(isValid: isValid, for: previousTextField)
        textField.snp.remakeConstraints { make in
            make.top.equalTo(previousTextField.snp.bottom).offset(offset)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(nameTextField.snp.height)
            make.width.equalTo(nameTextField.snp.width)
        }
        termsOfService.snp.remakeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(termsOffset)
            make.leading.equalTo(confirmPasswordTextField.snp.leading)
        }
    }
    
    private func updateForValidConfirmTextField(_ label: UILabel, relativeTo previousTextField: UITextField, isValid: Bool) {
        let offset = isValid ? 12 : 40
        setTextFieldBorderColor(isValid: isValid, for: previousTextField)
        label.snp.remakeConstraints { make in
            make.top.equalTo(previousTextField.snp.bottom).offset(offset)
            make.leading.equalTo(previousTextField.snp.leading)
        }
    }
    private func observeField(for publisher: Published<String>.Publisher,
                              isEmptyPublisher: AnyPublisher<Bool, Never>,
                              isValidPublisher: AnyPublisher<Bool, Never>,
                              textField: UITextField,
                              previousTextField: UIView,
                              emptyWarningLabel: UILabel,
                              validWarningLabel: UILabel) {
        Publishers.CombineLatest3(publisher, isEmptyPublisher, isValidPublisher)
            .sink { [weak self] (_, isEmpty, isValid) in
                guard let self else { return }
                if isEmpty {
                    self.updateConstraintsForEmptyTextField(textField, relativeTo: previousTextField as? UITextField, isEmpty: isEmpty)
                    emptyWarningLabel.isHidden = !isEmpty
                    validWarningLabel.isHidden = isEmpty
                } else {
                    self.updateConstraintsForValidTextField(textField, relativeTo: previousTextField as? UITextField, isValid: isValid)
                    validWarningLabel.isHidden = isValid
                    emptyWarningLabel.isHidden = !isEmpty
                }
            }
            .store(in: &cancellables)
    }

    private func observeConfirmField() {
        Publishers.CombineLatest3(registrationViewModel.$confirmPassword,
                                  registrationViewModel.isConfrimPasswordEmptyPublisher,
                                  registrationViewModel.isValidConfirmPasswordPublisher)
        .sink { [weak self] (_, isEmpty, isValid) in
            guard let self else { return }
            self.setTextFieldBorderColor(isValid: isValid, for: self.confirmPasswordTextField)
            if isEmpty {
                self.updateForEmptyConfirmTextField(self.termsOfService, relativeTo: self.confirmPasswordTextField, isEmpty: isEmpty)
                self.emptyConfirmFieldWarning.isHidden = !isEmpty
                self.confirmWarningLabel.isHidden = isEmpty
            } else {
                self.updateForValidConfirmTextField(self.termsOfService, relativeTo: self.confirmPasswordTextField, isValid: isValid)
                self.emptyConfirmFieldWarning.isHidden = !isEmpty
                self.confirmWarningLabel.isHidden = isValid
            }
        }
        .store(in: &cancellables)
    }
    
//    func setupBinding() {
//        viewModel.isSubmitEnabled
//            .
//    }
    
}

extension RegistrationView {
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        [nameTextField, nameSublabel, emptyNameFieldWarning, incorrectNameWarning, surnameTextField, surnameSublabel,
         emptySurnameFieldWarning, incorrectSurnameWarning, emailTextField, emailSublabel, emptyEmailFieldWarning, emailWarninigLabel,
         passwordTextField, passwordSublabel, emptyPasswordFieldWarning, passwordWarningLabel, confirmPasswordTextField, confirmSublabel,
         emptyConfirmFieldWarning, confirmWarningLabel, stackView, orLabel, passwordWarningLabel, termsOfService,
         incorrectNameWarning, confirmWarningLabel].forEach {
            scrollView.addSubview($0)
        }
        
        stackView.addArrangedSubview(yandexLogoButton)
        stackView.addArrangedSubview(vkLogoButton)
        
        addEndingTargets()
        addStartTarget()
        setupDelegate()
    }
    
    private func setConstraints() {
        addSubviews()
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.bottom.equalTo(snp.bottom)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(20)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.width.equalTo(348)
            make.height.equalTo(52)
        }
        
        nameSublabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.top).offset(-8)
            make.leading.equalTo(nameTextField.snp.leading).offset(16)
        }
        
        emptyNameFieldWarning.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(8)
            make.leading.equalTo(nameTextField.snp.leading).offset(16)
            make.trailing.equalTo(nameTextField.snp.trailing)
        }
        
        incorrectNameWarning.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(8)
            make.leading.equalTo(nameTextField.snp.leading).offset(16)
        }
        
        surnameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.centerX.equalTo(nameTextField.snp.centerX)
            make.width.equalTo(nameTextField.snp.width)
            make.height.equalTo(nameTextField)
        }
        
        surnameSublabel.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.top).offset(-8)
            make.leading.equalTo(surnameTextField.snp.leading).offset(16)
        }
        
        emptySurnameFieldWarning.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.bottom).offset(8)
            make.leading.equalTo(surnameTextField.snp.leading).offset(16)
            make.trailing.equalTo(surnameTextField.snp.trailing)
        }
        
        incorrectSurnameWarning.snp.makeConstraints { make in
            make.top.equalTo(emptySurnameFieldWarning.snp.top)
            make.leading.equalTo(emptySurnameFieldWarning.snp.leading)
            make.trailing.equalTo(emptySurnameFieldWarning.snp.trailing)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.bottom).offset(16)
            make.centerX.equalTo(surnameTextField.snp.centerX)
            make.width.equalTo(surnameTextField.snp.width)
            make.height.equalTo(surnameTextField)
        }
        
        emailSublabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.top).offset(-8)
            make.leading.equalTo(emailTextField.snp.leading).offset(16)
        }
        
        emptyEmailFieldWarning.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.leading.equalTo(emailTextField.snp.leading).offset(16)
            make.trailing.equalTo(emailTextField.snp.trailing)
        }
        
        emailWarninigLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.leading.equalTo(emailTextField.snp.leading).offset(16)
            make.trailing.equalTo(emailTextField.snp.trailing)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.centerX.equalTo(surnameTextField.snp.centerX)
            make.width.equalTo(surnameTextField.snp.width)
            make.height.equalTo(emailTextField.snp.height)
        }
        
        passwordSublabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.top).offset(-8)
            make.leading.equalTo(passwordTextField.snp.leading).offset(16)
        }
        
        emptyPasswordFieldWarning.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.equalTo(passwordTextField.snp.leading).offset(16)
            make.trailing.equalTo(passwordTextField.snp.trailing)
        }
        
        passwordWarningLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.equalTo(passwordTextField.snp.leading).offset(16)
            make.trailing.equalTo(emptyPasswordFieldWarning.snp.trailing)
        }
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.centerX.equalTo(passwordTextField.snp.centerX)
            make.width.equalTo(passwordTextField.snp.width)
            make.height.equalTo(passwordTextField.snp.height)
        }
        
        confirmSublabel.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.top).offset(-8)
            make.leading.equalTo(confirmPasswordTextField.snp.leading).offset(16)
        }
        
        termsOfService.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(12)
            make.leading.equalTo(confirmPasswordTextField.snp.leading)
            make.trailing.equalTo(confirmPasswordTextField.snp.trailing)
        }
        
        emptyConfirmFieldWarning.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(8)
            make.leading.equalTo(confirmPasswordTextField.snp.leading).offset(16)
            make.trailing.equalTo(confirmPasswordTextField.snp.trailing)
        }
        
        confirmWarningLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyConfirmFieldWarning.snp.top)
            make.leading.equalTo(emptyConfirmFieldWarning.snp.leading)
            make.trailing.equalTo(emptyConfirmFieldWarning.snp.trailing)
        }
        
        orLabel.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView.snp.centerX)
            make.top.equalTo(termsOfService.snp.bottom).offset(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(12)
            make.centerX.equalTo(scrollView.snp.centerX)
        }
    }
}

extension RegistrationView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        becomeFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

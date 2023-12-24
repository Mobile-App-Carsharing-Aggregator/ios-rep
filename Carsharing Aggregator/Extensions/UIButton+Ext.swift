import UIKit

enum EnterButtonState {
    case login
    case registration

    enum ButtonSelectionState {
        case selected
        case deselected
    }
    var title: String {
        switch self {
        case .login:
            return "ВХОД"
        case .registration:
            return "РЕГИСТРАЦИЯ"
        }
    }
    
    var enterTitle: String {
        switch self {
        case .login:
            return "ВОЙТИ"
        case .registration:
            return "СОЗДАТЬ АККАУНТ"
        }
    }
    
    func color(for selectionState: ButtonSelectionState) -> UIColor {
        switch (self, selectionState) {
        case (.login, .selected), (.registration, .deselected):
            return UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        case (.registration, .selected), (.login, .deselected):
            return UIColor(red: 0.404, green: 0.404, blue: 0.404, alpha: 1)
        }
    }
}

extension UIButton {
    convenience init(for state: EnterButtonState,
                     selectionState: EnterButtonState.ButtonSelectionState,
                     target: Any?,
                     action: Selector) {
        self.init()
        setTitle(state.title, for: .normal)
        setTitleColor(state.color(for: selectionState), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        addTarget(target, action: action, for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(for state: EnterButtonState,
                     target: Any?,
                     action: Selector) {
        self.init(type: .system)
        setTitle(state.enterTitle, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        layer.backgroundColor = UIColor.black.cgColor
        addTarget(target, action: action, for: .touchUpInside)
        layer.cornerRadius = 26
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(with logo: UIImage, target: Any?, action: Selector) {
        self.init()
        self.setImage(logo, for: .normal)
        addTarget(target, action: action, for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
     }
    
    static func deleteButton(target: Any?, action: Selector) -> UIButton {
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        clearButton.tintColor = .black
        clearButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        clearButton.addTarget(target, action: action, for: .touchUpInside)
        return clearButton
    }
}

import UIKit

extension UILabel {
    static func createOptionLabel(string str: String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor(
            red: 0.079,
            green: 0.077,
            blue: 0.077,
            alpha: 1)
        label.font = UIFont.systemFont(
            ofSize: 16,
            weight: .regular)
        
        let paragraphtyle = NSMutableParagraphStyle()
        paragraphtyle.lineHeightMultiple = 1.14
        label.attributedText = NSMutableAttributedString(
            string: str,
            attributes: [NSAttributedString.Key.kern: -0.15,
                         NSAttributedString.Key.paragraphStyle: paragraphtyle])
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    convenience init(warningString: String) {
        self.init()
        self.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.textColor = UIColor(red: 1,
                                 green: 0.231,
                                 blue: 0.188,
                                 alpha: 1)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.14
        self.attributedText = NSMutableAttributedString(
            string: warningString,
            attributes: [
                NSAttributedString.Key.kern: -0.15,
                NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.numberOfLines = 0
        self.isHidden = true
    }
    
    static func createTermsLabel() -> UILabel {
        let label = UILabel()

        let regularAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular),
            .kern: -0.15
        ]
        let linkAttributes: [NSAttributedString.Key: Any] = [
            .link: NSURL(string: "https://yandex.ru/legal/uslugi_termsofuse/")!,
            .font: UIFont.systemFont(ofSize: 14, weight: .medium),
            .kern: -0.15
        ]
        let attributedString = NSMutableAttributedString(string: "Нажимая кнопку \"Создать аккаунт\" вы\nсоглашаетесь с ", attributes: regularAttributes)
        
        let linkString = NSAttributedString(string: "Условиями и политикой сервиса", attributes: linkAttributes)

        attributedString.append(linkString)

        label.attributedText = attributedString
        label.isUserInteractionEnabled = true
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
  
    convenience init(placeholderString: String) {
        self.init()
        self.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        self.textColor = UIColor(red: 0.325,
                                 green: 0.357,
                                 blue: 0.855,
                                 alpha: 1)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.12
        self.attributedText = NSMutableAttributedString(
            string: placeholderString,
            attributes: [
                NSAttributedString.Key.kern: -0.15,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ])
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isHidden = true
       
    }
    
    func enterSublabelAnimation() {
        self.isHidden = false
        self.alpha = 0.0
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [],
            animations: {
                self.alpha = 1.0
            },
            completion: nil
        )
    }
}

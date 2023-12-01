import UIKit

class VerifyCodeView: UIView {
    
    var fieldStack = UIStackView()
    var verifyField = [VerifyTextField]()
    
    private let enterCodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        var paragraphtyle = NSMutableParagraphStyle()
        paragraphtyle.lineHeightMultiple = 1.15
        label.attributedText = NSMutableAttributedString(
            string: "Введите код",
            attributes:
                [NSAttributedString.Key.kern: -0.41,
                 NSAttributedString.Key.paragraphStyle: paragraphtyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        verifyTextFieldConfiguration()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func verifyTextFieldConfiguration() {
        fieldStack.translatesAutoresizingMaskIntoConstraints = false
        fieldStack.spacing = 6
        fieldStack.distribution = .fillEqually
        
        for number in 0...5 {
            let verifyTextField = VerifyTextField()
            verifyTextField.tag = number
            verifyField.append(verifyTextField)
            fieldStack.addArrangedSubview(verifyTextField)
        }
        addSubview(fieldStack)
        addSubview(enterCodeLabel)
        makeConstraints()
    }
}

extension VerifyCodeView {
    private func makeConstraints() {
        fieldStack.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.leading.equalTo(snp.leading).offset(33)
            make.trailing.equalTo(snp.trailing).offset(-33)
            make.height.equalTo(52)
        }
        enterCodeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(fieldStack.snp.top).offset(-12)
            make.centerX.equalTo(snp.centerX)
        }
    }
}

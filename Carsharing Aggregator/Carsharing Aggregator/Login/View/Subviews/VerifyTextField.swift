import UIKit

class VerifyTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        placeholder = "0"
        font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textAlignment = .center
    }
}

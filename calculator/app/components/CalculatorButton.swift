import UIKit


protocol CalculatorButtonDelegate: AnyObject {
    func calculatorButtonTapped(calculatorButtonType: CalculatorButtonType)
}

class CalculatorButton : UIButton {

    weak var delegate: CalculatorButtonDelegate?
    var calculatorButtonType : CalculatorButtonType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        self.layer.cornerRadius = 35
        self.setTitleColor(.white, for: .normal)
        NSLayoutConstraint.activate(
            [
                self.widthAnchor.constraint(equalToConstant: 88),
                self.heightAnchor.constraint(equalToConstant: 88)
            ]
        )
        self.addTarget(self, action: #selector(handleTap),for: .touchUpInside)
    }
    
    func configure(
        font: UIFont = .systemFont(ofSize: 40),
        calculatorButtonType: CalculatorButtonType,
        contentAlignment : UIControl.ContentHorizontalAlignment = .center,
        titleEdgeInsets: UIEdgeInsets = .zero
    ){
        self.setTitle(calculatorButtonType.rawValue, for: .normal)
        self.backgroundColor = calculatorButtonType.buttonColor
        self.titleLabel?.font = font
        self.contentHorizontalAlignment = contentAlignment
        self.titleEdgeInsets = titleEdgeInsets
        self.calculatorButtonType = calculatorButtonType
        self.addTarget(self , action: #selector(handleTap), for: .touchUpInside)
    }
    
    @objc private func handleTap() {
        delegate?.calculatorButtonTapped(calculatorButtonType: self.calculatorButtonType!)
    }
}



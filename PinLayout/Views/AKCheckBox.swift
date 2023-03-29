//
//  AKCheckBox.swift
//  PinLayout
//
//  Created by Juan Pablo Ramundo on 22/03/2023.
//

import UIKit

public protocol AKCheckboxDelegate: AnyObject {
    func onCheckboxPressed(selected: Bool)
}

public class AKCheckbox: UIControl {

    static let checkboxSize: CGFloat = 24

    public weak var delegate: AKCheckboxDelegate?

    private var customTarget: NSObjectProtocol?
    private var customAction: Selector?

    private var checkIconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: checkboxSize, height: checkboxSize))
    public var isLoading: Bool = false {
        didSet {
            toggleSkeleton()
        }
    }

    public var accessibilityIdentifierCheckbox: String? {
        get { accessibilityIdentifier }
        set {
            isAccessibilityElement = true
            accessibilityIdentifier = newValue
        }
    }

    private var isChecked: Bool = false {
        didSet {
            updateUI()
        }
    }

    override public var isEnabled: Bool {
        didSet {
            updateUI()
        }
    }

    convenience init(identifier: String? = "UIControl.CheckBoxControl") {
        self.init(frame: .zero)
        accessibilityLabel = identifier
        accessibilityIdentifier = identifier
        initialSetup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }

    @objc func didTapCheckBox() {
        isChecked.toggle()
        delegate?.onCheckboxPressed(selected: isChecked)
        if let action = customAction {
            customTarget?.perform(action, with: self)
        }
    }

    public override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        super.addTarget(target, action: action, for: controlEvents)
        customTarget = target as? NSObjectProtocol
        customAction = action
    }

    public func getCheckStatus() -> Bool {
        isChecked
    }

    public func setCheckStatus(withValue value: Bool) {
        self.isChecked = value
    }

    private func toggleSkeleton() {
        return
    }

    // MARK: - Setups Various
    private func initialSetup() {
        imageViewSetup()

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCheckBox))
        tap.cancelsTouchesInView = true
        self.addGestureRecognizer(tap)
    }

    private func updateUI() {
        if isChecked {
            checkIconImageView.image = isEnabled ? UIImage(named: "ico-checkbox-active") :
            UIImage(named: "ico-checkbox-active")
        } else {
            checkIconImageView.image = isEnabled ? UIImage(named: "ico-checkbox-deselected") :
            UIImage(named: "ico-checkbox-disable")
        }
    }

    private func imageViewSetup() {
        checkIconImageView.image = UIImage(named: "ico-checkbox-deselected")
        addSubview(checkIconImageView)
//        self.pinSize(to: AKCheckbox.checkboxSize)
        checkIconImageView.pinEdges(to: self)
    }
}


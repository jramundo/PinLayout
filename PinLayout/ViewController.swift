//
//  ViewController.swift
//  PinLayout
//
//  Created by Juan Pablo Ramundo on 22/03/2023.
//

import UIKit

class ViewController: UIViewController {

    private let titleLabelOne: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "titleLabelOne Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim."
        titleLabel.numberOfLines = 2
        return titleLabel
    }()

    private let titleLabelTwo: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "titleLabelTwo Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim."
        titleLabel.numberOfLines = 2
        return titleLabel
    }()

    private let pseudoTermsAndConditionsView = UIView()

    private let checkBox = AKCheckbox()

    private let titleLabelThree: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "titleLabelThree Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim."
        titleLabel.numberOfLines = 2
        return titleLabel
    }()

    private let titleLabelFour: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "titleLabelFour Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim."
        titleLabel.numberOfLines = 2
        return titleLabel
    }()

    private let titleLabelFive: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "titleLabelFour Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim."
        titleLabel.numberOfLines = 2
        return titleLabel
    }()

    private let coloredViewOne = UIView()
    private let coloredViewTwo = UIView()
    private let labelView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setUpViews()
        setUpContraints()
    }

    private func setUpViews() {
        view.addSubview(titleLabelOne)
        view.addSubview(titleLabelTwo)
        view.addSubview(pseudoTermsAndConditionsView)
        pseudoTermsAndConditionsView.addSubview(checkBox)
        pseudoTermsAndConditionsView.addSubview(titleLabelThree)
        view.addSubview(titleLabelFour)
        view.addSubview(coloredViewOne)
        view.addSubview(coloredViewTwo)
        coloredViewOne.backgroundColor = .lightGray
        coloredViewTwo.backgroundColor = .red
        labelView.addSubview(titleLabelFive)
        view.addSubview(labelView)
    }

    private func setUpContraints() {
        titleLabelOne.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabelOne.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabelOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabelOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])

        titleLabelTwo
            .pin(.top, to: titleLabelOne.bottomAnchor, offset: 20)
            .pin(.leading, to: view, constant: 20)
            .pin(.trailing, to: view, constant: -20)

        coloredViewOne.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            coloredViewOne.heightAnchor.constraint(equalToConstant: 50),
            coloredViewOne.widthAnchor.constraint(equalToConstant: 50),
            coloredViewOne.topAnchor.constraint(equalTo: titleLabelTwo.bottomAnchor, constant: 20),
            coloredViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])

        coloredViewTwo
            .pin(.height, to: coloredViewOne, constant: 25)
            .pin(.top, to: coloredViewOne)
            .pin(.leading, to: coloredViewOne.trailingAnchor, offset: 20)
            .pin(.trailing, to: view, constant: -20)

        pseudoTermsAndConditionsView
            .pinCenter(to: view)
            .pin(.leading, to: view, constant: 20)
            .pin(.trailing, to: view, constant: -20)

        checkBox
//            .pinSize(to: CGSize(width: 25, height: 25))
//            .pinSize(to: 25)
            .pin(.top, to: titleLabelThree)
            .pin(.leading, to: pseudoTermsAndConditionsView)

        titleLabelThree
            .pin(.top, .bottom, .trailing, to: pseudoTermsAndConditionsView)
            .pin(.leading, to: checkBox.trailingAnchor, offset: 20)

        titleLabelFour
            .pin(.leading, .trailing, to: view)
            .pin(.bottom, to: view, constant: -20)


        labelView.backgroundColor = .yellow
        labelView
            .pin(.top, to: pseudoTermsAndConditionsView.bottomAnchor, offset: 20)
            .pin(.leading, .trailing, to: view)

        titleLabelFive
//            .pinEdges(to: labelView, constant: 20)
            .pinEdges(to: labelView, insets: UIEdgeInsets(uniform: 10))
    }
}


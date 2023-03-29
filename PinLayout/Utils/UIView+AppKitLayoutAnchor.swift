//
//  UIView+AppKitLayoutAnchor.swift
//  PinLayout
//
//  Created by Juan Pablo Ramundo on 22/03/2023.
//

import UIKit

// MARK: - Layout Anchors Protocol

/// Defines a constraint protocol, which can be applied to `UIView`s.
public protocol AppKitLayoutAnchor {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
}

/// Conforming to the protocol.
extension UIView: AppKitLayoutAnchor {}
extension UILayoutGuide: AppKitLayoutAnchor {}

// MARK: - Pinning

public extension UIView {

    @discardableResult
    func pin(
        _ attributes: NSLayoutConstraint.Attribute...,
        to item: AppKitLayoutAnchor? = nil,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority = .required
    ) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []

        for attribute in attributes {
            let constraint = NSLayoutConstraint(
                item: self,
                attribute: attribute,
                relatedBy: relation,
                toItem: item,
                attribute: attribute,
                multiplier: multiplier,
                constant: constant
            )
            constraint.priority = priority
            constraint.identifier = String(describing: attribute)
            constraints.append(constraint)
        }

        NSLayoutConstraint.activate(constraints)
        return self
    }

    @discardableResult
    func pin(
        _ attribute: NSLayoutConstraint.Attribute,
        to yAnchor: NSLayoutYAxisAnchor,
        offset: CGFloat = 0,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = yAxisAnchor(for: attribute).constraint(for: relation, to: yAnchor, constant: offset)
        constraint.priority = priority
        constraint.identifier = String(describing: attribute)
        constraint.isActive = true
        return self
    }

    @discardableResult
    func pin(
        _ attribute: NSLayoutConstraint.Attribute,
        to xAnchor: NSLayoutXAxisAnchor,
        offset: CGFloat = 0,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = xAxisAnchor(for: attribute).constraint(for: relation, to: xAnchor, constant: offset)
        constraint.priority = priority
        constraint.identifier = String(describing: attribute)
        constraint.isActive = true
        return self
    }
}

// MARK: - Helpers

extension UIView {

    fileprivate func yAxisAnchor(for location: NSLayoutConstraint.Attribute) -> NSLayoutYAxisAnchor {
        switch location {
        case .top: return topAnchor
        case .bottom: return bottomAnchor
        case .firstBaseline: return firstBaselineAnchor
        case .lastBaseline: return lastBaselineAnchor
        case .centerY: return centerYAnchor
        default:
            fatalError("Only y-axis attributes can translate to y-axis anchors.")
        }
    }

    fileprivate func xAxisAnchor(for location: NSLayoutConstraint.Attribute) -> NSLayoutXAxisAnchor {
        switch location {
        case .left: return leftAnchor
        case .right: return rightAnchor
        case .leading: return leadingAnchor
        case .trailing: return trailingAnchor
        case .centerX: return centerXAnchor
        default:
            fatalError("Only x-axis attributes can translate to x-axis anchors.")
        }
    }
}

public extension NSLayoutYAxisAnchor {

    func constraint(
        for relation: NSLayoutConstraint.Relation,
        to anchor: NSLayoutYAxisAnchor,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        switch relation {
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, constant: constant)
        case .equal:
            return constraint(equalTo: anchor, constant: constant)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, constant: constant)
        @unknown default:
            return constraint(equalTo: anchor, constant: constant)
        }
    }
}

public extension NSLayoutXAxisAnchor {

    func constraint(
        for relation: NSLayoutConstraint.Relation,
        to anchor: NSLayoutXAxisAnchor,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        switch relation {
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, constant: constant)
        case .equal:
            return constraint(equalTo: anchor, constant: constant)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, constant: constant)
        @unknown default:
            return constraint(equalTo: anchor, constant: constant)
        }
    }
}

// MARK: - Bulk Constraints

// MARK: UIEdgeInsets Helpers

public extension UIEdgeInsets {

    init(uniform: CGFloat) {
        self.init(
            top: uniform,
            left: uniform,
            bottom: -uniform,
            right: -uniform
        )
    }
}

// MARK: Definitions

/// Returns a list of attribute pairs, used for simplicity.
/// For example, if we use `edges()`, we'll get pairs of all the edge constraints
/// associated with a constant (.top, .bottom, .leading, .trailing)
fileprivate enum BulkAttributes {

    typealias AttributePair = (attribute: NSLayoutConstraint.Attribute, constant: CGFloat)
    typealias AttributePairs = [AttributePair]

    // Edges

    static func edges(_ insets: UIEdgeInsets) -> AttributePairs {
        [
            (attribute: .leading, constant: insets.left),
            (attribute: .trailing, constant: insets.right),
            (attribute: .top, constant: insets.top),
            (attribute: .bottom, constant: insets.bottom),
        ]
    }

    // Center

    static func center(_ offset: CGPoint) -> AttributePairs {
        [
            (attribute: .centerX, constant: offset.x),
            (attribute: .centerY, constant: offset.y)
        ]
    }

    // Size

    static func size(_ constant: CGSize) -> AttributePairs {
        [
            (attribute: .width, constant: constant.width),
            (attribute: .height, constant: constant.height)
        ]
    }
}

// MARK: - UIView Helpers

public extension UIView {

    // MARK: Edges

    @discardableResult
    /// Pins `self` to the edges of `item`.
    /// - Parameters:
    ///   - item: `item` to which `self` is pinning.
    ///   - insets: `UIEdgeInsets` from `item`'s frame. The default value is `.zero`.
    /// - Returns: `self` so this can be chained with other pinning calls.
    func pinEdges(
        to item: AppKitLayoutAnchor,
        insets: UIEdgeInsets
    ) -> UIView {
        for pair in BulkAttributes.edges(insets) {
            pin(pair.attribute, to: item, constant: pair.constant)
        }
        return self
    }

    @discardableResult
    /// Pins `self` to the edges of `item`.
    /// - Parameters:
    ///   - item: `item` to which `self` is pinning.
    ///   - constant: The `constant` to be used as spacing to the edges. The default value is `.zero`.
    ///               The negative sign will be automatically applied where necessary (.trailing, .bottom, etc).
    /// - Returns: `self` so this can be chained with other pinning calls.
    func pinEdges(
        to item: AppKitLayoutAnchor,
        constant: CGFloat = .zero
    ) -> UIView {
        pinEdges(to: item, insets: UIEdgeInsets(uniform: constant))
    }

    // MARK: Center

    @discardableResult
    /// Pins `self.center` to `item.center`.
    /// - Parameters:
    ///   - item: `item` to which `center` is being pinned by `self.center`.
    ///   - offset: An `offset` point to be used as a distance to `item.center`.
    /// - Returns: `self` so this can be chained with other pinning calls.
    func pinCenter(
        to item: AppKitLayoutAnchor,
        offset: CGPoint = .zero
    ) -> UIView {
        for pair in BulkAttributes.center(offset) {
            pin(pair.attribute, to: item, constant: pair.constant)
        }
        return self
    }

    // MARK: Size

    @discardableResult
    /// Pins `self`'s size to `item`'s size.
    /// - Parameters:
    ///   - view: The `UIView` from which `self`'s size is pinning to.
    ///   - padding: A size `padding` to differ from `view`'s size. The default value is `.zero`.
    ///   - priority: The `priority` assigned to the constraints. The default value is `.required`.
    /// - Returns: `self` so this can be chained with other pinning calls.
    func pinSize(
        to view: UIView,
        padding: CGSize = .zero,
        priority: UILayoutPriority = .required
    ) -> UIView {
        for pair in BulkAttributes.size(padding) {
            pin(pair.attribute, to: view, constant: pair.constant, priority: priority)
        }
        return self
    }

    @discardableResult
    /// Pins `self` to a constant size.
    /// - Parameters:
    ///   - constant: The `size` to which `self`'s size will pin to.
    ///   - priority: The `priority` assigned to the constraints. The default value is `.required`.
    /// - Returns: `self` so this can be chained with other pinning calls.
    func pinSize(
        to size: CGSize,
        priority: UILayoutPriority = .required
    ) -> UIView {
        for pair in BulkAttributes.size(size) {
            pin(pair.attribute, constant: pair.constant, priority: priority)
        }
        return self
    }

    @discardableResult
    /// Pins `self` to a constant _squared_ size.
    /// This means it will be a "constant x constant" sized view.
    /// - Parameters:
    ///   - constant: The `constant` to which `self`'s size will square-pin to.
    ///   - priority: The `priority` assigned to the constraints. The default value is `.required`.
    /// - Returns: `self` so this can be chained with other pinning calls.
    func pinSize(
        to constant: CGFloat,
        priority: UILayoutPriority = .required
    ) -> UIView {
        let size = CGSize(width: constant, height: constant)
        return pinSize(to: size, priority: priority)
    }
}

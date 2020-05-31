//
//  Animator.swift
//  CustomCollectionLayout
//
//  Created by Vladimir Drozdin on 30/05/20.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import UIKit

final class Animator: NSObject, UIViewControllerAnimatedTransitioning {

    static let duration: TimeInterval = 0.5
    private let type: PresentationType
    private let firstViewController: MainViewController
    private let secondViewController: InfoViewController
    private var selectedCellImageViewSnapshot: UIView
    private let cellImageViewRect: CGRect

    init?(type: PresentationType, firstViewController: MainViewController, secondViewController: InfoViewController, selectedCellImageViewSnapshot: UIView) {
        self.type = type
        self.firstViewController = firstViewController
        self.secondViewController = secondViewController
        self.selectedCellImageViewSnapshot = selectedCellImageViewSnapshot

        guard let window = firstViewController.view.window ?? secondViewController.view.window,
            let selectedCell = firstViewController.selectedCell
            else { return nil }

        self.cellImageViewRect = selectedCell.ibImageView.convert(selectedCell.ibImageView.bounds, to: window)
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = secondViewController.view else {
            transitionContext.completeTransition(false)
            return
        }

        containerView.addSubview(toView)

        guard let selectedCell = firstViewController.selectedCell,
            let window = firstViewController.view.window ?? secondViewController.view.window,
            let cellImageSnapshot = selectedCell.ibImageView.snapshotView(afterScreenUpdates: true),
            let controllerImageSnapshot = secondViewController.profileImageView.snapshotView(afterScreenUpdates: true)
            else {
                transitionContext.completeTransition(true)
                return
        }

        let isPresenting = type.isPresenting

        let backgroundView: UIView
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = secondViewController.view.backgroundColor

        if isPresenting {
            selectedCellImageViewSnapshot = cellImageSnapshot

                backgroundView = UIView(frame: containerView.bounds)
                backgroundView.addSubview(fadeView)
                fadeView.alpha = 0
            } else {
                backgroundView = firstViewController.view.snapshotView(afterScreenUpdates: true) ?? fadeView
                backgroundView.addSubview(fadeView)
            }
 
            toView.alpha = 0

            [backgroundView, selectedCellImageViewSnapshot, controllerImageSnapshot].forEach { containerView.addSubview($0) }
        
            let controllerImageViewRect = secondViewController.profileImageView.convert(secondViewController.profileImageView.bounds, to: window)

            [selectedCellImageViewSnapshot, controllerImageSnapshot].forEach {
                $0.frame = isPresenting ? cellImageViewRect : controllerImageViewRect
            }
        
            controllerImageSnapshot.alpha = isPresenting ? 0 : 1

            selectedCellImageViewSnapshot.alpha = isPresenting ? 1 : 0
 
            UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {

                   self.selectedCellImageViewSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
                   controllerImageSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
                    fadeView.alpha = isPresenting ? 1 : 0
                }
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                    self.selectedCellImageViewSnapshot.alpha = isPresenting ? 0 : 1
                    controllerImageSnapshot.alpha = isPresenting ? 1 : 0
                }
            }, completion: { _ in

                self.selectedCellImageViewSnapshot.removeFromSuperview()
                controllerImageSnapshot.removeFromSuperview()
                
                backgroundView.removeFromSuperview()
                
                toView.alpha = 1

                transitionContext.completeTransition(true)
            })
        
    }
}

enum PresentationType {

    case present
    case dismiss

    var isPresenting: Bool {
        return self == .present
    }
}

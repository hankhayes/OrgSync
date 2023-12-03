//
//  PresentRight.swift
//  OrgSync
//
//  Created by Hank Hayes on 11/1/23.
//

import UIKit

class PresentRight: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    var animator: UIViewImplicitlyAnimating?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.interruptibleAnimator(using: transitionContext)
        animator.startAnimation()
    }

    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if self.animator != nil {
            return self.animator!
        }

        let container = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: .from)!

        let fromViewInitialFrame = transitionContext.initialFrame(for: fromVC)
        var fromViewFinalFrame = fromViewInitialFrame
        fromViewFinalFrame.origin.x = -fromViewFinalFrame.width

        let fromView = fromVC.view!
        let toView = transitionContext.view(forKey: .to)!

        var toViewInitialFrame = fromViewInitialFrame
        toViewInitialFrame.origin.x = toView.frame.size.width

        toView.frame = toViewInitialFrame
        container.addSubview(toView)

        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {

            toView.frame = fromViewInitialFrame
            fromView.frame = fromViewFinalFrame
        }

        animator.addCompletion { _ in
            transitionContext.completeTransition(true)
        }

        self.animator = animator

        return animator

    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        self.animator = nil
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentRight()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissRight()
    }
    
    
}


//
//  CustomUINavigationController.swift
//  VKontakte
//
//  Created by Valya on 18.07.2022.
//


import UIKit

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
    
    var viewController: UIViewController? {
        didSet {
        let recognizer = UIScreenEdgePanGestureRecognizer(target: self,
                                                          action: #selector(handleScreenEdgeGesture(_:)))
        recognizer.edges = [.left]
        viewController?.view.addGestureRecognizer(recognizer) }
    }
    
    @objc func handleScreenEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        
        switch recognizer.state {
            
        case .began:
            //Пользователь начал тянуть
            hasStarted = true
            viewController?.navigationController?.popViewController(animated: true)
            
        case .changed:
            //Пользователь продолжил тянуть
            
            guard let width = recognizer.view?.bounds.width else {
                hasStarted = false
                cancel()
                return
            }
            
            let translation = recognizer.translation(in: recognizer.view)
            
            let relativeTranslation = translation.x / width
            
            let progress = max(0, min(1, relativeTranslation))
            
            update(progress)
            
            shouldFinish = progress > 0.2
            
        case .ended:
            hasStarted = false
            shouldFinish ? finish() : cancel()
            
        case .cancelled:
            hasStarted = false
            cancel()
            
        default:
            break
        }
    }
}

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    let interactiveTransition = CustomInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            self.interactiveTransition.viewController = toVC
            return PushAnimator()
        }
        else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.viewController = toVC
            }
            return PopAnimator()
        }
        return nil
    }
    
    
    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
}

import UIKit
import QuartzCore

class ContainerViewController: UIViewController {
    
    enum SlideOutState {
        case Collapsed
        case leftPanelExpanded
    }
    
    let centerPanelExpandedOffset: CGFloat = 60
    var currentState: SlideOutState = .Collapsed {
        didSet {
            let shouldShowShadow = currentState != .Collapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    
    var leftViewController: SidePanelViewController?
    
    var centerNavigationController: UINavigationController!
    var centerViewController: CenterViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        centerNavigationController.navigationBar.barTintColor = UIColor.purple
        centerNavigationController.navigationBar.backgroundColor = UIColor.purple
        centerNavigationController.navigationBar.tintColor = UIColor.white
        centerNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        centerViewController.navigationItem.title = "Social Groups"
        centerNavigationController.didMove(toParentViewController: self)
        
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
//        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
        
    }
}

// MARK: CenterViewController delegate

extension ContainerViewController: CenterViewControllerDelegate {
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func collapseSidePanels() {
        animateLeftPanel(shouldExpand: false)
    }
    
    func addLeftPanelViewController() {
        guard leftViewController == nil else { return }
        
        if let vc = UIStoryboard.leftViewController() {
            vc.delegate = centerViewController
            addChildSidePanelController(vc)
            leftViewController = vc
        }
    }
    
    func addChildSidePanelController(_ sidePanelController: SidePanelViewController) {
        
        view.insertSubview(sidePanelController.view, at: 0)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            currentState = .leftPanelExpanded
            animateCenterPanelXPosition(
                targetPosition: centerNavigationController.view.frame.width - centerPanelExpandedOffset)
            
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .Collapsed
                self.leftViewController?.view.removeFromSuperview()
                self.leftViewController = nil
            }
        }
        
    }
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut, animations: {
                        self.centerNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func showShadowForCenterViewController(_ shouldShowShadow: Bool) {
        
        if shouldShowShadow {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
}

// MARK: Gesture recognizer

extension ContainerViewController: UIGestureRecognizerDelegate {
    
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.velocity(in: view).x < 0 {
            return
        }
        let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
        
        switch recognizer.state {
            
        case .began:
            if currentState == .Collapsed {
                if gestureIsDraggingFromLeftToRight {
                    addLeftPanelViewController()
                }
                
                showShadowForCenterViewController(true)
            }
            
        case .changed:
            if let rview = recognizer.view {
                rview.center.x = rview.center.x + recognizer.translation(in: view).x
                recognizer.setTranslation(CGPoint.zero, in: view)
            }
            
        case .ended:
            if let _ = leftViewController,
                let rview = recognizer.view {
                // animate the side panel open or closed based on whether the view
                // has moved more or less than halfway
                let hasMovedGreaterThanHalfway = rview.center.x > view.bounds.size.width
                animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
                
            }
            
        default:
            break
        }
        
    }
}

private extension UIStoryboard {
    
    static func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
    
    static func leftViewController() -> SidePanelViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "SidePanelViewController") as? SidePanelViewController
    }
    static func centerViewController() -> CenterViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "CenterViewController") as? CenterViewController
    }
}

extension UIApplication {
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(URL(string: url)!) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(URL(string: url)!)
                }
                return
            }
        }
    }
}

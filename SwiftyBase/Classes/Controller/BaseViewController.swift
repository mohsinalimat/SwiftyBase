//
//  BaseViewController.swift
//  Pods
//
//  Created by MacMini-2 on 30/08/17.
//
//

import UIKit

@IBDesignable
open class BaseViewController: UIViewController , UINavigationControllerDelegate {
    
    open var baseLayout : AppBaseLayout!
    open var aView : BaseView!
    
    open var btnName: UIButton!
    open var navigationTitleString : String!
    
    // MARK: - Lifecycle -
    
    required public init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init(iView: BaseView){
        super.init(nibName: nil, bundle: nil)
        aView = iView
    }
    
    required public init(iView: BaseView, andNavigationTitle titleString: String){
        
        super.init(nibName: nil, bundle: nil)
        aView = iView
        
        navigationTitleString = titleString
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil{
                return
            }
            self!.navigationItem.title = self!.navigationTitleString
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil{
                return
            }
            self!.navigationItem.title = self!.navigationTitleString
        }
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil{
                return
            }
            self!.navigationItem.title = self!.navigationTitleString
        }
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil{
                return
            }
            
            self!.navigationItem.title = self!.navigationTitleString
            self!.aView.endEditing(true)
        }
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    deinit{
        
        print("BaseView Controller Deinit Called")
        NotificationCenter.default.removeObserver(self)
        
        if aView != nil && aView.superview != nil{
            aView.releaseObject()
            aView.removeFromSuperview()
            aView = nil
        }
        
        if baseLayout != nil{
            baseLayout.releaseObject()
            baseLayout = nil
        }
        
        navigationTitleString = nil
    }
    
    // MARK: - Layout -
    
    open func loadViewControls(){
        
        self.view.backgroundColor = Color.appPrimaryBG.value
        self.view.addSubview(aView)
        self.view.isExclusiveTouch = true
        self.view.isMultipleTouchEnabled = true
    }
    
    open func setViewlayout(){
        
        /*  baseLayout Allocation   */
        baseLayout = AppBaseLayout()
    }
    
    public func expandViewInsideView(){
        baseLayout.expandView(aView, insideView: self.view)
    }
    
    
    // MARK: - Public Interface -
    

    
    // MARK: - User Interaction -
    
    
    // MARK: - Internal Helpers -
    
    
    // Mark - UINavigationControllerDelegate
    
}

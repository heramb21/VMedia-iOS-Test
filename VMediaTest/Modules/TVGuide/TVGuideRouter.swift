//
//  TVGuideRouter.swift
//  VMediaTest
//
//  Created by Heramb on 11/03/23.
//

import UIKit

class TVGuideRouter: PresenterToRouterChannelsProtocol {
    
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        
        print("TVGuideRouter creates the Channels module.")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController:TVGuideViewController = storyboard.instantiateViewController(withIdentifier: "TVGuideViewController") as! TVGuideViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: ViewToPresenterChannelsProtocol & InteractorToPresenterChannelsProtocol = TVGuidePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = TVGuideRouter()
        viewController.presenter?.view = viewController 
        viewController.presenter?.interactor = TVGuideInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        viewController.view.setNeedsLayout()
        
        return navigationController
    }
    
    func pushToQuoteDetail(on view: PresenterToViewChannelsProtocol, with item: ProgramItem) {
        debugPrint("pushToQuoteDetail")
    }
}

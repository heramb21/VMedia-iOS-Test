//
//  TVGuideContract.swift
//  VMediaTest
//
//  Created by Heramb on 11/03/23.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewChannelsProtocol: AnyObject {
    func onFetchChannelsSuccess()
    func onFetchChannelsFailure(error: String)
    
    func showHUD()
    func hideHUD()
    
    func deselectRowAt(row: Int)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterChannelsProtocol: AnyObject {
    
    var view: PresenterToViewChannelsProtocol? { get set }
    var interactor: PresenterToInteractorChannelsProtocol? { get set }
    var router: PresenterToRouterChannelsProtocol? { get set }
    
    var ChannelsStrings: [String]? { get set }
    var ChannelsID: [Int]? { get set}
    var ProgramItems: [ProgramItem]? { get set}
    
    func viewDidLoad()
    
    func refresh()
    
    func numberOfRowsInSection() -> Int
    func textLabelText(indexPath: IndexPath) -> String?
    
    func didSelectRowAt(index: Int)
    func deselectRowAt(index: Int)

}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorChannelsProtocol: AnyObject {
    
    var presenter: InteractorToPresenterChannelsProtocol? { get set }
    
    func loadChannels()
    func loadProgramItems()
    func retrieveChannels(at index: Int)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterChannelsProtocol: AnyObject {
    
    func fetchChannelsSuccess(Channels: [Channel])
    func fetchChannelsFailure(errorCode: Int)
    
    func getProgramItemSuccess(_ items: [ProgramItem])
    func getProgramItemFailure()
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterChannelsProtocol: AnyObject {
    
    static func createModule() -> UINavigationController
    
    func pushToQuoteDetail(on view: PresenterToViewChannelsProtocol, with item: ProgramItem)
}


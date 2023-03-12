//
//  TVGuidePresenter.swift
//  VMediaTest
//
//  Created by Heramb on 11/03/23.
//

import Foundation

class TVGuidePresenter: ViewToPresenterChannelsProtocol {
    var ChannelsStrings: [String]?
    var ProgramItems: [ProgramItem]?
    var ChannelsID: [Int]?
    
    // MARK: Properties
    weak var view: PresenterToViewChannelsProtocol?
    var interactor: PresenterToInteractorChannelsProtocol?
    var router: PresenterToRouterChannelsProtocol?
    
    var programItemNameStrings: [String]?
    
    // MARK: Inputs from view
    func viewDidLoad() {
        print("Presenter is being notified that the View was loaded.")
        view?.showHUD()
        interactor?.loadChannels()
        interactor?.loadProgramItems()
    }
    
    func refresh() {
        print("Presenter is being notified that the View was refreshed.")
        view?.showHUD()
        interactor?.loadChannels()
        interactor?.loadProgramItems()
    }
    
    func numberOfRowsInSection() -> Int {
        guard let ChannelsStrings = self.ChannelsStrings else {
            return 0
        }
        
        return ChannelsStrings.count
    }
    
    func textLabelText(indexPath: IndexPath) -> String? {
        guard let ChannelsStrings = self.programItemNameStrings else {
            return nil
        }
        
        return ChannelsStrings[indexPath.row]
    }

    
    func didSelectRowAt(index: Int) {
        interactor?.retrieveChannels(at: index)
    }
    
    func deselectRowAt(index: Int) {
        view?.deselectRowAt(row: index)
    }
    
}

// MARK: - Outputs to view
extension TVGuidePresenter: InteractorToPresenterChannelsProtocol {
    
    func fetchChannelsSuccess(Channels: [Channel]) {
        print("Presenter receives the result from Interactor after it's done its job.")
        self.ChannelsStrings = Channels.compactMap { $0.callSign }
        self.ChannelsID = Channels.compactMap { $0.id }
        view?.hideHUD()
        view?.onFetchChannelsSuccess()
    }
    
    func fetchChannelsFailure(errorCode: Int) {
        print("Presenter receives the result from Interactor after it's done its job.")
        view?.hideHUD()
        view?.onFetchChannelsFailure(error: "Couldn't fetch Channels: \(errorCode)")
    }
    
    func getProgramItemSuccess(_ items: [ProgramItem]) {
        view?.hideHUD()
        debugPrint("\(items)")
        self.ProgramItems = items
    }
    
    func getProgramItemFailure() {
        view?.hideHUD()
        print("Couldn't retrieve ProgramItem")
    }
    
    
}

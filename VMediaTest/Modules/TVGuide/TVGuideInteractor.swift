//
//  TVGuideInteractor.swift
//  VMediaTest
//
//  Created by Heramb on 11/03/23.
//

import Foundation

class TVGuideInteractor: PresenterToInteractorChannelsProtocol {
    
    // MARK: Properties
    weak var presenter: InteractorToPresenterChannelsProtocol?
    var channels: [Channel]?
    var programItems: [ProgramItem]?
    
    
    func loadChannels() {
        print("Interactor receives the request from Presenter to load quotes from the server.")
        ChannelsService.shared.getChannels(count: 30, success: { (code, channel) in
            self.channels = channel
            self.presenter?.fetchChannelsSuccess(Channels: channel)
        }) { (code) in
            self.presenter?.fetchChannelsFailure(errorCode: code)
        }
    }
    
    func loadProgramItems(){
        ProgramItemService.shared.getProgramItems(count: 30) { (code, programs) in
            self.programItems = programs
            self.presenter?.getProgramItemSuccess(programs)
        } failure: { (code) in
            self.presenter?.getProgramItemFailure()
        }

    }
    
    func retrieveChannels(at index: Int) {
        guard let channels = self.channels, channels.indices.contains(index) else {
            self.presenter?.getProgramItemFailure()
            return
        }
    }

}


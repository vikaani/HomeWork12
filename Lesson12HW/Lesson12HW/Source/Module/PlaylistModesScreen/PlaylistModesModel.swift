//
//  PlaylistModesModel.swift
//  Lesson12HW
//

//

import Foundation

protocol PlaylistModesModelDelegate: AnyObject {
    func dataDidLoad()
}

class PlaylistModesModel {
    
    weak var delegate: PlaylistModesModelDelegate?
    private let dataLoader = DataLoaderService()
    
    var items: [Song] = [] 
        
    func loadData() {
        
        dataLoader.loadPlaylist { [weak self] playlist in
            
            self?.items = playlist?.songs ?? []
            self?.delegate?.dataDidLoad()
        }
    }
}

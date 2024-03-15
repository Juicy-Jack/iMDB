//
//  PersonDetailServiceView.swift
//  iMDB
//
//  Created by Furkan Doğan on 15.03.2024.
//

import Foundation
import Combine

class PersonDetailDataService {
    @Published var person: Person? = nil
    var personDetailSubsctiption: AnyCancellable?
    
    var personID: Int
    
    init(personID: Int) {
        self.personID = personID
        getCredits()
    }
    
    func getCredits() {
        guard let url = URL(string: "https://api.themoviedb.org/3/person/\(personID)?language=en-US") else { return }
            
        personDetailSubsctiption = NetworkingManager.download(url: url)
            .decode(type: Person.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCredits) in
                self?.person = returnedCredits
                self?.personDetailSubsctiption?.cancel()
            })
    }
}

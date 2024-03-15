//
//  PersonDetailViewModel.swift
//  iMDB
//
//  Created by Furkan Doğan on 15.03.2024.
//

import Foundation
import Combine

class PersonDetailViewModel: ObservableObject {
    
    @Published var personID: Int
    @Published var person: Person? = nil
    
    private let personDetailDataService: PersonDetailDataService
    private var cancellables = Set<AnyCancellable>()

    
    let examplePerson = Person(adult: false, alsoKnownAs: [
        "دانيال رادكليف",
        "ダニエル・ラドクリフ",
        "Дэниэл Рэдклифф",
        "แดเนียล แรดคลิฟฟ์",
        "丹尼爾·域卡夫",
        "Деніел Редкліфф",
        "丹尼尔·雷德克里夫",
        "丹尼尔·雅各布·雷德克里夫",
        "ダニエル・ジェイコブ・ラドクリフ",
        "丹尼尔·拉德克利夫",
        "다니엘 래드클리프"
    ], biography: "Daniel Jacob Radcliffe (born 23 July 1989) is an English actor. He rose to fame at age twelve, when he began portraying Harry Potter in the film series of the same name; and has held various other film and theatre roles. Over his career, Radcliffe has received various awards and nominations.\n\nRadcliffe made his acting debut at age 10 in the BBC One television film David Copperfield (1999), followed by his feature film debut in The Tailor of Panama (2001). The same year, he starred as Harry Potter in the film adaptation of the J.K. Rowling fantasy novel, Harry Potter and the Philosopher's Stone. Over the next decade, he played the eponymous role in seven sequels, culminating with Harry Potter and the Deathly Hallows – Part 2 (2011). During this period, he became one of the world's highest-paid actors and gained worldwide fame, popularity, and critical acclaim.\n\nFollowing the success of Harry Potter, Radcliffe starred in the romantic comedy What If? (2013), and played the lawyer Arthur Kipps in the horror film The Woman in Black (2012), poet Allen Ginsberg in the drama film Kill Your Darlings (2013), Igor in the science-fiction horror film Victor Frankenstein (2015), a sentient corpse in the comedy-drama film Swiss Army Man (2016), technological prodigy Walter Mabry in the heist thriller film Now You See Me 2 (2016), and FBI agent Nate Foster in the critically acclaimed thriller film Imperium (2016). Since 2019, he has starred in the TBS anthology series Miracle Workers. In 2022, he starred in the action comedy The Lost City and portrayed Weird Al Yankovic in Weird: The Al Yankovic Story.\n\nRadcliffe branched out to stage acting in 2007, starring in the West End and Broadway productions of Equus. From 2011 to 2012 he portrayed J. Pierrepont Finch in the Broadway revival of the musical How to Succeed in Business Without Really Trying. He continued in Martin McDonagh's dark comedy The Cripple of Inishmaan (2013-2014) in the West End and Broadway and a revival of Tom Stoppard's play Rosencrantz and Guildenstern Are Dead (2017) at The Old Vic. He also starred in the satirical plays Privacy (2016) and The Lifespan of a Fact (2018), respectively off and on Broadway. In 2022 starred in the New York Theatre Workshop revival of Stephen Sondheim's Merrily We Roll Along.", birthday: "1989-07-23", deathday: nil, gender: 2, homepage: nil, id: 10980, imdbID: "nm0705356", knownForDepartment: "Acting", name: "Daniel Jacob Radcliffe", placeOfBirth: "Hammersmith, London, England, UK", popularity: 62.252, profilePath: "/iPg0J9UzAlPj1fLEJNllpW9IhGe.jpg")
    
    init(personID: Int) {
        self.personID = personID
        self.personDetailDataService = PersonDetailDataService(personID: personID)
        addSubscriber()
    }
    
    func addSubscriber() {
        personDetailDataService.$person
            .sink { [weak self] (returnedPerson) in
                self?.person = returnedPerson
            }
            .store(in: &cancellables)
    }
}

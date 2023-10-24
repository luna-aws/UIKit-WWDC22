//
//  HomeListViewModel.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/19/23.
//

import Combine
import Foundation

protocol TopicListViewModelRepresentable {
    
    var topicsValueSubject: CurrentValueSubject<[Topic], Error> { get }
    
    func loadData()
    func didTapItem(with indexPath: IndexPath)
}

final class TopicListViewModel<R: TopicRouter> {
    
    private let router: R
    
    private var topics: [Topic] = [] {
        didSet {
            topicsValueSubject.send(topics)
        }
    }
    
    internal var topicsValueSubject = CurrentValueSubject<[Topic], Error>([])
    
    init(router: R) {
        self.router = router
    }
}

extension TopicListViewModel: TopicListViewModelRepresentable {
    
    func loadData() {
        topics.append(Topic(name: "Page Control", description: "Description"))
        topics.append(Topic(name: "Page Control", description: "Description"))
        topics.append(Topic(name: "Page Control", description: "Description"))
    }
    
    func didTapItem(with indexPath: IndexPath) {
        let topic = topics[indexPath.row]
        router.process(route: .showPageControlDetail(topic))
    }
}

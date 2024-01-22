//
//  ReviewsViewModel.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 19.01.2024.
//

import Foundation

final class ReviewsViewModel {
    
    // MARK: - Observables
    @Observable
    private(set) var reviews: [ReviewsCellModel] = []
    
    @Observable
    private(set) var isLoading: Bool = false
    
    // MARK: - Properties
    weak var coordinator: ReviewsCoordinator?
    private(set) var userID: Int
    private let reviewsService: ReviewsService
    private let carByIdService: CarByIdService
    
    // MARK: - LifeCycle
    init(
        userID: Int,
        reviewsService: ReviewsService = ReviewsService(),
        carByIdService: CarByIdService = CarByIdService()
    ) {
        self.userID = userID
        self.reviewsService = reviewsService
        self.carByIdService = carByIdService
    }
    
    // MARK: - Methods
    func getReviewsFromNetwork() {
        isLoading = true
        reviewsService.getReviews(for: "\(userID)") { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let userReviews):
                if userReviews.count != 0 {
                    self.getCarsInfo(for: userReviews)
                } else {
                    self.isLoading = false
                }
            case .failure(let error):
                self.isLoading = false
                print("Ошибка получения отвызов: \(error)")
            }
        }
    }
    
    private func getCarsInfo(for userReviews: [Review]) {
        for review in userReviews {
            carByIdService.getCar(for: "\(review.car)") { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let car):
                    let reviewsCellModel = ReviewsCellModel(
                        date: review.createdAt,
                        carModel: "\(car.brand) \(car.model)",
                        company: car.company,
                        rating: Int(review.rating),
                        comment: review.comment
                    )
                    self.reviews.append(reviewsCellModel)
                case .failure(let error):
                    self.isLoading = false
                    print("Ошибка получения отвызов: \(error)")
                }
                if self.reviews.count == userReviews.count {
                    self.isLoading = false
                }
            }
        }
    }
}

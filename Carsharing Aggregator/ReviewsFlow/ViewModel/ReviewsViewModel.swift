//
//  ReviewsViewModel.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 19.01.2024.
//

import Foundation

final class ReviewsViewModel {
    
    // MARK: - Observables
    
    // MARK: - Properties
    weak var coordinator: ReviewsCoordinator?
    var reviews: [ReviewsCellModel] = []
    
    // MARK: - LifeCycle
    init() {
        getReviews()
    }
    // MARK: - Methods
    private func getReviews() {
        reviews = [
            ReviewsCellModel(
                date: "01.01.2024",
                carModel: "BMW",
                company: .BelkaCar,
                rating: 3,
                comment: "Первый раз взял Яндекс Драйв, навигация немного тупила, но автомобиль новый и чистый. Понравилось."
            ),
            ReviewsCellModel(
                date: "01.01.2024",
                carModel: "KIA",
                company: .CityDrive,
                rating: 4,
                comment: "Круто"
            ),
            ReviewsCellModel(
                date: "01.01.2024",
                carModel: "OPEL",
                company: .YandexDrive,
                rating: 1,
                comment: "Первый раз взял Яндекс Драйв, навигация немного тупила, но автомобиль новый и чистый. Понравилось. Первый раз взял Яндекс Драйв, навигация немного тупила. Понравилось."
            )
        ]
    }
}

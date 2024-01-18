//
//  ReviewAndRatingViewModel.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 16.01.2024.
//

import Foundation

class ReviewAndRatingViewModel {
    weak var coordinator: ReviewAndRatingCordinator?
    
    func saveReviewAndRating(rating: Int, comment: String) {
    deleteCarFromUserDefaults()
    }
    
    private func deleteCarFromUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "car")
    }
}

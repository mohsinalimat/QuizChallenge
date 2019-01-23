//
//  TopicQuizCell.swift
//  QuizChallenge
//
//  Created by Anton Makarov on 22/01/2019.
//  Copyright © 2019 Anton Makarov. All rights reserved.
//

import UIKit

class TopicQuizCell: UICollectionViewCell {
    
    var delegate: PrepareDelegate?

    @IBAction func startGame(_ sender: Any) {
        delegate?.startGame()
    }
}

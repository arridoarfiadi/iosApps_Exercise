//
//  Question.swift
//  Quizzler
//
//  Created by Arrido Arfiadi on 8/1/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class Question {
    let questionText: String
    let answer: Bool
    init(question: String, answer: Bool) {
        self.questionText = question
        self.answer = answer
    }
    func getQuestion() -> String{
        return self.questionText
    }
    func getAnswer() -> Bool{
        return self.answer
    }
}

//
//  SettingsViewController.swift
//  QuizChallenge
//
//  Created by Anton Makarov on 26/01/2019.
//  Copyright © 2019 Anton Makarov. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var profileImage: IBImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var backgroundSoundSwitch: UISwitch!
    @IBOutlet weak var notificationsSwitch: UISwitch!
    @IBOutlet weak var saveQuestionsSwitch: UISwitch!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSwitchPositions()
    }
    
    // MARK: - Actions
    
    @IBAction func switchAction(_ sender: UISwitch) {
            try! RealmManager.shared.updateSettings(sound: backgroundSoundSwitch.isOn, notify: notificationsSwitch.isOn, saveQuestion: saveQuestionsSwitch.isOn, payButton: true)
    }
    
    @IBAction func resetGameProgress(_ sender: Any) {
        // TODO: Reset Game Statisctics logic
    }
    
    @IBAction func logOut(_ sender: Any) {
        // TODO: LogOut logic
    }
    
    @IBAction func pressBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private
    
    private func setSwitchPositions() {
        guard let settings = RealmManager.shared.getObjectByID(SettingsModel.self, id: 1) else {
            return
        }
        
        // FIXME: Turn On at start app
        //AudioManager.shared.playMusic()
        backgroundSoundSwitch.isOn = settings.backgroundSoud
        notificationsSwitch.isOn = settings.notifications
        saveQuestionsSwitch.isOn = settings.saveQuestions
    }
}
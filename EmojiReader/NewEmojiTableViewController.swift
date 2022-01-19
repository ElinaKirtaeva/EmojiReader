//
//  NewEmojiTableViewController.swift
//  EmojiReader
//
//  Created by Элина Рупова on 19.01.2022.
//

import UIKit

class NewEmojiTableViewController: UITableViewController {
    
    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var emoji = Emoji(emoji: "", name: "", description: "", isFavourite: false)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        updateSaveButton()
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButton()
    }
    
    func updateSaveButton() {
        let emojiText = emojiTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descrText = descriptionTextField.text ?? ""
        
        saveButton.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !descrText.isEmpty
    }
    
    func updateUI() {
        emojiTextField.text = emoji.emoji
        nameTextField.text = emoji.name
        descriptionTextField.text = emoji.description
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else {return}
        let emojiText = emojiTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descrText = descriptionTextField.text ?? ""
        
        self.emoji = Emoji(emoji: emojiText, name: nameText, description: descrText, isFavourite: false)
    }
}

//
//  EmojiTableViewController.swift
//  EmojiReader
//
//  Created by Элина Рупова on 18.01.2022.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    var objects = [
        Emoji(emoji: "🥰", name: "Love", description: "Let's love each other", isFavourite: false),
        Emoji(emoji: "⚽️", name: "Football", description: "Let's play football together", isFavourite: false),
        Emoji(emoji: "🐫", name: "Camel", description: "Camels live in Africa", isFavourite: false)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Emoji Reader"
        self.navigationItem.leftBarButtonItem = self.editButtonItem

    }

    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else {return}
        let sourseVC = segue.source as! NewEmojiTableViewController
        let emoji = sourseVC.emoji
        if let selectedIndex = tableView.indexPathForSelectedRow {
            objects[selectedIndex.row] = emoji
            tableView.reloadRows(at: [selectedIndex], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: objects.count, section: 0)
            objects.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }

    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        let object = objects[indexPath.row]
        cell.setEmoji(object: object)
        return cell
    }
   
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(moveEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let like = likeAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, like])
    }
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    
    func likeAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Like") { (action, view, completion) in
            self.objects[indexPath.row].isFavourite = !self.objects[indexPath.row].isFavourite
            completion(true)
        }
        if self.objects[indexPath.row].isFavourite {
            action.backgroundColor = .systemPurple
            action.image = UIImage(systemName: "suit.heart.fill")
        } else {
            action.backgroundColor = .systemGray
            action.image = UIImage(systemName: "suit.heart")
        }

        return action
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "edit" else {return}
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = objects[indexPath.row]
        
        let navigationVC = segue.destination as! UINavigationController
        let newEmojiVC = navigationVC.topViewController as! NewEmojiTableViewController
        newEmojiVC.emoji = emoji
        newEmojiVC.title = "Edit"
    }

}

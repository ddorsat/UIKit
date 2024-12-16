//
//  ViewController.swift
//  Contacts
//
//  Created by Dmitry on 16.12.2024.
//

import UIKit

class ViewController: UIViewController {

    private var contacts = [ContactProtocol]() {
        didSet {
            contacts.sort { $0.title < $1.title }
        }
    }
    private func loadContacts() {
        contacts.append(Contact(title: "Dmitry", phone: "79998564843"))
        contacts.append(Contact(title: "John", phone: "79998587882"))
        contacts.append(Contact(title: "Mark", phone: "79263224322"))
    }

    override func viewDidLoad() {
        loadContacts()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet var tableView: UITableView!
    @IBAction func showNewContactAlert() {
        let alertController = UIAlertController(
            title: "Создать новый контакт", message: "Введите имя и телефон",
            preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Имя"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Номер телефона"
        }

        let createButton = UIAlertAction(title: "Создать", style: .default) {
            _ in
            guard let contactName = alertController.textFields?[0].text,
                let contactPhone = alertController.textFields?[1].text
            else {
                return
            }
            let contact = Contact(title: contactName, phone: contactPhone)
            self.contacts.append(contact)
            self.tableView.reloadData()
        }

        let cancelButton = UIAlertAction(
            title: "Отменить", style: .cancel, handler: nil)

        alertController.addAction(createButton)
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(
            withIdentifier: "MyCell")
        {
            print("Используем старую ячейку \(indexPath.row)")
            cell = reuseCell
        } else {
            print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
            cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        }
        configure(cell: &cell, for: indexPath)
        return cell
    }

    private func configure(
        cell: inout UITableViewCell, for indexPath: IndexPath
    ) {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = contacts[indexPath.row].title
        configuration.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration = configuration
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {

        let actionDelete = UIContextualAction(
            style: .destructive, title: "Удалить"
        ) { _, _, _ in
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }

        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}

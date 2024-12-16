import Foundation

protocol MessageProtocol {
    var text: String? { get set }
    var image: Data? { get set }
    var audio: Data? { get set }
    var video: Data? { get set }
    var sendDate: Date { get set }
    var senderId: UInt { get set }
}

struct Message: MessageProtocol {
    var text: String?
    var image: Data?
    var audio: Data?
    var video: Data?
    var sendDate: Date
    var senderId: UInt
}

protocol StatisticDelegate: AnyObject {
    func handle(message: MessageProtocol)
}

protocol MessengerProtocol {
    var messages: [MessageProtocol] { get set }
    var statisticDelegate: StatisticDelegate? { get set }
    init()
    mutating func receive(message: MessageProtocol)
    mutating func send(message: MessageProtocol)
}

extension Messenger: StatisticDelegate {
    func handle(message: any MessageProtocol) {
        print("Обработка сообщения от User #\(message.senderId) завершена")
    }
}

class Messenger: MessengerProtocol {
    var messages: [MessageProtocol]
    var statisticDelegate: StatisticDelegate?

    required init() {
        messages = []
    }

    func receive(message: MessageProtocol) {
        statisticDelegate?.handle(message: message)
        messages.append(message)
    }

    func send(message: MessageProtocol) {
        statisticDelegate?.handle(message: message)
        messages.append(message)
    }
}

var messenger = Messenger()
messenger.statisticDelegate = messenger.self
messenger.send(message: Message(text: "Hello", sendDate: Date(), senderId: 1))
messenger.messages.count
(messenger.statisticDelegate as! Messenger).messages.count

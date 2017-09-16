//
//  Command.swift
//  DiscountMarket
//
//  Created by Timofey on 5/31/17.
//  Copyright © 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit

protocol Command {
    func execute()
}

struct CommandWithTitle: Titlable, Command {

    let title: String
    private let origin: Command

    init(_ origin: Command, title: String) {
        self.origin = origin
        self.title = title
    }

    func execute() {
        origin.execute()
    }
}

struct CommandTo: Command {

    private let action: () -> ()
    init(action: @escaping () -> ()) {
        self.action = action
    }

    func execute() {
        action()
    }

}

struct CommandToDoNothing: Command {

    func execute() { }

}

class MergedCommand: Command {

    private let commands: [Command]
    init(commands: [Command]) {
        self.commands = commands
    }

    func execute() {
        commands.forEach{ $0.execute() }
    }

}

//TODO: Migrate all commands to this protocol
protocol GenericCommand {

    associatedtype T
    func execute(with: T)

    func toGenericCommand() -> GenericCommandTo<T>

}

extension GenericCommand {

    func toGenericCommand() -> GenericCommandTo<T> {
        return GenericCommandTo<T>(action: self.execute)
    }

}

struct GenericCommandWithTitle<T>: GenericCommand, Titlable {

    let title: String
    private let origin: GenericCommandTo<T>

    init<Command: GenericCommand>(_ origin: Command, title: String) where Command.T == T {
        self.origin = origin.toGenericCommand()
        self.title = title
    }

    func execute(with element: T) {
        origin.execute(with: element)
    }

    func toGenericCommand() -> GenericCommandTo<T> {
        return origin
    }
}

struct GenericCommandTo<T>: GenericCommand {

    private let action: (T) -> ()
    init(action: @escaping (T) -> ()) {
        self.action = action
    }

    func execute(with element: T) {
        action(element)
    }

    func toGenericCommand() -> GenericCommandTo<T> {
        return self
    }
}

struct GenericCommandToDoNothing<T>: GenericCommand {

    func execute(with element: T) { }

    func toGenericCommand() -> GenericCommandTo<T> {
        return GenericCommandTo{ _ in }
    }
}

class CommandToShowMessage: GenericCommand {

    private let action: (UIViewController) -> ()
    init(_ message: String, title: String) {
        self.action = { viewController in
            viewController.showMessage(message, withTitle: title)
        }
    }

    func execute(with viewController: UIViewController) {
        self.action(viewController)
    }

}

class MergedGenericCommand<T>: GenericCommand {

    private let commands: [GenericCommandTo<T>]
    init<Command: GenericCommand>(commands: [Command]) where Command.T == T {
        self.commands = commands.map{ $0.toGenericCommand() }
    }

    func execute(with element: T) {
        commands.forEach{ $0.execute(with: element) }
    }

}

class CommandToPopFromNavigationController: GenericCommand {

    func execute(with viewController: UIViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }

}

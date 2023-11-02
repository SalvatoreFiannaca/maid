import 'dart:collection';

import 'package:flutter/material.dart';

class ChatNode {
  final Key key;
  final String message;
  final bool userGenerated;

  int currentChild = 0;
  List<ChatNode> children;

  ChatNode({
    required this.key,
    required this.message,
    List<ChatNode>? children, // This now takes in a nullable list
    this.userGenerated = false,
  }) : this.children = children ?? [];

  ChatNode? find(Key targetKey) {
    final Queue<ChatNode> queue = Queue.from([this]);

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();

      if (current.key == targetKey) {
        return current;
      }

      for (var child in current.children) {
        queue.add(child);
      }
    }

    return null;
  }

  List<ChatNode>? getPath(Key targetKey) {
    final Map<ChatNode, ChatNode?> parents = {};  // ChatNode? for values
    final Queue<ChatNode> queue = Queue.from([this]);

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();

      if (current.key == targetKey) {
        final path = <ChatNode>[];

        var nodeInPath = current;
        while (true) {
          path.insert(0, nodeInPath);
          final parentNode = parents[nodeInPath];
          if (parentNode != null) {
            nodeInPath = parentNode;
          } else {
            break;
          }
        }

        return path;
      }

      for (var child in current.children) {
        parents[child] = current;
        queue.add(child);
      }
    }

    return null;
  }


  ChatNode? getParent(ChatNode target) {
    final Queue<ChatNode> queue = Queue.from([this]);

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();

      for (var child in current.children) {
        if (child == target) {
          return current;
        }
        queue.add(child);
      }
    }

    return null;
  }
}
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final List<Map<String, dynamic>> messages = [
    {
      "text":
          "Lorem Ipsum is simplyng industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic",
      "isMe": false
    },
    {"text": "I'm good, thanks! What about you?", "isMe": true},
    {
      "text": "I'm doing well. Just working on a Flutter project.",
      "isMe": false
    },
    {"text": "Sounds great! Flutter is awesome.", "isMe": true},
    {
      "text":
          "Lorem Ipsum is simplyng industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic",
      "isMe": false
    },
    {"text": "I'm good, thanks! What about you?", "isMe": true},
    {
      "text": "I'm doing well. Just working on a Flutter project.",
      "isMe": false
    },
    {"text": "Sounds great! Flutter is awesome.", "isMe": true},
  ];

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 241),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.close, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.chat, size: 30),
                      const SizedBox(width: 15),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'JOHN DOE',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Online',
                            style:
                                TextStyle(fontSize: 13, color: Colors.purple),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.more_vert_rounded),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(
                    text: messages[index]['text'],
                    isMe: messages[index]['isMe'],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                focusNode: _focusNode,
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        backgroundColor: const Color.fromARGB(255, 227, 227, 241),
        buttonBackgroundColor: Colors.grey[200],
        items: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(_focusNode);
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: const Icon(
                Icons.keyboard,
                size: 25,
              ),
            ),
          ),
          const CircleAvatar(
            backgroundColor: Colors.purple,
            child: Icon(
              Icons.chat,
              color: Colors.white,
              size: 25,
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;

  const ChatBubble({required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          const CircleAvatar(
            child: Icon(Icons.person),
          ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.65,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: isMe
                  ? Colors.grey[200]
                  : const Color.fromARGB(255, 5, 34, 57),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12.0),
                topRight: const Radius.circular(12.0),
                bottomLeft: isMe
                    ? const Radius.circular(12.0)
                    : const Radius.circular(0.0),
                bottomRight: isMe
                    ? const Radius.circular(0.0)
                    : const Radius.circular(12.0),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isMe ? Colors.black87 : Colors.white,
              ),
            ),
          ),
        ),
        if (isMe)
          const CircleAvatar(
            child: Icon(Icons.person),
          ),
      ],
    );
  }
}

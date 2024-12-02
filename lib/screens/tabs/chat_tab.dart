import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:aquaventures/utils/colors.dart';

class ChatTab extends StatefulWidget {
  final String currentUserId;
  final String receiverId;

  const ChatTab({
    super.key,
    required this.currentUserId,
    required this.receiverId,
  });

  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  final TextEditingController messageController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Send message to Firestore
  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      final message = messageController.text.trim();

      await firestore.collection('chats').add({
        'senderId': widget.currentUserId,
        'receiverId': widget.receiverId,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });

      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: 'MESSAGES',
          fontSize: 18,
          fontFamily: 'Bold',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection('chats')
                  .where('senderId', isEqualTo: widget.currentUserId)
                  .where('receiverId', isEqualTo: widget.receiverId)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No messages yet.'));
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final data = messages[index].data() as Map<String, dynamic>;
                    final isMe = data['senderId'] == widget.currentUserId;

                    return Row(
                      mainAxisAlignment: isMe
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [
                        if (isMe)
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage('assets/avatar.png'),
                            ),
                          ),
                        if (!isMe)
                          const SizedBox(width: 40), // Space for alignment
                        Expanded(
                          child: Align(
                            alignment: isMe
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5.0),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? Colors.blue[100]
                                    : Colors.greenAccent[100],
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(20),
                                  topRight: const Radius.circular(20),
                                  bottomLeft: isMe
                                      ? const Radius.circular(0)
                                      : const Radius.circular(20),
                                  bottomRight: isMe
                                      ? const Radius.circular(20)
                                      : const Radius.circular(0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 5.0,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: TextWidget(
                                text: data['message'],
                                fontSize: 16.0,
                                isItalize: false,
                                isBold: false,
                                align: TextAlign.left,
                                color: Colors.black87,
                                fontFamily: 'Regular',
                              ),
                            ),
                          ),
                        ),
                        if (!isMe)
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage('assets/avatar.png'),
                            ),
                          ),
                        if (isMe)
                          const SizedBox(width: 40), // Space for alignment
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Type here . . ',
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: sendMessage,
                  backgroundColor: primary,
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat2/Models/message_model.dart';
import 'package:scholar_chat2/custom_widgets/custom_textfield.dart';
import '../custom_widgets/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  static String id = 'ChatPage';
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  void _scrollDown() {
    _scrollController.animateTo(
      0,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  bool isLoading = false;
  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final docRef = FirebaseFirestore.instance.collection("messages");
  List<TextEditingController>? _controllers = [];
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('messages')
      .orderBy("CurrentDate", descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            isLoading = true;
          }

          if (snapshot.hasData) {
            List<MessagesModel> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(MessagesModel.fromJson(snapshot.data!.docs[i]));
            }

            return BlurryModalProgressHUD(
              inAsyncCall: isLoading = false,
              child: Scaffold(
                  appBar: AppBar(
                    title: Center(child: Text('Scholar Chat')),
                    automaticallyImplyLeading: false,
                  ),
                  body: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                        reverse: true,
                        controller: _scrollController,
                        itemCount: messagesList.length,
                        itemBuilder: ((context, index) {
                          _controllers!.add(TextEditingController());
                          return messagesList[index].id == email
                              ? ChatBubble(message: messagesList[index])
                              : ChatBubbleRecieve(message: messagesList[index]);
                        }),
                      )),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: CustomChatTextField(
                          controller: controller,
                          onSubmitted: (data) async {
                            docRef.add({
                              'message': data,
                              'CurrentDate': DateTime.now(),
                              'id': email,
                            });
                            controller.clear();
                            _scrollDown();
                          },
                        ),
                      )
                    ],
                  )),
            );
          }
          return BlurryModalProgressHUD(inAsyncCall: true, child: Scaffold());
        });
  }
}

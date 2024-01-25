import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:flutter_application_ticktok_clone/features/inbox/view_models/messages_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static String routeName = "chatdetail";
  static String routeURL = ":chatId";
  final String chatId;
  const ChatDetailScreen({super.key, required this.chatId});

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final bool _isTapped = false;
  final TextEditingController _textEditingController = TextEditingController();
  void _onTap() {
    setState(() {
      _isTapped != _isTapped;
    });
  }

  void _onSendPress() {
    final text = _textEditingController.text;
    if (text == "") {
      return;
    } else {
      ref.read(messagesProvider.notifier).sendMessage(text);
      _textEditingController.text = "";
    }
  }

  @override
  void initState() {
    _textEditingController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final mediaSize = MediaQuery.of(context).size;
    final isLoading = ref.watch(messagesProvider).isLoading;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                          radius: 23,
                          foregroundImage: NetworkImage(
                            "https://img1.daumcdn.net/thumb/C100x100/?scode=mtistory2&fname=https%3A%2F%2Ftistory3.daumcdn.net%2Ftistory%2F4506296%2Fattach%2F27003a1355e84452a5cc9d2dc88c59ca",
                          )),
                      Positioned(
                        right: -2,
                        bottom: -1,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: Colors.green.shade300,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 1.5, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  Gaps.h10,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "mroh1226 (${widget.chatId})",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Gaps.v3,
                      const Text(
                        "Active now",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  ),
                ],
              ),
              const Row(
                children: [
                  FaIcon(FontAwesomeIcons.flag),
                  Gaps.h10,
                  FaIcon(FontAwesomeIcons.barsStaggered)
                ],
              ),
            ],
          )),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70,
              child: Center(
                child: Text(
                  "December16, 2022 3:29PM",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Gaps.v10,
            MessagePop()
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: BottomAppBar(
          child: TextField(
            controller: _textEditingController,
            onTap: _onTap,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
                labelText: "Send your messages.",
                suffixIcon: GestureDetector(
                  onTap: isLoading ? null : _onSendPress,
                  child: isLoading
                      ? const CircularProgressIndicator.adaptive()
                      : const FaIcon(
                          FontAwesomeIcons.paperPlane,
                          color: Colors.blue,
                        ),
                ),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)))),
          ),
        ),
      ),
    );
  }
}

class MessagePop extends ConsumerWidget {
  const MessagePop({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(chatProvider).when(
          data: (data) {
            return IgnorePointer(
              child: ListView.separated(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final isMine =
                        data[index].userId == ref.watch(authRepo).user!.uid;
                    return Row(
                      mainAxisAlignment: isMine
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(isMine ? 15 : 0),
                                  bottomRight: Radius.circular(isMine ? 0 : 15),
                                  topLeft: const Radius.circular(15),
                                  topRight: const Radius.circular(15)),
                              color:
                                  isMine ? Colors.blue.shade700 : Colors.white),
                          child: Text(
                            data[index].text,
                            style: TextStyle(
                                color: isMine ? Colors.white : Colors.black,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Gaps.v16),
            );
          },
          error: (error, stackTrace) => const Center(
            child: Text("error"),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
  }
}

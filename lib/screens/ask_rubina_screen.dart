import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:only_vocal/components/colors.dart';

class AskRubinaScreen extends StatefulWidget {
  const AskRubinaScreen({super.key});

  @override
  State<AskRubinaScreen> createState() => _AskRubinaScreenState();
}

class _AskRubinaScreenState extends State<AskRubinaScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(_messageController.text.trim());
        _messageController.clear();
      });
      
      // Auto-scroll to bottom
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF121212),
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Ask Rubina',
          // style: GoogleFonts.roboto(
          //   color: Colors.white,
          //   fontWeight: FontWeight.bold,
          // ),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        // backgroundColor: const Color(0xFF1A1E3F),
        // backgroundColor: const Color(0xFF05152E),
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              // color: Color(0xFF1A1E3F),
              // color: Color(0xFF05152E),
                color: AppColors.background,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      // backgroundColor: const Color(0xFFFFD700),
                      // backgroundColor: const Color(0xFF2B90CA),
                      backgroundColor: AppColors.primary,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: AppColors.background,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rubina',
                          style: GoogleFonts.roboto(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your AI Assistant',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    )

                  ],
                ),

                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      // color: const Color(0xFFFFD700).withOpacity(0.3),
                      // color: const Color(0xFF2B90CA).withOpacity(0.3),
                      color: AppColors.primary.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    'Ask me anything! I\'m here to help you with your questions.',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          
          // Messages section
          Expanded(
            child: _messages.isEmpty
                ? Container()
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  // color: const Color(0xFFFFD700),
                                  // color: const Color(0xFF2B90CA),
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  _messages[index],
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    // color: const Color(0xFF121212),
                                    color: AppColors.background,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          
          // Input section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              // color: Color(0xFF1A1E3F),
              color: AppColors.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        // color: const Color(0xFFFFD700).withOpacity(0.3),
                        // color: const Color(0xFF2B90CA).withOpacity(0.3),
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                    child: TextField(
                      controller: _messageController,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: GoogleFonts.roboto(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      // color: Color(0xFFFFD700),
                      // color: Color(0xFF2B90CA),
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send,
                      // color: Color(0xFF121212),
                      // color: Color(0xFF05152E),
                      color: AppColors.background,
                      size: 20,
                    ),
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

import 'package:flutter/material.dart';

class CommentSection extends StatelessWidget {
  final List<String> comments;
  final TextEditingController commentController;
  final VoidCallback onAddComment;

  const CommentSection({
    super.key,
    required this.comments,
    required this.commentController,
    required this.onAddComment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCommentHeader(context),
          const SizedBox(height: 8),
          _buildCommentTextField(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildCommentHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Comments (${comments.length})",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextButton(
          onPressed: () => _showCommentsBottomSheet(context),
          child: const Text("Show"),
        )
      ],
    );
  }

  Widget _buildCommentTextField() {
    return TextField(
      controller: commentController,
      decoration: InputDecoration(
        hintText: "Add a comment...",
        suffixIcon: IconButton(
          icon: const Icon(Icons.send),
          onPressed: onAddComment,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showCommentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CommentListView(comments: comments);
      },
    );
  }
}
class CommentListView extends StatelessWidget {
  final List<String> comments;

  const CommentListView({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 16),
          _buildCommentsList(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Comments (${comments.length})",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildCommentsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return CommentItem(comment: comments[index]);
        },
      ),
    );
  }
}

// widgets/comment_item.dart

class CommentItem extends StatelessWidget {
  final String comment;

  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(radius: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(comment),
            ),
          ),
        ],
      ),
    );
  }
}
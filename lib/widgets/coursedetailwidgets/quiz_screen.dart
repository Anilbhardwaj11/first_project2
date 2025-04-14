import 'package:first_project/widgets/coursedetailwidgets/quiz_questions.dart';
import 'package:flutter/material.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const QuizQuestionScreen(
                  subject: 'Science',
                  currentQuestion: 1,
                  totalQuestions: 20,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey[500],
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.grey[800]!, width: 1.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Quiz name -', style: TextStyle(color: Colors.white)),
                        SizedBox(height: 4),
                        Text('Date -', style: TextStyle(color: Colors.white)),
                        SizedBox(height: 4),
                        Text('Time -', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey[800]!, width: 1.0),
                      ),
                      child: const Text(
                        'Rank 5',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Questions - 13/23',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';

class QuizQuestionScreen extends StatefulWidget {
  final String subject;
  final int currentQuestion;
  final int totalQuestions;

  const QuizQuestionScreen({
    super.key,
    required this.subject,
    required this.currentQuestion,
    required this.totalQuestions,
  });

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  int? selectedOption;
  late int currentQuestionIndex;
  
  // Sample questions and options for demo - you would replace this with your actual data
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is 2 + 2?',
      'options': ['3', '4', '5', '6'],
      'correctAnswer': 1, // Index of correct answer
    },
    {
      'question': 'What is 5 * 3?',
      'options': ['12', '15', '18', '20'],
      'correctAnswer': 1,
    },
    {
      'question': 'What is 10 - 7?',
      'options': ['1', '2', '3', '4'],
      'correctAnswer': 2,
    },
    // Add more questions as needed
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the current question index based on the prop passed
    currentQuestionIndex = widget.currentQuestion - 1;
    if (currentQuestionIndex < 0) currentQuestionIndex = 0;
    if (currentQuestionIndex >= questions.length) currentQuestionIndex = questions.length - 1;
  }

  // Get current question data
  Map<String, dynamic> get currentQuestion {
    return questions[currentQuestionIndex];
  }

  // Navigate to previous question
  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        selectedOption = null; // Reset selected option for new question
      });
    }
  }

  // Navigate to next question
  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOption = null; // Reset selected option for new question
      });
    } else {
      // Handle end of quiz
      showQuizCompletionDialog();
    }
  }
  
  // Show dialog when quiz is complete
  void showQuizCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Complete'),
          content: const Text('You have completed all questions!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Return to previous screen
              },
              child: const Text('Finish'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Subject and Question Count
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Colors.grey[600]!,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'Subject - ${widget.subject}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Questions - ${currentQuestionIndex + 1}/${questions.length}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Question Area
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Colors.grey[600]!,
                    width: 1.0,
                  ),
                ),
                height: 150, // Adjust as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Question : ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      currentQuestion['question'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Options Label
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Options',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              const SizedBox(height: 10),
              
              // Option Buttons
              Expanded(
                child: ListView.builder(
                  itemCount: currentQuestion['options'].length,
                  itemBuilder: (context, index) {
                    return optionButton(
                      index: index,
                      text: currentQuestion['options'][index],
                      onTap: () {
                        setState(() {
                          selectedOption = index;
                        });
                      },
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous Button
                  ElevatedButton(
                    onPressed: currentQuestionIndex > 0 ? goToPreviousQuestion : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: currentQuestionIndex > 0 ? Colors.black : Colors.grey,
                      side: BorderSide(
                        color: currentQuestionIndex > 0 ? Colors.grey[600]! : Colors.grey[400]!,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: Text('Previous'),
                    ),
                  ),
                  
                  // Next Button
                  ElevatedButton(
                    onPressed: selectedOption != null ? goToNextQuestion : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: selectedOption != null ? Colors.black : Colors.grey,
                      side: BorderSide(
                        color: selectedOption != null ? Colors.grey[800]! : Colors.grey[400]!,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: Text(
                        currentQuestionIndex < questions.length - 1 ? 'Next' : 'Finish'
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget optionButton({
    required int index,
    required String text,
    required VoidCallback onTap,
  }) {
    final bool isSelected = selectedOption == index;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 18.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: isSelected ? Colors.white : Colors.grey[800]!,
              width: 1.0,
            ),
            color: isSelected ? Colors.grey[600] : Colors.transparent,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[400],
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}

void navigateToQuizQuestion(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const QuizQuestionScreen(
        subject: 'Math',
        currentQuestion: 1,  // Changed to start at question 1
        totalQuestions: 3,   // Set to match our sample questions length
      ),
    ),
  );
}
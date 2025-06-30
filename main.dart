import 'package:flutter/material.dart';

void main() {
  runApp(const FeedbackApp());
}

class FeedbackApp extends StatelessWidget {
  const FeedbackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Feedback Form',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const FeedbackFormPage(),
    );
  }
}

class FeedbackFormPage extends StatefulWidget {
  const FeedbackFormPage({super.key});

  @override
  State<FeedbackFormPage> createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends State<FeedbackFormPage> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String rollNumber = '';
  String feedback = '';
  double experience = 3;
  String? selectedCategory;

  Map<String, bool> features = {
    'Easy to Use': false,
    'Design': false,
    'Speed': false,
    'Support': false,
  };

  final List<String> categories = [
    'Bug Report',
    'Suggestion',
    'General',
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Thank You!'),
          content: const Text('Your feedback has been submitted.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade200,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Feedback Form'),
        leading: const BackButton(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    TextFormField(
                      decoration: _fieldDecoration('Enter your name'),
                      validator: (val) => val == null || val.isEmpty
                          ? 'Please enter your name'
                          : null,
                      onSaved: (val) => name = val!,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      decoration: _fieldDecoration('Enter your roll number'),
                      validator: (val) => val == null || val.isEmpty
                          ? 'Please enter roll number'
                          : null,
                      onSaved: (val) => rollNumber = val!,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      maxLines: 4,
                      decoration: _fieldDecoration('Enter your feedback...'),
                      validator: (val) => val == null || val.isEmpty
                          ? 'Please write feedback'
                          : null,
                      onSaved: (val) => feedback = val!,
                    ),
                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Rate your experience'),
                        Text(experience.toInt().toString()),
                      ],
                    ),
                    Slider(
                      value: experience,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: experience.toString(),
                      onChanged: (val) => setState(() => experience = val),
                    ),
                    const SizedBox(height: 16),

                    const Text('Select a category'),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: _fieldDecoration("Choose a category"),
                      value: selectedCategory,
                      isExpanded: true,
                      items: categories
                          .map((cat) =>
                          DropdownMenuItem(value: cat, child: Text(cat)))
                          .toList(),
                      onChanged: (val) => setState(() => selectedCategory = val),
                      validator: (val) =>
                      val == null ? 'Please select a category' : null,
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'What features did you like?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...features.keys.map((feature) {
                      return CheckboxListTile(
                        title: Text(feature),
                        value: features[feature],
                        onChanged: (val) =>
                            setState(() => features[feature] = val ?? false),
                      );
                    }),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20), // space below submit button
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



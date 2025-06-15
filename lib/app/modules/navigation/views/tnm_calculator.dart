import 'package:flutter/material.dart';

class TNMCalculatorPage extends StatefulWidget {
  const TNMCalculatorPage({super.key});

  @override
  State<TNMCalculatorPage> createState() => _TNMCalculatorPageState();
}

class _TNMCalculatorPageState extends State<TNMCalculatorPage> {
  String? selectedTumor;
  String? selectedNodes;
  String? selectedMetastasis;
  String? result;

  final List<String> tumorOptions = ['T0', 'T1', 'T2', 'T3', 'T4'];
  final List<String> nodeOptions = ['N0', 'N1', 'N2', 'N3'];
  final List<String> metastasisOptions = ['M0', 'M1'];

  String calculateStage(String t, String n, String m) {
    // Basic logic: You can expand this based on cancer type specific TNM staging
    if (m == 'M1') return 'Stage IV';
    if (n == 'N2' || n == 'N3') return 'Stage III';
    if (t == 'T3' || t == 'T4') return 'Stage II';
    return 'Stage I';
  }

  void onCalculate() {
    if (selectedTumor != null && selectedNodes != null && selectedMetastasis != null) {
      final stage = calculateStage(selectedTumor!, selectedNodes!, selectedMetastasis!);
      setState(() {
        result = "TNM: $selectedTumor $selectedNodes $selectedMetastasis\nResult: $stage";
      });
    } else {
      setState(() {
        result = "Please select all values.";
      });
    }
  }

  Widget _buildDropdown(String label, List<String> options, String? selectedValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue,
          items: options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TNM Stage Calculator"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdown("Tumor (T)", tumorOptions, selectedTumor, (value) {
                setState(() => selectedTumor = value);
              }),
              _buildDropdown("Lymph Nodes (N)", nodeOptions, selectedNodes, (value) {
                setState(() => selectedNodes = value);
              }),
              _buildDropdown("Metastasis (M)", metastasisOptions, selectedMetastasis, (value) {
                setState(() => selectedMetastasis = value);
              }),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: onCalculate,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text("Calculate Stage", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 30),
              if (result != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    result!,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

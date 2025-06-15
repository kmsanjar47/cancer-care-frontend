import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/doctors_controller.dart';
import 'doctor_details.view.dart';

class DoctorsView extends GetView<DoctorsController> {
  const DoctorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Give option to set date and time
              const SizedBox(height: 50),
              const Text(
                "Available \nSpecialist",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                height: 250,
                width: double.infinity,
                child: CalendarDatePicker(
                  selectableDayPredicate: (date) => true,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2027),
                  onDateChanged: (date) {
                    // Handle date change
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Handle doctor selection
                        Get.to(
                          () => const DoctorDetailsView(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 500),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Dr. Serena Gomez",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "Medicine Specialist",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          "Square Hospital LTD",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        ...List.generate(
                                          5,
                                          (index) => const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Experience",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          "5 Years",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Patients",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          "1.08K",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // Image.asset("assets/images/doctor_ad.png",
                                //   height: 60,
                                //   width: 60,
                                //   fit: BoxFit.cover,
                                // ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // Button to book appointment
                            ElevatedButton(
                              onPressed: () {
                                Get.to(
                                  () => const BookAppointment(),
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(milliseconds: 500),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Book Appointment",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.5,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  String? selectedCancerType;
  final List<String> questions = [
    "Are you experiencing any pain?",
    "Have you noticed any unusual lumps?",
    "Are you currently undergoing treatment?",
    "Do you have a family history of cancer?",
    "Have you experienced sudden weight loss?"
  ];
  final Map<int, String> answers = {};
  final TextEditingController descriptionController = TextEditingController();
  String? uploadedFileName;

  Future<void> _pickReport() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        uploadedFileName = result.files.single.name;
      });
    }
  }

  void _bookAppointment() {
    // Handle form submission
    print("Cancer Type: $selectedCancerType");
    print("Answers: $answers");
    print("Description: ${descriptionController.text}");
    print("Report: $uploadedFileName");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Appointment booked!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Appointment"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Cancer Type",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedCancerType,
              items: const [
                DropdownMenuItem(value: "Breast Cancer", child: Text("Breast Cancer")),
                DropdownMenuItem(value: "Lung Cancer", child: Text("Lung Cancer")),
                DropdownMenuItem(value: "Prostate Cancer", child: Text("Prostate Cancer")),
              ],
              onChanged: (value) => setState(() => selectedCancerType = value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Triage Questions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            ...questions.asMap().entries.map((entry) {
              int index = entry.key;
              String question = entry.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question),
                  Row(
                    children: ["Yes", "No", "Not Sure"].map((option) {
                      return Expanded(
                        child: RadioListTile<String>(
                          title: Text(option, style: const TextStyle(fontSize: 14)),
                          value: option,
                          groupValue: answers[index],
                          onChanged: (val) => setState(() => answers[index] = val!),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            }).toList(),

            const Text(
              "Additional Notes (optional)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Describe your condition or symptoms...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Upload Report (optional)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickReport,
                  child: const Text("Choose File"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    uploadedFileName ?? "No file selected",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton.icon(
                onPressed: _bookAppointment,
                icon: const Icon(Icons.calendar_today),
                label: const Text("Book Appointment"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

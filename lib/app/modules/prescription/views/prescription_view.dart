import 'package:flutter/material.dart';

class Appointment {
  final String patientId;
  final String patientName;
  final int patientAge;
  final String patientContact;
  final String cancerType;
  final String severity;
  final String description;
  final String? reportUrl;

  Appointment({
    required this.patientId,
    required this.patientName,
    required this.patientAge,
    required this.patientContact,
    required this.cancerType,
    required this.severity,
    required this.description,
    this.reportUrl,
  });
}

Color getSeverityColor(String severity) {
  switch (severity.toLowerCase()) {
    case 'high':
      return Colors.red;
    case 'medium':
      return Colors.orange;
    case 'low':
      return Colors.green;
    default:
      return Colors.grey;
  }
}

class AppointmentListPage extends StatefulWidget {
  const AppointmentListPage({super.key});

  @override
  State<AppointmentListPage> createState() => _AppointmentListPageState();
}

class _AppointmentListPageState extends State<AppointmentListPage> {
  List<Appointment> appointments = [
    Appointment(
      patientId: "P001",
      patientName: "Alice Rahman",
      patientAge: 42,
      patientContact: "+8801234567890",
      cancerType: "Breast Cancer",
      severity: "High",
      description: "Lump found on left breast. Undergoing initial diagnosis.",
      reportUrl: "https://example.com/report1.pdf",
    ),
    Appointment(
      patientId: "P002",
      patientName: "Bob Karim",
      patientAge: 55,
      patientContact: "+8809876543210",
      cancerType: "Lung Cancer",
      severity: "Medium",
      description: "Shortness of breath and occasional coughing.",
      reportUrl: "https://example.com/report2.pdf",
    ),
    Appointment(
      patientId: "P003",
      patientName: "Charlie Das",
      patientAge: 38,
      patientContact: "+880111222333",
      cancerType: "Prostate Cancer",
      severity: "Low",
      description: "Routine checkup requested by patient.",
      reportUrl: null,
    ),
  ];

  void _showDetailsModal(Appointment appointment) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Text(
                  appointment.patientName,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text("Patient ID: ${appointment.patientId}"),
                Text("Age: ${appointment.patientAge}"),
                Text("Contact: ${appointment.patientContact}"),
                const SizedBox(height: 12),
                Text(
                  appointment.cancerType,
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text(
                      "Severity: ",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Chip(
                      label: Text(appointment.severity),
                      backgroundColor:
                      getSeverityColor(appointment.severity).withOpacity(0.1),
                      labelStyle: TextStyle(
                        color: getSeverityColor(appointment.severity),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Description:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  appointment.description.isNotEmpty
                      ? appointment.description
                      : "No description provided.",
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 20),
                if (appointment.reportUrl != null && appointment.reportUrl!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Medical Report:",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading:
                        const Icon(Icons.picture_as_pdf, color: Colors.red),
                        title: const Text("View Report"),
                        onTap: () {
                          // Replace with actual PDF viewer
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Opening report...")),
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard(Appointment appointment) {
    final severityColor = getSeverityColor(appointment.severity);

    return InkWell(
      onTap: () => _showDetailsModal(appointment),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appointment.patientName,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text("ID: ${appointment.patientId}"),
              Text("Age: ${appointment.patientAge}"),
              Text("Contact: ${appointment.patientContact}"),
              const SizedBox(height: 8),
              Text(
                appointment.cancerType,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("Severity: ",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: severityColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      appointment.severity,
                      style: TextStyle(
                          color: severityColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text("Description:",
                  style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Text(
                appointment.description.isNotEmpty
                    ? appointment.description
                    : "No description provided.",
                style: const TextStyle(fontSize: 15),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointments"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ReorderableListView(
        padding: const EdgeInsets.all(16),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex--;
            final item = appointments.removeAt(oldIndex);
            appointments.insert(newIndex, item);
          });
        },
        children: List.generate(
          appointments.length,
              (index) => _buildCard(appointments[index])
              .copyWith(key: ValueKey(appointments[index].patientId)),
        ),
      ),
    );
  }
}

extension on Widget {
  Widget copyWith({Key? key}) => KeyedSubtree(key: key, child: this);
}

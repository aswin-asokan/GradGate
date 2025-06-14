import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:gradgate/helper/database_helper.dart';
import 'package:gradgate/shared/extensions/variables.dart';
import 'package:gradgate/shared/widgets/custom_textfield.dart';
import 'package:gradgate/shared/widgets/job_search.dart';
import 'package:gradgate/shared/widgets/location_autocomplete.dart';
import 'package:gradgate/shared/widgets/type_widget.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:intl/intl.dart';
import 'dart:convert'; // Ensure this import for JSON encoding/decoding

class SearchJob extends StatefulWidget {
  const SearchJob({super.key});

  @override
  State<SearchJob> createState() => _SearchJobState();
}

TextEditingController minSal = TextEditingController(text: "0");
TextEditingController maxSal = TextEditingController(text: "10000000");
TextEditingController location = TextEditingController();
TextEditingController company = TextEditingController();

String type = "Full Time";

class _SearchJobState extends State<SearchJob> {
  late String plainText;
  late Future<List<Map<String, dynamic>>> futureJobList;

  SidebarXController controller = SidebarXController(selectedIndex: 0);
  int count = 5;
  double ratio = .9;
  List<Color> colors = [
    const Color(0xffe3dbfa),
    const Color(0xfffbe2f4),
    const Color(0xffffe1cc),
    const Color(0xffd4f6ed),
  ];
  final _random = Random();

  @override
  void initState() {
    super.initState();
    futureJobList = DBHelper().getAllJobsForStudents(department);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    count = _calculateGridCount(width);
    ratio = _calculateAspectRatio(width);

    return Scaffold(
      backgroundColor: secBg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Search Jobs",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openEndDrawer(); // Open right-side drawer
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: futureJobList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error loading jobs"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No jobs available"));
            } else {
              List<Map<String, dynamic>> jobLists = snapshot.data!;

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: count,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: ratio,
                ),
                itemCount: jobLists.length,
                itemBuilder: (context, index) {
                  final job = jobLists[index];

                  // Parse Quill description safely
                  String jobAbout = '';
                  try {
                    final aboutDec = jsonDecode(job['description']);
                    final delta = Delta.fromJson(aboutDec);
                    final doc = Document.fromDelta(delta);
                    jobAbout = doc.toPlainText();
                  } catch (e) {
                    jobAbout = 'Description not available';
                  }

                  return JobSearch(
                    date: job['date'] != null
                        ? DateFormat('yyyy-MM-dd')
                            .format(DateTime.parse(job['date']))
                        : 'N/A',
                    company: job['employer_name'] ?? 'Unknown',
                    job: job['title'] ?? 'Untitled',
                    link: job['employer_pic'] ??
                        "assets/images/no-profile-picture-15258 (1).png", // Ensure this is in the jobs table
                    type: job['type'] ?? 'N/A',
                    salary: job['salary']?.toString() ?? '0',
                    location: job['employer_location'] ?? 'Remote',
                    jobAbout: jobAbout,
                    jobId: job['id']?.toString() ?? '',
                    color: colors[_random.nextInt(colors.length)],
                  );
                },
              );
            }
          },
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(25),
          children: [
            const Text(
              "Filters",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            CustomTextfield(
              head: "Enter minimum Salary",
              hint: "Minimum Salary",
              controller: minSal,
              type: TextInputType.number,
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              head: "Enter Maximum Salary",
              hint: "Maximum Salary",
              controller: maxSal,
              type: TextInputType.number,
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              head: "Enter Company name",
              hint: "Company name",
              controller: company,
              type: TextInputType.text,
            ),
            const SizedBox(height: 10),
            const Text("Location",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            LocationAutocomplete(locationController: location),
            const SizedBox(height: 10),
            const Text("Job Type",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  type = "Full Time";
                });
              },
              child: TypeWidget(
                  icon: Icons.work_outline,
                  text: "Full Time",
                  isSelected: type == "Full Time"),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                setState(() {
                  type = "Internship";
                });
              },
              child: TypeWidget(
                  icon: Icons.school,
                  text: "Internship",
                  isSelected: type == "Internship"),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                child: const Text(
                  'Filter',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateGridCount(double width) {
    if (width > 1770) {
      return 5;
    } else if (width < 1730 && width > 1445) {
      return 4;
    } else if (width < 1445 && width > 1342) {
      return 4;
    } else if (width < 1342 && width > 1211) {
      return 3;
    } else if (width < 1211 && width > 1057) {
      return 3;
    } else if (width < 1057 && width > 975) {
      return 3;
    } else if (width < 975 && width > 885) {
      return 2;
    } else if (width < 885 && width > 795) {
      return 2;
    } else if (width < 795 && width > 765) {
      return 2;
    } else if (width < 765 && width > 715) {
      return 2;
    } else if (width < 715 && width > 646) {
      return 2;
    } else {
      return 1; // Default case
    }
  }

  double _calculateAspectRatio(double width) {
    if (width > 1770) {
      return .9;
    } else if (width < 1730 && width > 1445) {
      return .95;
    } else if (width < 1445 && width > 1342) {
      return .85;
    } else if (width < 1342 && width > 1211) {
      return 1;
    } else if (width < 1211 && width > 1057) {
      return .85;
    } else if (width < 1057 && width > 975) {
      return .75;
    } else if (width < 975 && width > 885) {
      return 1;
    } else if (width < 885 && width > 795) {
      return .85;
    } else if (width < 795 && width > 765) {
      return 1;
    } else if (width < 765 && width > 715) {
      return .95;
    } else if (width < 715 && width > 646) {
      return .85;
    } else if (width < 646 && width > 590) {
      return 1 / .65;
    } else {
      return 1 / .8; // Default case
    }
  }
}

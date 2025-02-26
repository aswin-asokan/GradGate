import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/locationField.dart';
import 'package:gradgate/components/widgets.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:gradgate/Controller/studCon.dart';
import 'package:intl/intl.dart';
import 'dart:convert'; // Ensure this import for JSON encoding/decoding

class Jobsearch extends StatefulWidget {
  const Jobsearch({super.key});

  @override
  State<Jobsearch> createState() => _JobsearchState();
}

TextEditingController minSal = TextEditingController(text: "0");
TextEditingController maxSal = TextEditingController(text: "10000000");
TextEditingController location = TextEditingController();
TextEditingController company = TextEditingController();

String type = "Full Time";

class _JobsearchState extends State<Jobsearch> {
  late  QuillController _controller ;
  late String plainText;
  late Future<Map<String, dynamic>> futureJobList;

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
    futureJobList = studCont().viejobList(); // Call the jobList function from the controller
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    count = _calculateGridCount(width);
    ratio = _calculateAspectRatio(width);

    return Scaffold(
      backgroundColor: secBg,
      appBar: AppBar(
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
        child: FutureBuilder<Map<String, dynamic>>(
          future: futureJobList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error loading jobs"));
            } else if (!snapshot.hasData || snapshot.data!['jobDet'].isEmpty) {
              return const Center(child: Text("No jobs available"));
            } else {
              // Job list data from the API response
              List<dynamic> jobLists = snapshot.data!['jobDet'];

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: count,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: ratio,
                ),
                itemCount: jobLists.length,
                itemBuilder: (context, index) {
                  var job = jobLists[index];

    // Assuming 'about' is a JSON string containing the Quill document
    var aboutDec = jsonDecode(job['about']);
    
    // Create a Delta from the decoded JSON
    Delta delta = Delta.fromJson(aboutDec);

    // Create a Quill Document from the Delta
    Document document = Document.fromDelta(delta);

    // Initialize the QuillController with the document
    _controller = QuillController(
      document: document,
      selection: TextSelection.collapsed(offset: 0),
    );

    // Convert document to plain text
    plainText = _controller.document.toPlainText();
                  // Extract job details
                  String jobTitle = job['job_title'];
                  String companyName = job['company_name'];
                  String salary = job['salary'].toString();
                  String jobType = job['job_type'];
                  String location = job['location'];
                  String jobAbout = plainText;
                  String jobId = job['job_id'].toString();


                  // Parse the job['date'] into a DateTime object
                  DateTime dateTime = DateTime.parse(job['date']);
                  String date = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
                  String imgUrl = job['imgUrl'];

                  return jobSearchWidget(
                    date,
                    companyName,
                    jobTitle,
                    imgUrl,
                    jobType,
                    salary,
                    location,
                    jobAbout,
                    jobId,
                    colors[_random.nextInt(colors.length)],
                    context,
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
            customTextField("Enter minimum Salary", "Minimum Salary", minSal, TextInputType.number, null),
            const SizedBox(height: 10),
            customTextField("Enter Maximum Salary", "Maximum Salary", maxSal, TextInputType.number, null),
            const SizedBox(height: 10),
            customTextField("Enter Company name", "Company name", company, TextInputType.text, null),
            const SizedBox(height: 10),
            const Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            LocationAutocomplete(locationController: location),
            const SizedBox(height: 10),
            const Text("Job Type", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  type = "Full Time";
                });
              },
              child: Type(Icons.work_outline, "Full Time", type == "Full Time"),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                setState(() {
                  type = "Internship";
                });
              },
              child: Type(Icons.school, "Internship", type == "Internship"),
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

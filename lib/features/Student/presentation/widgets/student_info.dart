import 'package:flutter/material.dart';
import 'package:gradgate/features/Employer/presentation/widgets/count_widget.dart';
import 'package:gradgate/helper/database_helper.dart';
import 'package:gradgate/shared/extensions/variables.dart';

class StudentInfo extends StatefulWidget {
  const StudentInfo({super.key});

  @override
  State<StudentInfo> createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  int applied = 0, selected = 0, rejected = 0, waiting = 0;
  void fetchStats() async {
    final stats = await DBHelper().getJobStatsForStudent(userID);
    setState(() {
      applied = stats['applied']!;
      selected = stats['selected']!;
      rejected = stats['rejected']!;
      waiting = stats['waiting_reply']!;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchStats();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          CountWidget(
              color: const Color(0xffeaf2fd),
              count: applied,
              title: "Applied",
              icon: Icons.file_open_outlined,
              iconColor: const Color(0xff60a3fc)),
          CountWidget(
              color: const Color(0xfff9f4ed),
              count: selected,
              title: "Short Listed",
              icon: Icons.list_alt_outlined,
              iconColor: const Color(0xfff29f50)),
          CountWidget(
            color: const Color.fromARGB(255, 200, 222, 217),
            count: waiting,
            title: "Waiting Listed",
            icon: Icons.watch_later_outlined,
            iconColor: const Color(0xff446d67),
          ),
          CountWidget(
            color: const Color(0xfffaecea),
            count: rejected,
            title: "Rejected",
            icon: Icons.not_interested_outlined,
            iconColor: const Color(0xffeba993),
          ),
        ],
      ),
    );
  }
}

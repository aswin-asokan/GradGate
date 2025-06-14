import 'package:flutter/material.dart';
import 'package:gradgate/features/Student/presentation/screens/view_job.dart';

class JobSearch extends StatelessWidget {
  const JobSearch(
      {super.key,
      required this.color,
      required this.company,
      required this.date,
      required this.job,
      required this.jobAbout,
      required this.jobId,
      required this.link,
      required this.location,
      required this.salary,
      required this.type});
  final String date;
  final String company;
  final String job;
  final String link;
  final String type;
  final String salary;
  final String location;
  final String jobAbout;
  final String jobId;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black12),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      width: 350,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 25, right: 25),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(35))),
                  child: Text(
                    date,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  company,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Text(
                        job,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors
                            .transparent, // Optional: Set a background color if needed
                        child: ClipOval(
                          child: link ==
                                  "assets/images/no-profile-picture-15258 (1).png"
                              ? Image.asset(
                                  "assets/images/no-profile-picture-15258 (1).png",
                                  fit: BoxFit
                                      .cover, // Use BoxFit.cover to fill the CircleAvatar
                                  width:
                                      200, // Set the width to be double the radius
                                  height:
                                      200, // Set the height to be double the radius
                                )
                              : Image.network(
                                  link,
                                  fit: BoxFit
                                      .cover, // Use BoxFit.cover to fill the CircleAvatar
                                  width:
                                      200, // Set the width to be double the radius
                                  height:
                                      200, // Set the height to be double the radius
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, left: 10, right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(35))),
                  child: Text(
                    type,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$$salary/m",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(location,
                        overflow: TextOverflow.ellipsis, softWrap: true),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewJob(
                                    jobTitle: job,
                                    jobCompany: company,
                                    jobType: type,
                                    jobLocation: location,
                                    lastDate: date,
                                    imgLink: link,
                                    jobAbout: jobAbout,
                                    jobSalary: salary,
                                    jobId: jobId,
                                  )),
                        );
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.black),
                          shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))))),
                      child: const Text(
                        "Details",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}

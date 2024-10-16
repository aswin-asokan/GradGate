import 'package:flutter/material.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/variables.dart';

class Colprofile extends StatefulWidget {
  const Colprofile({super.key});

  @override
  State<Colprofile> createState() => _ColprofileState();
}

class _ColprofileState extends State<Colprofile> {
  @override
  Widget build(BuildContext context) {
    //_controller.document = var_about!;
    return Scaffold(
      backgroundColor: secBg,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      // Optional: Add box shadow for better visibility
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 200,
                    clipBehavior: Clip
                        .antiAlias, // Ensures the image fits within the rounded edges
                    child: Image.asset(
                      "assets/images/White Minimalist Corporate Personal Profile LinkedIn Banner.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      right: 20,
                      top: 10,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          icon: const Icon(
                            Icons.logout,
                            size: 30,
                          ))),
                  Positioned(
                      right: 70,
                      top: 10,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/colSettings');
                          },
                          icon: const Icon(
                            Icons.settings_outlined,
                            size: 30,
                          )))
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                var_name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // Wrap the Text in Flexible to allow it to take available space
                  Flexible(
                    child: Text(
                      var_loc,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18 // Responsive font size
                          ),
                      overflow: TextOverflow
                          .ellipsis, // Optional: Ensure text doesn't overflow
                      maxLines: 10, // Optional: Limit to one line
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const Divider(),
              Row(
                children: [
                  const Icon(
                    Icons.phone_outlined,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    var_phone,
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.mail_outline,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    var_mail,
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

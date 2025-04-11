import 'package:first_project/Utils/dynamic_size.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;

  final TextEditingController nameController = TextEditingController(text: "Ananya Pandey");
  final TextEditingController emailController = TextEditingController(text: "ananya@gmail.com");
  final TextEditingController mobileController = TextEditingController(text: "8989874679");
  final TextEditingController courseController = TextEditingController(text: "12th CBSE");
  final TextEditingController regNoController = TextEditingController(text: "kjbdkjhbd");
  final TextEditingController regDateController = TextEditingController(text: "03 April");

  final int attended = 190;
  final int pending = 320;
  final int total = 190;

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes(context);

    return Scaffold(
      appBar: const ProfileAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomDivider(),
              SizedBox(height: sizes.sizedBoxHeight(0.005)),
              const CustomDivider(),
              SizedBox(height: sizes.sizedBoxHeight(0.02)),
              ProfileInfo(name: nameController.text, course: courseController.text),
              SizedBox(height: sizes.sizedBoxHeight(0.01)),
              const CustomDivider(),
              SizedBox(height: sizes.sizedBoxHeight(0.006)),
              Column(
                children: [
                  Text(
                    "Unlocking potential, embracing challenges, and shaping the future!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: sizes.fontSize(0.05)),
                  ),
                  SizedBox(height: sizes.sizedBoxHeight(0.01)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AttendanceCard(label: 'Attended', count: attended, sizes: sizes),
                      AttendanceCard(label: 'Pending', count: pending, sizes: sizes),
                      AttendanceCard(label: 'Total', count: total, sizes: sizes),
                    ],
                  )
                ],
              ),
              SizedBox(height: sizes.sizedBoxHeight(0.04)),
              const CustomDivider(),
              Padding(
                padding: sizes.cardPadding(horizontal: 0.05),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Personal Information",
                          style: TextStyle(
                            fontSize: sizes.fontSize(0.05),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isEditing = !isEditing;
                            });
                          },
                          child: Text(isEditing ? "Save" : "Edit", style: TextStyle(fontSize: sizes.fontSize(0.04))),
                        )
                      ],
                    ),
                    SizedBox(height: sizes.sizedBoxHeight(0.02)),
                    buildTextField("Name", nameController, sizes),
                    buildTextField("Registration No", regNoController, sizes),
                    buildTextField("Registration Date", regDateController, sizes),
                    buildTextField("Course", courseController, sizes),
                    buildTextField("Email Address", emailController, sizes),
                    buildTextField("Mobile No.", mobileController, sizes),
                  ],
                ),
              ),
              SizedBox(height: sizes.sizedBoxHeight(0.03)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, AppSizes sizes) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizes.sizedBoxHeight(0.012)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$label:",
              style: TextStyle(fontSize: sizes.fontSize(0.045), fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: sizes.sizedBoxWidth(0.02)),
          Expanded(
            flex: 3,
            child: isEditing
                ? TextField(
                    controller: controller,
                    style: TextStyle(fontSize: sizes.fontSize(0.045)),
                    decoration: const InputDecoration(isDense: true),
                  )
                : Text(
                    controller.text,
                    style: TextStyle(fontSize: sizes.fontSize(0.045)),
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
        ],
      ),
    );
  }
}

class AttendanceCard extends StatelessWidget {
  final String label;
  final int count;
  final AppSizes sizes;

  const AttendanceCard({
    super.key,
    required this.label,
    required this.count,
    required this.sizes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(fontSize: sizes.fontSize(0.075), fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontSize: sizes.fontSize(0.05), color: Colors.grey),
        ),
      ],
    );
  }
}

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes(context);
    return AppBar(
      title: Text(
        "Profile",
        style: TextStyle(fontSize: sizes.fontSize(0.065), fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
        iconSize: sizes.iconSize(0.06),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Colors.grey[500],
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String name;
  final String course;

  const ProfileInfo({super.key, required this.name, required this.course});

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes(context);

    return Padding(
      padding: sizes.cardPadding(horizontal: 0.05, vertical: 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileAvatar(sizes: sizes),
          SizedBox(width: sizes.sizedBoxWidth(0.07)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: sizes.fontSize(0.05),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: sizes.sizedBoxHeight(0.004)),
                Text(
                  course,
                  style: TextStyle(fontSize: sizes.fontSize(0.042), color: Colors.grey[600]),
                ),
                SizedBox(height: sizes.sizedBoxHeight(0.007)),
                ProfileProgress(sizes: sizes),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final AppSizes sizes;

  const ProfileAvatar({super.key, required this.sizes});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: sizes.avatarRadius(0.12),
      backgroundColor: Colors.grey[300],
      backgroundImage: const AssetImage("assets/images/Ananya.jpg"),
    );
  }
}

class ProfileProgress extends StatelessWidget {
  final AppSizes sizes;

  const ProfileProgress({super.key, required this.sizes});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: 0.78,
            backgroundColor: Colors.grey[300],
            minHeight: sizes.sizedBoxHeight(0.007),
            valueColor: AlwaysStoppedAnimation<Color?>(Colors.grey[800]),
          ),
        ),
        SizedBox(height: sizes.sizedBoxHeight(0.005)),
        Text(
          "78% completed",
          style: TextStyle(fontSize: sizes.fontSize(0.04), color: Colors.grey[600]),
        ),
      ],
    );
  }
}

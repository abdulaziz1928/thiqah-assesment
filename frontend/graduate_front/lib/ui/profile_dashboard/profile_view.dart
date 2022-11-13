import 'package:flutter/material.dart';
import 'package:graduate_front/ui/profile_dashboard/profile_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/user.dart';
import '../../core/utils/styles.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    getImage() {
      try {
        if (user.pPath == null) {
          return Image.asset(
            "assets/images/man.png",
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          );
        } else {
          return Image.network(
            user.pPath!,
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          );
        }
      } catch (e) {}
    }

    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        // onModelReady: (viewmodel){viewmodel.notifyListeners();},
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Profile',
                  style: TStyles.veryLargeText.copyWith(fontSize: 30)),
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  color: Colors.red,
                  tooltip: 'Signout',
                  onPressed: viewmodel.signout,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// Profile Image
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ClipOval(
                            child: getImage(),
                          ),
                        )
                      ],
                    ),

                    /// Full Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${user.fName} ${user.lName}',
                          style: TStyles.mediumText,
                        )
                      ],
                    ),

                    ///  General Info
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: Offset(0, 4),
                              color: Colors.black.withOpacity(0.15),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            /// Email
                            Row(
                              children: [
                                Text('Email'),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${user.email}',
                                  style: TStyles.mediumText,
                                ),
                              ],
                            ),
                            SizedBox(height: 5),

                            /// Birthday
                            Row(
                              children: [
                                Text('Date of Birth'),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${user.birthday}',
                                  style: TStyles.mediumText,
                                ),
                              ],
                            ),
                          ],
                        )),

                    /// Graduate Program
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            'Applied Graduate Program',
                            style: TStyles.mediumText,
                          ),
                        )
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: Offset(0, 4),
                              color: Colors.black.withOpacity(0.15),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              /// Program
                              Row(
                                children: [
                                  Text('Program'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    user.gProgram?.program ?? '',
                                    style: TStyles.mediumText,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),

                              /// Level of Study
                              Row(
                                children: [
                                  Text('Level of Study'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    user.gProgram?.level ?? '',
                                    style: TStyles.mediumText,
                                  ),
                                ],
                              ),

                              /// Faculty / Division
                              Row(
                                children: [
                                  Text('Faculty / Division'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    user.gProgram?.faculty ?? '',
                                    style: TStyles.mediumText,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                            ]))
                  ],
                ),
              ),
            ),
          );
        });
  }
}

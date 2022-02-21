import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wecode_2021/src/data_models/general_user.dart';
import 'package:wecode_2021/src/jobs_screen/jobs_board_screen.dart';
import 'package:wecode_2021/src/services/firestore_service.dart';
import 'package:wecode_2021/src/student_screen/news_student_screen.dart';
import 'package:wecode_2021/src/student_screen/student_dashboard_screen.dart';

class StudentLinktreeView extends StatefulWidget {
  const StudentLinktreeView({Key? key}) : super(key: key);

  @override
  _StudentLinktreeViewState createState() => _StudentLinktreeViewState();
}

class _StudentLinktreeViewState extends State<StudentLinktreeView> {
  @override
  final FirestoreService _firestoreService = FirestoreService();

  TextEditingController _searchController = TextEditingController();
  String? theSearch;
  String dropdownValue = 'date'; //bootcoamp name
  bool canSearch = false;

  @override
  void initState() {
    canSearch = false;
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("List of students"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                            label: Text(
                              'search',
                            ),
                            hintText: 'name'),
                        onChanged: (value) {
                          if (value.length < 1) {
                            setState(() {
                              canSearch = false;
                              debugPrint(canSearch.toString());
                            });
                          } else {
                            setState(() {
                              canSearch = true;
                              debugPrint(canSearch.toString());
                            });
                          }
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: canSearch == true
                          ? whatShouldIDO
                          : null, //if cansearch true return something, else return null
                      icon: FaIcon(FontAwesomeIcons.search),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sort by: ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['date', 'bootcamp name']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  postionedContainer(context: context, top: 200, left: -50),
                  postionedContainer(
                    context: context,
                    top: 0,
                    right: -50,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: StreamBuilder<List<GeneralUser>>(
                      stream: _firestoreService.streamOfGeneralUsers(
                          name: theSearch, sortby: dropdownValue),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return LinearProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return PersonCardWidget(
                                  theUser: snapshot.data![index]);
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  whatShouldIDO() {
    setState(() {
      theSearch = _searchController.value.text;
    });
  }

  Widget postionedContainer({
    required BuildContext context,
    double? right,
    double? left,
    double? bottom,
    double? top,
  }) {
    return Positioned(
      right: right,
      top: top,
      bottom: bottom,
      left: left,
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withAlpha(100),
            borderRadius: BorderRadius.circular(159)),
      ),
    );
  }
}

class PersonCardWidget extends StatelessWidget {
  const PersonCardWidget({
    Key? key,
    required this.theUser,
  }) : super(key: key);

  final GeneralUser theUser;

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.black,
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewsStudentScreen(
                        generalUser: theUser,
                      )));
        },
        child: Container(
          color: Colors.white24,
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 90,
          // color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  Theme.of(context).primaryColor.withAlpha(100),
                              width: 2),
                          borderRadius: BorderRadius.circular(50)),
                      child: CircleAvatar(
                        radius: 20,
                        onBackgroundImageError: (err, stack) =>
                            debugPrint(err.toString()),
                        backgroundImage: NetworkImage(
                            'https://researcher.almojam.org/api/assets/unknown.jpg'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      theUser.name ?? 'no name',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'the text',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api, override_on_non_overriding_member, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'models/color.dart';
import 'overlay.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class KeyClass {
  static final shakeKey1 = const Key('__RIKEY1__');
  static final shakeKey2 = const Key('__RIKEY2__');
}

dynamic getKey(key) {
  if (key == KeyClass.shakeKey2) {
    return KeyClass.shakeKey1;
  } else {
    return KeyClass.shakeKey2;
  }
}

dynamic shakey = KeyClass.shakeKey1;

final ColorClass darkmode = ColorClass(
  id: 1,
  name: 'Dark',
  brightText1: Colors.white,
  brightText2: Color.fromARGB(255, 45, 124, 243),
  dimText1: Color.fromARGB(255, 165, 165, 165),
  dimText2: Color.fromARGB(255, 139, 139, 139),
  navigationBackground: Colors.black,
  navigationIcon: Colors.grey,
  navigationIconActive: Colors.blue,
  navigationText: Colors.grey,
  navigationTextActive: Colors.blue,
  background1: Colors.black,
  background2: Color.fromARGB(255, 18, 19, 20),
  background3: Color.fromARGB(255, 15, 15, 15),
  tileColor: Color.fromARGB(255, 15, 15, 15),
  defaultPic: Colors.white,
  brightIcon: Colors.white,
  brightIconActive: Colors.blue,
  dimIcon: Colors.grey,
  dimIconActive: Colors.grey,
  canvasColor: Color.fromARGB(255, 15, 15, 15),
  dividerColor: Color.fromARGB(255, 15, 15, 15),
  settingsTileColor: Color.fromARGB(255, 15, 15, 15),
  searchColor: Color.fromARGB(255, 37, 38, 40),
  transactionDivider: Color.fromARGB(255, 43, 44, 46),
);

final ColorClass lightmode = ColorClass(
  id: 1,
  name: 'Light',
  brightText1: Colors.black,
  brightText2: Color.fromARGB(255, 45, 124, 243),
  dimText1: Colors.grey,
  dimText2: Colors.grey,
  navigationBackground: Colors.black,
  navigationIcon: Colors.grey,
  navigationIconActive: Colors.blue,
  navigationText: Colors.grey,
  navigationTextActive: Colors.blue,
  background1: Colors.white,
  background2: Colors.white,
  background3: Color.fromARGB(255, 240, 242, 255),
  tileColor: Color.fromARGB(255, 15, 15, 15),
  defaultPic: Colors.black,
  brightIcon: Colors.black,
  brightIconActive: Colors.blue,
  dimIcon: Colors.grey,
  dimIconActive: Colors.grey,
  canvasColor: Color.fromARGB(255, 238, 238, 238),
  dividerColor: Color.fromARGB(255, 215, 215, 215),
  settingsTileColor: Color.fromARGB(255, 240, 242, 255),
  searchColor: Color.fromARGB(255, 226, 226, 226),
  transactionDivider: Color.fromARGB(255, 43, 44, 46),
);

final List<Map<String, dynamic>> _languages = [
  {
    'value': 'English',
    'label': 'English',
  },
  {
    'value': 'French',
    'label': 'French',
  }
];

final List<Map<String, dynamic>> _modes = [
  {
    'value': 'Dark',
    'label': 'Dark Mode',
  },
  {
    'value': 'Light',
    'label': 'Light Mode',
  }
];

final storage = const FlutterSecureStorage();

class _HomeScreenState extends State<HomeScreen> {
  int _selectedindex = 0;

  dynamic mode;
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();

  void getMode() async {
    String? mymode = await storage.read(key: 'mode');
    if (mymode == null) {
      setState(() {
        mode = darkmode;
        modeCon.text = 'Dark';
      });
    } else if (mymode == 'Light') {
      setState(() {
        mode = lightmode;
        modeCon.text = 'Light';
      });
    } else {
      setState(() {
        mode = darkmode;
        modeCon.text = 'Dark';
      });
    }
  }

  void getLanguage() async {
    String? mylang = await storage.read(key: 'lang');
    if (mylang == null) {
      setState(() {
        languageCon.text = 'English';
      });
    } else if (mylang == 'French') {
      setState(() {
        languageCon.text = 'French';
      });
    } else {
      setState(() {
        languageCon.text = 'English';
      });
    }
  }

  void initState() {
    super.initState();
    getMode();
    getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    double myheight = MediaQuery.of(context).size.height;

    getMode();

    /*



    The List Screen Tab




    */

    Future<bool> _onWillPop() async {
      return true;
    }

    mydivider(int index) {
      if (index != _selectedindex) {
        return Container(
          height: 3,
          width: MediaQuery.of(context).size.width * 25 / 100,
          decoration: BoxDecoration(
              color: mode.dividerColor,
              border: Border(
                  top: BorderSide(color: mode.background2),
                  bottom: BorderSide(color: mode.canvasColor))),
        );
      } else {
        if (index == 0) {
          return Row(
            children: [
              Container(
                height: 3,
                width: MediaQuery.of(context).size.width * 25 / 100 - 10,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 45, 124, 243),
                    border: Border(
                      top: BorderSide(
                          width: 2, color: Color.fromARGB(255, 45, 124, 243)),
                      bottom: BorderSide(
                          width: 2, color: Color.fromARGB(255, 45, 124, 243)),
                    )),
              ),
              Container(
                width: 10,
                height: 3,
                decoration: BoxDecoration(
                    color: mode.dividerColor,
                    border: Border(
                        top: BorderSide(color: mode.background2),
                        bottom: BorderSide(color: mode.canvasColor))),
              )
            ],
          );
        } else if (index == 3) {
          return Row(
            children: [
              Container(
                height: 3,
                width: 10,
                decoration: BoxDecoration(
                    color: mode.dividerColor,
                    border: Border(
                        top: BorderSide(color: mode.background2),
                        bottom: BorderSide(color: mode.canvasColor))),
              ),
              Container(
                height: 3,
                width: MediaQuery.of(context).size.width * 25 / 100 - 10,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 45, 124, 243),
                    border: Border(
                      top: BorderSide(
                          width: 2, color: Color.fromARGB(255, 45, 124, 243)),
                      bottom: BorderSide(
                          width: 2, color: Color.fromARGB(255, 45, 124, 243)),
                    )),
              ),
            ],
          );
        } else {
          return Row(
            children: [
              Container(
                height: 3,
                width: 5,
                decoration: BoxDecoration(
                    color: mode.dividerColor,
                    border: Border(
                        top: BorderSide(color: mode.background2),
                        bottom: BorderSide(color: mode.canvasColor))),
              ),
              Container(
                height: 3,
                width: MediaQuery.of(context).size.width * 25 / 100 - 10,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 45, 124, 243),
                    border: Border(
                      top: BorderSide(
                          width: 2, color: Color.fromARGB(255, 45, 124, 243)),
                      bottom: BorderSide(
                          width: 2, color: Color.fromARGB(255, 45, 124, 243)),
                    )),
              ),
              Container(
                height: 3,
                width: 5,
                decoration: BoxDecoration(
                    color: mode.dividerColor,
                    border: Border(
                        top: BorderSide(color: mode.background2),
                        bottom: BorderSide(color: mode.canvasColor))),
              ),
            ],
          );
        }
      }
    }

    List<Widget> actionList() {
      Widget Check = Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: Icon(Icons.save_alt));
      if (_selectedindex == 1) {
        List<Widget> myactions = [
          Check,
        ];
        return List.empty();
      } else {
        return List.empty();
      }
    }

    if (mode == null) {
      Loader.appLoader.showLoader();
      return Scaffold(
        body: Stack(
          children: [Container(color: Colors.black), Overlay()],
        ),
      );
    } else {
      Loader.appLoader.hideLoader();
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: mode.background1,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.blue),
            backgroundColor: mode.background1,
            actions: actionList(),
          ),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          final myHeight = constraints.maxHeight;
          final myWidth = constraints.maxWidth;

          //List Widget
          Widget Lists() {
            return Container();
          }

          /*


      The Checkout Screen Tab


      
      */

          Widget Checkout() {
            return Container();
          }
          /*




      The Transaction screen Tab


      */

          Widget Transactions() {
            return Container();
          }
          /*



The Settings Screen Tab



      */

          Widget MSettings() {
            return Container();
          }

          getWid(int index) {
            final List widgets = [
              Lists(),
              Checkout(),
              Transactions(),
              MSettings()
            ];
            return (widgets[index]);
          }

          //scaffold body starts here
          return Container(
            height: MediaQuery.of(context).size.height - 104,
            child: Column(
              children: [
                Container(
                    //overflow error exists right here
                    height: myHeight - 3,
                    child: getWid(_selectedindex)),
                Container(
                  height: 3,
                  child: Row(
                    children: [
                      mydivider(0),
                      mydivider(1),
                      mydivider(2),
                      mydivider(3),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              brightness: Brightness.dark,
              canvasColor: mode.canvasColor,
              primaryColor: const Color.fromARGB(255, 45, 124, 243),
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(bodySmall: const TextStyle(color: Colors.grey))),
          child: SizedBox(
            height: 54,
            child: BottomNavigationBar(
                onTap: (int index) {
                  setState(() {
                    _selectedindex = index;
                  });
                },
                currentIndex: _selectedindex,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'List',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.local_grocery_store),
                    label: 'Checkout',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history),
                    label: 'Transactions',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings_outlined),
                    label: 'Settings',
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

//Sidebar

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      backgroundColor: Colors.black,
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.blue,
                    ),
                    onPressed: () => {Navigator.of(context).pop()},
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Account Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.settings_applications),
            title: const Text('Management'),
            onTap: () => {},
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Container(
              height: 1.5,
              width: 250,
              color: const Color.fromARGB(155, 50, 50, 50),
            ),
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.history),
            title: const Text('History'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.compare_arrows),
            title: const Text('Cashin/cash out'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.directions_run_outlined),
            title: const Text('End of day'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          Row(
            children: [
              const SizedBox(
                  width: 50,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'User',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              Container(
                height: 1.5,
                width: 200,
                color: const Color.fromARGB(155, 50, 50, 50),
              ),
            ],
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.person),
            title: const Text('User info'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('Login');
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Container(
              height: 1.5,
              width: 250,
              color: const Color.fromARGB(155, 50, 50, 50),
            ),
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.manage_accounts),
            title: const Text('Sub Accounts'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}

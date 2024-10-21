import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/widgets/AnimatedSearchBar.dart';
import 'package:flexify/widgets/DeleteAlertDialog.dart';
import 'package:flexify/widgets/LoadingImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddFriends extends StatefulWidget {
  const AddFriends({super.key});

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  final TextEditingController friendsNameController = TextEditingController();

  int _searchBarOpen = 0;
  StreamSubscription<http.Response>? searchStream;

  bool loadingDone = true;
  bool connectedToInternet = true;

  final TextEditingController _controller = TextEditingController();

  List<dynamic> friends = [];
  List<dynamic> openRequests = [];
  List<List<String>> searchUsers = [];

  List<Widget> friendsWidgets(BuildContext context) {
    if (!loadingDone) return [global.loadingWidget(context, 1)];

    List<Widget> returnWidgets = [];
    if (friends.isEmpty) {
      return [
        Center(
          child: Text(
            'No friends',
            style: TextStyle(
              color: Theme.of(context).focusColor.withOpacity(.75),
              fontSize: global.width(context) * .04,
            ),
          ),
        )
      ];
    }

    for (var i = 0; i < friends.length; i++) {
      returnWidgets.add(
        Container(
          padding: EdgeInsets.all(global.containerPadding - 10),
          margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(global.borderRadius),
              color: global.darkGrey),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: global.width(context) * .15,
                height: global.width(context) * .15,
                child: Stack(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: AnimatedScale(
                          duration: global.standardAnimationDuration,
                          scale: 2,
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaX: 30,
                              sigmaY: 30,
                            ),
                            child: LoadingImage(
                              url:
                                  '${global.host}/getProfilePicture?username=${friends[i][1]}',
                              width: global.width(context) * .2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Stack(
                          children: [
                            LoadingImage(
                              url:
                                  '${global.host}/getProfilePicture?username=${friends[i][1]}',
                              width: global.width(context) * .2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: global.width(context) * .05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      friends[i][1],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: global.width(context) * .05,
                      ),
                    ),
                    Text(
                      friends[i][2],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(.75),
                        fontSize: global.width(context) * .035,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => removeFriend(friends[i][0], friends[i][2]),
                icon: Icon(
                  Icons.clear,
                  color: Colors.red,
                  size: global.width(context) * .075,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return returnWidgets;
  }

  List<Widget> openRequestsWidgets(BuildContext context) {
    if (!loadingDone) return [global.loadingWidget(context, 1)];

    List<Widget> returnWidgets = [];

    if (openRequests.isEmpty) {
      return [
        Center(
          child: Text(
            'No Requests',
            style: TextStyle(
              color: Theme.of(context).focusColor.withOpacity(.75),
              fontSize: global.width(context) * .04,
            ),
          ),
        )
      ];
    }

    for (var i = 0; i < openRequests.length; i++) {
      returnWidgets.add(
        Container(
          padding: EdgeInsets.all(global.containerPadding - 10),
          margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(global.borderRadius),
            color: Theme.of(context).colorScheme.background,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: global.width(context) * .15,
                height: global.width(context) * .15,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(1000),
                        ),
                      ),
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: AnimatedScale(
                          duration: global.standardAnimationDuration,
                          scale: 2,
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaX: 30,
                              sigmaY: 30,
                            ),
                            child: LoadingImage(
                              url:
                                  '${global.host}/getProfilePicture?username=${openRequests[i][1]}',
                              width: global.width(context) * .2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Stack(
                          children: [
                            LoadingImage(
                              url:
                                  '${global.host}/getProfilePicture?username=${openRequests[i][1]}',
                              width: global.width(context) * .2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: global.width(context) * .45,
                padding: EdgeInsets.only(left: global.width(context) * .05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      openRequests[i][1],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: global.width(context) * .05,
                      ),
                    ),
                    Text(
                      openRequests[i][2],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(.75),
                        fontSize: global.width(context) * .035,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => rejectFriendshipRequest(openRequests[i][0]),
                icon: Icon(
                  Icons.clear,
                  color: Theme.of(context).colorScheme.error,
                  size: global.width(context) * .075,
                ),
              ),
              IconButton(
                onPressed: () => acceptFriendshipRequest(openRequests[i][0]),
                icon: Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.primary,
                  size: global.width(context) * .075,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return returnWidgets;
  }

  searchForUsers(String searchString) async {
    loadingDone = false;
    setState(() {});

    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      loadingDone = true;
      connectedToInternet = false;
      setState(() {});
      return;
    }
    connectedToInternet = true;

    if (searchStream != null) {
      searchStream!.cancel();
    }

    searchStream = http
        .get(Uri.parse('${global.host}/searchUsers?q=$searchString'))
        .asStream()
        .listen((http.Response res) async {
      if (res.body == 'bad request') {
        searchUsers = [];
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      for (var i = 0; i < jsonDecode(res.body).length; i++) {
        var e = jsonDecode(res.body)[i];

        if (prefs.getString('username') == e[0]) break;

        searchUsers.add([(e)[0] as String, (e)[1] as String]);
      }

      loadingDone = true;
      setState(() {});
    });
  }

  removeFriend(userId, String firstname) async {
    showDialog(
      context: context,
      builder: (context) => DeleteAlertDialog(actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('cancle'),
        ),
        TextButton(
          onPressed: () async {
            loadingDone = false;
            setState(() {});
            SharedPreferences prefs = await SharedPreferences.getInstance();

            await http.post(
              Uri.parse('${global.host}/removeFriendship'),
              body: {
                'jwt': prefs.getString('jwt'),
                'friend_id': userId.toString(),
              },
            );

            await getData();
            loadingDone = true;
            setState(() {});
            Navigator.pop(context);
          },
          child: const Text('delete'),
        ),
      ], title: 'Do you really want to remove $firstname as friend?'),
    );
  }

  acceptFriendshipRequest(userId) async {
    loadingDone = false;
    setState(() {});

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await http.post(
      Uri.parse('${global.host}/acceptFriendshipRequest'),
      body: {
        'jwt': prefs.getString('jwt'),
        'requester_id': userId.toString(),
      },
    );

    await getData();
    loadingDone = true;
    setState(() {});
  }

  rejectFriendshipRequest(userId) async {
    loadingDone = false;
    setState(() {});

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await http.post(
      Uri.parse('${global.host}/rejectFriendshipRequest'),
      body: {
        'jwt': prefs.getString('jwt'),
        'requester_id': userId.toString(),
      },
    );

    await getData();
    loadingDone = true;
    setState(() {});
  }

  getData() async {
    loadingDone = false;
    setState(() {});

    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response res = await http.get(
      Uri.parse('${global.host}/getFriends?jwt=${prefs.getString('jwt')}'),
    );

    if (res.body == 'bad request') {
      friends = [];
      return;
    }
    friends = jsonDecode(res.body);

    res = await http.get(Uri.parse(
      '${global.host}/getFriendshipRequests?jwt=${prefs.getString('jwt')}',
    ));

    openRequests = jsonDecode(res.body);
    loadingDone = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() async {
      searchForUsers(_controller.text);
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.all(global.height(context) * .025),
                  child: Row(
                    mainAxisAlignment: _searchBarOpen == 0
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: _searchBarOpen == 0,
                        child: AnimatedContainer(
                          duration: global.standardAnimationDuration,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(
                            global.width(context) * 0.005,
                          ),
                          width: global.width(context) * 0.15,
                          height: global.width(context) * 0.15,
                          decoration: BoxDecoration(
                            boxShadow: [global.darkShadow(context)],
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Theme.of(context).colorScheme.onBackground,
                            icon: const Icon(Icons.arrow_back_rounded),
                            iconSize: global.width(context) * 0.05,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _searchBarOpen == 0,
                        child: Text(
                          'Friendslist',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            color: Theme.of(context).focusColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1,
                            fontSize: global.width(context) * 0.09,
                          ),
                        ),
                      ),
                      AnimatedSearchBar(
                        isOpen: _searchBarOpen == 1,
                        radius: global.width(context) * 0.075,
                        searchBarWidth: Tuple(
                          global.containerWidth(context) -
                              global.width(context) * .1,
                          global.width(context) * 0.075 * 2,
                        ),
                        backgroundColor: global.darkGrey,
                        searchController: _controller,
                        duration: const Duration(milliseconds: 0),
                        iconSize: global.width(context) * 0.055,
                        onTap: () {
                          _searchBarOpen == 0
                              ? _searchBarOpen = 1
                              : _searchBarOpen = 0;
                          setState(() {});
                        },
                        openIcon: Icons.close,
                        closedIcon: Icons.search,
                        fadeDuration: const Duration(milliseconds: 500),
                      ),
                    ],
                  ),
                ),

                // FRIENDS WIDGETS
                ..._searchBarOpen == 1
                    ? [
                        ...(connectedToInternet
                            ? (!loadingDone
                                ? [
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: global.height(context) * .1,
                                      ),
                                      width: global.width(context) * .2,
                                      height: global.width(context) * .2,
                                      alignment: Alignment.center,
                                      child: global.loadingWidget(context, 1),
                                    )
                                  ]
                                : (searchUsers.isNotEmpty
                                    ? searchUsers.map(
                                        (e) => UserWidget(
                                          username: e[0],
                                          firstname: e[1],
                                          friends: friends,
                                        ),
                                      )
                                    : [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: global.height(context) * .05,
                                          ),
                                          child: Text(
                                            'No users with the name "${_controller.text}"',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                              fontSize:
                                                  global.width(context) * .04,
                                            ),
                                          ),
                                        )
                                      ]))
                            : [
                                Center(
                                  child: Text(
                                    'No connection',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                                  ),
                                )
                              ])
                      ]
                    : [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: global.height(context) * .025,
                            horizontal: global.width(context) * .1,
                          ),
                          child: Text(
                            'Your Friends',
                            style: TextStyle(
                              color: Theme.of(context).focusColor,
                              fontSize: global.width(context) * .075,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...friendsWidgets(context),
                        global.largeHeight(context),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: global.height(context) * .025,
                            horizontal: global.width(context) * .1,
                          ),
                          child: Text(
                            'Friendship Requests',
                            style: TextStyle(
                              color: Theme.of(context).focusColor,
                              fontSize: global.width(context) * .075,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...openRequestsWidgets(context),
                      ],
              ],
            ),
            Visibility(
              visible: false,
              child: Container(
                width: global.width(context),
                height: global.height(context),
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(.9),
                alignment: Alignment.center,
                child: global.loadingWidget(context, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserWidget extends StatefulWidget {
  const UserWidget({
    super.key,
    required this.username,
    required this.firstname,
    required this.friends,
  });

  final String username;
  final String firstname;
  final List<dynamic> friends;

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  bool sent = false;
  sendFriendshipRequest() async {
    sent = true;
    setState(() {});

    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response res = await http.post(
      Uri.parse('${global.host}/sendFriendshipRequest'),
      body: {
        'jwt': prefs.getString('jwt'),
        'username': widget.username,
      },
    );
    print(res.body);
  }

  @override
  Widget build(BuildContext context) {
    bool contains = false;

    for (var i = 0; i < widget.friends.length; i++) {
      if (widget.friends[i][1] == widget.username) {
        contains = true;
        break;
      }
    }

    return Container(
      padding: EdgeInsets.all(global.containerPadding - 10),
      margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(global.borderRadius),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [global.darkShadow(context)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: global.width(context) * .15,
            height: global.width(context) * .15,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                  ),
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: AnimatedScale(
                      duration: global.standardAnimationDuration,
                      scale: 2,
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(
                          sigmaX: 30,
                          sigmaY: 30,
                        ),
                        child: LoadingImage(
                          url:
                              '${global.host}/getProfilePicture?username=${widget.username}',
                          width: global.width(context) * .2,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: Stack(
                      children: [
                        LoadingImage(
                          url:
                              '${global.host}/getProfilePicture?username=${widget.username}',
                          width: global.width(context) * .2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: global.width(context) * .5,
            padding: EdgeInsets.only(left: global.width(context) * .05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.username,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: global.width(context) * .05,
                  ),
                ),
                Text(
                  widget.firstname,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.75),
                    fontSize: global.width(context) * .035,
                  ),
                ),
              ],
            ),
          ),
          contains
              ? const SizedBox()
              : AnimatedSwitcher(
                  duration: global.standardAnimationDuration,
                  child: IconButton(
                    key: ValueKey(sent),
                    onPressed: sendFriendshipRequest,
                    icon: Icon(
                      sent ? CupertinoIcons.check_mark : CupertinoIcons.add,
                      color: sent
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

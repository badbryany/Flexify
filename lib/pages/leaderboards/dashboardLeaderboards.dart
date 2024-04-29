import 'package:flexify/pages/leaderboards/widgets/Leaderboard.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class DashboardLeaderboards extends StatefulWidget {
  const DashboardLeaderboards({super.key});

  @override
  State<DashboardLeaderboards> createState() => DashboardLeaderboardsState();
}

class DashboardLeaderboardsState extends State<DashboardLeaderboards> {
  List<Person> data = [];

  String suffix = 'sets';

  int selectedStatIndex = 0;
  List stats = [
    [
      0,
      'Total Sets',
    ],
    [
      1,
      'Moved Weight',
    ],
    [
      2,
      'Total Workout Time',
    ],
  ];

  getData() async {
    data = [];
    switch (selectedStatIndex) {
      case 0:
        data = [
          Person(
            username: 'yololololololololololololololololfickern',
            firstname: 'oskar',
            value: 5032,
            profilePictureUrl:
                'https://miro.medium.com/v2/resize:fit:1080/1*jWx9suY2k3Ifq4B8A_vz9g.jpeg',
          ),
          Person(
            username: 'klara_die_krasse_itch123fick mich',
            firstname: 'klörchen',
            value: 232,
            profilePictureUrl:
                'https://www.theclickcommunity.com/blog/wp-content/uploads/2017/01/portrait-of-boy-in-a-red-and-black-shirt-by-Kristin-Dokoza.jpg',
          ),
          Person(
            username: 'klöschen',
            firstname: 'oskar',
            value: 243,
            profilePictureUrl:
                'https://thephotoacademy.com/storage/magazine/448/3-the-photo-academy-portrait-Yousuf-Karsh.jpeg',
          ),
          Person(
            username: 'waxymaxylolololo',
            firstname: 'oskar',
            value: 535,
            profilePictureUrl:
                'https://pbs.twimg.com/media/FaUuKhkWYAA3u5c.jpg',
          ),
        ];
        data.add(Person(
          username: 'waxymaxy',
          firstname: 'oskar',
          value: 100,
          profilePictureUrl:
              'https://burst.shopifycdn.com/photos/fashion-model-in-fur.jpg?width=1000&format=pjpg&exif=0&iptc=0',
        ));
        data.add(Person(
          username: 'foofighter',
          firstname: 'martin',
          value: 23,
          profilePictureUrl:
              'https://i.pinimg.com/736x/d4/53/07/d453076ca0b5fc48989d3c9a2a2fc209.jpg',
        ));
        data.add(Person(
          username: 'foofighter',
          firstname: 'martin',
          value: 3,
          profilePictureUrl:
              'https://i.pinimg.com/736x/d4/53/07/d453076ca0b5fc48989d3c9a2a2fc209.jpg',
        ));
        suffix = 'Sets';
        break;
      case 1:
        data = [
          Person(
            username: 'yololololololololololololololololfickern',
            firstname: 'oskar',
            value: 5032,
            profilePictureUrl:
                'https://miro.medium.com/v2/resize:fit:1080/1*jWx9suY2k3Ifq4B8A_vz9g.jpeg',
          ),
          Person(
            username: 'klara_die_krasse_itch123fick mich',
            firstname: 'klörchen',
            value: 232,
            profilePictureUrl:
                'https://www.theclickcommunity.com/blog/wp-content/uploads/2017/01/portrait-of-boy-in-a-red-and-black-shirt-by-Kristin-Dokoza.jpg',
          ),
          Person(
            username: 'klöschen',
            firstname: 'oskar',
            value: 243,
            profilePictureUrl:
                'https://thephotoacademy.com/storage/magazine/448/3-the-photo-academy-portrait-Yousuf-Karsh.jpeg',
          ),
          Person(
            username: 'waxymaxylolololo',
            firstname: 'oskar',
            value: 535,
            profilePictureUrl:
                'https://pbs.twimg.com/media/FaUuKhkWYAA3u5c.jpg',
          ),
        ];
        data.add(Person(
          username: 'waxymaxy',
          firstname: 'oskar',
          value: 100,
          profilePictureUrl:
              'https://burst.shopifycdn.com/photos/fashion-model-in-fur.jpg?width=1000&format=pjpg&exif=0&iptc=0',
        ));
        data.add(Person(
          username: 'foofighter',
          firstname: 'martin',
          value: 23,
          profilePictureUrl:
              'https://i.pinimg.com/736x/d4/53/07/d453076ca0b5fc48989d3c9a2a2fc209.jpg',
        ));
        data.add(Person(
          username: 'foofighter',
          firstname: 'martin',
          value: 3,
          profilePictureUrl:
              'https://i.pinimg.com/736x/d4/53/07/d453076ca0b5fc48989d3c9a2a2fc209.jpg',
        ));
        suffix = 'kg';
        break;
      case 2:
        data = [
          Person(
            username: 'yololololololololololololololololfickern',
            firstname: 'oskar',
            value: 1.3,
            profilePictureUrl:
                'https://miro.medium.com/v2/resize:fit:1080/1*jWx9suY2k3Ifq4B8A_vz9g.jpeg',
          ),
          Person(
            username: 'klara_die_krasse_itch123fick mich',
            firstname: 'klörchen',
            value: .4,
            profilePictureUrl:
                'https://www.theclickcommunity.com/blog/wp-content/uploads/2017/01/portrait-of-boy-in-a-red-and-black-shirt-by-Kristin-Dokoza.jpg',
          ),
          Person(
            username: 'klöschen',
            firstname: 'oskar',
            value: .3,
            profilePictureUrl:
                'https://thephotoacademy.com/storage/magazine/448/3-the-photo-academy-portrait-Yousuf-Karsh.jpeg',
          ),
          Person(
            username: 'waxymaxylolololo',
            firstname: 'oskar',
            value: 2.1,
            profilePictureUrl:
                'https://pbs.twimg.com/media/FaUuKhkWYAA3u5c.jpg',
          ),
        ];
        data.add(Person(
          username: 'waxymaxy',
          firstname: 'oskar',
          value: 1.34,
          profilePictureUrl:
              'https://burst.shopifycdn.com/photos/fashion-model-in-fur.jpg?width=1000&format=pjpg&exif=0&iptc=0',
        ));
        data.add(Person(
          username: 'foofighter',
          firstname: 'martin',
          value: 1.23,
          profilePictureUrl:
              'https://i.pinimg.com/736x/d4/53/07/d453076ca0b5fc48989d3c9a2a2fc209.jpg',
        ));
        data.add(Person(
          username: 'foofighter',
          firstname: 'martin',
          value: 2.1,
          profilePictureUrl:
              'https://i.pinimg.com/736x/d4/53/07/d453076ca0b5fc48989d3c9a2a2fc209.jpg',
        ));
        suffix = 'h';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Column(
      children: [
        SizedBox(
          height: global.height(context) * .07,
          width: global.width(context) * global.containerWidthFactor,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: stats
                .map(
                  (e) => GestureDetector(
                    onTap: () => setState(() {
                      selectedStatIndex = e[0];
                    }),
                    child: AnimatedContainer(
                      duration: global.standardAnimationDuration,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(global.borderRadius),
                          boxShadow: [global.lightShadow(context)],
                          gradient: LinearGradient(
                            colors: selectedStatIndex == e[0]
                                ? [
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context).colorScheme.onPrimary,
                                  ]
                                : [
                                    Theme.of(context).colorScheme.background,
                                    Theme.of(context).colorScheme.background,
                                  ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          )),
                      child: Text(
                        e[1],
                        style: TextStyle(
                          color: selectedStatIndex == e[0]
                              ? Colors.black
                              : Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Leaderboard(
          title: stats[selectedStatIndex][1],
          data: data,
          suffix: suffix,
        ),
      ],
    );
  }
}

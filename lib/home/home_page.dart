import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/app_config.dart';
import 'package:task/home/logic/home_bloc.dart';
import 'package:task/home/logic/home_event.dart';
import 'package:task/home/logic/home_state.dart';
import 'package:task/model/home_header_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(GetSalon());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const Drawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Top Salon",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HomeInitial) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is HomeFailure) {
            return const Center(child: Text(AppConfig.errordata));
          } else if (state is HomeSuccess) {
            return HomeSuccessPage(headerdata: state.header!);
          } else {
            return const Center(child: Text(AppConfig.somthingWronng));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _selectedIndex == 0 ? Colors.pink[400] : Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business,
                color: _selectedIndex == 1 ? Colors.pink[400] : Colors.black),
            label: 'Nearby',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag,
                color: _selectedIndex == 2 ? Colors.pink[400] : Colors.black),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded,
                color: _selectedIndex == 3 ? Colors.pink[400] : Colors.black),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _selectedIndex == 4 ? Colors.pink[400] : Colors.black),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink[400],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class HomeSuccessPage extends StatefulWidget {
  HomeHeaderModel headerdata;
  HomeSuccessPage({Key? key, required this.headerdata}) : super(key: key);

  @override
  _HomeSuccessPageState createState() => _HomeSuccessPageState();
}

class _HomeSuccessPageState extends State<HomeSuccessPage> {
  int _selectedchip = 0;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  late List<Widget> imageSliders;

  @override
  void initState() {
    imageSliders = widget.headerdata.carousel!
        .map(
          (item) => Container(
            height: 100,
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(item.image!,
                  fit: BoxFit.cover, width: double.infinity),
            ),
          ),
        )
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: false,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.headerdata.carousel!.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 6.0,
                height: 6.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (_current == entry.key ? Colors.red : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 45,
          child: ListView.builder(
            itemCount: widget.headerdata.services?.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: MaterialButton(
                  elevation: 0.5,
                  onPressed: () {
                    setState(() {
                      _selectedchip = index;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  color:
                      index == _selectedchip ? Colors.pink[400] : Colors.white,
                  child: Text(
                    widget.headerdata.services?[index].serviceName ?? " ",
                    style: TextStyle(
                        color: index == _selectedchip
                            ? Colors.white
                            : Colors.grey),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: const [
            SizedBox(width: 15),
            Text(
              "Top Salon",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Spacer(),
            Text(
              "Filter",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Icon(Icons.filter_alt_rounded, color: Colors.black),
            SizedBox(width: 15),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      offset: const Offset(1, 2),
                      color: Colors.grey[200]!,
                      blurRadius: 10)
                ], color: Colors.white),
                height: 100,
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        height: 95,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          child: Image.network(
                              widget.headerdata.carousel?[0].image ?? "",
                              fit: BoxFit.cover,
                              width: double.infinity),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text(
                                "  data",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                              SizedBox(height: 7),
                              Container(
                                  child: Text("  data",
                                      style: const TextStyle(
                                          color: Colors.green, fontSize: 12))),
                              const Spacer(),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "2.5 km",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    height: 30,
                                    child: MaterialButton(
                                      onPressed: () {},
                                      color: Colors.pink[400],
                                      child: const Text(
                                        "View",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

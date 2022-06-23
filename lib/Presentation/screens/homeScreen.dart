import 'package:digitalfactory/Data/database/localdb.dart';
import 'package:digitalfactory/Presentation/screens/favoritescreen.dart';
import 'package:digitalfactory/business_logic/favoriteevent/favoriteevent_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Data/repositories/randomeventrepo.dart';
import '../../Data/webservices/requestRandomEvent.dart';
import '../../business_logic/randomevent/randomevent_cubit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void getRandomEvent() {
    context.read<RandomeventCubit>().fetchRandomEvent();
  }

  @override
  void initState() {
    getRandomEvent();
    super.initState();
  }

  DataBaseHelper database = DataBaseHelper();

  var items = [
    "education",
    "recreational",
    "social",
    "diy",
    "charity",
    "cooking",
    "relaxation",
    "music",
    "busywork"
  ];
  String dropdownvalue = 'education';
  double slidervalue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Random Event'),
          centerTitle: true,
          backgroundColor: Colors.purple,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => FavoriteeventCubit(),
                      child: FavoriteScreen(),
                    ),
                  ));
                },
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ))
          ],
        ),
        //RandomeventCubit(RandomEventRepository(requestService: RequestService())
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<RandomeventCubit, RandomeventState>(
              builder: (context, state) {
                Widget result = Container();
                if (state is RandomeventLoading) {
                  return result = Center(child: CircularProgressIndicator());
                } else if (state is RandomeventSuccess) {
                  return result = Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Card(
                          elevation: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.eventModel!.activity,
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'accessibility: ${state.eventModel!.accessibility}',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'key == ${state.eventModel!.key}',
                                style: TextStyle(color: Colors.black),
                              ),
                              if (state.eventModel!.link != "")
                                Text(
                                  'link: ${state.eventModel!.link}',
                                  style: TextStyle(color: Colors.black),
                                ),
                              Text(
                                'participants: ${state.eventModel!.participants}',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'price: ${state.eventModel!.price}',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'type: ${state.eventModel!.type}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              context
                                  .read<RandomeventCubit>()
                                  .fetchRandomEvent();
                            },
                            child: Text('Get Another Activity'),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Select an activity with a specific type'),
                        DropdownButton(
                          value: dropdownvalue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              onTap: () {},
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                              context
                                  .read<RandomeventCubit>()
                                  .fetchEventbytype(newValue);
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Slider(
                            label: slidervalue.toString(),
                            value: slidervalue,
                            min: 0,
                            max: 1,
                            divisions: 10,
                            onChanged: (value) {
                              setState(() {
                                slidervalue = value;
                              });
                              print(slidervalue);
                            }),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<RandomeventCubit>()
                                  .fetchEventbyprice(slidervalue);
                            },
                            child: Text('Get by price')),
                        ElevatedButton(
                            onPressed: () {
                              Event event = Event();
                              event.accessibility =
                                  state.eventModel!.accessibility.toString();
                              event.activity = state.eventModel!.activity;
                              event.key = state.eventModel!.key.toString();
                              event.participants =
                                  state.eventModel!.participants.toString();
                              event.price = state.eventModel!.price.toString();
                              event.type = state.eventModel!.type.toString();

                              database.insert(event);
                            },
                            child: Text('Add To Favorite')),
                      ]);
                } else if (state is RandomeventFailure) {
                  return result = Text("Error  ${state.errmsg}");
                }

                return result;
              },
            ),
          ),
        ));
  }
}

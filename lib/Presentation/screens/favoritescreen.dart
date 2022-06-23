import 'package:digitalfactory/business_logic/favoriteevent/favoriteevent_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  void getfavorite() {
    context.read<FavoriteeventCubit>().getFavoriteevent();
  }

  @override
  void initState() {
    getfavorite();
    super.initState();
  }

  TextEditingController _controller = TextEditingController();


  Widget _textfield() {
    return TextFormField(
      controller: _controller,
      onChanged: (value) {
        context.read<FavoriteeventCubit>().searchbyname(value);
      },
    );
  }

  Widget _FilterbyType() {
    String value = context.watch<FavoriteeventCubit>().searchedtype;
   
    return DropdownButton(
      value: value,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items.map((String items) {
        return DropdownMenuItem(
          onTap: () {},
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) {
        context.read<FavoriteeventCubit>().changeSearchedType(newValue!);
        context.read<FavoriteeventCubit>().filterbytype(newValue);
        //dropdownvalue = newValue!;
        //context.read<RandomeventCubit>().fetchEventbytype(newValue);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Event'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: BlocBuilder<FavoriteeventCubit, FavoriteeventState>(
        builder: (context, state) {
          if (state is Favoriteeventloading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is Favoriteeventsuccess) {
            return SafeArea(
                child: SingleChildScrollView(
              // physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    _textfield(),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Align(alignment: Alignment.topLeft, child: _FilterbyType()),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: state.event.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.event[index].activity,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      'accessibility: ${state.event[index].accessibility}',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      'key == ${state.event[index].key}',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    if (state.event[index].link != "")
                                      Text(
                                        'link: ${state.event[index].link}',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    Text(
                                      'participants: ${state.event[index].participants}',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      'price: ${state.event[index].price}',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      'type: ${state.event[index].type}',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context
                                      .read<FavoriteeventCubit>()
                                      .deleteFavoriteevent(
                                          state.event[index].id!);
                                },
                                child: Icon(Icons.delete,
                                    color: Colors.purple, size: 50),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                  ],
                ),
              ),
            ));
          }
          return Center(child: Text('No Data'));
        },
      ),
    );
  }
}

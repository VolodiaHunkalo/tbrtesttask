import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbrtesttask/blocs/database_bloc/database_bloc.dart';
import 'package:tbrtesttask/helpers/phone_number_helper.dart';

class CustomCountryCodePicker extends StatefulWidget {
  const CustomCountryCodePicker({Key? key}) : super(key: key);

  @override
  _CustomCountryCodePickerState createState() =>
      _CustomCountryCodePickerState();
}

class _CustomCountryCodePickerState extends State<CustomCountryCodePicker> {
  String choosenImage = 'https://flagcdn.com/w640/af.png';
  String choosenDial = '+370';
  String choosenCountry = '';
  String searchValue = 'A';
  String? _phoneNumber;
  bool _isButtonEnabled = false;
  final phoneController = TextEditingController();
  String? phone = '';

  @override
  void initState() {
    phoneController.addListener(_validatePhone);
    super.initState();
  }

  void _validatePhone() {
    final phone = phoneController.text;
    setState(() {
      _isButtonEnabled = phone.length == 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabaseBloc, DatabaseState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: false,
              title: const Text(
                'Get Started',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              )),
          backgroundColor: const Color.fromRGBO(142, 170, 251, 1),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: const Color.fromRGBO(142, 170, 251, 1),
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Country code',
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(244, 255, 255, 0.4),
                                ),
                                onChanged: (value) {
                                  context
                                      .read<DatabaseBloc>()
                                      .add(SearchCountry(searchValue: value));

                                  setState(() {
                                    searchValue = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: BlocBuilder<DatabaseBloc, DatabaseState>(
                                    builder: (context, state) {
                                  if (state.state == SearchState.initial) {
                                    return ListView.builder(
                                      itemCount: state.countries.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            Navigator.pop(context);
                                            setState(() {
                                              choosenImage = state
                                                  .countries[index].flagUrl;
                                              choosenDial = state
                                                  .countries[index].dialCode;
                                              choosenCountry =
                                                  state.countries[index].name;
                                            });
                                          },
                                          title: RichText(
                                            text: TextSpan(
                                              text:
                                                  '+${state.countries[index].dialCode}  ',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      89, 76, 116, 1)),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: state
                                                      .countries[index].name,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          leading: Image.network(
                                            state.countries[index].flagUrl,
                                            width: 20,
                                            height: 20,
                                          ),
                                        );
                                      },
                                    );
                                  } else if (state.state ==
                                      SearchState.search) {
                                    return ListView.builder(
                                      itemCount: state.searchedCountries.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            Navigator.pop(context);
                                            setState(() {
                                              choosenImage = state
                                                  .countries[index].flagUrl;
                                              choosenDial = state
                                                  .countries[index].dialCode;
                                              choosenCountry =
                                                  state.countries[index].name;
                                            });
                                          },
                                          title: RichText(
                                            text: TextSpan(
                                              text:
                                                  '+${state.searchedCountries[index].dialCode}  ',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      89, 76, 116, 1)),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: state
                                                      .searchedCountries[index]
                                                      .name,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          leading: Image.network(
                                            state.searchedCountries[index]
                                                .flagUrl,
                                            width: 20,
                                            height: 20,
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return const Text('Something go wrong');
                                  }
                                }),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromRGBO(244, 255, 255, 0.4)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              choosenImage,
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              choosenDial,
                              style: const TextStyle(
                                color: Color.fromRGBO(
                                  89,
                                  76,
                                  116,
                                  1,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(left: 8),
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color:
                                    const Color.fromRGBO(244, 255, 255, 0.4)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextField(
                                    controller: phoneController,
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      hintText: '(123) 123-1234',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        phone = value;
                                        phoneController.value =
                                            TextEditingValue(
                                          text: formatPhoneNumber(value)!,
                                          selection: TextSelection.collapsed(
                                            offset: formatPhoneNumber(value)!
                                                .length,
                                          ),
                                        );
                                      });
                                    }),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: phone!.length == 14
                  ? Colors.white
                  : const Color.fromRGBO(244, 245, 245, 0.4),
            ),
            child: FloatingActionButton(
              onPressed: phone!.length == 14
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            child: Container(
                              height: 180,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'My congratulations, you successfully added phone number for country $choosenCountry',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Okay"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  : null,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              child: Center(
                child: Icon(Icons.arrow_forward,
                    color: phone!.length == 14
                        ? const Color.fromRGBO(89, 76, 116, 1)
                        : const Color.fromRGBO(120, 134, 184, 1)),
              ),
            ),
          ),
        );
      },
    );
  }
}

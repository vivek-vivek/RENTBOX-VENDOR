import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/my_cars.dart';
import 'package:rentbox_vendor/models/mycars.dart';
import 'package:rentbox_vendor/res/constant/image_name.dart';
import 'package:rentbox_vendor/res/style/colors.dart';
import 'package:rentbox_vendor/view_model/Google%20Map/map_screen.dart';
import 'package:card_swiper/card_swiper.dart';

class SingleProductScreen extends StatelessWidget {
  const SingleProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rsize = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<MyCarsProvider>(
        builder: (context, cars, child) {
          return Stack(
            children: <Widget>[
              // Background image
              Container(
                height: rsize.width * 0.75,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(cars.photos[cars.index].first),
                      fit: BoxFit.cover),
                ),
              ),
              Positioned(
                top: rsize.width * 0.1,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.keyboard_double_arrow_left_sharp),
                ),
              ),
              // Scrollable foreground
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: rsize.width * 0.75),
                  child: Container(
                    color: MyColors.body,
                    height: rsize.height * 1,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: rsize.width * 0.05,
                        left: rsize.width * 0.05,
                        right: rsize.width * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                cars.name[cars.index],
                                style: GoogleFonts.anonymousPro(
                                  color: MyColors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: rsize.width * 0.065,
                                ),
                              ),
                              SizedBox(width: rsize.width * 0.025),
                              Container(
                                height: rsize.width * 0.1,
                                decoration: BoxDecoration(
                                  color: MyColors.grey2,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(rsize.width * 0.03)),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    cars.verified[cars.index],
                                    style: GoogleFonts.anonymousPro(
                                      color: MyColors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: rsize.width * 0.045,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: rsize.width * 0.025),
                          const Expanded(
                            child: MyTabbedPage(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/*-----------------------------TAB BAR -------------------------------*/
class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({super.key});
  @override
  State<MyTabbedPage> createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rsize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.body,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.all(Radius.circular(rsize.width * 0.03)),
            ),
            child: TabBar(
              controller: _tabController,
              tabs: const [Tab(text: "Overall"), Tab(text: "Car")],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                FirstScreen(),
                SecondScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  // static const CameraPosition _kGoogle =
  //     CameraPosition(target: LatLng(10.1632, 76.6413), zoom: 14.4746);

  @override
  Widget build(BuildContext context) {
    // Completer<GoogleMapController> controllers = Completer();
    final rsize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: rsize.width * 0.02),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(rsize.width * 0.03)),
        ),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(rsize.width * 0.02),
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container2(
                  rsize: rsize,
                  titile: "3.6s",
                  subTitile: '0-100 km/h',
                  icon: Icons.speed,
                ),
                Container2(
                    rsize: rsize,
                    titile: "450 km",
                    subTitile: 'Range',
                    icon: Icons.local_gas_station),
              ],
            ),
            SizedBox(height: rsize.width * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container2(
                  rsize: rsize,
                  titile: "3.6s",
                  subTitile: '0-100 km/h',
                  icon: Icons.speed,
                ),
                Container2(
                    rsize: rsize,
                    titile: "450 km",
                    subTitile: 'Range',
                    icon: Icons.local_gas_station),
              ],
            ),
            SizedBox(height: rsize.width * 0.03),
            InkWell(
              onDoubleTap: () => Navigator.pushNamed(context, '/mapScreen'),
              child: SizedBox(
                height: rsize.width * 1,
                child: const MapScreen(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Container2 extends StatelessWidget {
  const Container2({
    super.key,
    required this.rsize,
    required this.titile,
    required this.subTitile,
    required this.icon,
  });

  final Size rsize;
  final String titile;
  final String subTitile;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.grey2,
        borderRadius: BorderRadius.all(Radius.circular(rsize.width * 0.03)),
      ),
      height: rsize.width * 0.25,
      width: rsize.width * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: MyColors.white),
          Text(
            titile,
            style: GoogleFonts.anonymousPro(
              color: MyColors.btnText,
              fontWeight: FontWeight.w500,
              fontSize: rsize.width * 0.065,
            ),
          ),
          Text(
            subTitile,
            style: GoogleFonts.anonymousPro(
              color: MyColors.black,
              fontWeight: FontWeight.w500,
              fontSize: rsize.width * 0.045,
            ),
          ),
        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List images = [IMG.car, IMG.car, IMG.car];
    final rsize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.body,
      body: Padding(
        padding: EdgeInsets.only(top: rsize.width * 0.025),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(rsize.width * 0.03)),
          ),
          child: Consumer<MyCarsProvider>(builder: (context, cars, child) {
            for (var element in cars.photos) {
              element.toString();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.amber,
                    height: rsize.width * 0.5,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          cars.photos[cars.index][index].toString(),
                          fit: BoxFit.cover,
                        );
                      },
                      itemCount: cars.photos[cars.index].length,
                      autoplay: true,
                      pagination: const SwiperPagination(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(rsize.width * 0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.speed, color: MyColors.btnText),
                      Text(
                        "Speed",
                        style: GoogleFonts.lato(
                          color: MyColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: rsize.width * 0.045,
                        ),
                      ),
                      const Icon(Icons.airline_seat_recline_extra,
                          color: MyColors.btnText),
                      Text(
                        "4 Seat",
                        style: GoogleFonts.lato(
                          color: MyColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: rsize.width * 0.045,
                        ),
                      ),
                      const Icon(Icons.local_gas_station_rounded,
                          color: MyColors.btnText),
                      Text(
                        "petroll",
                        style: GoogleFonts.lato(
                          color: MyColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: rsize.width * 0.045,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: rsize.width * 0.2, top: rsize.width * 0.025),
                  child: Container(
                    width: rsize.width * 0.5,
                    decoration: BoxDecoration(
                      color: MyColors.body,
                      borderRadius:
                          BorderRadius.all(Radius.circular(rsize.width * 0.03)),
                    ),
                    child: Text(
                      "${cars.price[cars.index]}/ day",
                      style: GoogleFonts.anonymousPro(
                        color: MyColors.btnText,
                        fontWeight: FontWeight.w700,
                        fontSize: rsize.width * 0.075,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                TexDatas(
                    rsize: rsize,
                    rcNumber: cars.rcNumber[cars.index].toString(),
                    title: 'Rc Number'),
                TexDatas(
                    rsize: rsize,
                    rcNumber: cars.seatNum[cars.index].toString(),
                    title: 'Location'),
                TexDatas(
                    rsize: rsize,
                    rcNumber: cars.locationName[cars.index].toString(),
                    title: 'Total Seats'),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class TexDatas extends StatelessWidget {
  const TexDatas({
    super.key,
    required this.rsize,
    required this.rcNumber,
    required this.title,
  });

  final Size rsize;
  final String rcNumber;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: rsize.width * 0.025,
          top: rsize.width * 0.025,
          right: rsize.width * 0.025),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.anonymousPro(
              color: MyColors.btnText,
              fontWeight: FontWeight.w700,
              fontSize: rsize.width * 0.045,
            ),
          ),
          Text(
            rcNumber,
            style: GoogleFonts.anonymousPro(
              color: MyColors.btnText,
              fontWeight: FontWeight.w700,
              fontSize: rsize.width * 0.045,
            ),
          ),
        ],
      ),
    );
  }
}

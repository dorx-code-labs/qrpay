import 'package:qrpay/core_widgets/edit_location_bottom_sheet.dart';
import 'package:qrpay/core_widgets/not_logged_in_dialog_box.dart';
import 'package:qrpay/core_widgets/or_divider.dart';
import 'package:qrpay/core_widgets/proceed_button.dart';
import 'package:qrpay/core_widgets/select_delivery_location.dart';
import 'package:qrpay/models/delivery_location.dart';
import 'package:qrpay/models/usable_constants.dart';
import 'package:qrpay/services/auth_provider_widget.dart';
import 'package:qrpay/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qrpay/constants/images.dart';
import 'package:qrpay/constants/ui.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qrpay/services/navigation.dart';
import 'package:qrpay/services/ui_services.dart';
import 'package:qrpay/theming/theme_controller.dart';

class WhereAreYouPage extends StatelessWidget {
  final Widget page;
  final bool userLocationMode;
  const WhereAreYouPage({
    Key key,
    @required this.page,
    this.userLocationMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Image(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.5),
            colorBlendMode: BlendMode.darken,
            fit: BoxFit.cover,
            image: AssetImage(
              mapPic,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor,
                  primaryColor.withOpacity(0.5),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.mapMarkedAlt,
                      color: Colors.white,
                      size: 100,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      userLocationMode
                          ? "Where are you?"
                          : "Where should we deliver to?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      userLocationMode
                          ? "We need to know where you are so we can search for nearby properties and items to you."
                          : "We need to know where to deliver your ordered items.\nPress the button below to Select a location from your previously saved locations or create a new location.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () async {
                        LocationService()
                            .getUserLocation(context)
                            .then((value) {
                          if (value == null) {
                          } else {
                            DeliveryLocation location =
                                DeliveryLocation.fromData(
                              value,
                            );

                            Provider.of<UsableConstants>(
                              context,
                              listen: false,
                            ).addUserLocation(
                              location,
                              "Location",
                            );

                            LocationService().addLocationToFirebase(
                              context,
                              LatLng(location.lat, location.long),
                              locationID: null,
                              name: "Location",
                            );

                            NavigationService().pushReplacement(
                              context,
                              page,
                            );
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.mapMarkerAlt,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Locate Me",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    OrDivider(
                      textColor: Colors.white,
                    ),
                    InkWell(
                      onTap: () async {
                        if (AuthProvider.of(context).auth.isSignedIn()) {
                          bool allGood = await UIServices().showDatSheet(
                            SelectDeliveryLocationBottomSheet(),
                            true,
                            context,
                          );

                          if (allGood != null && allGood) {
                            NavigationService().pushReplacement(
                              context,
                              page,
                            );
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return NotLoggedInDialogBox();
                            },
                          );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.mapMarkerAlt,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Select From History",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (Provider.of<UsableConstants>(context, listen: true)
                            .currentDeliveryLocation !=
                        null)
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 5,
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    Provider.of<UsableConstants>(context,
                                                listen: true)
                                            .currentDeliveryLocation
                                            .name ??
                                        "Location",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Latitude: ${Provider.of<UsableConstants>(context, listen: true).currentDeliveryLocation.lat}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Longitude: ${Provider.of<UsableConstants>(context, listen: true).currentDeliveryLocation.long}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  /*  SizedBox(
                    height: 5,
                  ), */
                                  /*  Text(
                    loc,
                    style: TextStyle(
                      color: widget.selected ? Colors.white : null,
                    ),
                  ) */
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                PopupMenuButton(
                                  child: Icon(
                                    Icons.more_vert_rounded,
                                    color: ThemeBuilder.of(context)
                                                .getCurrentTheme() ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        value: 1,
                                        child: Text("Edit"),
                                      ),
                                    ];
                                  },
                                  onSelected: (val) {
                                    if (val == 1) {
                                      UIServices().showDatSheet(
                                        EditLocationBottomSheet(
                                          deliveryLocation:
                                              Provider.of<UsableConstants>(
                                                      context,
                                                      listen: true)
                                                  .currentDeliveryLocation,
                                        ),
                                        true,
                                        context,
                                      );
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Provider.of<UsableConstants>(context, listen: true)
                  .currentDeliveryLocation !=
              null
          ? Wrap(
              children: [
                ProceedButton(
                  processable: false,
                  enablable: false,
                  color: altColor,
                  text: "Done",
                  onTap: () {
                    NavigationService().pushReplacement(
                      context,
                      page,
                    );
                  },
                ),
              ],
            )
          : null,
    );
  }
}

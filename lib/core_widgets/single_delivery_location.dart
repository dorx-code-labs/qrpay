import 'package:flutter/material.dart';
import 'package:qrpay/models/delivery_location.dart';
import 'package:qrpay/services/ui_services.dart';
import 'package:qrpay/theming/theme_controller.dart';

import 'edit_location_bottom_sheet.dart';

class SingleDeliveryLocation extends StatefulWidget {
  final bool selected;
  final Function onTap;
  final DeliveryLocation deliveryLocation;
  SingleDeliveryLocation({
    Key key,
    @required this.deliveryLocation,
    this.onTap,
    @required this.selected,
  }) : super(key: key);

  @override
  _SingleDeliveryLocationState createState() => _SingleDeliveryLocationState();
}

class _SingleDeliveryLocationState extends State<SingleDeliveryLocation> {
  String loc = "Location";

  @override
  Widget build(BuildContext context) {
   /*  _getAddressFromLatLng(
      LatLng(
        widget.deliveryLocation.lat,
        widget.deliveryLocation.long,
      ),
    );
 */
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) widget.onTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5,
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: widget.selected ? Colors.green : null,
            border: Border.all(
              width: 1,
              color: Colors.grey,
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
                    widget.deliveryLocation.name ?? "Location",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: widget.selected ? Colors.white : null,
                    ),
                  ),
                  Text(
                    "Latitude: ${widget.deliveryLocation.lat}",
                    style: TextStyle(
                      color: widget.selected ? Colors.white : null,
                    ),
                  ),
                  Text(
                    "Longitude: ${widget.deliveryLocation.long}",
                    style: TextStyle(
                      color: widget.selected ? Colors.white : null,
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
                    color: ThemeBuilder.of(context).getCurrentTheme() ==
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
                          deliveryLocation: widget.deliveryLocation,
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
    );
  }

 /*  void _getAddressFromLatLng(LatLng _currentPosition) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      loc =
          "${place.locality}, ${place.postalCode}, ${place.country}, ${place.street}";
    } catch (e) {
     
      loc = "There was an error in generating the location name";
    }
  } */
}

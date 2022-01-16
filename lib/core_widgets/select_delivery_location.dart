import 'package:qrpay/models/usable_constants.dart';
import 'package:qrpay/services/text_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qrpay/constants/basic.dart';
import 'package:qrpay/models/delivery_location.dart';
import 'package:qrpay/services/auth_provider_widget.dart';
import 'package:qrpay/services/ui_services.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

import 'edit_location_bottom_sheet.dart';
import 'informational_box.dart';
import 'proceed_button.dart';
import 'single_delivery_location.dart';
import 'top_back_bar.dart';
import 'transparent_button.dart';

class SelectDeliveryLocationBottomSheet extends StatelessWidget {
  const SelectDeliveryLocationBottomSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackBar(
          icon: null,
          onPressed: null,
          text: "Your Delivery Location",
        ),
        InformationalBox(
          visible: true,
          onClose: null,
          message:
              "In order to simplify your life, ${appName.capitalizeFirstOfEach} lets you save your usual locations to your account and access them anytime.",
        ),
        Expanded(
          child: PaginateFirestore(
            emptyDisplay: TransparentButton(
                icon: Icon(
                  Icons.add_location,
                ),
                text: "Add A Location",
                onTap: () async {
                  UIServices().showDatSheet(
                    EditLocationBottomSheet(
                      deliveryLocation: null,
                    ),
                    false,
                    context,
                  );
                }),
            scrollDirection: Axis.vertical,
            header: SliverList(
                delegate: SliverChildListDelegate([
              TransparentButton(
                icon: Icon(
                  Icons.add_location,
                ),
                text: "Add A Location",
                onTap: () {
                  UIServices().showDatSheet(
                    EditLocationBottomSheet(
                      deliveryLocation: null,
                    ),
                    false,
                    context,
                  );
                },
              ),
            ])),
            isLive: true,
            itemBuilderType: PaginateBuilderType.listView,
            itemBuilder: (
              index,
              context,
              snapshot,
            ) {
              DeliveryLocation deliveryLocation =
                  DeliveryLocation.fromSnapshot(snapshot);

              return SingleDeliveryLocation(
                selected: Provider.of<UsableConstants>(context, listen: true)
                            .currentDeliveryLocation !=
                        null &&
                    deliveryLocation.id ==
                        Provider.of<UsableConstants>(context, listen: true)
                            .currentDeliveryLocation
                            .id,
                onTap: () {
                  if (Provider.of<UsableConstants>(context, listen: false)
                              .currentDeliveryLocation !=
                          null &&
                      Provider.of<UsableConstants>(context, listen: false)
                              .currentDeliveryLocation
                              .id ==
                          deliveryLocation.id) {
                    Provider.of<UsableConstants>(context, listen: false)
                        .removeDeliveryLocation(
                      context,
                    );
                  } else {
                    Provider.of<UsableConstants>(context, listen: false)
                        .addDeliveryLocation(
                      deliveryLocation,
                      "Home Location",
                    );
                  }
                },
                deliveryLocation: deliveryLocation,
              );
            },
            query: FirebaseFirestore.instance
                .collection(DeliveryLocation.DIRECTORY)
                .doc(AuthProvider.of(context).auth.getCurrentUID())
                .collection(AuthProvider.of(context).auth.getCurrentUID()),
          ),
        ),
        ProceedButton(
          onTap: () {
            Navigator.of(context).pop(
              Provider.of<UsableConstants>(context, listen: false)
                      .currentDeliveryLocation !=
                  null,
            );
          },
          text: "Done",
        )
      ],
    );
  }
}

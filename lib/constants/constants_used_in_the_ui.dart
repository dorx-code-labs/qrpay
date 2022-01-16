import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qrpay/models/thing_type.dart';
import 'package:qrpay/services/text_service.dart';
import 'images.dart';

const KEY = "key";
const ENTIREPLACE = "entirePlace";
const SECURITY = "security";
const LUXURY = "luxury";
const WELLBEING = "wellbeing";
const PRIVATEROOM = "privateRoom";
const SHAREDROOM = "sharedRoom";
const SHAREDWITHOTHERRENTERS = "sharedWithOtherRenters";
const SHAREDWITHPROPERTY = "sharedWithProperty";
const SHAREDWITHFAMILY = "sharedWithFamily";
const IMAGE = "image";
const PEACEFUL = "peaceful";
const SPACIOUS = "spacious";
const FORRENT = "for rent";
const FORSALE = "for sale";
const QUIET = "quiet";
const FAMILYFRIENDLY = "family-friendly";

const FIRSTHAND = "firstHand";
const SECONDHAND = "secondHand";

const EXTRAHANDS = "extraHands";

const THEYRESCAMMINGME = "scam";
const THEYREOFFENSIVE = "offensive";
const OTHER = "other";

const AUTOMATIC = "automatic";
const MANUAL = "manual";
const AUTOMATEDMANUAL = "automated manual";
const CONTINUOUSMANUAL = "continuously variable";

const FOURWHEELDRIVE = "4 Wheel Drive";
const TWOWHEELDRIVE = "2 Wheel Drive";
const SIXWHEELDRIVE = "6 Wheel Drive";

const RIGHTHANDDRIVE = "right hand drive";
const LEFTHANDDRIVE = "left hand drive";
const MIDDLEDRIVE = "middle drive";

const SCENIC = "scenic";
const REMOTE = "remote";
const PARTY = "party";
const BUSINESSFRIENDLY = "business-friendly";

const PETROL = "petrol";
const DIESEL = "diesel";
const ETHANOL = "ethanol";
const ELECTRIC = "electric";
const HYBRID = "hybrid";

const HECTARES = "hectares";
const ACRES = "acres";
const DECIMALS = "decimals";

Map sizes = {
  HECTARES: 2.47105,
  ACRES: 1,
  DECIMALS: 0.01,
};

List carenergySources = [
  PETROL,
  DIESEL,
  ETHANOL,
];

List moreCarEnergySources = [
  ELECTRIC,
  HYBRID,
];

List carSetups = [
  RIGHTHANDDRIVE,
  LEFTHANDDRIVE,
  MIDDLEDRIVE,
];

List driveTypes = [
  FOURWHEELDRIVE,
  TWOWHEELDRIVE,
  SIXWHEELDRIVE,
];

List transmissionList = [
  AUTOMATIC,
  MANUAL,
];

List moreTransmissionList = [
  AUTOMATEDMANUAL,
  CONTINUOUSMANUAL,
];

Map rentRelatedOptions = {
  "Find A Hostel": {
    IMAGE: campus,
    KEY: "find_hostel",
  },
  "Rent A Space / Room": {
    IMAGE: bedroom,
    KEY: "rent_space",
  },
};

Map hotelOptions = {
  "Book A Hotel": {
    IMAGE: lobby,
    KEY: "book_a_hotel",
  }
};

Map buyHouseRelatedOptions = {
  "Buy A House / Apartment": {
    IMAGE: happyMan,
    KEY: "buy_house",
  },
};

Map landRelatedOptions = {
  "Buy Land": {
    IMAGE: land,
    KEY: "buy_land",
  },
  "Talk To An Agent": {
    IMAGE: agent,
    KEY: "talk_to_a_broker",
  },
};

List<String> reportOptions = [
  THEYRESCAMMINGME,
  THEYREOFFENSIVE,
  OTHER,
];

Map interiorDecorOptions = {
  "Shop For Other Products": {
    IMAGE: ecommerce,
    KEY: "buy_products",
  },
};

Map addStuffOptions = {
  "Rent / Sell A House": {
    IMAGE: compound,
    KEY: "rent_property",
  },
  "Sell Land": {
    IMAGE: land,
    KEY: "sell_land",
  },
};

Map moreAddStuffOptions = {
  "Sell Furniture / Interior Decor": {
    IMAGE: interior,
    KEY: "sell_stuff",
  },
  "Become An Agent": {
    IMAGE: agent,
    KEY: "become_broker",
  },
};

Map homescreenOptions = {
  "Rent A Place / Buy A House / Find A Hostel": {
    "image": bedroom,
    "key": "find_room",
    "desc": "Find a room or home or a rental for yourself / your business."
  },
  "Sell Land/ Rent Out A House": {
    "image": happyMan,
    "key": "sell_land",
    "desc":
        "Make some money renting out your home / hotel / hostel or selling some land."
  },
  "Sell Some Stuff": {
    "image": ecommerce,
    "key": "sell_stuff",
    "desc": "Sell a car or any other property."
  },
  "Nothing for now.": {
    "image": whiteLogo,
    "key": "looking_around",
    "desc": "I just want to have a look around."
  },
};

Map vehicleOptions = {
  "Buy A Car / Vehicle": {
    IMAGE: vehicle,
    KEY: "buy_vehicle",
  },
  "Sell A Car / Vehicle": {
    IMAGE: ecommerce,
    KEY: "sell_vehicle",
  },
};

List hands = [
  FIRSTHAND,
  SECONDHAND,
  EXTRAHANDS,
];

Map<String, IconData> availableHighlights = {
  PEACEFUL: FontAwesomeIcons.peace,
  SPACIOUS: Icons.people,
  FAMILYFRIENDLY: Icons.family_restroom,
  BUSINESSFRIENDLY: FontAwesomeIcons.moneyBill,
  QUIET: Icons.surround_sound,
  SCENIC: Icons.beach_access,
  REMOTE: FontAwesomeIcons.directions,
  PARTY: Icons.party_mode,
};

Map<String, IconData> sellageModes = {
  FORRENT: Icons.house,
  FORSALE: Icons.monetization_on_sharp,
};

Map houseOptions = {
  ENTIREPLACE: {},
  PRIVATEROOM: {},
  SHAREDROOM: {
    "content": [
      SHAREDWITHOTHERRENTERS,
      SHAREDWITHPROPERTY,
      SHAREDWITHFAMILY,
    ]
  },
};

String getTileText(String text) {
  return text == ENTIREPLACE
      ? "Entire Place"
      : text == PRIVATEROOM
          ? "Private Room"
          : text == SHAREDROOM
              ? "Shared Room"
              : text == SHAREDWITHFAMILY
                  ? "Shared With Family"
                  : text == SHAREDWITHPROPERTY
                      ? "Shared With Property"
                      : "Shared With Other Guests";
}

Map<String, String> propertyModes = {
  ThingType.LAND: land,
  ThingType.HOUSE: bedroom,
};

Map<String, Map<String, dynamic>> productModes = {
  ThingType.PRODUCT: {
    "image": furniture,
    "desc":
        "Stuff like Furniture, Art, Vases, Stickers, Sculptures etc. Everything interior decor and exterior decor - related.",
  },
  ThingType.VEHICLE: {
    "image": vehicle,
    "desc":
        "Cars, Trucks, Planes, Boodaboda, Scooters and anything else that is a vehicle.",
  },
};

Map categoryModes = {
  ThingType.HOUSE.capitalizeFirstOfEach: FontAwesomeIcons.home,
  ThingType.LAND.capitalizeFirstOfEach: Icons.landscape,
  ThingType.PRODUCT.capitalizeFirstOfEach: FontAwesomeIcons.chair,
  ThingType.VEHICLE.capitalizeFirstOfEach: FontAwesomeIcons.car,
};

const GREEN = "green";
const BLUE = "blue";
const PURPLE = "purple";
const RED = "red";
const YELLOW = "yellow";
const ORANGE = "orange";
const VIOLET = "violet";
const PINK = "pink";
const BLACK = "black";
const WHITE = "white";

Map<String, Color> allColors = {
  GREEN: Colors.green,
  BLUE: Colors.blue,
  PURPLE: Colors.purple,
  RED: Colors.red,
  BLACK: Colors.black,
  YELLOW: Colors.yellow,
  ORANGE: Colors.orange,
  VIOLET: Colors.purpleAccent,
  PINK: Colors.pink,
  WHITE: Colors.white,
};

List<String> amenityTypes = [
  WELLBEING,
  LUXURY,
  SECURITY,
  ThingType.VEHICLE,
];

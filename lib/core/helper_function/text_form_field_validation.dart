import '../../features/language/presentation/provider/language_provider.dart';

final RegExp emailValid = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
);

String? validateEstateRooms(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "estate_rooms");
  }
  return null;
}

String? validateEstateName(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "estate_name");
  }
  return null;
}

String? validateArea(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "area");
  }
  return null;
}

String? validateEstateBath(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "estate_bath");
  }
  return null;
}

bool validEnglish(String value) {
  RegExp regex = RegExp(r'/^[A-Za-z0-9]*$');
  return (regex.hasMatch(value));
}

String? validatePhone(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "phone_required");
  }
  if (value.length < 10) {
    return LanguageProvider.translate("validation", "phone_invalid");
  }
  if (validEnglish(value)) {
    return LanguageProvider.translate("validation", "english_phone");
  }
  return null;
}

String? validateName(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "name");
  }
  return null;
}

String? validateEmail(String? value) {
  if (!emailValid.hasMatch(value!)) {
    if (value.isEmpty) {
      return LanguageProvider.translate("validation", "email");
    } else {
      return LanguageProvider.translate("validation", "incorrect_email");
    }
  }
  return null;
}

String? validateOtp(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "otp_required");
  } else if (value.length < 4) {
    return LanguageProvider.translate("validation", "otp_length");
  }
  return null;
}

String? validatePassword(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "password_required");
  }
  return null;
}

String validateCity() {
  return LanguageProvider.translate("validation", "government");
}

String validateImage() {
  return LanguageProvider.translate("validation", "image");
}

String validateImageId() {
  return LanguageProvider.translate("validation", "image_id");
}

String validateAddress() {
  return LanguageProvider.translate("validation", "address");
}

String? validatePart() {
  return LanguageProvider.translate("validation", "part");
}

String? validateFirstName(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "first_name");
  }
  return null;
}

String? validateLastName(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "last_name");
  }
  return null;
}

String? validateApartment(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "apartment");
  }
  return null;
}

String? validateBuilding(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "building");
  }
  return null;
}

String? validateAddressName(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "address_name");
  }
  return null;
}

String? validateStreetName(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "street_name");
  }
  return null;
}

String? validateCheckPhone(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "phone_check");
  }
  return null;
}

String? validateBio(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "empty_about_me");
  }
  return null;
}

String? validateConfirmPassword(String? value, String? confirmPassword) {
  if (value != confirmPassword) {
    return LanguageProvider.translate("validation", "confirm_password");
  }
  return null;
}

String? validateDate(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "select_date");
  }
  return null;
}

String? validateAdTitle(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "ad_title");
  }
  return null;
}

String? validateAuctionTitle(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "auction_title");
  }
  return null;
}

String? validateDescription(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "description");
  }
  return null;
}

String? validatePrice(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "price");
  }
  return null;
}

String? validateCategory(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "choose_category");
  }
  return null;
}

String? validateSubCategory(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "choose_sub_category");
  }
  return null;
}

String? validateFilter(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "add_filter");
  }
  return null;
}

String? validatePriceType(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "add_price_type");
  }
  return null;
}

String? validateMap(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "add_map_address");
  }
  return null;
}

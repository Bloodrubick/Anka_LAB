import 'package:surf_mad_teacher_training/assets/images/app_svg_icons.dart';
import 'package:surf_mad_teacher_training/assets/strings/app_strings.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_type.dart';

extension PlaceTypeExtension on PlaceType {
  String get icon {
    switch (this) {
      case PlaceType.museum:
        return AppSvgIcons.icMuseum;
      case PlaceType.park:
        return AppSvgIcons.icPark;
      case PlaceType.cafe:
        return AppSvgIcons.icCafe;
      case PlaceType.restaurant:
        return AppSvgIcons.icRestaurant;
      case PlaceType.hotel:
        return AppSvgIcons.icHotel;
      case PlaceType.temple:
        return AppSvgIcons.icTemple;
      case PlaceType.monument:
        return AppSvgIcons.icMonument;
      case PlaceType.theatre:
        return AppSvgIcons.icTheatre;
      case _:
        return AppSvgIcons.icOther;
    }
  }

  String get label {
    switch (this) {
      case PlaceType.museum:
        return AppStrings.placeTypeMuseum;
      case PlaceType.park:
        return AppStrings.placeTypePark;
      case PlaceType.cafe:
        return AppStrings.placeTypeCafe;
      case PlaceType.restaurant:
        return AppStrings.placeTypeRestaurant;
      case PlaceType.hotel:
        return AppStrings.placeTypeHotel;
      case PlaceType.temple:
        return AppStrings.placeTypeTemplate;
      case PlaceType.monument:
        return AppStrings.placeTypeMonument;
      case PlaceType.theatre:
        return AppStrings.placeTypeTheatre;
      case _:
        return AppStrings.placeTypeOther;
    }
  }
}

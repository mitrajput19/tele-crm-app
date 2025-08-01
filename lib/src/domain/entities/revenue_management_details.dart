class RevenueManagementDetails {
  List<RatesAndAvailabilities>? ratesAndAvailabilities;
  List<PropertyHolidays>? propertyHolidays;
  List<PropertyEvents>? propertyEvents;
  List<PropertySeasons>? seasons;

  RevenueManagementDetails({
    this.ratesAndAvailabilities,
    this.propertyHolidays,
    this.propertyEvents,
    this.seasons,
  });

  RevenueManagementDetails.fromJson(Map<String, dynamic> json) {
    if (json['rates_and_availabilities'] != null) {
      ratesAndAvailabilities = <RatesAndAvailabilities>[];
      json['rates_and_availabilities'].forEach((v) {
        ratesAndAvailabilities!.add(new RatesAndAvailabilities.fromJson(v));
      });
    }
    if (json['property_holidays'] != null) {
      propertyHolidays = <PropertyHolidays>[];
      json['property_holidays'].forEach((v) {
        propertyHolidays!.add(new PropertyHolidays.fromJson(v));
      });
    }
    if (json['property_events'] != null) {
      propertyEvents = <PropertyEvents>[];
      json['property_events'].forEach((v) {
        propertyEvents!.add(new PropertyEvents.fromJson(v));
      });
    }
    if (json['seasons'] != null) {
      seasons = <PropertySeasons>[];
      json['seasons'].forEach((v) {
        seasons!.add(new PropertySeasons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ratesAndAvailabilities != null) {
      data['rates_and_availabilities'] = this.ratesAndAvailabilities!.map((v) => v.toJson()).toList();
    }
    if (this.propertyHolidays != null) {
      data['property_holidays'] = this.propertyHolidays!.map((v) => v.toJson()).toList();
    }
    if (this.propertyEvents != null) {
      data['property_events'] = this.propertyEvents!.map((v) => v.toJson()).toList();
    }
    if (this.seasons != null) {
      data['seasons'] = this.seasons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RatesAndAvailabilities {
  int? roomCategoryId;
  String? roomCategoryName;
  int? propertyId;
  String? propertyName;
  int? defaultCurrencyId;
  String? defaultCurrencySymbol;
  List<RatePlanDatesAndAvailability>? datesAndAvailability;
  List<RatePlans>? ratePlans;

  RatesAndAvailabilities({
    this.roomCategoryId,
    this.roomCategoryName,
    this.propertyId,
    this.propertyName,
    this.defaultCurrencyId,
    this.defaultCurrencySymbol,
    this.datesAndAvailability,
    this.ratePlans,
  });

  RatesAndAvailabilities.fromJson(Map<String, dynamic> json) {
    roomCategoryId = json['room_category_id'];
    roomCategoryName = json['room_category_name'];
    propertyId = json['property_id'];
    propertyName = json['property_name'];
    defaultCurrencyId = json['default_currency_id'];
    defaultCurrencySymbol = json['default_currency_symbol'];
    if (json['dates_and_availability'] != null) {
      datesAndAvailability = <RatePlanDatesAndAvailability>[];
      json['dates_and_availability'].forEach((v) {
        datesAndAvailability!.add(new RatePlanDatesAndAvailability.fromJson(v));
      });
    }
    if (json['rate_plans'] != null) {
      ratePlans = <RatePlans>[];
      json['rate_plans'].forEach((v) {
        ratePlans!.add(new RatePlans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_category_id'] = this.roomCategoryId;
    data['room_category_name'] = this.roomCategoryName;
    data['property_id'] = this.propertyId;
    data['property_name'] = this.propertyName;
    data['default_currency_id'] = this.defaultCurrencyId;
    data['default_currency_symbol'] = this.defaultCurrencySymbol;
    if (this.datesAndAvailability != null) {
      data['dates_and_availability'] = this.datesAndAvailability!.map((v) => v.toJson()).toList();
    }
    if (this.ratePlans != null) {
      data['rate_plans'] = this.ratePlans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RatePlanDatesAndAvailability {
  String? date;
  String? availableRoomsCountPms;
  String? availableRoomsCountCm;
  String? availableRoomsCountWlw;
  String? availableRoomsCountWla;

  RatePlanDatesAndAvailability({
    this.date,
    this.availableRoomsCountPms,
    this.availableRoomsCountCm,
    this.availableRoomsCountWlw,
    this.availableRoomsCountWla,
  });

  RatePlanDatesAndAvailability.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    availableRoomsCountPms = json['available_rooms_count_pms'];
    availableRoomsCountCm = json['available_rooms_count_cm'];
    availableRoomsCountWlw = json['available_rooms_count_wlw'];
    availableRoomsCountWla = json['available_rooms_count_wla'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['available_rooms_count_pms'] = this.availableRoomsCountPms;
    data['available_rooms_count_cm'] = this.availableRoomsCountCm;
    data['available_rooms_count_wlw'] = this.availableRoomsCountWlw;
    data['available_rooms_count_wla'] = this.availableRoomsCountWla;
    return data;
  }
}

class RatePlans {
  int? ratePlanId;
  String? ratePlanName;
  int? ratePlanOccupancyMappingId;
  int? adultOccupancyCount;
  int? childrenOccupancyCount;
  String? defaultNetAmount;
  String? defaultGrossAmount;
  List<RatePlanTaxes>? taxes;
  List<PlatfromAvailabilityAndRatesPerDate>? pmsAvailabilityAndRatesPerDate;
  List<PlatfromAvailabilityAndRatesPerDate>? wlwAvailabilityAndRatesPerDate;
  List<PlatfromAvailabilityAndRatesPerDate>? wlaAvailabilityAndRatesPerDate;

  RatePlans({
    this.ratePlanId,
    this.ratePlanName,
    this.ratePlanOccupancyMappingId,
    this.adultOccupancyCount,
    this.childrenOccupancyCount,
    this.defaultNetAmount,
    this.defaultGrossAmount,
    this.taxes,
    this.pmsAvailabilityAndRatesPerDate,
    this.wlwAvailabilityAndRatesPerDate,
    this.wlaAvailabilityAndRatesPerDate,
  });

  RatePlans.fromJson(Map<String, dynamic> json) {
    ratePlanId = json['rate_plan_id'];
    ratePlanName = json['rate_plan_name'];
    ratePlanOccupancyMappingId = json['rate_plan_occupancy_mapping_id'];
    adultOccupancyCount = json['adult_occupancy_count'];
    childrenOccupancyCount = json['children_occupancy_count'];
    defaultNetAmount = json['default_net_amount'];
    defaultGrossAmount = json['default_gross_amount'];
    if (json['taxes'] != null) {
      taxes = <RatePlanTaxes>[];
      json['taxes'].forEach((v) {
        taxes!.add(new RatePlanTaxes.fromJson(v));
      });
    }
    if (json['pms_availability_and_rates_per_date'] != null) {
      pmsAvailabilityAndRatesPerDate = <PlatfromAvailabilityAndRatesPerDate>[];
      json['pms_availability_and_rates_per_date'].forEach((v) {
        pmsAvailabilityAndRatesPerDate!.add(new PlatfromAvailabilityAndRatesPerDate.fromJson(v));
      });
    }
    if (json['wlw_availability_and_rates_per_date'] != null) {
      wlwAvailabilityAndRatesPerDate = <PlatfromAvailabilityAndRatesPerDate>[];
      json['wlw_availability_and_rates_per_date'].forEach((v) {
        wlwAvailabilityAndRatesPerDate!.add(new PlatfromAvailabilityAndRatesPerDate.fromJson(v));
      });
    }
    if (json['wla_availability_and_rates_per_date'] != null) {
      wlaAvailabilityAndRatesPerDate = <PlatfromAvailabilityAndRatesPerDate>[];
      json['wla_availability_and_rates_per_date'].forEach((v) {
        wlaAvailabilityAndRatesPerDate!.add(new PlatfromAvailabilityAndRatesPerDate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate_plan_id'] = this.ratePlanId;
    data['rate_plan_name'] = this.ratePlanName;
    data['rate_plan_occupancy_mapping_id'] = this.ratePlanOccupancyMappingId;
    data['adult_occupancy_count'] = this.adultOccupancyCount;
    data['children_occupancy_count'] = this.childrenOccupancyCount;
    data['default_net_amount'] = this.defaultNetAmount;
    data['default_gross_amount'] = this.defaultGrossAmount;
    if (this.taxes != null) {
      data['taxes'] = this.taxes!.map((v) => v.toJson()).toList();
    }
    if (this.pmsAvailabilityAndRatesPerDate != null) {
      data['pms_availability_and_rates_per_date'] =
          this.pmsAvailabilityAndRatesPerDate!.map((v) => v.toJson()).toList();
    }
    if (this.wlwAvailabilityAndRatesPerDate != null) {
      data['wlw_availability_and_rates_per_date'] =
          this.wlwAvailabilityAndRatesPerDate!.map((v) => v.toJson()).toList();
    }
    if (this.wlaAvailabilityAndRatesPerDate != null) {
      data['wla_availability_and_rates_per_date'] =
          this.wlaAvailabilityAndRatesPerDate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RatePlanTaxes {
  int? taxId;
  String? taxName;
  String? taxAmount;
  String? taxType;

  RatePlanTaxes({
    this.taxId,
    this.taxName,
    this.taxAmount,
    this.taxType,
  });

  RatePlanTaxes.fromJson(Map<String, dynamic> json) {
    taxId = json['tax_id'];
    taxName = json['tax_name'];
    taxAmount = json['tax_amount'];
    taxType = json['tax_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax_id'] = this.taxId;
    data['tax_name'] = this.taxName;
    data['tax_amount'] = this.taxAmount;
    data['tax_type'] = this.taxType;
    return data;
  }
}

class PlatfromAvailabilityAndRatesPerDate {
  String? date;
  int? isAmountOverridden;
  String? netAmount;
  String? grossAmount;
  int? stopSell;

  PlatfromAvailabilityAndRatesPerDate({
    this.date,
    this.isAmountOverridden,
    this.netAmount,
    this.grossAmount,
    this.stopSell,
  });

  PlatfromAvailabilityAndRatesPerDate.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    isAmountOverridden = json['is_amount_overridden'];
    netAmount = json['net_amount'];
    grossAmount = json['gross_amount'];
    stopSell = json['stop_sell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['is_amount_overridden'] = this.isAmountOverridden;
    data['net_amount'] = this.netAmount;
    data['gross_amount'] = this.grossAmount;
    data['stop_sell'] = this.stopSell;
    return data;
  }
}

class PropertyHolidays {
  String? date;
  String? totalCrucial;
  String? totalImportant;
  String? totalRelevant;

  PropertyHolidays({
    this.date,
    this.totalCrucial,
    this.totalImportant,
    this.totalRelevant,
  });

  PropertyHolidays.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    totalCrucial = json['total_crucial'];
    totalImportant = json['total_important'];
    totalRelevant = json['total_relevant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['total_crucial'] = this.totalCrucial;
    data['total_important'] = this.totalImportant;
    data['total_relevant'] = this.totalRelevant;
    return data;
  }
}

class PropertyEvents {
  String? date;
  String? totalCrucial;
  String? totalImportant;
  String? totalRelevant;

  PropertyEvents({
    this.date,
    this.totalCrucial,
    this.totalImportant,
    this.totalRelevant,
  });

  PropertyEvents.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    totalCrucial = json['total_crucial'];
    totalImportant = json['total_important'];
    totalRelevant = json['total_relevant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['total_crucial'] = this.totalCrucial;
    data['total_important'] = this.totalImportant;
    data['total_relevant'] = this.totalRelevant;
    return data;
  }
}

class PropertySeasons {
  String? date;
  int? seasonId;
  String? seasonName;
  String? typeOfSeasonName;
  String? seasonColor;
  String? seasonBadgeHtml;
  int? seasonPhaseId;
  String? seasonPhaseName;
  String? typeOfSubSeasonName;
  String? phaseColor;
  String? phaseBadgeHtml;

  PropertySeasons({
    this.date,
    this.seasonId,
    this.seasonName,
    this.typeOfSeasonName,
    this.seasonColor,
    this.seasonBadgeHtml,
    this.seasonPhaseId,
    this.seasonPhaseName,
    this.typeOfSubSeasonName,
    this.phaseColor,
    this.phaseBadgeHtml,
  });

  PropertySeasons.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    seasonId = json['season_id'];
    seasonName = json['season_name'];
    typeOfSeasonName = json['type_of_season_name'];
    seasonColor = json['season_color'];
    seasonBadgeHtml = json['season_badge_html'];
    seasonPhaseId = json['season_phase_id'];
    seasonPhaseName = json['season_phase_name'];
    typeOfSubSeasonName = json['type_of_sub_season_name'];
    phaseColor = json['phase_color'];
    phaseBadgeHtml = json['phase_badge_html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['season_id'] = this.seasonId;
    data['season_name'] = this.seasonName;
    data['type_of_season_name'] = this.typeOfSeasonName;
    data['season_color'] = this.seasonColor;
    data['season_badge_html'] = this.seasonBadgeHtml;
    data['season_phase_id'] = this.seasonPhaseId;
    data['season_phase_name'] = this.seasonPhaseName;
    data['type_of_sub_season_name'] = this.typeOfSubSeasonName;
    data['phase_color'] = this.phaseColor;
    data['phase_badge_html'] = this.phaseBadgeHtml;
    return data;
  }
}

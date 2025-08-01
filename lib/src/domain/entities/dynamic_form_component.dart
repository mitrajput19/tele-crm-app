class DynamicFormComponent {
  num? ratio;
  String? toolType;
  String? type;
  String? id;
  bool? showLabel;
  String? label;
  String? inputValue;
  String? placeholder;
  bool? mandatory;
  String? regex;
  bool? todaySelected;
  bool? disablePastDates;
  bool? disableFutureDates;
  bool? format24Enabled;
  List<DynamicFormOption>? options;
  String? orientation;
  num? gridSize;
  num? minValue;
  num? maxValue;
  num? currentValue;
  bool? currentState;
  bool? preview;
  List<String>? fileTypes;
  String? selectedColor;
  num? maxRating;
  num? currentRating;

  DynamicFormComponent({
    this.ratio,
    this.toolType,
    this.type,
    this.id,
    this.showLabel,
    this.label,
    this.inputValue,
    this.placeholder,
    this.mandatory,
    this.regex,
    this.todaySelected,
    this.disablePastDates,
    this.disableFutureDates,
    this.format24Enabled,
    this.options,
    this.orientation,
    this.gridSize,
    this.minValue,
    this.maxValue,
    this.currentValue,
    this.currentState,
    this.preview,
    this.fileTypes,
    this.selectedColor,
    this.maxRating,
    this.currentRating,
  });

  DynamicFormComponent.fromJson(Map<String, dynamic> json) {
    ratio = json['ratio'];
    toolType = json['toolType'];
    type = json['type'];
    id = json['id'];
    showLabel = json['show_label'];
    label = json['label'];
    inputValue = json['inputValue'];
    placeholder = json['placeholder'];
    mandatory = json['mandatory'];
    regex = json['regex'];
    todaySelected = json['today_selected'];
    disablePastDates = json['disable_past_dates'];
    disableFutureDates = json['disable_future_dates'];
    format24Enabled = json['format_24_enabled'];
    if (json['options'] != null) {
      options = <DynamicFormOption>[];
      json['options'].forEach((v) {
        options!.add(new DynamicFormOption.fromJson(v));
      });
    }
    orientation = json['orientation'];
    gridSize = json['gridSize'];
    minValue = json['min_value'];
    maxValue = json['max_value'];
    currentValue = json['current_value'];
    currentState = json['current_state'];
    preview = json['preview'];
    if (json['file_type'] != null) {
      fileTypes = json['file_types'].cast<String>();
    }
    selectedColor = json['selected_color'];
    maxRating = json['max_rating'];
    currentRating = json['current_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ratio'] = this.ratio;
    data['toolType'] = this.toolType;
    data['type'] = this.type;
    data['id'] = this.id;
    data['show_label'] = this.showLabel;
    data['label'] = this.label;
    data['inputValue'] = this.inputValue;
    data['placeholder'] = this.placeholder;
    data['mandatory'] = this.mandatory;
    data['regex'] = this.regex;
    data['today_selected'] = this.todaySelected;
    data['disable_past_dates'] = this.disablePastDates;
    data['disable_future_dates'] = this.disableFutureDates;
    data['format_24_enabled'] = this.format24Enabled;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['orientation'] = this.orientation;
    data['gridSize'] = this.gridSize;
    data['min_value'] = this.minValue;
    data['max_value'] = this.maxValue;
    data['current_value'] = this.currentValue;
    data['current_state'] = this.currentState;
    data['preview'] = this.preview;
    data['file_types'] = this.fileTypes;
    data['selected_color'] = this.selectedColor;
    data['max_rating'] = this.maxRating;
    data['current_rating'] = this.currentRating;
    return data;
  }

  static List<DynamicFormComponent> listFromJson(dynamic json) {
    List<DynamicFormComponent> list = [];
    if (json['data']['details']['components'] != null) {
      json['data']['details']['components'].forEach((v) {
        list.add(new DynamicFormComponent.fromJson(v));
      });
    }
    return list;
  }
}

class DynamicFormOption {
  String? displayText;
  String? value;
  bool? checked;

  DynamicFormOption({this.displayText, this.value, this.checked});

  DynamicFormOption.fromJson(Map<String, dynamic> json) {
    displayText = json['display_text'];
    value = json['value'];
    checked = json['checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['display_text'] = this.displayText;
    data['value'] = this.value;
    data['checked'] = this.checked;
    return data;
  }
}

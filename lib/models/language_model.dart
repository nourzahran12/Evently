class LanguageModel {
  String name;
  String code;

  LanguageModel({required this.name, required this.code});

  static List<LanguageModel> languages = [
    LanguageModel(name: 'English', code: 'en'),
    LanguageModel(name: 'العربية', code: 'ar'),
  ];
}

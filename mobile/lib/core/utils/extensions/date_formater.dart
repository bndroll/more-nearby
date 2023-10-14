
enum _DateLexem {
  year,
  month,
  day,
  hours,
  minutes,
  seconds
}

extension _DateLexemMethods on _DateLexem {
  String get lexem => switch(this) {
    _DateLexem.year => 'YYYY',
    _DateLexem.month => 'MM',
    _DateLexem.day => 'DD',
    _DateLexem.hours => 'hh',
    _DateLexem.minutes => 'mm',
    _DateLexem.seconds => 'ss'
  };

  int getDateLexemValue(DateTime dateTime) => switch(this) {
    _DateLexem.year => dateTime.year,
    _DateLexem.month => dateTime.month,
    _DateLexem.day => dateTime.day,
    _DateLexem.hours => dateTime.hour,
    _DateLexem.minutes => dateTime.minute,
    _DateLexem.seconds => dateTime.second
  };
}


extension DateFormater on DateTime {


  ///An extension for format date in Flutter by special format lexemes:
  ///YYYY - get year
  ///MM - get month
  ///DD - get date
  ///hh - get hours
  ///mm - get minutes
  ///ss - get seconds
  ///
  /// Example: debugPrint(DateTime.parse('09.09.2002').format('YYYY-MM-DD'))
  /// Result: 2002-09-09
  String format(String format) {
    var formattedDate = format;
    for(final dateLexem in _DateLexem.values) {
      final value = dateLexem.getDateLexemValue(this);
      formattedDate = formattedDate.replaceAll(dateLexem.lexem, value < 10 ? '0$value' : value.toString());
    }
    return formattedDate;
  }

}
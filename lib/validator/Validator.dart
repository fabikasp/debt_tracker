class Validator {
  static String validatePerson(String person) {
    if (person.isEmpty) {
      return 'Bitte Person angeben';
    }

    if (person.length > 30) {
      return 'Nicht mehr als 20 Zeichen verwenden';
    }

    return null;
  }

  static String validateReason(String reason) {
    if (reason.isEmpty) {
      return 'Bitte Grund angeben';
    }

    if (reason.length > 100) {
      return 'Nicht mehr als 100 Zeichen verwenden';
    }

    return null;
  }

  static bool isNumeric(String str) {
    if (str == null) {
      return false;
    }

    return double.tryParse(str) != null;
  }

  static String validateAmount(String amount) {
    amount = amount.replaceAll(',', '.');

    if (amount.isEmpty) {
      return 'Bitte Betrag angeben';
    }

    if (!isNumeric(amount)) {
      return 'Betrag muss eine Zahl sein';
    }

    if (double.parse(amount) == 0) {
      return 'Betrag ist zu klein';
    }

    if (double.parse(amount) > 9999999999) {
      return 'Betrag ist zu groß';
    }

    return null;
  }
}
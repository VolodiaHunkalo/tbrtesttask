String? formatPhoneNumber(String phoneNumber) {
  phoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
  if (phoneNumber.length < 4) {
    return phoneNumber;
  } else if (phoneNumber.length < 7) {
    return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3)}'
        .trim();
  } else if (phoneNumber.length < 11) {
    return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}'
        .trim();
  } else {
    return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6, 10)}'
        .trim();
  }
}

enum ScreenElements {
  scanDoc("Scan document", "assets/icons/scan_document.svg"),
  searchPatient("Search patient", "assets/icons/patient.svg");

  final String name;
  final String imagePath;

  const ScreenElements(this.name, this.imagePath);
}

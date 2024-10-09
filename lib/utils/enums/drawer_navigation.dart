enum DrawerNavigation {
  overview("Overview","assets/icons/overview.svg"),
  appointments("Appointments","assets/icons/appointments.svg"),
  patient("Patient","assets/icons/patient.svg"),
  contacts("Contacts","assets/icons/contacts.svg"),
  schedule("Schedule","assets/icons/schedule.svg"),
  help("Help","assets/icons/help.svg"),
  support("Support","assets/icons/support.svg"),
  settings("Settings","assets/icons/settings.svg");

  final String name;
  final String imagePath;

  const DrawerNavigation(this.name, this.imagePath);
}

double getProgressForPage(int currentPage) {
  switch (currentPage) {
    case 0:
      return 0.0;
    case 1:
      return 0.3;
    case 2:
      return 0.6;
    case 3:
      return 1.0;
    default:
      return 0.0;
  }
}

double getbottomSpace(int currentPage) {
  switch (currentPage) {
    case 1:
      return 50;
    case 2:
      return 0;
    case 3:
      return 0;
    case 4:
      return 20;
    default:
      return 0.0;
  }
}

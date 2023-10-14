extension NumParsing on String? {
    double parseDoubleOr(double or) => double.tryParse(this ?? '') ?? or;
    int parseIntOr(int or) => int.tryParse(this ?? '') ?? or;
}
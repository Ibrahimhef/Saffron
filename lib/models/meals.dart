class Meal {
  final String id;
  final int category;
  final String title;
  final String description;
  final String ingredients;
  final String step;
  final int duration;
  final String email;
  final String imageURL;
  final bool display;

  Meal(
      {this.display,
      this.id,
      this.category,
      this.title,
      this.description,
      this.ingredients,
      this.step,
      this.duration,
      this.email,
      this.imageURL});
}

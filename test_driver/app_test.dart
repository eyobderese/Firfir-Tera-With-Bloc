import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Onboarding, Register and login test', () {
    final onboarding2NextButton = find.byValueKey('onboarding2_next_button');
    final onboarding3NextButton = find.byValueKey('onboarding3_next_button');

    final usernameField = find.byValueKey('username_field');
    final passwordField = find.byValueKey('password_field');
    final loginButton = find.byValueKey('login_button');
    final snackBarFinder = find.byType('SnackBar');

    final register1NextButton = find.byValueKey('register1_next_button');
    final discoverPageKey = find.byValueKey('discover_page');

    final galleryOptionButton = find.text('Gallery');

    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('navigate through onboarding and register', () async {
      // Wait for onboarding page 1 to automatically navigate to page 2
      await Future.delayed(const Duration(seconds: 6));

      // Tap on the next button on onboarding page 2
      await driver.tap(onboarding2NextButton);

      // Tap on the next button on onboarding page 3
      await driver.tap(onboarding3NextButton);

      await driver.tap(find.byValueKey('register_button'));

      await driver.tap(find.byValueKey('register_email_field'));
      await driver.enterText('testuser@gmail.com');
      await driver.waitFor(find.text('testuser@gmail.com'));

      await driver.tap(find.byValueKey('register_password_field'));
      await driver.enterText('testpassword');
      await driver.waitFor(find.text('testpassword'));

      await driver.tap(find.byValueKey('user_type_dropdown'));
      await driver.tap(find.text('I am a Cook'));
      await driver.tap(register1NextButton);

      await driver.waitFor(find.text('Success'));

      await driver.tap(find.byValueKey('register2_firstName_field'));
      await driver.enterText('test');
      await driver.waitFor(find.text('test'));

      await driver.tap(find.byValueKey('register2_lastName_field'));
      await driver.enterText('fatheruser');
      await driver.waitFor(find.text('fatheruser'));

      await driver.tap(find.byValueKey('register2_bio_field'));
      await driver.enterText('test bio');
      await driver.waitFor(find.text('test bio'));
      await driver.tap(find.byValueKey('register2_next_button'));

      await driver.waitFor(find.text('Success'));

      // Open the bottom sheet for image selection
      await driver.tap(find.byValueKey('register3_image_button'));

      // Select the camera or gallery option
      await driver.tap(galleryOptionButton);
      await Future.delayed(
          const Duration(seconds: 5)); // Wait for the image to be selecte

      // Verify that the image has been selected and displayed
      await driver.tap(find.byValueKey('register3_finish_button'));
      await Future.delayed(const Duration(seconds: 2));

      // Check for a success message
      await driver.waitFor(find.text('You are Registerd Successfully'));
      await Future.delayed(const Duration(seconds: 2));
    }, timeout: const Timeout(Duration(minutes: 1)));

    // checks if the profile page is shown and then logs out
    test('go to profile page and logout', () async {
      await driver.tap(find.byValueKey('profile_button'));
      await driver.waitFor(find.byValueKey('profile_page'),
          timeout: const Duration(minutes: 1));

      await Future.delayed(const Duration(seconds: 1));

      await driver.tap(find.byValueKey('logout_button'));
      await driver.waitFor(find.byValueKey('login_page'),
          timeout: const Duration(seconds: 5));
    }, timeout: const Timeout(Duration(minutes: 2)));

    // the login part
    test('try to login with incorrect credentials', () async {
      // Enter invalid username
      await driver.tap(usernameField);
      await driver.enterText('invalid@gmail.com');
      await driver.waitFor(find.text('invalid@gmail.com'));

      await Future.delayed(const Duration(seconds: 1));
      // Enter invalid password
      await driver.tap(passwordField);
      await driver.enterText('invalid_password');
      await driver.waitFor(find.text('invalid_password'));
      await Future.delayed(const Duration(seconds: 1));

      // Tap on login button
      await driver.tap(loginButton);

      // Verify if SnackBar is shown (indicating failure)
      await driver.waitFor(snackBarFinder, timeout: const Duration(seconds: 6));
    }, timeout: const Timeout(Duration(minutes: 5)));

    test('login with correct credentials', () async {
      // Enter valid username
      await driver.tap(usernameField);
      await driver.enterText('testuser@gmail.com');
      await driver.waitFor(find.text('testuser@gmail.com'));

      await Future.delayed(const Duration(seconds: 1));
      // Enter valid password
      await driver.tap(passwordField);
      await driver.enterText('testpassword');
      await driver.waitFor(find.text('testpassword'));

      await Future.delayed(const Duration(seconds: 1));
      // Tap on login button
      await driver.tap(loginButton);
      await Future.delayed(const Duration(seconds: 2));

      // Verify if Discover page is shown (indicating Success)
      await driver.waitFor(discoverPageKey,
          timeout: const Duration(seconds: 5));
    }, timeout: const Timeout(Duration(minutes: 2)));

    // test if the create recipe page is shown
    test('go to create recipe page and create a recipe', () async {
      // Tap on the button to navigate to the create recipe page
      await driver.tap(find.byValueKey('add_recipe_button'));
      await driver.waitFor(find.byValueKey('create_recipe_page'),
          timeout: const Duration(seconds: 5));

      await Future.delayed(const Duration(seconds: 2));

      // Tap on the button to select an image
      await driver.tap(find.byValueKey('select_image_button'));
      await driver.tap(find.text('Gallery'));
      await Future.delayed(
          const Duration(seconds: 5)); // Wait for the image to be selected

      await Future.delayed(const Duration(seconds: 1));
      // Enter recipe name
      await driver.tap(find.byValueKey('recipe_name_field'));
      await driver.enterText('Delicious Pasta');

      await Future.delayed(const Duration(seconds: 1));
      // Enter number of serves
      await driver.tap(find.byValueKey('serve_field'));
      await driver.enterText('4');

      await Future.delayed(const Duration(seconds: 1));
      // Enter cooking time
      await driver.tap(find.byValueKey('cooking_time_field'));
      await driver.enterText('30');

      // Enter description
      await driver.tap(find.byValueKey('description_field'));
      await driver.enterText('A mouthwatering pasta dish.');

      await Future.delayed(const Duration(seconds: 1));

      // Select meal type
      await driver.tap(find.byValueKey('meal_type_dropdown'));
      await driver.tap(find.text('Dinner'));

      await Future.delayed(const Duration(seconds: 1));

      // Select fasting type
      await driver.tap(find.byValueKey('fasting_dropdown'));
      await driver.tap(find.text('Non-Fasting'));

      // Add ingredients
      await Future.delayed(const Duration(seconds: 1));
      await driver.tap(find.byValueKey('ingredient_list'));
      await driver.enterText('Pasta');

      await Future.delayed(const Duration(seconds: 1));

      // Add steps
      await driver.tap(find.byValueKey('step_list'));
      await driver.enterText('Boil pasta');

      await Future.delayed(const Duration(seconds: 1));

      // Tap on Save My Recipe button
      await Future.delayed(const Duration(seconds: 2));
      await driver.tap(find.byValueKey('save_button'));

      await Future.delayed(const Duration(seconds: 3));
      await driver.waitFor(
          find.text(
              'Recipe Created Successfully, You can view it in the Discover Page'),
          timeout: const Duration(seconds: 7));
    }, timeout: const Timeout(Duration(minutes: 3)));

    test('go to discover page and detailed view', () async {
      await driver.tap(find.byValueKey('discover_button'));
      await driver.waitFor(find.byValueKey('discover_page'),
          timeout: const Duration(seconds: 3));

      // tap on the dinner option and then tap on the first recipe card

      await driver.tap(find.text('Dinner'));
      await driver.waitFor(find.byValueKey('recipe_card'),
          timeout: const Duration(seconds: 3));

      await driver.tap(find.byValueKey('recipe_card'));
      await driver.waitFor(find.byValueKey('detailed_recipe_page'),
          timeout: const Duration(seconds: 3));

      // Tap on the comment button
      await Future.delayed(const Duration(seconds: 2));
      await driver.tap(find.byValueKey('comment_button'));
      await driver.waitFor(find.byValueKey('comment_page'),
          timeout: const Duration(seconds: 3));

      await Future.delayed(const Duration(seconds: 10));

      await driver.waitFor(find.byValueKey('comment_textfield'));
      await driver.tap(find.byValueKey('comment_textfield'));
      await Future.delayed(const Duration(seconds: 2));
      await driver.enterText('This is a test comment');
      await driver.waitFor(find.text('This is a test comment'));
      await Future.delayed(const Duration(seconds: 2));
      await driver.tap(find.byValueKey('send_comment'));
      await Future.delayed(const Duration(seconds: 3));
    }, timeout: const Timeout(Duration(minutes: 1)));
  });
}

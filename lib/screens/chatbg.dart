import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackgroundChangeScreen extends StatefulWidget {
  final Function(String?, Color?) onBackgroundSelected;

  const BackgroundChangeScreen({Key? key, required this.onBackgroundSelected})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BackgroundChangeScreenState createState() => _BackgroundChangeScreenState();
}

class _BackgroundChangeScreenState extends State<BackgroundChangeScreen> {
  Color? selectedColor;
  String? selectedImage;



  Future<void> _saveSelectedBackground(String? image, Color? color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (image != null) {
      prefs.setString('selectedImage', image);
      prefs.remove('selectedColor');
    } else if (color != null) {
      prefs.setString('selectedColor', color.value.toString());
      prefs.remove('selectedImage');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Background')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Select Color', style: TextStyle(fontSize: 16)),
          ),
          _buildColorGrid(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Select Image', style: TextStyle(fontSize: 16)),
          ),
          _buildImageGrid(),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _saveSelectedBackground(selectedImage, selectedColor);
                widget.onBackgroundSelected(selectedImage, selectedColor);
                Navigator.pop(context);
              },
              child: const Text('Change Background'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorGrid() {
    List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: colors
            .map((color) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = color;
                      selectedImage = null;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                          ),
                        ),
                        if (selectedColor == color)
                          const Icon(Icons.check, color: Colors.white),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

 Widget _buildImageGrid() {
  return GridView.builder(
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    itemCount: 11, // Change this to the number of images in your images/bg folder
    itemBuilder: (context, index) {
      // Get image from assets/images/bg folder
      String imagePath = 'images/Chat BG/$index.jpg';
      return GestureDetector(
        onTap: () {
          print('Selected Image: $imagePath');
          setState(() {
            selectedImage = imagePath;
            selectedColor = null;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0), 
          child: Stack(
            alignment: Alignment.center,
            children: [
             ClipRRect(
                borderRadius: BorderRadius.circular(8.0), // Set borderRadius here
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              if (selectedImage == imagePath)
                const Icon(Icons.check, color: Colors.white),
            ],
          ),
        ),
      );
    },
  );
}

}

import 'package:dnd_app/presentation/common_widgets/masked_gif_image_widget.dart';
import 'package:flutter/material.dart';

final text = '''

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pharetra leo eros, et mattis erat consequat sed. Quisque vitae ligula a magna ornare porttitor. Maecenas molestie porttitor dolor. Nulla ornare, elit nec convallis euismod, urna leo interdum sem, ac rutrum tellus tortor nec leo. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris vehicula porta est. Nulla luctus nunc ac justo tincidunt, ornare eleifend tortor cursus. Nulla dapibus eros porta tortor consequat, at feugiat justo imperdiet. Phasellus consequat vehicula risus vitae sagittis. Vivamus a magna quis orci maximus luctus. Fusce sit amet pellentesque augue. Vestibulum lorem dui, consectetur vel varius at, tempor non sapien. Vivamus lacinia eleifend purus sit amet rhoncus.

Suspendisse potenti. In cursus, justo tempus congue accumsan, quam mauris mollis risus, vitae lobortis erat purus vitae dolor. Sed finibus, purus vel consequat fermentum, magna turpis varius purus, ut blandit massa felis nec lorem. Morbi cursus purus a leo luctus dictum. Nam mattis dui urna, eget cursus magna commodo sit amet. Ut nulla urna, vehicula vel ipsum eu, convallis consequat nunc. Donec ornare interdum pellentesque. Aenean sed est laoreet, lacinia nunc viverra, accumsan magna.

Fusce vel elit eu ante vehicula aliquam. Proin sit amet laoreet nisi. Sed faucibus euismod nulla at aliquam. Pellentesque aliquet luctus arcu, sit amet consequat nulla feugiat accumsan. In tristique augue nec sapien dapibus rutrum. Maecenas non bibendum justo, at auctor quam. Vivamus maximus ipsum ac nibh facilisis, a sodales ex tincidunt. Maecenas vel arcu venenatis, dictum quam ut, pellentesque urna. Ut consectetur convallis nisi, sit amet efficitur ex ullamcorper non. Nulla augue lorem, tincidunt id felis eget, dapibus convallis sapien. Cras efficitur risus vel porta scelerisque. Sed quam lorem, laoreet vitae ullamcorper sed, sollicitudin in nulla.

Cras dictum venenatis est, eu dapibus nunc pellentesque quis. Sed vel magna ligula. Sed convallis eleifend nunc in euismod. Pellentesque venenatis laoreet orci, gravida viverra lacus auctor et. Suspendisse purus nunc, interdum eu laoreet sed, lobortis nec massa. In sapien nisi, lobortis at magna quis, porttitor tincidunt mi. Donec pellentesque malesuada nulla id ornare. Nulla finibus sem urna, nec rhoncus enim tempus in. Quisque ultricies nunc nec lectus congue porttitor. Aenean vel finibus nisi.

Curabitur volutpat lorem eu ultricies suscipit. Nulla consequat, sem sit amet porta viverra, orci nisi elementum risus, ut consequat justo turpis a eros. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque cursus odio in rutrum commodo. In eget tristique tortor, id condimentum sem. Nullam posuere eu tellus in dictum. Phasellus in euismod libero, eget interdum sem. Morbi at commodo lectus. ''';

class GifTestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.greenAccent,
        padding: EdgeInsets.all(20),
        // child: Text('Hello World'),
        child: SingleChildScrollView(
          child: MaskedGifImageWidget(
            forward: true,
            image: AssetImage('assets/noise.gif'),
            blendMode: BlendMode.dstIn,
            child: Text(text),
          ),
        ),
      ),
    );
  }
}

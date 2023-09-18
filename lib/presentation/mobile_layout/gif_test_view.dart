import 'package:dnd_app/presentation/common_widgets/masked_gif_image_widget.dart';
import 'package:dnd_app/presentation/mobile_layout/main_scaffold.dart';
import 'package:flutter/material.dart';

class GifTestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Blend Child Widget with Custom Painter'),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              MainBackgroundWidget(),
              MaskedGifImageWidget(
                image: AssetImage('assets/noise.gif'),
                child: Text('''

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus in neque varius, lacinia neque ac, hendrerit sapien. Morbi rutrum pellentesque sapien quis pulvinar. Phasellus ut ornare augue. In nisl justo, congue nec augue nec, efficitur euismod mauris. Ut lacus ligula, fermentum molestie mi vitae, iaculis vestibulum lectus. Praesent aliquam imperdiet lorem eget tempus. In hac habitasse platea dictumst. Vivamus eu molestie nulla, eu dictum velit. Ut molestie enim felis, egestas eleifend velit malesuada dignissim. Sed vel efficitur diam, vitae bibendum purus. Vivamus feugiat id lorem vel porttitor. Duis malesuada pellentesque lacinia.

Nulla mattis sem id sem laoreet faucibus sed et enim. Maecenas in augue vitae lorem cursus convallis. Suspendisse ut suscipit purus, in fermentum arcu. Quisque pulvinar sem a felis congue rhoncus id ut lorem. Cras est diam, lacinia sit amet erat sit amet, sagittis volutpat nibh. Suspendisse potenti. Curabitur pellentesque commodo volutpat. Etiam id porttitor lacus, nec lacinia mi. In hac habitasse platea dictumst. In scelerisque purus quis arcu dictum, quis ultrices diam viverra. Curabitur turpis purus, euismod tincidunt mattis non, porttitor id odio. Nullam neque augue, consectetur non urna vel, aliquet interdum enim. Duis vulputate, ex eu ultrices tincidunt, sapien ligula tincidunt metus, vel scelerisque dolor purus ut nunc. Aliquam odio dolor, imperdiet sit amet risus eget, condimentum molestie urna. Nulla sem dui, imperdiet in sagittis eget, malesuada vel leo.

Nunc vestibulum pharetra molestie. In vehicula orci est, a porta leo condimentum fermentum. Phasellus sollicitudin, nisl nec condimentum facilisis, ligula risus faucibus sem, ac fermentum elit purus ac nunc. Etiam id sapien ex. Integer eu massa eu dolor aliquet elementum. Curabitur ac imperdiet leo, et sagittis lorem. Nulla fringilla vestibulum auctor. Cras condimentum metus tempus lacus varius mattis. Donec nulla mauris, tristique fermentum turpis vel, fermentum ornare urna. Nullam orci nunc, pellentesque vel dignissim ac, ullamcorper id turpis. Curabitur lobortis pellentesque lorem, vitae commodo erat molestie vehicula. Mauris vitae consectetur ex. Curabitur id rutrum tellus, vitae condimentum sapien. Duis tempus feugiat risus volutpat tempus. Curabitur enim ipsum, tincidunt a accumsan at, faucibus eu enim. Sed vehicula aliquam erat, elementum dignissim justo fermentum sit amet.

Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Integer vitae fermentum nisl, at feugiat lorem. Curabitur et mattis erat. Nulla facilisi. Pellentesque egestas lacus odio, ac tincidunt erat bibendum quis. Suspendisse maximus orci magna. Vestibulum quis faucibus lacus. Proin venenatis euismod nisl, non tincidunt purus tristique vel. Suspendisse scelerisque lorem mauris, eleifend volutpat ante lacinia nec.

Suspendisse mollis dictum ante, id tempor dolor varius et. Sed vitae eleifend ex. Curabitur mattis feugiat libero id pretium. Cras vitae nisi eget mauris viverra consectetur sed ut nulla. Phasellus eleifend nulla eget semper consectetur. Integer quis libero tellus. Morbi scelerisque enim ipsum, sit amet tincidunt metus sodales et. Fusce vestibulum, eros quis vestibulum maximus, nisi augue ullamcorper purus, sit amet dictum sapien felis et risus. Aenean gravida hendrerit nisl et tincidunt. Suspendisse varius rhoncus arcu ac mollis. Quisque auctor, magna eu accumsan tincidunt, orci sem laoreet turpis, congue vulputate ipsum ex molestie turpis. '''),
                blendMode: BlendMode.dstIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

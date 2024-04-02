import 'package:flutter/material.dart';
import 'package:student_hub/widgets/components/video_call_navigation.dart';

class  VideoCallPage extends StatefulWidget {
  static const String pageId = "/VideoCallPage";

  const  VideoCallPage({super.key});

  @override
  State< VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  bool _isMicMuted = false;
  bool _isCameraOff = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VideoNavigationBar(),
      body: Stack(
        children: [
          Container(
            color: Colors.grey[200],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildUserTile(),
                  const SizedBox(height: 20),
                  _buildUserTile(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlButton(
                  icon: _isMicMuted ? Icons.mic_off : Icons.mic,
                  onPressed: () {
                    setState(() {
                      _isMicMuted = !_isMicMuted;
                    });
                  },
                ),
                _buildControlButton(
                  icon: _isCameraOff ? Icons.videocam_off : Icons.videocam,
                  onPressed: () {
                    setState(() {
                      _isCameraOff = !_isCameraOff;
                    });
                  },
                ),
                _buildControlButton(
                  icon: Icons.call_end,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildMicIcon() {
    return Icon(
      _isMicMuted ? Icons.mic_off : Icons.mic,
      size: 30,
      color: _isMicMuted ? Colors.grey : Colors.black,
    );
  }

  Widget _buildControlButton({IconData? icon, VoidCallback? onPressed}) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      color: Colors.black,
      iconSize: 40,
    );
  }
  Widget _buildUserTile() {
    return Container(
      width: double.infinity,
      color: Colors.grey,
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.person,
            size: 48,
            color: Colors.black,
          ),
          const SizedBox(height: 8),
          _buildMicIcon(),
        ],
      ),
    );
  }
}

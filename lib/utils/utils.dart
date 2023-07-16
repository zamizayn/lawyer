import 'dart:io';

import 'package:flutter/material.dart';

enum FileType { File, Network, Memory }

class FullScreenImage extends StatefulWidget {
  var path;
  final FileType fileType;
  FullScreenImage({required this.path, required this.fileType});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: InteractiveViewer(
              child: widget.fileType == FileType.File
                  ? Image.file(File(widget.path))
                  : widget.fileType == FileType.Memory
                      ? Image.memory(widget.path)
                      : Image.network(widget.path))),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';

class VHSEffect extends StatefulWidget {
  final Widget child;

  const VHSEffect({Key? key, required this.child}) : super(key: key);

  @override
  _VHSEffectState createState() => _VHSEffectState();
}

class _VHSEffectState extends State<VHSEffect> with SingleTickerProviderStateMixin {
  FragmentShader? _shader;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _loadShader();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadShader() async {
    try {
      final program = await FragmentProgram.fromAsset('shaders/vhs.frag');
      setState(() {
        _shader = program.fragmentShader();
      });
    } catch (e) {
      print('Erreur lors du chargement du shader: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_shader == null) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Mise à jour des uniformes du shader
        _shader!.setFloat(0, _controller.value); // uTime
        _shader!.setFloat(1, MediaQuery.of(context).size.width); // uResolution.x
        _shader!.setFloat(2, MediaQuery.of(context).size.height); // uResolution.y

        return ShaderMask(
          shaderCallback: (bounds) {
            return _shader!;
          },
          blendMode: BlendMode.srcOver,
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}
import 'package:dating_app/models/user.dart';
import 'package:flutter/material.dart';

class AnimatedImageCard extends StatefulWidget {
  const AnimatedImageCard({this.user});

  @override
  _AnimatedImageCardState createState() => _AnimatedImageCardState();
  final User user;
}

class _AnimatedImageCardState extends State<AnimatedImageCard>
    with TickerProviderStateMixin {
  Animation<Offset> _offset;
  Animation<double> _opacity;

  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    _opacity = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          0.400,
          curve: Curves.ease,
        ),
      ),
    );

    _offset =
        Tween<Offset>(begin: Offset.zero, end: const Offset(300, 300)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          0.100,
          curve: Curves.ease,
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final animationBuilder = AnimatedBuilder(
      builder: _buildAnimation,
      animation: _animationController,
    );

    return animationBuilder;
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Opacity(
      opacity: _opacity.value,
      child:
       Column(
        children: <Widget>[
          Image.network(
            widget.user.image,
            fit: BoxFit.fill,
            height: 300,
            width: 300,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              widget.user.name,
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ],
      ),
    );
  }
}

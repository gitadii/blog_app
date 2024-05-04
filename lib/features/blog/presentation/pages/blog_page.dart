import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Blog App'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Routemaster.of(context).push('add-new-blog');
            },
            icon: const Icon(
              CupertinoIcons.add_circled,
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text("Logged In!"),
      ),
    );
  }
}

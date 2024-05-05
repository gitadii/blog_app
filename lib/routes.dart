import 'dart:convert';

import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

// When the user is logged out
final loggedOutRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: LoginPage()),
    '/sign-up': (_) => const MaterialPage(child: SignUpPage()),
  },
);

// When the user is logged in
final loggedInRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: BlogPage()),
    '/add-new-blog': (_) => const MaterialPage(child: AddNewBlogPage()),
    //TODO: edit the '/view-blog' route according to the name of the blog dynamically
    // '/view-blog': (route) {
    //   return MaterialPage( child: BlogViewerPage(blogEntity: route.pathParameters['blogEntity']));
    // }
    // final blogEntity =
    //     BlogModel.fromJson(jsonDecode(route.pathParameters['blogEntity']));
    // if (blogEntity != null) {
    //   return MaterialPage(
    //     child: BlogViewerPage(
    //       blogEntity: blogEntity,
    //     ),
    //   );
    // } else {
    //   return MaterialPage(child: Container());
    // }
  },
);

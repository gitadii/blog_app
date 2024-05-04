import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
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
  },
);

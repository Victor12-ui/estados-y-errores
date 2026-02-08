import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../providers/post_provider.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PostProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: switch (provider.status) {
        PostStatus.loading => _shimmerList(),

        PostStatus.success => ListView.builder(
          itemCount: provider.posts.length,
          itemBuilder: (_, i) {
            final post = provider.posts[i];
            return ListTile(title: Text(post.title), subtitle: Text(post.body));
          },
        ),

        PostStatus.empty => const Center(
          child: Text('No hay datos disponibles'),
        ),

        PostStatus.error => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Ocurrió un error'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  context.read<PostProvider>().loadPosts();
                },
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      },
    );
  }

  Widget _shimmerList() {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (_, i) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16,
                  width: double.infinity,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                Container(height: 14, width: 200, color: Colors.white),
              ],
            ),
          ),
        );
      },
    );
  }
}

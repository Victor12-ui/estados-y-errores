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
      backgroundColor: const Color.fromARGB(255, 46, 76, 175),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          'Posts',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: switch (provider.status) {
        // ---------------- LOADING ----------------
        PostStatus.loading => _shimmerList(),

        // ---------------- SUCCESS ----------------
        PostStatus.success => ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: provider.posts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (_, i) {
              final post = provider.posts[i];

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cabecera tipo perfil
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 16,
                            backgroundColor: Color(0xFF4F46E5),
                            child: Icon(
                              Icons.person,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Usuario',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Text(
                        post.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        post.body,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.45,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

        // ---------------- EMPTY ----------------
        PostStatus.empty => const Center(
            child: Text('No hay datos disponibles'),
          ),

        // ---------------- ERROR ----------------
        PostStatus.error => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cloud_off,
                  size: 42,
                  color: Colors.grey,
                ),
                const SizedBox(height: 8),
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

  // ---------------- SHIMMER ----------------
  Widget _shimmerList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (_, i) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        );
      },
    );
  }
}

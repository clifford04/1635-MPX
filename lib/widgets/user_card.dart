import 'package:flutter/material.dart';
import '../models/UserModel.dart';

/// Widget for displaying a user card with animations
class UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onTap;

  const UserCard({
    super.key,
    required this.user,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar
              Hero(
                tag: 'user_avatar_${user.id}',
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: user.avatar != null
                      ? AssetImage(user.avatar!)
                      : null,
                  child: user.avatar == null
                      ? Text(
                          user.username[0].toUpperCase(),
                          style: const TextStyle(fontSize: 24),
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              // User info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    if (user.bio != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        user.bio!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      '${user.friends.length} friends • ${user.reviewIds.length} reviews',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}


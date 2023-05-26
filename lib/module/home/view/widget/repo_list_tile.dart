import 'package:flutter/material.dart';

import '../../model/git_repo_model.dart';

class RepoListTile extends StatelessWidget {
  const RepoListTile({super.key, required this.repoData, required this.index});
  final GitRepoModel repoData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 14),
            const Icon(Icons.book, size: 40),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    repoData.name ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    repoData.description ?? '',
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.code, size: 15),
                      const SizedBox(width: 5),
                      Text(
                        repoData.language ?? '',
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.bug_report, size: 15),
                      const SizedBox(width: 5),
                      Text(
                        repoData.openIssuesCount.toString(),
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.person_2, size: 15),
                      const SizedBox(width: 5),
                      Text(
                        repoData.watchersCount.toString(),
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        index.toString(),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(height: 1)
      ],
    );
  }
}

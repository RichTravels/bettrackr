import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<PackageInfo> _info() => PackageInfo.fromPlatform();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About & Legal')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FutureBuilder<PackageInfo>(
            future: _info(),
            builder: (context, snap) {
              final name = snap.data?.appName ?? 'BetTrackr';
              final version = snap.data != null
                  ? '${snap.data!.version} (${snap.data!.buildNumber})'
                  : '—';
              return Card(
                child: ListTile(
                  title: Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: Text('Version: $version'),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Legal Disclaimer',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  SizedBox(height: 8),
                  Text(
                    'Team names used in this app are for identification purposes only. '
                        'BetTrackr is not affiliated with, endorsed by, or sponsored by the '
                        'National Football League or any NFL team.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              title: const Text('Open-source licenses'),
              subtitle: const Text('View licenses for third-party packages'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showLicensePage(
                context: context,
                applicationName: 'BetTrackr',
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Attribution & Branding',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  SizedBox(height: 8),
                  Text(
                    'This app uses original UI elements and team color schemes only. '
                        'Official logos, wordmarks, and league shields are not used.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

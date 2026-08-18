/// Builds driver/team image URLs on F1's official Cloudinary CDN.
class F1Cdn {
  static const _base = 'https://media.formula1.com/image/upload';
  static const _v = 'v1740000001';

  static const _teamSlugs = {
    'alpine': 'alpine',
    'aston_martin': 'astonmartin',
    'audi': 'audi',
    'cadillac': 'cadillac',
    'ferrari': 'ferrari',
    'haas': 'haasf1team',
    'mclaren': 'mclaren',
    'mercedes': 'mercedes',
    'rb': 'racingbulls',
    'red_bull': 'redbullracing',
    'williams': 'williams',
  };

  static String _driverAssetCode(String givenName, String familyName) {
    String prefix(String value) {
      final normalized = value
          .toLowerCase()
          .replaceAll('ä', 'a')
          .replaceAll('á', 'a')
          .replaceAll('å', 'a')
          .replaceAll('é', 'e')
          .replaceAll('í', 'i')
          .replaceAll('ö', 'o')
          .replaceAll('ó', 'o')
          .replaceAll('ü', 'u')
          .replaceAll('ú', 'u')
          .replaceAll(RegExp(r'[^a-z]'), '');
      return normalized.substring(0, normalized.length < 3 ? normalized.length : 3);
    }

    return '${prefix(givenName)}${prefix(familyName)}01';
  }

  /// Circular face crop — standings rows and result lists.
  static String driverAvatar(String team, String givenName, String familyName) {
    final teamSlug = _teamSlugs[team.toLowerCase()] ?? team.toLowerCase();
    final assetCode = _driverAssetCode(givenName, familyName);
    return '$_base/c_fill,g_face,w_80,h_80,r_max/q_auto/$_v/common/f1/2026/$teamSlug/$assetCode/2026$teamSlug${assetCode}right.webp';
  }

  /// Team logo (white, transparent background).
  static String teamLogo(String team, {int width = 64}) {
    final teamSlug = _teamSlugs[team.toLowerCase()] ?? team.toLowerCase();
    return '$_base/c_lfill,w_$width/q_auto/$_v/common/f1/2026/$teamSlug/2026${teamSlug}logowhite.webp';
  }
}

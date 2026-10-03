// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#00FFFF',
    secondary: '#00B4FF',
    tertiary: '#8A2BE2',
    background: '#0A0A1A',
    surface: '#141436',
    surfaceVariant: '#1E1E4A',
    outline: '#2E2E5C',
    success: '#00FFAA',
    warning: '#FFCC00',
    error: '#FF4444',
    onPrimary: '#0A0A1A',
    onSecondary: '#FFFFFF',
    onBackground: '#FFFFFF',
    onSurface: '#FFFFFF'
  };

  static readonly Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static readonly Shapes = {
    smallCornerRadius: 8,
    mediumCornerRadius: 14,
    largeCornerRadius: 22
  };

  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36
  };

  static readonly Elevation = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 }
  };
}
// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#2563EB',
    secondary: '#60A5FA',
    tertiary: '#93C5FD',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#CBD5E1',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E3A8A',
    onTertiary: '#1E40AF',
    onBackground: '#0F172A',
    onSurface: '#0F172A'
  };

  static readonly Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 4,
    medium: 8,
    large: 16
  };

  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28
  };

  static readonly Elevation = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
  };
}
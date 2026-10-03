// AppTokens.ets
export class AppTokens {
  static colors = {
    primary: '#FFA8A8',
    secondary: '#FFE1A8',
    tertiary: '#A8FFE1',
    background: '#FFFCF5',
    surface: '#FFFFFF',
    surfaceVariant: '#F7F7F7',
    outline: '#E2E2E2',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#1E1E1E',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E',
  };

  static typography = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static shapes = {
    small: 6,
    medium: 12,
    large: 20,
  };

  static spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };

  static elevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 },
  };
}

// Helper function for hex colors
function hexToColor(hex: string): ResourceColor {
  return hex;
}
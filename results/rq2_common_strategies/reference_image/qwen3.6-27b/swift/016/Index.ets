// entry/src/main/ets/viewmodel/AppTokens.ets

export class AppTokens {
  static readonly Colors = {
    primary: '#00FFFF',
    secondary: '#9D00FF',
    tertiary: '#00FFA3',
    background: '#0B0B0D',
    surface: '#1A1A1D',
    surfaceVariant: '#2E2E33',
    outline: '#3F3F46',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#000000',
    onSecondary: '#FFFFFF',
    onTertiary: '#000000',
    onBackground: '#E5E7EB',
    onSurface: '#E5E7EB'
  }

  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes = {
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 14
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }
}
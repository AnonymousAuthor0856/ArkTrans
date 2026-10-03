// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#A0C4FF',
    secondary: '#B7E4C7',
    tertiary: '#FFDDC1',
    background: '#F8F7FF',
    surface: '#FFFFFF',
    surfaceVariant: '#F0F0F5',
    outline: '#D9D9E3',
    success: '#B4E4C7',
    warning: '#FFDDC1',
    error: '#FFB4AB',
    onPrimary: '#001D3D',
    onSecondary: '#003720',
    onTertiary: '#3E2800',
    onBackground: '#1B1B1F',
    onSurface: '#1B1B1F'
  }

  static readonly Typography = {
    display: { fontSize: 45, fontWeight: FontWeight.Bold },
    headline: { fontSize: 24, fontWeight: FontWeight.Medium },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Regular },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }

  static readonly Elevation = {
    level1: { radius: 2, dy: 1, opacity: 0.08 },
    level2: { radius: 4, dy: 2, opacity: 0.10 },
    level3: { radius: 8, dy: 4, opacity: 0.12 }
  }
}
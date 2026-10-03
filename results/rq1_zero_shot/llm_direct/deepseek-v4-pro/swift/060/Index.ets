// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#2563EB',
    secondary: '#38BDF8',
    tertiary: '#60A5FA',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#CBD5E1',
    onPrimary: '#FFFFFF',
    onSecondary: '#0F172A',
    onTertiary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#1E293B'
  };

  static readonly Typography = {
    display: { fontSize: 24, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium },
    title: { fontSize: 14, fontWeight: FontWeight.Medium },
    body: { fontSize: 12, fontWeight: FontWeight.Normal }
  };

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  };

  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    buttonContentHorizontal: 16,
    buttonContentVertical: 8
  };
}
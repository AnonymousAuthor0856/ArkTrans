// entry/src/main/ets/viewmodel/AppTokens.ets

export class AppTokens {
  static readonly Colors = {
    primary: '#FF7A00',
    secondary: '#FFC300',
    tertiary: '#FFF1C0',
    background: '#FFF8E7',
    surface: '#FFFFFF',
    surfaceVariant: '#FFEBB8',
    outline: '#BCA789',
    success: '#28A745',
    warning: '#FFC107',
    error: '#DC3545',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  } as const;

  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  } as const;

  static readonly Shapes = {
    small: 8,
    medium: 14,
    large: 24
  } as const;

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  } as const;

  static readonly ElevationMapping = {
    level1: { radius: 4, dy: 2, opacity: 0.12 },
    level2: { radius: 8, dy: 4, opacity: 0.16 }
  } as const;
}
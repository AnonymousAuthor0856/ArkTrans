// entry/src/main/ets/viewmodel/AppTokens.ets

interface ColorToken {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyItem {
  size: number;
  weight: FontWeight;
}

interface TypographyToken {
  display: TypographyItem;
  headline: TypographyItem;
  title: TypographyItem;
  body: TypographyItem;
  label: TypographyItem;
}

interface ShapeToken {
  smallCornerRadius: number;
  mediumCornerRadius: number;
  largeCornerRadius: number;
}

interface SpacingToken {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ElevationItem {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationMappingToken {
  level1: ElevationItem;
  level2: ElevationItem;
  level3: ElevationItem;
}

export class AppTokens {
  static readonly Colors: ColorToken = {
    primary: '#1E3A8A',
    secondary: '#2563EB',
    tertiary: '#60A5FA',
    background: '#F5F8FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E8EEFA',
    outline: '#CBD5E1',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0B1220',
    onBackground: '#0B1220',
    onSurface: '#0B1220'
  };

  static readonly TypographyTokens: TypographyToken = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static readonly Shapes: ShapeToken = {
    smallCornerRadius: 8,
    mediumCornerRadius: 12,
    largeCornerRadius: 18
  };

  static readonly Spacing: SpacingToken = {
    xs: 6,
    sm: 10,
    md: 14,
    lg: 18,
    xl: 26,
    xxl: 36
  };

  static readonly ElevationMapping: ElevationMappingToken = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.16 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 }
  };
}
// entry/src/main/ets/viewmodel/AppTokens.ts
import { Color, FontSize, FontWeight } from '@kit.ArkUI';

export class AppTokens {
  static readonly Colors = {
    primary: '#0EA5E9',
    secondary: '#22C55E',
    tertiary: '#F59E0B',
    background: '#F7FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#EFF3F7',
    outline: '#D4D9E1',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#0F172A',
    onTertiary: '#111827',
    onBackground: '#0B1220',
    onSurface: '#0B1220'
  };

  static readonly TypographyTokens = {
    display: { fontSize: 24, fontWeight: FontWeight.SemiBold, lineHeight: 30, letterSpacing: 0 },
    headline: { fontSize: 18, fontWeight: FontWeight.SemiBold, lineHeight: 24, letterSpacing: 0 },
    title: { fontSize: 14, fontWeight: FontWeight.Medium, lineHeight: 18, letterSpacing: 0 },
    body: { fontSize: 12, fontWeight: FontWeight.Normal, lineHeight: 16, letterSpacing: 0 },
    label: { fontSize: 10, fontWeight: FontWeight.Medium, lineHeight: 14, letterSpacing: 0 }
  };

  static readonly Shapes = {
    small: 6,
    medium: 8,
    large: 12
  };

  static readonly Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  };
}

export interface MetricCardUi {
  id: number;
  title: string;
  value: string;
  delta: string;
  color: string;
}

export interface ChartCardUi {
  id: number;
  title: string;
  color: string;
}
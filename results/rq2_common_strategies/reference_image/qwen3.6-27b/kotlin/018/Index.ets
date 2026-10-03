// entry/src/main/ets/viewmodel/AppTokens.ts
import { Color } from '@kit.ArkUI';

export class AppTokens {
  static readonly Colors = {
    primary: '#D7BBA8',
    secondary: '#A2C4C9',
    tertiary: '#B3C9A2',
    background: '#F0EBE3',
    surface: '#FFFFFF',
    surfaceVariant: '#E6E0D9',
    outline: '#DCD7CF',
    success: '#7EA87E',
    warning: '#D9B872',
    error: '#D98B8B',
    onPrimary: '#433E3A',
    onSecondary: '#433E3A',
    onTertiary: '#433E3A',
    onBackground: '#433E3A',
    onSurface: '#433E3A'
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static readonly Radius = {
    small: 8,
    medium: 16,
    large: 24
  };
}

export interface FilterItem {
  id: number;
  name: string;
  author: string;
  price: string;
  color: string;
}

export interface Filter {
  id: string;
  name: string;
}
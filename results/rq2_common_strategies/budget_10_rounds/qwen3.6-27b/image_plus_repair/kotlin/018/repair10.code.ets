// entry/src/main/ets/viewmodel/AppTokens.ts

class AppTokenColors {
  primary: string = '#D7BBA8';
  secondary: string = '#A2C4C9';
  tertiary: string = '#B3C9A2';
  background: string = '#F0EBE3';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#E6E0D9';
  outline: string = '#DCD7CF';
  success: string = '#7EA87E';
  warning: string = '#D9B872';
  error: string = '#D98B8B';
  onPrimary: string = '#433E3A';
  onSecondary: string = '#433E3A';
  onTertiary: string = '#433E3A';
  onBackground: string = '#433E3A';
  onSurface: string = '#433E3A';
}

class AppTokenSpacing {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
}

class AppTokenRadius {
  small: number = 8;
  medium: number = 16;
  large: number = 24;
}

export class AppTokens {
  static readonly Colors: AppTokenColors = new AppTokenColors();
  static readonly Spacing: AppTokenSpacing = new AppTokenSpacing();
  static readonly Radius: AppTokenRadius = new AppTokenRadius();
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
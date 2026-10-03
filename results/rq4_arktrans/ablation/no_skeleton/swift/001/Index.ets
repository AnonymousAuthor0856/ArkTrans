// src/main/ets/components/AppTokens.ets

export interface AppColors {
  primary: string;
  onPrimary: string;
  secondary: string;
  onSecondary: string;
  tertiary: string;
  onTertiary: string;
  background: string;
  onBackground: string;
  surface: string;
  onSurface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
}

export const AppTokens = {
  Colors: {
    primary: '#6750A4',
    onPrimary: '#FFFFFF',
    secondary: '#6CBB3B',
    onSecondary: '#0F0F0F',
    tertiary: '#FFB300',
    onTertiary: '#1F1200',
    background: '#F6F7FB',
    onBackground: '#0F172A',
    surface: '#FCFCFF',
    onSurface: '#111827',
    surfaceVariant: '#EFEFF5',
    outline: '#D0D5DD',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#DC2626'
  } as AppColors,
  
  Spacing: {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  },

  Shapes: {
    small: 4,
    medium: 8,
    large: 12
  }
};

export interface ProductUi {
  id: number;
  title: string;
  price: string;
  badge: string;
  rating: string;
  color: string;
}
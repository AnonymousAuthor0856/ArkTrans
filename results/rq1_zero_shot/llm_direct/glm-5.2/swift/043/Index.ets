// AppTokens.ets
export class AppTokens {
  static Colors = {
    primary: '#FF00E5FF',
    secondary: '#FF00BFA5',
    tertiary: '#FF69F0AE',
    background: '#FF0A0A0A',
    surface: '#FF121212',
    surfaceVariant: '#FF1E1E1E',
    outline: '#FF2C2C2C',
    success: '#FF00C853',
    warning: '#FFFFD600',
    error: '#FFD50000',
    onPrimary: '#FF0A0A0A',
    onSecondary: '#FF0A0A0A',
    onBackground: '#FFFFFFFF',
    onSurface: '#FFFFFFFF'
  };

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes = {
    small: 6,
    medium: 10,
    large: 14
  };

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28
  };

  static ElevationMapping = {
    level1: { radius: 4, x: 0, y: 2, opacity: 0.15 },
    level2: { radius: 8, x: 0, y: 4, opacity: 0.18 },
    level3: { radius: 12, x: 0, y: 6, opacity: 0.2 }
  };
}

export class CartItem {
  id: number;
  name: string;
  price: number;

  constructor(id: number, name: string, price: number) {
    this.id = id;
    this.name = name;
    this.price = price;
  }
}
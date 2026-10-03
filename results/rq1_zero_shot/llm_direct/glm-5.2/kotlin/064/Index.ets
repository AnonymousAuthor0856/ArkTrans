// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#111111',
    secondary: '#2A2A2A',
    tertiary: '#444444',
    background: '#F7F7F7',
    surface: '#FFFFFF',
    surfaceVariant: '#EDEDED',
    outline: '#D6D6D6',
    success: '#1E7D4C',
    warning: '#B98400',
    error: '#B3261E',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0A0A0A',
    onSurface: '#0A0A0A'
  };

  static readonly Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Medium, lineHeight: 34 },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium, lineHeight: 26 },
    title: { fontSize: 16, fontWeight: FontWeight.Medium, lineHeight: 22 },
    body: { fontSize: 14, fontWeight: FontWeight.Normal, lineHeight: 20 },
    label: { fontSize: 12, fontWeight: FontWeight.Medium, lineHeight: 16 }
  };

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16
  };
}

export class ApprovalPin {
  id: number;
  title: string;
  status: string;
  x: number;
  y: number;

  constructor(id: number, title: string, status: string, x: number, y: number) {
    this.id = id;
    this.title = title;
    this.status = status;
    this.x = x;
    this.y = y;
  }
}
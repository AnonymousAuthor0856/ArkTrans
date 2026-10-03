import { display } from '@kit.ArkUI';

// AppTokens.ets
export interface TypographyToken {
  size: number;
  weight: FontWeight;
}

export interface ElevationToken {
  opacity: number;
  radius: number;
  dy: number;
}

export class AppTokens {
  static readonly Colors: Record<string, string> = {
    primary: '#111111',
    secondary: '#333333',
    tertiary: '#777777',
    background: '#FFFFFF',
    surface: '#F9F9F9',
    surfaceVariant: '#E5E5E5',
    outline: '#CCCCCC',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#DC2626',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#111111',
    onBackground: '#111111',
    onSurface: '#111111'
  }

  static readonly TypographyTokens: Record<string, TypographyToken> = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: Record<string, number> = {
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 14
  }

  static readonly Spacing: Record<string, number> = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static readonly ElevationMapping: Record<string, ElevationToken> = {
    level2: { opacity: 0.12, radius: 8, dy: 4 }
  }
}

// Marker.ets
export interface Marker {
  id: number;
  x: number;
  y: number;
  label: string;
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    { id: 1, x: 120, y: 200, label: 'Store A' },
    { id: 2, x: 360, y: 400, label: 'Store B' }
  ];

  build() {
    Column() {
      Text('Product Detail')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight as FontWeight)
        .foregroundColor('#111111')
        .alignSelf(ItemAlign.Start)

      // Product Card
      Column({ space: AppTokens.Spacing.md }) {
        Rect()
          .fill('#E5E5E5')
          .height(160)
          .width('100%')

        Text('Monochrome Bag')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight as FontWeight)
          .foregroundColor('#111111')

        Text('A minimalist and timeless design piece.')
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight as FontWeight)
          .foregroundColor('#777777')

        Text('$79.00')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight as FontWeight)
          .foregroundColor('#111111')

        Button('Add to Cart')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight as FontWeight)
          .backgroundColor('#111111')
          .foregroundColor('#FFFFFF')
          .borderRadius(AppTokens.Shapes.mediumCornerRadius)
          .height(48)
          .width('100%')
          .onClick(() => {
            console.info('Add to Cart tapped!');
          })
      }
      .padding(AppTokens.Spacing.lg)
      .backgroundColor('#F9F9F9')
      .borderRadius(AppTokens.Shapes.largeCornerRadius)
      .shadow({ 
        radius: AppTokens.ElevationMapping.level2.radius, 
        color: Color('#000000').withAlpha(AppTokens.ElevationMapping.level2.opacity), 
        offsetY: AppTokens.ElevationMapping.level2.dy 
      })
      .margin({ top: AppTokens.Spacing.lg })

      // Map Area
      Stack() {
        Canvas(this.getUIContext().getHostContext() as unknown as CanvasRenderingContext2D)
          .width('100%')
          .height('100%')
      }
      .width('100%')
      .height(240)
      .borderRadius(AppTokens.Shapes.largeCornerRadius)
      .backgroundColor('#F9F9F9')
      .margin({ top: AppTokens.Spacing.lg })

      // Action Buttons
      Row({ space: AppTokens.Spacing.md }) {
        Button('Add Marker')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight as FontWeight)
          .backgroundColor('#333333')
          .foregroundColor('#FFFFFF')
          .borderRadius(AppTokens.Shapes.mediumCornerRadius)
          .height(44)
          .layoutWeight(1)
          .onClick(() => {
            const newMarker: Marker = {
              id: Date.now(),
              x: Math.random() * 400 + 50,
              y: Math.random() * 300 + 50,
              label: 'New'
            };
            this.markers.push(newMarker);
          })

        Button('Clear')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight as FontWeight)
          .backgroundColor('#777777')
          .foregroundColor('#111111')
          .borderRadius(AppTokens.Shapes.mediumCornerRadius)
          .height(44)
          .layoutWeight(1)
          .onClick(() => {
            this.markers = [];
          })
      }
      .margin({ top: AppTokens.Spacing.lg })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor('#FFFFFF')
  }
}
class AppColors {
  static readonly primary: ResourceColor = '#111111';
  static readonly secondary: ResourceColor = '#333333';
  static readonly tertiary: ResourceColor = '#777777';
  static readonly background: ResourceColor = '#FFFFFF';
  static readonly surface: ResourceColor = '#F9F9F9';
  static readonly surfaceVariant: ResourceColor = '#E5E5E5';
  static readonly outline: ResourceColor = '#CCCCCC';
  static readonly success: ResourceColor = '#16A34A';
  static readonly warning: ResourceColor = '#F59E0B';
  static readonly error: ResourceColor = '#DC2626';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#FFFFFF';
  static readonly onTertiary: ResourceColor = '#111111';
  static readonly onBackground: ResourceColor = '#111111';
  static readonly onSurface: ResourceColor = '#111111';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly smallCornerRadius: number = 6;
  static readonly mediumCornerRadius: number = 10;
  static readonly largeCornerRadius: number = 14;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
  color: ResourceColor;

  constructor(elevation: number, radius: number, dy: number, opacity: number, color: ResourceColor) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
    this.color = color;
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.1, '#1A000000');
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.12, '#1F000000');
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.15, '#26000000');
}

class Marker {
  id: number;
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.id = Date.now() + Math.floor(Math.random() * 1000000);
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

@Entry
@Component
struct RootScreen {
  @State private markers: Marker[] = [
    new Marker(120, 200, 'Store A'),
    new Marker(360, 400, 'Store B')
  ];

  private randomInRange(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column({ space: AppSpacing.lg }) {
        Text('Product Detail')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)

        Column({ space: AppSpacing.md }) {
          Column() {
          }
          .width('100%')
          .height(160)
          .backgroundColor(AppColors.surfaceVariant)

          Text('Monochrome Bag')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Text('A minimalist and timeless design piece.')
            .fontSize(AppTypography.bodySize)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.tertiary)

          Text('$79.00')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)

          Button('Add to Cart', { type: ButtonType.Normal, stateEffect: true })
            .width('100%')
            .height(48)
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.mediumCornerRadius)
            .onClick(() => {
              console.info('Add to Cart tapped!');
            })
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Start)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.largeCornerRadius)
        .shadow({
          radius: AppElevation.level2.radius,
          color: AppElevation.level2.color,
          offsetX: 0,
          offsetY: AppElevation.level2.dy
        })

        Stack({ alignContent: Alignment.TopStart }) {
          Stack({ alignContent: Alignment.TopStart }) {
            Column() {
            }
            .width('100%')
            .height('100%')
            .backgroundColor(AppColors.surfaceVariant)

            ForEach(this.markers, (marker: Marker) => {
              Circle()
                .width(28)
                .height(28)
                .fill(AppColors.primary)
                .position({
                  x: marker.x - 14,
                  y: marker.y - 14
                })
            }, (marker: Marker) => marker.id.toString())
          }
          .width('100%')
          .height('100%')
          .clip(true)
        }
        .width('100%')
        .height(240)
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.largeCornerRadius)

        Row({ space: AppSpacing.md }) {
          Button('Add Marker', { type: ButtonType.Normal, stateEffect: true })
            .layoutWeight(1)
            .height(44)
            .fontSize(AppTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppShapes.mediumCornerRadius)
            .onClick(() => {
              const marker: Marker = new Marker(
                this.randomInRange(100, 500),
                this.randomInRange(150, 450),
                'New'
              );
              this.markers = this.markers.concat([marker]);
            })

          Button('Clear', { type: ButtonType.Normal, stateEffect: true })
            .layoutWeight(1)
            .height(44)
            .fontSize(AppTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(AppShapes.mediumCornerRadius)
            .onClick(() => {
              this.markers = [];
            })
        }
        .width('100%')
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
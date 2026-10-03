interface AppColors {
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

interface TextStyleToken {
  fontSize: number;
  fontWeight: number;
}

interface AppTypography {
  display: TextStyleToken;
  title: TextStyleToken;
  body: TextStyleToken;
  label: TextStyleToken;
}

interface AppShapes {
  small: number;
  medium: number;
  large: number;
}

interface AppSpacing {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface AppElevation {
  level1: ShadowSpec;
}

class AppTokens {
  static readonly Colors: AppColors = {
    primary: '#FF1E3A8A',
    secondary: '#FF3B82F6',
    tertiary: '#FF60A5FA',
    background: '#FFF5F8FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE8EEFA',
    outline: '#FFCBD5E1',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF0B1220',
    onBackground: '#FF0B1220',
    onSurface: '#FF0B1220'
  };

  static readonly TypographyTokens: AppTypography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static readonly Shapes: AppShapes = {
    small: 6,
    medium: 10,
    large: 16
  };

  static readonly Spacing: AppSpacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36
  };

  static readonly ElevationMapping: AppElevation = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 }
  };
}

interface LiveItem {
  id: number;
  title: string;
  viewers: number;
  price: string;
}

@Entry
@Component
struct Index {
  build() {
    Stack() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct LiveCard {
  @Prop item: LiveItem;

  build() {
    Column() {
      Stack() {
      }
      .width('100%')
      .height(160)
      .borderRadius(AppTokens.Shapes.medium)
      .clip(true)
      .backgroundColor(AppTokens.Colors.secondary)

      Text(this.item.title)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      Text(`${this.item.viewers} viewers`)
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
        .fontColor(AppTokens.Colors.tertiary)
        .margin({ top: AppTokens.Spacing.sm })

      Row() {
        Text(this.item.price)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.primary)

        Button('Join Live')
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {})
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}

@Component
struct RootScreen {
  private liveList: LiveItem[] = [
    { id: 1, title: 'Smartphone Flash Deal', viewers: 1234, price: '$699' },
    { id: 2, title: 'Gaming Chair Special', viewers: 880, price: '$249' },
    { id: 3, title: 'Headphones Clearance', viewers: 1640, price: '$99' },
    { id: 4, title: 'Mechanical Keyboard', viewers: 512, price: '$129' }
  ];

  build() {
    Stack() {
      Column() {
        Text('Live Shop Events')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ bottom: AppTokens.Spacing.md })

        List({ space: AppTokens.Spacing.md }) {
          ForEach(this.liveList, (item: LiveItem) => {
            ListItem() {
              LiveCard({ item: item })
            }
          }, (item: LiveItem) => item.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ bottom: 96 })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.background, 0.0],
          [AppTokens.Colors.surfaceVariant, 0.5],
          [AppTokens.Colors.background, 1.0]
        ]
      })

      Stack() {
        Text('+')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSecondary)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor(AppTokens.Colors.secondary)
      .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.3)', offsetY: 4 })
      .position({ x: '85%', y: '78%' })
      .onClick(() => {})

      Row() {
        Row() {
          Text('Home')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.primary)

          Text('Live')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Text('Cart')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Text('Profile')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.1)', offsetY: -2 })
      .position({ x: 0, y: '100%' })
      .translate({ y: -56 })
    }
    .width('100%')
    .height('100%')
  }
}

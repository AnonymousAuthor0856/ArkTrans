// AppTokens.ets
interface ColorsType {
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

interface TypographyTokenType {
  size: number;
  weight: FontWeight;
}

interface TypographyTokensType {
  display: TypographyTokenType;
  title: TypographyTokenType;
  body: TypographyTokenType;
  label: TypographyTokenType;
}

interface ShapesType {
  small: number;
  medium: number;
  large: number;
}

interface SpacingType {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ShadowSpecType {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationMappingType {
  level1: ShadowSpecType;
  level2: ShadowSpecType;
  level3: ShadowSpecType;
}

interface MaterialDefaultsType {
  bottomAppBarHeight: number;
  fabSize: number;
  buttonHorizontalPadding: number;
  buttonVerticalPadding: number;
  fabBottomMargin: number;
  fabTrailingMargin: number;
  lazyColumnContentBottomPadding: number;
}

export class AppTokens {
  static Colors: ColorsType = {
    primary: '#1E3A8A',
    secondary: '#3B82F6',
    tertiary: '#60A5FA',
    background: '#F5F8FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E8EEFA',
    outline: '#CBD5E1',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0B1220',
    onBackground: '#0B1220',
    onSurface: '#0B1220'
  }

  static TypographyTokens: TypographyTokensType = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static Shapes: ShapesType = {
    small: 6,
    medium: 10,
    large: 16
  }

  static Spacing: SpacingType = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36
  }

  static ElevationMapping: ElevationMappingType = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 }
  }

  static MaterialDefaults: MaterialDefaultsType = {
    bottomAppBarHeight: 80,
    fabSize: 56,
    buttonHorizontalPadding: 16,
    buttonVerticalPadding: 8,
    fabBottomMargin: 16,
    fabTrailingMargin: 16,
    lazyColumnContentBottomPadding: 96
  }
}

export class LiveItem {
  id: number;
  title: string;
  viewers: number;
  price: string;

  constructor(id: number, title: string, viewers: number, price: string) {
    this.id = id;
    this.title = title;
    this.viewers = viewers;
    this.price = price;
  }
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  private liveList: LiveItem[] = [
    new LiveItem(1, "Smartphone Flash Deal", 1234, "$699"),
    new LiveItem(2, "Gaming Chair Special", 880, "$249"),
    new LiveItem(3, "Headphones Clearance", 1640, "$99"),
    new LiveItem(4, "Mechanical Keyboard", 512, "$129")
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Main Content Area
      Column() {
        Text("Live Shop Events")
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ bottom: AppTokens.Spacing.md })

        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.liveList, (item: LiveItem) => {
              LiveItemCard({ item: item })
            }, (item: LiveItem) => item.id.toString())
          }
          .padding({ bottom: AppTokens.MaterialDefaults.lazyColumnContentBottomPadding })
        }
        .layoutWeight(1)
        .align(Alignment.Start)
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.background, 0.0],
          [AppTokens.Colors.surfaceVariant, 0.5],
          [AppTokens.Colors.background, 1.0]
        ]
      })

      // Floating Action Button (FAB)
      Column() {
        Blank()
        Row() {
          Blank()
          Button() {
            Text('+')
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
          }
          .width(AppTokens.MaterialDefaults.fabSize)
          .height(AppTokens.MaterialDefaults.fabSize)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.MaterialDefaults.fabSize / 2)
          .margin({
            right: AppTokens.MaterialDefaults.fabTrailingMargin,
            bottom: AppTokens.MaterialDefaults.fabBottomMargin + AppTokens.MaterialDefaults.bottomAppBarHeight
          })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // Bottom Navigation Bar
      Column() {
        Blank()
        BottomNavBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// LiveItemCard.ets
@Component
struct LiveItemCard {
  private item: LiveItem = new LiveItem(0, "", 0, "");

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Placeholder Image Area
      Column()
        .width('100%')
        .height(160)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.item.title)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Text(`${this.item.viewers} viewers`)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.tertiary)

      Row() {
        Text(this.item.price)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.primary)

        Blank()

        Button() {
          Text("Join Live")
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .padding({
          top: AppTokens.MaterialDefaults.buttonVerticalPadding,
          bottom: AppTokens.MaterialDefaults.buttonVerticalPadding,
          left: AppTokens.MaterialDefaults.buttonHorizontalPadding,
          right: AppTokens.MaterialDefaults.buttonHorizontalPadding
        })
      }
      .width('100%')
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}

// BottomNavBar.ets
@Component
struct BottomNavBar {
  build() {
    Row() {
      Blank()
      Text("Home")
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.primary)
      Blank()
      Text("Live")
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
      Blank()
      Text("Cart")
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
      Blank()
      Text("Profile")
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
      Blank()
    }
    .width('100%')
    .height(AppTokens.MaterialDefaults.bottomAppBarHeight)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: 0.5,
      color: 'rgba(0,0,0,0.1)',
      offsetX: 0,
      offsetY: -1
    })
  }
}
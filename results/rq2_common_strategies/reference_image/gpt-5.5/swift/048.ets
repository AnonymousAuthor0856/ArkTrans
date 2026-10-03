class AppColors {
  static readonly primary: string = '#1E3A8A';
  static readonly secondary: string = '#3B82F6';
  static readonly tertiary: string = '#60A5FA';
  static readonly background: string = '#F5F8FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E8EEFA';
  static readonly outline: string = '#CBD5E1';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#0B1220';
  static readonly onBackground: string = '#0B1220';
  static readonly onSurface: string = '#0B1220';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.15);
  static readonly level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18);
}

class MaterialDefaults {
  static readonly bottomAppBarHeight: number = 80;
  static readonly fabSize: number = 56;
  static readonly buttonHorizontalPadding: number = 16;
  static readonly buttonVerticalPadding: number = 8;
  static readonly fabBottomMargin: number = 16;
  static readonly fabTrailingMargin: number = 16;
  static readonly lazyColumnContentBottomPadding: number = 96;
}

class LiveItem {
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

function formatViewers(value: number): string {
  if (value < 1000) {
    return value.toString();
  }

  let high: number = Math.floor(value / 1000);
  let low: string = (value % 1000).toString();
  while (low.length < 3) {
    low = '0' + low;
  }
  return `${high},${low}`;
}

@Entry
@Component
struct RootScreen {
  private liveList: LiveItem[] = [
    new LiveItem(1, 'Smartphone Flash Deal', 1234, '$699'),
    new LiveItem(2, 'Gaming Chair Special', 880, '$249'),
    new LiveItem(3, 'Headphones Clearance', 1640, '$99'),
    new LiveItem(4, 'Mechanical Keyboard', 512, '$129')
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: AppSpacing.md }) {
        Text('Live Shop Events')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)

        Scroll() {
          Column({ space: AppSpacing.md }) {
            ForEach(
              this.liveList,
              (item: LiveItem) => {
                LiveItemCard({ item: item })
              },
              (item: LiveItem) => item.id.toString()
            )
          }
          .width('100%')
          .padding({ bottom: MaterialDefaults.lazyColumnContentBottomPadding })
        }
        .layoutWeight(1)
        .width('100%')
        .scrollBar(BarState.Off)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppColors.background, 0.0],
          [AppColors.surfaceVariant, 0.5],
          [AppColors.background, 1.0]
        ]
      })

      Row() {
        Blank()
          .layoutWeight(1)

        Stack() {
          Text('+')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
        }
        .width(MaterialDefaults.fabSize)
        .height(MaterialDefaults.fabSize)
        .borderRadius(MaterialDefaults.fabSize / 2)
        .backgroundColor(AppColors.secondary)
        .onClick(() => {
        })
      }
      .width('100%')
      .padding({
        right: MaterialDefaults.fabTrailingMargin,
        bottom: MaterialDefaults.fabBottomMargin + MaterialDefaults.bottomAppBarHeight
      })
      .zIndex(1)

      BottomNavBar()
        .zIndex(2)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Component
struct LiveItemCard {
  item: LiveItem = new LiveItem(0, '', 0, '');

  build() {
    Column({ space: AppSpacing.sm }) {
      Blank()
        .width('100%')
        .height(160)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.medium)

      Text(this.item.title)
        .fontSize(AppTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Text(`${formatViewers(this.item.viewers)} viewers`)
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.tertiary)

      Row() {
        Text(this.item.price)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)

        Blank()
          .layoutWeight(1)

        Row() {
          Text('Join Live')
            .fontSize(AppTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
        .padding({
          top: MaterialDefaults.buttonVerticalPadding,
          bottom: MaterialDefaults.buttonVerticalPadding,
          left: MaterialDefaults.buttonHorizontalPadding,
          right: MaterialDefaults.buttonHorizontalPadding
        })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .onClick(() => {
        })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level1.radius,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: AppElevation.level1.dy
    })
  }
}

@Component
struct BottomNavBar {
  build() {
    Row() {
      Text('Home')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.primary)

      Text('Live')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)

      Text('Cart')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)

      Text('Profile')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(MaterialDefaults.bottomAppBarHeight)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: 0.5,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: -1
    })
  }
}
// MARK: - AppTokens Colors
class AppColors {
  static primary: string = '#1E3A8A';
  static secondary: string = '#3B82F6';
  static tertiary: string = '#60A5FA';
  static background: string = '#F5F8FF';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E8EEFA';
  static outline: string = '#CBD5E1';
  static success: string = '#22C55E';
  static warning: string = '#F59E0B';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#FFFFFF';
  static onTertiary: string = '#0B1220';
  static onBackground: string = '#0B1220';
  static onSurface: string = '#0B1220';
}

class AppSpacing {
  static sm: number = 6;
  static md: number = 10;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 36;
}

class AppShapes {
  static small: number = 6;
  static medium: number = 10;
  static large: number = 16;
}

class AppMaterialDefaults {
  static bottomAppBarHeight: number = 80;
  static fabSize: number = 56;
  static buttonHorizontalPadding: number = 16;
  static buttonVerticalPadding: number = 8;
  static fabBottomMargin: number = 16;
  static fabTrailingMargin: number = 16;
  static lazyColumnContentBottomPadding: number = 96;
}

class AppElevationLevel {
  radius: number = 0;
  dy: number = 0;
  opacity: number = 0;
}

class AppElevation {
  static level1: AppElevationLevel = { radius: 4, dy: 2, opacity: 0.12 };
  static level2: AppElevationLevel = { radius: 8, dy: 4, opacity: 0.15 };
  static level3: AppElevationLevel = { radius: 12, dy: 6, opacity: 0.18 };
}

// MARK: - Data Model
class LiveItem {
  id: number = 0;
  title: string = '';
  viewers: number = 0;
  price: string = '';
}

const liveList: LiveItem[] = [
  { id: 1, title: 'Smartphone Flash Deal', viewers: 1234, price: '$699' },
  { id: 2, title: 'Gaming Chair Special', viewers: 880, price: '$249' },
  { id: 3, title: 'Headphones Clearance', viewers: 1640, price: '$99' },
  { id: 4, title: 'Mechanical Keyboard', viewers: 512, price: '$129' },
];

// MARK: - LiveItemCard Component
@Component
struct LiveItemCard {
  item: LiveItem = new LiveItem();

  build() {
    Column({ space: AppSpacing.sm }) {
      // Placeholder image area
      Row()
        .width('100%')
        .height(160)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.medium)

      Text(this.item.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')

      Text(`${this.item.viewers} viewers`)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.tertiary)
        .width('100%')

      Row() {
        Text(this.item.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)

        Blank()

        Button('Join Live')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .padding({
            top: AppMaterialDefaults.buttonVerticalPadding,
            bottom: AppMaterialDefaults.buttonVerticalPadding,
            left: AppMaterialDefaults.buttonHorizontalPadding,
            right: AppMaterialDefaults.buttonHorizontalPadding,
          })
          .height('auto')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level1.radius,
      color: `rgba(0,0,0,${AppElevation.level1.opacity})`,
      offsetX: 0,
      offsetY: AppElevation.level1.dy,
    })
  }
}

// MARK: - BottomNavBar Component
@Component
struct BottomNavBar {
  build() {
    Row() {
      Blank()
      Text('Home')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.primary)
      Blank()
      Text('Live')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
      Blank()
      Text('Cart')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
      Blank()
      Text('Profile')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
      Blank()
    }
    .width('100%')
    .height(AppMaterialDefaults.bottomAppBarHeight)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: 2,
      color: 'rgba(0,0,0,0.1)',
      offsetX: 0,
      offsetY: -1,
    })
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main content
      Column({ space: AppSpacing.md }) {
        Text('Live Shop Events')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .width('100%')

        Scroll() {
          Column({ space: AppSpacing.md }) {
            ForEach(liveList, (item: LiveItem) => {
              LiveItemCard({ item: item })
            }, (item: LiveItem) => item.id.toString())
          }
          .width('100%')
          .padding({ bottom: AppMaterialDefaults.lazyColumnContentBottomPadding })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(AppSpacing.lg)
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppColors.background, 0.0],
          [AppColors.surfaceVariant, 0.5],
          [AppColors.background, 1.0],
        ],
      })

      // Bottom navigation bar
      BottomNavBar()

      // FAB
      Stack({ alignContent: Alignment.BottomEnd }) {
        Row()
          .width('100%')
          .height('100%')

        Button('+')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .width(AppMaterialDefaults.fabSize)
          .height(AppMaterialDefaults.fabSize)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppMaterialDefaults.fabSize / 2)
          .margin({
            right: AppMaterialDefaults.fabTrailingMargin,
            bottom:
            AppMaterialDefaults.fabBottomMargin +
            AppMaterialDefaults.bottomAppBarHeight,
          })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
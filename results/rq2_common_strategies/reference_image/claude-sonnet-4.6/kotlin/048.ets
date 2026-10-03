// entry/src/main/ets/pages/Index.ets
// ArkTS conversion of the Kotlin/Compose "Live Shop Events" screen.
// Language: ArkTS (HarmonyOS NEXT / API 11+)

// ------------------------------------------------------------------
// Design tokens
// ------------------------------------------------------------------
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

class AppType {
  static readonly displaySize: number = 28; // fp
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly small: number = 6;   // vp
  static readonly medium: number = 10;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly sm: number = 6;      // vp
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

// elevation -> shadow spec (elevation, blur radius, dy, opacity)
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

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.15);
  static readonly level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18);
}

function shadowColor(opacity: number): string {
  const alpha: number = Math.round(opacity * 255);
  const hex: string = alpha.toString(16).toUpperCase().padStart(2, '0');
  return '#' + hex + '000000';
}

// ------------------------------------------------------------------
// Model
// ------------------------------------------------------------------
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

// ------------------------------------------------------------------
// Screen
// ------------------------------------------------------------------
@Entry
@Component
struct Index {
  @State liveList: LiveItem[] = [
    new LiveItem(1, 'Smartphone Flash Deal', 1234, '$699'),
    new LiveItem(2, 'Gaming Chair Special', 880, '$249'),
    new LiveItem(3, 'Headphones Clearance', 1640, '$99'),
    new LiveItem(4, 'Mechanical Keyboard', 512, '$129')
  ];

  @Builder
  LiveCard(item: LiveItem) {
    Column({ space: AppSpacing.sm }) {
      // Media placeholder
      Column()
        .width('100%')
        .height(160)
        .borderRadius(AppShapes.medium)
        .clip(true)
        .backgroundColor(AppColors.secondary)

      Text(item.title)
        .fontSize(AppType.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')

      Text(`${item.viewers} viewers`)
        .fontSize(AppType.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.tertiary)
        .width('100%')

      Row() {
        Text(item.price)
          .fontSize(AppType.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)

        Button('Join Live', { type: ButtonType.Normal })
          .fontSize(AppType.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .height(40)
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: ElevationMapping.level1.radius,
      color: shadowColor(ElevationMapping.level1.opacity),
      offsetX: 0,
      offsetY: ElevationMapping.level1.dy
    })
  }

  @Builder
  BottomBar() {
    Row() {
      Text('Home')
        .fontSize(AppType.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.primary)

      Text('Live')
        .fontSize(AppType.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)

      Text('Cart')
        .fontSize(AppType.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)

      Text('Profile')
        .fontSize(AppType.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(72)
    .padding({ left: 40, right: 40 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  build() {
    Column() {
      // ---- content area ----
      Column() {
        Text('Live Shop Events')
          .fontSize(AppType.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .width('100%')
          .margin({ bottom: AppSpacing.md })

        Stack({ alignContent: Alignment.BottomEnd }) {
          List({ space: AppSpacing.md }) {
            ForEach(this.liveList, (item: LiveItem) => {
              ListItem() {
                this.LiveCard(item)
              }
            }, (item: LiveItem) => item.id.toString())

            // trailing content padding (96dp in the Compose original)
            ListItem() {
              Column().width('100%').height(96)
            }
          }
          .width('100%')
          .height('100%')
          .scrollBar(BarState.Off)

          // Floating action button
          Button('+', { type: ButtonType.Circle })
            .width(56)
            .height(56)
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .shadow({
              radius: ElevationMapping.level3.radius,
              color: shadowColor(ElevationMapping.level3.opacity),
              offsetX: 0,
              offsetY: ElevationMapping.level3.dy
            })
            .margin({ right: 0, bottom: AppSpacing.lg })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.lg })

      // ---- bottom app bar ----
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.background, 0.0],
        [AppColors.surfaceVariant, 0.5],
        [AppColors.background, 1.0]
      ]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
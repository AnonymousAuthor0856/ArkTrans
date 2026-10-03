const NAME: string = '063*LiveShop*en';
const UI_TYPE: string = 'ECommerce';
const STYLE_THEME: string = 'Modern Blue';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface LiveItem {
  id: number;
  title: string;
  viewers: number;
  price: string;
}

class AppTokens {
  static readonly Colors = class {
    static readonly primary: ResourceColor = '#1E3A8A';
    static readonly secondary: ResourceColor = '#3B82F6';
    static readonly tertiary: ResourceColor = '#60A5FA';
    static readonly background: ResourceColor = '#F5F8FF';
    static readonly surface: ResourceColor = '#FFFFFF';
    static readonly surfaceVariant: ResourceColor = '#E8EEFA';
    static readonly outline: ResourceColor = '#CBD5E1';
    static readonly success: ResourceColor = '#22C55E';
    static readonly warning: ResourceColor = '#F59E0B';
    static readonly error: ResourceColor = '#EF4444';
    static readonly onPrimary: ResourceColor = '#FFFFFF';
    static readonly onSecondary: ResourceColor = '#FFFFFF';
    static readonly onTertiary: ResourceColor = '#0B1220';
    static readonly onBackground: ResourceColor = '#0B1220';
    static readonly onSurface: ResourceColor = '#0B1220';
  };

  static readonly TypographyTokens = class {
    static readonly displaySize: number = 28;
    static readonly titleSize: number = 18;
    static readonly bodySize: number = 14;
    static readonly labelSize: number = 12;
    static readonly displayWeight: FontWeight = FontWeight.Bold;
    static readonly titleWeight: FontWeight = FontWeight.Medium;
    static readonly bodyWeight: FontWeight = FontWeight.Normal;
    static readonly labelWeight: FontWeight = FontWeight.Medium;
  };

  static readonly Shapes = class {
    static readonly small: number = 6;
    static readonly medium: number = 10;
    static readonly large: number = 16;
  };

  static readonly Spacing = class {
    static readonly sm: number = 6;
    static readonly md: number = 10;
    static readonly lg: number = 16;
    static readonly xl: number = 24;
    static readonly xxl: number = 36;
  };

  static readonly ElevationMapping = class {
    static readonly level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.12 };
    static readonly level2: ShadowSpec = { elevation: 6, radius: 8, dy: 4, opacity: 0.15 };
    static readonly level3: ShadowSpec = { elevation: 10, radius: 12, dy: 6, opacity: 0.18 };
  };
}

@Component
struct LiveCard {
  @Prop item: LiveItem;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Blank()
        .width('100%')
        .height(160)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.item.title)
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(AppTokens.TypographyTokens.titleWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')

      Text(`${this.item.viewers} viewers`)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.tertiary)
        .width('100%')

      Row() {
        Text(this.item.price)
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.primary)

        Button('Join Live', { type: ButtonType.Normal })
          .fontSize(AppTokens.TypographyTokens.labelSize)
          .fontWeight(AppTokens.TypographyTokens.labelWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(36)
          .padding({ left: 14, right: 14 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row() {
      Text('Home')
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.primary)

      Text('Live')
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Text('Cart')
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Text('Profile')
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(64)
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Entry
@Component
struct RootScreen {
  private liveList: LiveItem[] = [
    { id: 1, title: 'Smartphone Flash Deal', viewers: 1234, price: '$699' },
    { id: 2, title: 'Gaming Chair Special', viewers: 880, price: '$249' },
    { id: 3, title: 'Headphones Clearance', viewers: 1640, price: '$99' },
    { id: 4, title: 'Mechanical Keyboard', viewers: 512, price: '$129' }
  ];

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column({ space: AppTokens.Spacing.md }) {
          Text('Live Shop Events')
            .fontSize(AppTokens.TypographyTokens.displaySize)
            .fontWeight(AppTokens.TypographyTokens.displayWeight)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')

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
          .edgeEffect(EdgeEffect.Spring)
          .scrollBar(BarState.Off)
        }
        .width('100%')
        .layoutWeight(1)
        .padding(AppTokens.Spacing.lg)
        .linearGradient({
          angle: 180,
          colors: [
            [AppTokens.Colors.background, 0.0],
            [AppTokens.Colors.surfaceVariant, 0.5],
            [AppTokens.Colors.background, 1.0]
          ]
        })

        BottomNavigationBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      Button('+', { type: ButtonType.Circle })
        .width(56)
        .height(56)
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(AppTokens.TypographyTokens.titleWeight)
        .fontColor(AppTokens.Colors.onSecondary)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(28)
        .margin({ right: AppTokens.Spacing.lg, bottom: 72 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
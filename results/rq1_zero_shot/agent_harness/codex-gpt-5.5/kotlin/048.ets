const NAME: string = '063*LiveShop*en';
const UI_TYPE: string = 'ECommerce';
const STYLE_THEME: string = 'Modern Blue';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

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

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
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

@Entry
@Component
struct MainActivity {
  private liveList: LiveItem[] = [
    new LiveItem(1, 'Smartphone Flash Deal', 1234, '$699'),
    new LiveItem(2, 'Gaming Chair Special', 880, '$249'),
    new LiveItem(3, 'Headphones Clearance', 1640, '$99'),
    new LiveItem(4, 'Mechanical Keyboard', 512, '$129')
  ];
  private navItems: string[] = ['Home', 'Live', 'Cart', 'Profile'];

  @Builder
  LiveCard(item: LiveItem): void {
    Column({ space: AppSpacing.sm }) {
      Rect().width('100%').height(160).fill(AppColors.secondary).radius(10);
      Text(item.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Text(`${item.viewers} viewers`)
        .fontSize(14)
        .fontColor(AppColors.tertiary);
      Row() {
        Text(item.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary);
        Blank();
        Button('Join Live')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(10);
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  BottomBar(): void {
    Row() {
      ForEach(this.navItems, (item: string) => {
        Text(item)
          .fontSize(14)
          .fontColor(item === 'Home' ? AppColors.primary : AppColors.onSurface);
      }, (item: string) => item)
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center);
  }

  build() {
    Stack() {
      Column({ space: AppSpacing.md }) {
        Text('Live Shop Events')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary);
        Scroll() {
          Column({ space: AppSpacing.md }) {
            ForEach(this.liveList, (item: LiveItem) => {
              this.LiveCard(item);
            }, (item: LiveItem) => item.id.toString())
            Blank().height(96);
          }
        }
        .layoutWeight(1);
        this.BottomBar();
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.lg })
      .backgroundColor(AppColors.background);
      Button('+')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(28)
        .width(56)
        .height(56)
        .position({ x: '80%', y: '78%' });
    }
    .width('100%')
    .height('100%');
  }
}

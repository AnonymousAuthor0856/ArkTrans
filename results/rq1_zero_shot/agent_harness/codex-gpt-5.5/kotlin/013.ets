const NAME: string = '011*MusicPlayer*en';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Retro Flat';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#EF476F';
  static readonly secondary: string = '#FFD166';
  static readonly tertiary: string = '#06D6A0';
  static readonly background: string = '#FFFCF2';
  static readonly surface: string = '#FFF8E1';
  static readonly surfaceVariant: string = '#FCE7E7';
  static readonly outline: string = '#BDBDBD';
  static readonly success: string = '#06D6A0';
  static readonly warning: string = '#FFA600';
  static readonly error: string = '#D62828';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1F1F1F';
  static readonly onTertiary: string = '#1F1F1F';
  static readonly onBackground: string = '#1F1F1F';
  static readonly onSurface: string = '#1F1F1F';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class OffsetPoint {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

@Entry
@Component
struct MainActivity {
  @State knobPosition: OffsetPoint = new OffsetPoint(300, 300);

  @Builder
  Header(): void {
    Text('Retro Music Player')
      .fontSize(30)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .height(64)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  Deck(): void {
    Stack() {
      Circle()
        .width(240)
        .height(240)
        .fill(Color.Transparent)
        .border({ width: 12, color: AppColors.secondary });
      Circle()
        .width(40)
        .height(40)
        .fill(AppColors.primary)
        .translate({ x: 60, y: 60 });
    }
    .width(280)
    .height(280)
    .backgroundColor(AppColors.surface)
    .border({ width: 3, color: AppColors.outline })
    .borderRadius(16)
    .alignContent(Alignment.Center)
    .gesture(PanGesture().onActionUpdate((event: GestureEvent) => {
      this.knobPosition = new OffsetPoint(event.offsetX, event.offsetY);
    }));
  }

  @Builder
  Controls(): void {
    Row() {
      Button('Play')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(12)
        .width(120)
        .height(48);
      Button('Pause')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(12)
        .width(120)
        .height(48);
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly);
  }

  build() {
    Column() {
      this.Header();
      Column() {
        this.Deck();
        Text('Track: Summer Nights')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        this.Controls();
        Text(`Knob X:${Math.floor(this.knobPosition.x)} Y:${Math.floor(this.knobPosition.y)}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.tertiary);
        Blank().height(AppSpacing.xxl);
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}

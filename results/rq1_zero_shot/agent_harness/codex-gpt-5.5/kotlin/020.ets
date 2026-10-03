const NAME: string = '020RemoteControlen';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Retro Flat';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#FF7A00';
  static readonly secondary: string = '#FFC300';
  static readonly tertiary: string = '#FFF3C0';
  static readonly background: string = '#FFF8E7';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFEBC8';
  static readonly outline: string = '#BCA789';
  static readonly success: string = '#28A745';
  static readonly warning: string = '#FFC107';
  static readonly error: string = '#DC3545';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
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
  @State knobPosition: OffsetPoint = new OffsetPoint(0, 0);
  @State powerOn: boolean = false;

  progressValue(): number {
    return ((this.knobPosition.x + this.knobPosition.y) % 400) / 4;
  }

  @Builder
  Header(): void {
    Text('Retro Remote Control')
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  RemotePad(): void {
    Stack() {
      Circle()
        .width(240)
        .height(240)
        .fill('#33FFC300');
      Circle()
        .width(48)
        .height(48)
        .fill(AppColors.primary)
        .translate({ x: this.knobPosition.x / 8, y: this.knobPosition.y / 8 });
    }
    .width(280)
    .height(280)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(24)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
    .alignContent(Alignment.Center)
    .gesture(PanGesture().onActionUpdate((event: GestureEvent) => {
      this.knobPosition = new OffsetPoint(event.offsetX, event.offsetY);
    }));
  }

  @Builder
  Controls(): void {
    Row() {
      Button(this.powerOn ? 'Off' : 'On')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(40)
        .width(80)
        .height(80)
        .onClick(() => {
          this.powerOn = !this.powerOn;
        });
      Button('Reset')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(40)
        .width(80)
        .height(80)
        .onClick(() => {
          this.knobPosition = new OffsetPoint(0, 0);
        });
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly);
  }

  build() {
    Column() {
      this.Header();
      Column({ space: AppSpacing.xl }) {
        this.RemotePad();
        Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.powerOn ? AppColors.success : AppColors.error);
        this.Controls();
        Progress({ value: this.progressValue(), total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant);
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.background);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}

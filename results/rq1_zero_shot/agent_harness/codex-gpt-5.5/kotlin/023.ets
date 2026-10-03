const NAME: string = '024PomodoroTimeren';
const UI_TYPE: string = 'Productivity';
const STYLE_THEME: string = 'Soft Pastel';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#FF8FAB';
  static readonly secondary: string = '#B4E3D0';
  static readonly tertiary: string = '#FFD6A5';
  static readonly background: string = '#FFFCF9';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FDE2E4';
  static readonly outline: string = '#FCC2D7';
  static readonly success: string = '#4ADE80';
  static readonly warning: string = '#FACC15';
  static readonly error: string = '#FB7185';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
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
  @State isRunning: boolean = false;

  progressValue(): number {
    return ((this.knobPosition.x + this.knobPosition.y) % 400) / 4;
  }

  @Builder
  Header(): void {
    Text('Pomodoro Timer')
      .fontSize(30)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .height(60)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  TimerDial(): void {
    Stack() {
      Circle()
        .width(240)
        .height(240)
        .fill('#66B4E3D0');
      Circle()
        .width(60)
        .height(60)
        .fill(AppColors.primary)
        .translate({ x: this.knobPosition.x / 8, y: this.knobPosition.y / 8 });
    }
    .width(280)
    .height(280)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(140)
    .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
    .alignContent(Alignment.Center)
    .gesture(PanGesture().onActionUpdate((event: GestureEvent) => {
      this.knobPosition = new OffsetPoint(event.offsetX, event.offsetY);
    }));
  }

  @Builder
  Controls(): void {
    Row({ space: AppSpacing.lg }) {
      Button('Start')
        .fontSize(14)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(45)
        .width(90)
        .height(90)
        .onClick(() => {
          this.isRunning = true;
        });
      Button('Stop')
        .fontSize(14)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.tertiary)
        .borderRadius(45)
        .width(90)
        .height(90)
        .onClick(() => {
          this.isRunning = false;
        });
    }
    .alignItems(VerticalAlign.Center);
  }

  build() {
    Column() {
      this.Header();
      Column({ space: AppSpacing.xl }) {
        this.TimerDial();
        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isRunning ? AppColors.success : AppColors.error);
        this.Controls();
        Progress({ value: this.progressValue(), total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant);
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}

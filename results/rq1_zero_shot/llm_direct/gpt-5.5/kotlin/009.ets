import window from '@ohos.window';

const NAME: string = '003VideoPlayeren';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Modern Blue';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#1E3A8A';
  static readonly secondary: string = '#3B82F6';
  static readonly background: string = '#0F172A';
  static readonly surface: string = '#1E293B';
  static readonly surfaceVariant: string = '#334155';
  static readonly outline: string = '#475569';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onBackground: string = '#F8FAFC';
  static readonly onSurface: string = '#E2E8F0';
  static readonly onSurface70: string = '#B3E2E8F0';
  static readonly secondary20: string = '#333B82F6';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly medium: number = 12;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

function formatTime(sec: number): string {
  const total: number = Math.max(Math.floor(sec), 0);
  const m: number = Math.floor(total / 60);
  const s: number = total % 60;
  return `${m}:${s < 10 ? '0' + s : s}`;
}

@Entry
@Component
struct RootScreen {
  @State title: string = 'Journey through the Skies';
  @State currentTime: number = 95;
  @State totalTime: number = 240;
  @State playing: boolean = false;
  @State fullscreen: boolean = false;

  aboutToAppear(): void {
    window.getLastWindow(getContext(this), (err, win) => {
      if (!err && win) {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      }
    });
  }

  build() {
    Column() {
      if (!this.fullscreen) {
        Row() {
          Text('Video Player')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onBackground)
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.background)
      }

      Column() {
        Stack({ alignContent: Alignment.Center }) {
          Text('Video Surface')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)

        Column({ space: AppSpacing.md }) {
          Text(this.title)
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .width('100%')

          Slider({
            value: this.currentTime / this.totalTime * 100,
            min: 0,
            max: 100,
            step: 1,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .blockColor(AppColors.primary)
            .selectedColor(AppColors.primary)
            .trackColor(AppColors.outline)
            .showTips(false)
            .onChange((value: number) => {
              this.currentTime = value / 100 * this.totalTime;
            })

          Row() {
            Text(formatTime(this.currentTime))
              .fontSize(AppTypography.labelSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface70)

            Text(formatTime(this.totalTime))
              .fontSize(AppTypography.labelSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface70)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Row() {
            Button('−10s', { type: ButtonType.Normal, stateEffect: true })
              .fontSize(AppTypography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(AppShapes.medium)
              .onClick(() => {
                this.currentTime = Math.max(this.currentTime - 10, 0);
              })

            Button({ type: ButtonType.Circle, stateEffect: true }) {
              Text(this.playing ? 'II' : '▶')
                .fontSize(AppTypography.displaySize)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.onPrimary)
            }
            .width(72)
            .height(72)
            .backgroundColor(AppColors.primary)
            .onClick(() => {
              this.playing = !this.playing;
            })

            Button('+30s', { type: ButtonType.Normal, stateEffect: true })
              .fontSize(AppTypography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(AppShapes.medium)
              .onClick(() => {
                this.currentTime = Math.min(this.currentTime + 30, this.totalTime);
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .alignItems(VerticalAlign.Center)

          Row() {
            Button(this.fullscreen ? 'Exit Fullscreen' : 'Fullscreen', { type: ButtonType.Normal, stateEffect: true })
              .fontSize(AppTypography.labelSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
              .backgroundColor(this.fullscreen ? AppColors.secondary20 : AppColors.surface)
              .borderColor(AppColors.outline)
              .borderWidth(1)
              .borderRadius(AppShapes.medium)
              .onClick(() => {
                this.fullscreen = !this.fullscreen;
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
        }
        .width('100%')
        .padding(AppSpacing.xl)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
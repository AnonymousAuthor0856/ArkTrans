import window from '@ohos.window';

const NAME: string = '105_ChargingProgress_en';
const UI_TYPE: string = 'SmartHome Dashboard';
const STYLE_THEME: string = 'Retro Flat';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#3B82F6';
  static readonly secondary: string = '#22C55E';
  static readonly background: string = '#F5F5F4';
  static readonly surface: string = '#FFFFFF';
  static readonly outline: string = '#D4D4D8';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#1F2937';
  static readonly accent: string = '#F59E0B';
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.45;

  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    }).catch(() => {
    });
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text('Charging Progress')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)

        Row() {
          Text('EV')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.primary)
            .width(42)
            .height(42)
            .textAlign(TextAlign.Center)
            .border({
              width: 2,
              color: AppColors.primary,
              radius: 21
            })
            .margin({ left: 8 })

          Blank()

          Button({ type: ButtonType.Circle }) {
            Text('⚙')
              .fontSize(24)
              .fontColor(AppColors.accent)
          }
          .width(44)
          .height(44)
          .backgroundColor(Color.Transparent)
          .margin({ right: 8 })
        }
        .width('100%')
        .height('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(64)
      .backgroundColor(AppColors.surface)

      Column({ space: AppSpacing.xl }) {
        Stack({ alignContent: Alignment.Center }) {
          Text('🔋')
            .fontSize(64)

          Text('⚡')
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.primary)
        }
        .width(72)
        .height(72)

        Text(`${Math.floor(this.progress * 100)}%`)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)

        Progress({
          value: this.progress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('80%')
          .height(14)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surface)
          .border({
            width: 1,
            color: AppColors.outline,
            radius: 7
          })
          .borderRadius(7)

        Button({ type: ButtonType.Capsule }) {
          Text('Simulate Charge')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
        .height(44)
        .padding({
          left: 18,
          right: 18
        })
        .backgroundColor(AppColors.secondary)
        .onClick(() => {
          this.progress += 0.1;
          if (this.progress > 1) {
            this.progress = 0;
          }
        })

        Text(this.progress < 1 ? 'Charging...' : 'Fully Charged!')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.progress < 1 ? AppColors.primary : AppColors.secondary)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
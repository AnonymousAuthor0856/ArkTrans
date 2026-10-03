import window from '@ohos.window';

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

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 14;
  static readonly large: number = 24;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
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

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16);
}

@Entry
@Component
struct MainActivity {
  @State private knobX: number = 0;
  @State private knobY: number = 0;
  @State private powerOn: boolean = false;

  private readonly padSize: number = 248;
  private readonly knobSize: number = 48;
  private readonly outerCircleSize: number = 400;

  aboutToAppear(): void {
    window.getLastWindow(getContext(this), (err, win) => {
      if (!err && win) {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      }
    });
  }

  private progressValue(): number {
    return ((this.knobX + this.knobY) % 400) / 400;
  }

  build() {
    Column() {
      Row() {
        Text('Retro Remote Control')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(88)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.xl }) {
        Stack({ alignContent: Alignment.Center }) {
          Stack() {
            Blank()
              .width(this.outerCircleSize)
              .height(this.outerCircleSize)
              .borderRadius(this.outerCircleSize / 2)
              .backgroundColor('rgba(255, 195, 0, 0.20)')
              .position({
                x: (this.padSize - this.outerCircleSize) / 2,
                y: (this.padSize - this.outerCircleSize) / 2
              })

            Blank()
              .width(this.knobSize)
              .height(this.knobSize)
              .borderRadius(this.knobSize / 2)
              .backgroundColor(AppColors.primary)
              .position({
                x: this.knobX - this.knobSize / 2,
                y: this.knobY - this.knobSize / 2
              })
          }
          .width(this.padSize)
          .height(this.padSize)
          .clip(true)
          .onTouch((event: TouchEvent) => {
            if ((event.type === TouchType.Down || event.type === TouchType.Move) && event.touches.length > 0) {
              this.knobX = event.touches[0].x;
              this.knobY = event.touches[0].y;
            }
          })
        }
        .width(280)
        .height(280)
        .padding(AppSpacing.lg)
        .borderRadius(AppShapes.large)
        .backgroundColor(AppColors.surfaceVariant)
        .shadow({
          radius: AppElevationMapping.level1.radius,
          color: 'rgba(0, 0, 0, 0.12)',
          offsetX: 0,
          offsetY: AppElevationMapping.level1.dy
        })

        Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.powerOn ? AppColors.success : AppColors.error)

        Row() {
          Button(this.powerOn ? 'Off' : 'On')
            .width(80)
            .height(80)
            .borderRadius(40)
            .backgroundColor(AppColors.primary)
            .fontColor(AppColors.onPrimary)
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.powerOn = !this.powerOn;
            })

          Button('Reset')
            .width(80)
            .height(80)
            .borderRadius(40)
            .backgroundColor(AppColors.secondary)
            .fontColor(AppColors.onSecondary)
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.knobX = 0;
              this.knobY = 0;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Progress({
          value: this.progressValue(),
          total: 1,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(6)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .style({ strokeWidth: 6 })
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
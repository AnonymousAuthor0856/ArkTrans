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

class AppSizes {
  static readonly dial: number = 280;
  static readonly dialInner: number = 180;
  static readonly knob: number = 30;
  static readonly button: number = 90;
  static readonly progressHeight: number = 8;
  static readonly appBarHeight: number = 64;
}

class AppElevation {
  static readonly level1Radius: number = 4;
  static readonly level1Dy: number = 2;
  static readonly level1Color: string = '#1F000000';
  static readonly level2Radius: number = 8;
  static readonly level2Dy: number = 4;
  static readonly level2Color: string = '#2E000000';
}

@Entry
@Component
struct Index {
  @State knobX: number = 0;
  @State knobY: number = 0;
  @State isRunning: boolean = false;

  private clamp(value: number, min: number, max: number): number {
    return Math.min(Math.max(value, min), max);
  }

  private moveKnob(event: GestureEvent): void {
    const fingers: FingerInfo[] = event.fingerList;
    if (fingers.length > 0) {
      const half: number = AppSizes.knob / 2;
      const max: number = AppSizes.dial - AppSizes.knob;
      this.knobX = this.clamp(fingers[0].localX - half, 0, max);
      this.knobY = this.clamp(fingers[0].localY - half, 0, max);
    }
  }

  private progressPercent(): number {
    const travelled: number = Math.abs(this.knobX) + Math.abs(this.knobY);
    return (travelled % 400) / 400 * 100;
  }

  build() {
    Column() {
      // CenterAlignedTopAppBar
      Row() {
        Text('Pomodoro Timer')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(AppSizes.appBarHeight)
      .justifyContent(FlexAlign.Center)

      Column() {
        // Dial surface (Surface + Canvas)
        Stack() {
          Circle({ width: AppSizes.dial, height: AppSizes.dial })
            .fill(AppColors.surfaceVariant)
            .shadow({
              radius: AppElevation.level2Radius,
              color: AppElevation.level2Color,
              offsetX: 0,
              offsetY: AppElevation.level2Dy
            })

          Circle({ width: AppSizes.dialInner, height: AppSizes.dialInner })
            .fill(AppColors.secondary)
            .opacity(0.4)

          Circle({ width: AppSizes.knob, height: AppSizes.knob })
            .fill(AppColors.primary)
            .position({ x: this.knobX, y: this.knobY })
        }
        .width(AppSizes.dial)
        .height(AppSizes.dial)
        .gesture(
          PanGesture()
            .onActionStart((event: GestureEvent) => {
              this.moveKnob(event);
            })
            .onActionUpdate((event: GestureEvent) => {
              this.moveKnob(event);
            })
        )
        .margin({ bottom: AppSpacing.xl })

        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isRunning ? AppColors.success : AppColors.error)
          .margin({ bottom: AppSpacing.xl })

        Row() {
          Button('Start', { type: ButtonType.Circle, stateEffect: true })
            .width(AppSizes.button)
            .height(AppSizes.button)
            .backgroundColor(AppColors.primary)
            .fontColor(AppColors.onPrimary)
            .fontSize(14)
            .shadow({
              radius: AppElevation.level1Radius,
              color: AppElevation.level1Color,
              offsetX: 0,
              offsetY: AppElevation.level1Dy
            })
            .onClick(() => {
              this.isRunning = true;
            })
            .margin({ right: AppSpacing.lg })

          Button('Stop', { type: ButtonType.Circle, stateEffect: true })
            .width(AppSizes.button)
            .height(AppSizes.button)
            .backgroundColor(AppColors.tertiary)
            .fontColor(AppColors.onSecondary)
            .fontSize(14)
            .shadow({
              radius: AppElevation.level1Radius,
              color: AppElevation.level1Color,
              offsetX: 0,
              offsetY: AppElevation.level1Dy
            })
            .onClick(() => {
              this.isRunning = false;
            })
        }
        .margin({ bottom: AppSpacing.xl })

        Progress({
          value: this.progressPercent(),
          total: 100,
          type: ProgressType.Linear
        })
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .style({ strokeWidth: AppSizes.progressHeight })
          .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
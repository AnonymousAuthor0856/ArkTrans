import window from '@ohos.window';

class AppColors {
  static readonly primary: ResourceColor = '#00FF66';
  static readonly secondary: ResourceColor = '#CCCCCC';
  static readonly tertiary: ResourceColor = '#999999';
  static readonly background: ResourceColor = '#000000';
  static readonly surface: ResourceColor = '#0A0A0A';
  static readonly surfaceVariant: ResourceColor = '#141414';
  static readonly outline: ResourceColor = '#2A2A2A';
  static readonly success: ResourceColor = '#22C55E';
  static readonly warning: ResourceColor = '#F59E0B';
  static readonly error: ResourceColor = '#EF4444';
  static readonly onPrimary: ResourceColor = '#000000';
  static readonly onSecondary: ResourceColor = '#FFFFFF';
  static readonly onTertiary: ResourceColor = '#FFFFFF';
  static readonly onBackground: ResourceColor = '#E0E0E0';
  static readonly onSurface: ResourceColor = '#E0E0E0';
}

class AppTypography {
  static readonly display: number = 26;
  static readonly title: number = 16;
  static readonly body: number = 13;
  static readonly label: number = 11;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

@Component
struct MixerSlider {
  @Prop label: string = '';
  @Link value: number;

  build() {
    Column({ space: AppSpacing.xs }) {
      Text(`${this.label} ${Math.trunc(this.value * 100)}%`)
        .fontSize(AppTypography.body)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      Slider({
        value: this.value,
        min: 0,
        max: 1,
        step: 0.01,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .height(48)
        .trackThickness(4)
        .trackColor(AppColors.surfaceVariant)
        .selectedColor(AppColors.primary)
        .blockColor(AppColors.primary)
        .blockSize({ width: 27, height: 27 })
        .showTips(false)
        .onChange((value: number) => {
          this.value = value;
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct RootScreen {
  @State private bass: number = 0.4;
  @State private mid: number = 0.5;
  @State private treble: number = 0.6;
  @State private master: number = 0.7;

  aboutToAppear(): void {
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
        win.setWindowBackgroundColor('#000000');
      })
      .catch(() => {
      });
  }

  build() {
    Column() {
      Text('Audio Mixer Terminal')
        .fontSize(AppTypography.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        MixerSlider({ label: 'Bass', value: $bass })
        MixerSlider({ label: 'Mid', value: $mid })
        MixerSlider({ label: 'Treble', value: $treble })

        Blank()
          .height(AppSpacing.lg)

        Stack({ alignContent: Alignment.Start }) {
          Blank()
            .width('100%')
            .height(6)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(3)

          Blank()
            .width(`${this.master * 100}%`)
            .height(6)
            .backgroundColor(AppColors.primary)
            .borderRadius(3)
        }
        .width('100%')
        .height(6)

        Text(`Master Volume ${Math.trunc(this.master * 100)}%`)
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Start)

        Slider({
          value: this.master,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .height(48)
          .trackThickness(4)
          .trackColor(AppColors.surfaceVariant)
          .selectedColor(AppColors.primary)
          .blockColor(AppColors.primary)
          .blockSize({ width: 27, height: 27 })
          .showTips(false)
          .onChange((value: number) => {
            this.master = value;
          })

        Button() {
          Text('Apply Settings')
            .fontSize(AppTypography.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .width('100%')
            .textAlign(TextAlign.Center)
        }
        .type(ButtonType.Normal)
        .width('100%')
        .height(48)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .stateEffect(true)
        .onClick(() => {
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.background)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
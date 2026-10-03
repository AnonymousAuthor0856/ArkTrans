const NAME: string = '015Recorderen';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Dark Neon';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#00FFFF';
  static readonly secondary: string = '#9D00FF';
  static readonly tertiary: string = '#00FFA3';
  static readonly background: string = '#0B0B0D';
  static readonly surface: string = '#1A1A1D';
  static readonly surfaceVariant: string = '#2E2E33';
  static readonly outline: string = '#3F3F46';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#000000';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#000000';
  static readonly onBackground: string = '#E5E7EB';
  static readonly onSurface: string = '#E5E7EB';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

@Entry
@Component
struct MainActivity {
  @State title: string = '';
  @State recording: boolean = false;
  @State seconds: number = 0;

  @Builder
  Header(): void {
    Text('Neon Recorder')
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.primary)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  RecorderPanel(): void {
    Stack() {
      Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.recording ? AppColors.primary : AppColors.onSurface);
    }
    .width('100%')
    .height(200)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(14)
    .alignContent(Alignment.Center);
  }

  @Builder
  Controls(): void {
    Row() {
      Button(this.recording ? 'Stop' : 'Record')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(this.recording ? AppColors.error : AppColors.primary)
        .borderRadius(14)
        .width(160)
        .height(52)
        .onClick(() => {
          this.recording = !this.recording;
          if (this.recording) {
            this.seconds = 0;
          }
        });
      Button('Reset')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(14)
        .width(120)
        .height(52)
        .onClick(() => {
          this.seconds = 0;
        });
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly);
  }

  build() {
    Column() {
      this.Header();
      Column({ space: AppSpacing.lg }) {
        TextInput({ text: this.title, placeholder: 'Recording name' })
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .placeholderColor(AppColors.onSurface)
          .caretColor(AppColors.primary)
          .backgroundColor(AppColors.surface)
          .border({ width: 1, color: AppColors.outline })
          .borderRadius(10)
          .width('100%')
          .height(48)
          .onChange((value: string) => {
            this.title = value;
          });
        this.RecorderPanel();
        this.Controls();
        Blank().height(AppSpacing.xxl);
        Text(`Output Path: /storage/recordings/${this.title.trim().length === 0 ? 'untitled' : this.title}.mp3`)
          .fontSize(14)
          .fontColor('#B3E5E7EB');
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.surfaceVariant);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}

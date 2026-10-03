import { Entry, ObservedObject } from '@ohos/library';

const NAME = "015Recorderen";
const UI_TYPE = "Media";
const STYLE_THEME = "Dark Neon";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppTokens {
  static Colors = {
    primary: '#00FFFF',
    secondary: '#9D00FF',
    tertiary: '#00FFA3',
    background: '#0B0B0D',
    surface: '#1A1A1D',
    surfaceVariant: '#2E2E33',
    outline: '#3F3F46',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#000000',
    onSecondary: '#FFFFFF',
    onTertiary: '#000000',
    onBackground: '#E5E7EB',
    onSurface: '#E5E7EB',
  };
  static Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };
  static Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  };
  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };
}

class RootScreenViewModel extends ObservedObject {
  title: string = '';
  recording: boolean = false;
  seconds: number = 0;

  toggleRecording(): void {
    this.recording = !this.recording;
    if (this.recording) {
      this.seconds = 0;
    }
  }

  reset(): void {
    this.seconds = 0;
  }
}

@Entry
@Component
struct RootScreen {
  viewModel: RootScreenViewModel = new RootScreenViewModel();

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Text('Neon Recorder')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .width('100%')
          .textAlign(TextAlign.Center);

        Column() {
          TextInput({ text: this.viewModel.title, placeholder: 'Recording name' })
            .onChange((value: string) => {
              this.viewModel.title = value;
            })
            .height(50)
            .borderRadius(AppTokens.Shapes.medium)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.lg });

          Column() {
            Text(this.viewModel.recording ? `Recording... ${this.viewModel.seconds}s` : 'Press Record')
              .fontSize(AppTokens.Typography.title.fontSize)
              .fontWeight(AppTokens.Typography.title.fontWeight)
              .fontColor(this.viewModel.recording ? AppTokens.Colors.primary : AppTokens.Colors.onSurface);
          }
          .width('100%')
          .height(200)
          .borderRadius(AppTokens.Shapes.large)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: AppTokens.Spacing.lg });

          Row() {
            Button(this.viewModel.recording ? 'Stop' : 'Record')
              .onClick(() => this.viewModel.toggleRecording())
              .height(52)
              .width(160)
              .borderRadius(AppTokens.Shapes.large)
              .backgroundColor(this.viewModel.recording ? AppTokens.Colors.error : AppTokens.Colors.primary)
              .fontColor(AppTokens.Colors.onPrimary)
              .fontSize(AppTokens.Typography.title.fontSize)
              .fontWeight(AppTokens.Typography.title.fontWeight);

            Button('Reset')
              .onClick(() => this.viewModel.reset())
              .height(52)
              .width(120)
              .borderRadius(AppTokens.Shapes.large)
              .backgroundColor(AppTokens.Colors.secondary)
              .fontColor(AppTokens.Colors.onSecondary)
              .fontSize(AppTokens.Typography.title.fontSize)
              .fontWeight(AppTokens.Typography.title.fontWeight);
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .margin({ bottom: AppTokens.Spacing.xxl });

          Text(`Output Path: /storage/recordings/${this.viewModel.title === '' ? 'untitled' : this.viewModel.title}.mp3`)
            .fontSize(AppTokens.Typography.body.fontSize)
            .fontWeight(AppTokens.Typography.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .opacity(0.7)
            .width('100%')
            .textAlign(TextAlign.Center);
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .linearGradient({
          angle: 180,
          colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.surfaceVariant, 1.0]]
        })
        .alignItems(HorizontalAlign.Center);
      }
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}
import { BusinessError } from '@kit.BasicServicesKit';
import { UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

// Token Definitions matching the Kotlin source
interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyToken {
  fontSize: number;
  fontWeight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

const AppTokens = {
  Colors: {
    primary: '#8E6BF2',
    secondary: '#D3C1FF',
    tertiary: '#B39DDB',
    background: '#F5F3FF',
    surface: '#FFFFFF',
    surfaceVariant: '#ECE6F8',
    outline: '#D1C4E9',
    success: '#4CAF50',
    warning: '#FFB300',
    error: '#E53935',
    onPrimary: '#FFFFFF',
    onSecondary: '#2E1A47',
    onBackground: '#2E1A47',
    onSurface: '#2E1A47'
  } as ColorTokens,
  TypographyTokens: {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  } as TypographyTokens,
  Shapes: {
    small: 8, // dp
    medium: 14, // dp
    large: 20 // dp
  } as ShapeTokens,
  Spacing: {
    sm: 6, // dp
    md: 10, // dp
    lg: 16, // dp
    xl: 24 // dp
  } as SpacingTokens
};

@Entry
@Component
struct RootScreen {
  @State orderId: string = '';
  @State issue: string = '';
  @State submitted: boolean = false;

  build() {
    Column() {
      Text('After-Sale Service')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)

      // Card Component
      Column() {
        Text('Order ID')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ bottom: AppTokens.Spacing.sm })

        TextInput({ placeholder: 'Enter order number', text: this.orderId })
          .type(InputType.Number)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .onChange((value: string) => {
            this.orderId = value;
          })
          .width('100%')
          .height(48) // Approximate height for single line input

        Text('Issue Description')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.sm })

        TextArea({ placeholder: 'Describe your issue', text: this.issue })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .onChange((value: string) => {
            this.issue = value;
          })
          .width('100%')
          .height(120)
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({
        radius: 12,
        color: '#000000',
        offsetX: 0,
        offsetY: 4
      })

      Button('Submit Request')
        .width('100%')
        .height(56)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .borderRadius(AppTokens.Shapes.large)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .onClick(() => {
          this.submitted = true;
        })

      if (this.submitted) {
        Row() {
          Text('Request submitted successfully!')
            .fontColor(AppTokens.Colors.success)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding(AppTokens.Spacing.lg)
        .backgroundColor('#264CAF50') // Success color with ~15% alpha approximation
        .borderRadius(AppTokens.Shapes.medium)
      }
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
    .spacing(AppTokens.Spacing.lg)
  }
}

export default class EntryAbility extends UIAbility {
  onCreate(want: Want): void {
    console.info('[ArkTS] EntryAbility onCreate');
  }

  onDestroy(): void {
    console.info('[ArkTS] EntryAbility onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    console.info('[ArkTS] EntryAbility onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        console.error('[ArkTS] Failed to load content. Cause:' + JSON.stringify(err));
        return;
      }
      console.info('[ArkTS] Succeeded in loading content. Data:' + JSON.stringify(data));
    });

    // Handle full screen / system bars similar to Android implementation
    let windowClass: window.Window | undefined = undefined;
    windowStage.getMainWindow((err, win) => {
      if (err) {
        console.error(`Failed to get main window. Code:${err.code}, message:${err.message}`);
        return;
      }
      windowClass = win;
      try {
        windowClass?.setWindowLayoutFullScreen(true);
        // Note: Hiding status bar/navigation bar programmatically requires specific permissions 
        // and API calls depending on the OS version, often handled by the framework or settings.
        // For UI preview purposes, layout fullscreen is the closest equivalent to the visual style.
      } catch (e) {
        console.error(`Failed to set full screen. Code:${(e as BusinessError).code}, message:${(e as BusinessError).message}`);
      }
    });
  }

  onWindowStageDestroy(): void {
    console.info('[ArkTS] EntryAbility onWindowStageDestroy');
  }

  onForeground(): void {
    console.info('[ArkTS] EntryAbility onForeground');
  }

  onBackground(): void {
    console.info('[ArkTS] EntryAbility onBackground');
  }
}
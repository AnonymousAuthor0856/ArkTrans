// AppTokens.ets
import { Length, ResourceStr } from '@ohos.arkui';

export class AppTokens {
  static Colors = {
    primary: '#FF8E6BF2',
    secondary: '#FFD3C1FF',
    tertiary: '#FFB39DDB',
    background: '#FFF5F3FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFECE6F8',
    outline: '#FFD1C4E9',
    success: '#FF4CAF50',
    warning: '#FFFFB300',
    error: '#FFE53935',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF2E1A47',
    onBackground: '#FF2E1A47',
    onSurface: '#FF2E1A47',
  };

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static Shapes = {
    small: 8,
    medium: 14,
    large: 20,
  };

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
  };

  static ShadowSpec = class {
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
  };

  static ElevationMapping = {
    level1: new AppTokens.ShadowSpec(4, 8, 2, 0.18),
    level2: new AppTokens.ShadowSpec(8, 12, 4, 0.22),
    level3: new AppTokens.ShadowSpec(12, 20, 8, 0.26),
  };
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  @State private orderId: string = '';
  @State private issue: string = '';
  @State private submitted: boolean = false;

  // Custom Card Style using @Extend
  @Extend(Column)
  customCardStyle(cornerRadius: number, backgroundColor: ResourceStr, shadowSpec: AppTokens.ShadowSpec, ambientColor: ResourceStr) {
    .backgroundColor(backgroundColor)
    .borderRadius(cornerRadius)
    .shadow({
      radius: shadowSpec.radius,
      color: ambientColor,
      offsetX: 0,
      offsetY: shadowSpec.dy,
    });
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background);

      // Main Content
      Column() {
        Text('After-Sale Service')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ bottom: AppTokens.Spacing.lg });

        // Card Area
        Column() {
          Text('Order ID')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.md });

          // Order ID Input
          Stack({ alignContent: Alignment.Start }) {
            if (this.orderId === '') {
              Text('Enter order number')
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .opacity(0.5)
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
                .height(56)
                .textAlignVertical(TextAlign.Center);
            }
            TextInput({ text: this.orderId })
              .onChange((value: string) => {
                this.orderId = value;
              })
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
              .height(56)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .borderWidth(1)
              .borderColor(this.orderId !== '' ? AppTokens.Colors.primary : AppTokens.Colors.outline);
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.md });

          Text('Issue Description')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.md });

          // Issue Description Input
          Stack({ alignContent: Alignment.Start }) {
            if (this.issue === '') {
              Text('Describe your issue')
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .opacity(0.5)
                .padding({
                  left: AppTokens.Spacing.md,
                  right: AppTokens.Spacing.md,
                  top: AppTokens.Spacing.sm + 4,
                });
            }
            TextArea({ text: this.issue })
              .onChange((value: string) => {
                this.issue = value;
              })
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .padding({
                left: AppTokens.Spacing.md,
                right: AppTokens.Spacing.md,
                top: AppTokens.Spacing.sm + 4,
              })
              .height(120)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .borderWidth(1)
              .borderColor(this.issue !== '' ? AppTokens.Colors.primary : AppTokens.Colors.outline);
          }
          .width('100%');
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokens.Spacing.lg)
        .customCardStyle(
          AppTokens.Shapes.large,
          AppTokens.Colors.surface,
          AppTokens.ElevationMapping.level2,
          AppTokens.Colors.outline
        )
        .margin({ bottom: AppTokens.Spacing.lg });

        // Submit Button
        Button('Submit Request')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(56)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => {
            this.submitted = true;
          })
          .margin({ bottom: AppTokens.Spacing.lg });

        // Success Message
        if (this.submitted) {
          Text('Request submitted successfully!')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.success)
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.success)
            .opacity(0.15)
            .borderRadius(AppTokens.Shapes.medium)
            .textAlign(TextAlign.Center);
        }
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg);
    }
    .width('100%')
    .height('100%');
  }
}
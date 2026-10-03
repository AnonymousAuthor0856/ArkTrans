import { Component, State } from '@kit.ArkUI';

const NAME = "059*AfterSale*en";
const UI_TYPE = "ECommerce";
const STYLE_THEME = "Clay Morph";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppTokens {
  static readonly Colors = {
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
  };

  static readonly TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 8,
    medium: 14,
    large: 20
  };

  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24
  };

  static readonly ElevationMapping = {
    level1: { elevation: 4, radius: 8, dy: 2, opacity: 0.18 },
    level2: { elevation: 8, radius: 12, dy: 4, opacity: 0.22 },
    level3: { elevation: 12, radius: 20, dy: 8, opacity: 0.26 }
  };
}

@Component
struct RootScreen {
  @State orderId: string = '';
  @State issue: string = '';
  @State submitted: boolean = false;

  build() {
    Column({ space: AppTokens.Spacing.lg }) {
      Text('After-Sale Service')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)

      Column({ space: AppTokens.Spacing.md }) {
        Text('Order ID')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        TextInput({ placeholder: 'Enter order number', text: this.orderId })
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .onChange((value: string) => {
            this.orderId = value;
          })

        Text('Issue Description')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        TextArea({ placeholder: 'Describe your issue', text: this.issue })
          .width('100%')
          .height(120)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .onChange((value: string) => {
            this.issue = value;
          })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: AppTokens.Colors.secondary,
        offsetY: AppTokens.ElevationMapping.level2.dy
      })

      Button('Submit Request')
        .width('100%')
        .height(56)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .borderRadius(AppTokens.Shapes.large)
        .onClick(() => {
          this.submitted = true;
        })

      if (this.submitted) {
        Row() {
          Text('Request submitted successfully!')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontColor(AppTokens.Colors.success)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor('#1A4CAF50')
        .borderRadius(AppTokens.Shapes.medium)
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Entry
@Component
struct MainPage {
  build() {
    Stack() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
// Index.ets

const NAME: string = "059*AfterSale*en";
const UI_TYPE: string = "ECommerce";
const STYLE_THEME: string = "Clay Morph";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

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

class AppTokens {
  static primary: string = "#8E6BF2";
  static secondary: string = "#D3C1FF";
  static tertiary: string = "#B39DDB";
  static background: string = "#F5F3FF";
  static surface: string = "#FFFFFF";
  static surfaceVariant: string = "#ECE6F8";
  static outline: string = "#D1C4E9";
  static success: string = "#4CAF50";
  static warning: string = "#FFB300";
  static error: string = "#E53935";
  static onPrimary: string = "#FFFFFF";
  static onSecondary: string = "#2E1A47";
  static onBackground: string = "#2E1A47";
  static onSurface: string = "#2E1A47";

  static displayFontSize: number = 28;
  static displayFontWeight: FontWeight = FontWeight.Bold;
  static titleFontSize: number = 18;
  static titleFontWeight: FontWeight = FontWeight.Medium;
  static bodyFontSize: number = 14;
  static bodyFontWeight: FontWeight = FontWeight.Normal;
  static labelFontSize: number = 12;
  static labelFontWeight: FontWeight = FontWeight.Medium;

  static smallRadius: number = 8;
  static mediumRadius: number = 14;
  static largeRadius: number = 20;

  static sm: number = 6;
  static md: number = 10;
  static lg: number = 16;
  static xl: number = 24;

  static level1: ShadowSpec = new ShadowSpec(4, 8, 2, 0.18);
  static level2: ShadowSpec = new ShadowSpec(8, 12, 4, 0.22);
  static level3: ShadowSpec = new ShadowSpec(12, 20, 8, 0.26);
}

@Entry
@Component
struct RootScreen {
  @State orderId: string = "";
  @State issue: string = "";
  @State submitted: boolean = false;

  build() {
    Column() {
      Scroll() {
        Column() {
          Text("After-Sale Service")
            .fontSize(AppTokens.displayFontSize)
            .fontWeight(AppTokens.displayFontWeight)
            .fontColor(AppTokens.onBackground)
            .margin({ bottom: AppTokens.lg });

          Column() {
            Text("Order ID")
              .fontSize(AppTokens.titleFontSize)
              .fontWeight(AppTokens.titleFontWeight)
              .fontColor(AppTokens.onSurface)
              .margin({ bottom: AppTokens.md });

            TextInput({ text: this.orderId, placeholder: "Enter order number" })
              .onChange((value: string) => {
                this.orderId = value;
              })
              .backgroundColor(AppTokens.surfaceVariant)
              .borderRadius(AppTokens.mediumRadius)
              .borderWidth({ bottom: 1 })
              .borderColor(AppTokens.outline)
              .height(50)
              .width("100%");

            Text("Issue Description")
              .fontSize(AppTokens.titleFontSize)
              .fontWeight(AppTokens.titleFontWeight)
              .fontColor(AppTokens.onSurface)
              .margin({ top: AppTokens.md, bottom: AppTokens.md });

            TextArea({ text: this.issue, placeholder: "Describe your issue" })
              .onChange((value: string) => {
                this.issue = value;
              })
              .backgroundColor(AppTokens.surfaceVariant)
              .borderRadius(AppTokens.mediumRadius)
              .borderWidth({ bottom: 1 })
              .borderColor(AppTokens.outline)
              .height(120)
              .width("100%");
          }
          .padding(AppTokens.lg)
          .backgroundColor(AppTokens.surface)
          .borderRadius(AppTokens.largeRadius)
          .shadow({
            radius: AppTokens.level2.radius,
            color: AppTokens.secondary,
            offsetX: 0,
            offsetY: AppTokens.level2.dy
          })
          .width("100%");

          Button("Submit Request", { type: ButtonType.Capsule })
            .backgroundColor(AppTokens.primary)
            .fontColor(AppTokens.onPrimary)
            .fontSize(AppTokens.titleFontSize)
            .fontWeight(AppTokens.titleFontWeight)
            .height(56)
            .width("100%")
            .margin({ top: AppTokens.lg })
            .onClick(() => {
              this.submitted = true;
            });

          if (this.submitted) {
            Text("Request submitted successfully!")
              .fontSize(AppTokens.bodyFontSize)
              .fontWeight(AppTokens.bodyFontWeight)
              .fontColor(AppTokens.success)
              .textAlign(TextAlign.Center)
              .width("100%")
              .padding(AppTokens.lg)
              .backgroundColor("#264CAF50")
              .borderRadius(AppTokens.mediumRadius)
              .margin({ top: AppTokens.lg });
          }
        }
        .width("100%")
        .padding(AppTokens.lg);
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)
      .width("100%");
    }
    .width("100%")
    .height("100%")
    .backgroundColor(AppTokens.background);
  }
}
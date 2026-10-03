// 059*AfterSale*en | ECommerce | Clay Morph | en | 720x1280

const NAME: string = "059*AfterSale*en";
const UI_TYPE: string = "ECommerce";
const STYLE_THEME: string = "Clay Morph";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppTokens {
  static Colors = {
    primary: "#8E6BF2",
    secondary: "#D3C1FF",
    tertiary: "#B39DDB",
    background: "#F5F3FF",
    surface: "#FFFFFF",
    surfaceVariant: "#ECE6F8",
    outline: "#D1C4E9",
    success: "#4CAF50",
    warning: "#FFB300",
    error: "#E53935",
    onPrimary: "#FFFFFF",
    onSecondary: "#2E1A47",
    onBackground: "#2E1A47",
    onSurface: "#2E1A47",
  };
  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
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
  static ElevationMapping = {
    level1: { elevation: 4, radius: 8, dy: 2, opacity: 0.18 },
    level2: { elevation: 8, radius: 12, dy: 4, opacity: 0.22 },
    level3: { elevation: 12, radius: 20, dy: 8, opacity: 0.26 },
  };
}

@Entry
@Component
struct RootScreen {
  @State orderId: string = "";
  @State issue: string = "";
  @State submitted: boolean = false;

  build() {
    Column() {
      Column() {
        Text("After-Sale Service")
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .margin({ bottom: AppTokens.Spacing.lg });

        // Card
        Column() {
          Text("Order ID")
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.sm });

          TextInput({ text: this.orderId, placeholder: "Enter order number" })
            .type(InputType.Normal)
            .onChange((value: string) => {
              this.orderId = value;
            })
            .width("100%")
            .height(50)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .margin({ bottom: AppTokens.Spacing.md });

          Text("Issue Description")
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.sm });

          TextArea({ text: this.issue, placeholder: "Describe your issue" })
            .onChange((value: string) => {
              this.issue = value;
            })
            .width("100%")
            .height(120)
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium);
        }
        .width("100%")
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `rgba(211, 193, 255, ${AppTokens.ElevationMapping.level2.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy,
        })
        .margin({ bottom: AppTokens.Spacing.lg });

        Button("Submit Request")
          .onClick(() => {
            this.submitted = true;
          })
          .width("100%")
          .height(56)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .borderRadius(AppTokens.Shapes.large)
          .margin({ bottom: AppTokens.Spacing.lg });

        if (this.submitted) {
          Row() {
            Text("Request submitted successfully!")
              .fontSize(AppTokens.TypographyTokens.body.fontSize)
              .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
              .fontColor(AppTokens.Colors.success);
          }
          .width("100%")
          .padding(AppTokens.Spacing.lg)
          .backgroundColor("rgba(76, 175, 80, 0.15)")
          .borderRadius(AppTokens.Shapes.medium)
          .justifyContent(FlexAlign.Center);
        }
      }
      .width("100%")
      .padding(AppTokens.Spacing.lg);
    }
    .width("100%")
    .height("100%")
    .backgroundColor(AppTokens.Colors.background)
    .alignItems(HorizontalAlign.Start);
  }
}
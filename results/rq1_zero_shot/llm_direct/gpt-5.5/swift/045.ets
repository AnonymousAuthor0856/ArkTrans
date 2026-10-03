interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
  color: string;
}

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
    onSurface: '#2E1A47',
    onSurface50: 'rgba(46, 26, 71, 0.50)',
    success15: 'rgba(76, 175, 80, 0.15)',
    shadowLevel2: 'rgba(209, 196, 233, 0.22)'
  };

  static readonly TypographyTokens = {
    display: {
      size: 28,
      weight: FontWeight.Bold
    },
    title: {
      size: 18,
      weight: FontWeight.Medium
    },
    body: {
      size: 14,
      weight: FontWeight.Regular
    },
    label: {
      size: 12,
      weight: FontWeight.Medium
    }
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

  static readonly ElevationMapping: Record<string, ShadowSpec> = {
    level1: {
      elevation: 4,
      radius: 8,
      dy: 2,
      opacity: 0.18,
      color: 'rgba(209, 196, 233, 0.18)'
    },
    level2: {
      elevation: 8,
      radius: 12,
      dy: 4,
      opacity: 0.22,
      color: 'rgba(209, 196, 233, 0.22)'
    },
    level3: {
      elevation: 12,
      radius: 20,
      dy: 8,
      opacity: 0.26,
      color: 'rgba(209, 196, 233, 0.26)'
    }
  };
}

@Entry
@Component
struct RootScreen {
  @State private orderId: string = '';
  @State private issue: string = '';
  @State private submitted: boolean = false;
  @State private orderIdIsFocused: boolean = false;
  @State private issueIsFocused: boolean = false;

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.lg }) {
        Text('After-Sale Service')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        Column({ space: AppTokens.Spacing.md }) {
          Text('Order ID')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          Stack({ alignContent: Alignment.TopStart }) {
            TextInput({
              text: this.orderId,
              placeholder: ''
            })
              .width('100%')
              .height(56)
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .caretColor(AppTokens.Colors.primary)
              .padding({
                left: AppTokens.Spacing.md,
                right: AppTokens.Spacing.md
              })
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .border({
                width: 1,
                color: this.orderIdIsFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline
              })
              .onFocus(() => {
                this.orderIdIsFocused = true;
              })
              .onBlur(() => {
                this.orderIdIsFocused = false;
              })
              .onChange((value: string) => {
                this.orderId = value;
              })

            if (this.orderId.length === 0 && !this.orderIdIsFocused) {
              Text('Enter order number')
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
                .fontColor(AppTokens.Colors.onSurface50)
                .padding({
                  left: AppTokens.Spacing.md,
                  right: AppTokens.Spacing.md,
                  top: 21,
                  bottom: 21
                })
            }
          }
          .width('100%')
          .height(56)

          Text('Issue Description')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          Stack({ alignContent: Alignment.TopStart }) {
            TextArea({
              text: this.issue,
              placeholder: ''
            })
              .width('100%')
              .height(120)
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .caretColor(AppTokens.Colors.primary)
              .padding({
                left: AppTokens.Spacing.md,
                right: AppTokens.Spacing.md,
                top: AppTokens.Spacing.sm + 4,
                bottom: AppTokens.Spacing.sm + 4
              })
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .border({
                width: 1,
                color: this.issueIsFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline
              })
              .onFocus(() => {
                this.issueIsFocused = true;
              })
              .onBlur(() => {
                this.issueIsFocused = false;
              })
              .onChange((value: string) => {
                this.issue = value;
              })

            if (this.issue.length === 0 && !this.issueIsFocused) {
              Text('Describe your issue')
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
                .fontColor(AppTokens.Colors.onSurface50)
                .padding({
                  left: AppTokens.Spacing.md,
                  right: AppTokens.Spacing.md,
                  top: AppTokens.Spacing.sm + 4,
                  bottom: AppTokens.Spacing.sm + 4
                })
            }
          }
          .width('100%')
          .height(120)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: AppTokens.ElevationMapping.level2.color,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        Button() {
          Text('Submit Request')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .textAlign(TextAlign.Center)
        }
        .type(ButtonType.Normal)
        .width('100%')
        .height(56)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large)
        .onClick(() => {
          this.submitted = true;
        })

        if (this.submitted) {
          Text('Request submitted successfully!')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.success)
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.success15)
            .borderRadius(AppTokens.Shapes.medium)
            .textAlign(TextAlign.Center)
        }

        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
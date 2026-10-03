// AppTokens - using class definitions instead of object literals

class ColorsClass {
  primary: string = '#8E6BF2';
  secondary: string = '#D3C1FF';
  tertiary: string = '#B39DDB';
  background: string = '#F5F3FF';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#ECE6F8';
  outline: string = '#D1C4E9';
  success: string = '#4CAF50';
  warning: string = '#FFB300';
  error: string = '#E53935';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#2E1A47';
  onBackground: string = '#2E1A47';
  onSurface: string = '#2E1A47';
}

class SpacingClass {
  sm: number = 6;
  md: number = 10;
  lg: number = 16;
  xl: number = 24;
}

class ShapesClass {
  small: number = 8;
  medium: number = 14;
  large: number = 20;
}

const Colors: ColorsClass = new ColorsClass();
const Spacing: SpacingClass = new SpacingClass();
const Shapes: ShapesClass = new ShapesClass();

@Entry
@Component
struct RootScreen {
  @State orderId: string = '';
  @State issue: string = '';
  @State submitted: boolean = false;
  @State orderIdFocused: boolean = false;
  @State issueFocused: boolean = false;

  build() {
    Stack() {
      Scroll() {
        Column({ space: Spacing.lg }) {
          // Title
          Text('After-Sale Service')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onBackground)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Card Area
          Column({ space: Spacing.md }) {
            Text('Order ID')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .width('100%')
              .textAlign(TextAlign.Start)

            // Order ID Input
            Stack({ alignContent: Alignment.TopStart }) {
              if (this.orderId === '' && !this.orderIdFocused) {
                Text('Enter order number')
                  .fontSize(14)
                  .fontColor('#802E1A47')
                  .padding({
                    left: Spacing.md,
                    right: Spacing.md,
                    top: (56 - 14) / 2,
                    bottom: (56 - 14) / 2
                  })
                  .height(56)
                  .width('100%')
                  .textAlign(TextAlign.Start)
              }
              TextInput({ text: this.orderId, placeholder: '' })
                .fontSize(14)
                .fontColor(Colors.onSurface)
                .height(56)
                .width('100%')
                .padding({ left: Spacing.md, right: Spacing.md })
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(Shapes.medium)
                .borderWidth(1)
                .borderColor(this.orderIdFocused ? Colors.primary : Colors.outline)
                .onChange((value: string) => {
                  this.orderId = value;
                })
                .onFocus(() => {
                  this.orderIdFocused = true;
                })
                .onBlur(() => {
                  this.orderIdFocused = false;
                })
            }
            .width('100%')

            Text('Issue Description')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .width('100%')
              .textAlign(TextAlign.Start)

            // Issue Description Input
            Stack({ alignContent: Alignment.TopStart }) {
              if (this.issue === '' && !this.issueFocused) {
                Text('Describe your issue')
                  .fontSize(14)
                  .fontColor('#802E1A47')
                  .padding({
                    left: Spacing.md,
                    right: Spacing.md,
                    top: Spacing.sm + 4,
                    bottom: Spacing.sm + 4
                  })
                  .width('100%')
                  .textAlign(TextAlign.Start)
              }
              TextArea({ text: this.issue, placeholder: '' })
                .fontSize(14)
                .fontColor(Colors.onSurface)
                .height(120)
                .width('100%')
                .padding({
                  left: Spacing.md,
                  right: Spacing.md,
                  top: Spacing.sm + 4,
                  bottom: Spacing.sm + 4
                })
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(Shapes.medium)
                .borderWidth(1)
                .borderColor(this.issueFocused ? Colors.primary : Colors.outline)
                .onChange((value: string) => {
                  this.issue = value;
                })
                .onFocus(() => {
                  this.issueFocused = true;
                })
                .onBlur(() => {
                  this.issueFocused = false;
                })
            }
            .width('100%')
          }
          .width('100%')
          .padding(Spacing.lg)
          .backgroundColor(Colors.surface)
          .borderRadius(Shapes.large)
          .shadow({
            radius: 12,
            color: '#38D1C4E9',
            offsetX: 0,
            offsetY: 4,
          })
          .alignItems(HorizontalAlign.Start)

          // Submit Button
          Button() {
            Text('Submit Request')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onPrimary)
          }
          .width('100%')
          .height(56)
          .backgroundColor(Colors.primary)
          .borderRadius(Shapes.large)
          .onClick(() => {
            this.submitted = true;
          })

          // Success Message
          if (this.submitted) {
            Text('Request submitted successfully!')
              .fontSize(14)
              .fontColor(Colors.success)
              .width('100%')
              .padding(Spacing.lg)
              .backgroundColor('#264CAF50')
              .borderRadius(Shapes.medium)
              .textAlign(TextAlign.Center)
          }
        }
        .width('100%')
        .padding(Spacing.lg)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
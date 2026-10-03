// pages/Index.ets
class AppColors {
  static readonly primary: string = '#8E6BF2';
  static readonly secondary: string = '#D3C1FF';
  static readonly tertiary: string = '#B39DDB';
  static readonly background: string = '#F5F3FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#ECE6F8';
  static readonly outline: string = '#D1C4E9';
  static readonly success: string = '#4CAF50';
  static readonly successBg: string = '#264CAF50';
  static readonly warning: string = '#FFB300';
  static readonly error: string = '#E53935';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#2E1A47';
  static readonly onBackground: string = '#2E1A47';
  static readonly onSurface: string = '#2E1A47';
  static readonly placeholder: string = '#802E1A47';
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class AppRadii {
  static readonly small: number = 8;
  static readonly medium: number = 14;
  static readonly large: number = 20;
}

class AppType {
  static readonly display: number = 28;
  static readonly title: number = 18;
  static readonly body: number = 14;
  static readonly label: number = 12;
}

@Entry
@Component
struct Index {
  @State orderId: string = '';
  @State issue: string = '';
  @State submitted: boolean = false;

  build() {
    Column({ space: AppSpacing.lg }) {
      // Title
      Text('After-Sale Service')
        .fontSize(AppType.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .width('100%')
        .textAlign(TextAlign.Start)

      // Card
      Column({ space: AppSpacing.md }) {
        Text('Order ID')
          .fontSize(AppType.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')

        TextInput({ text: this.orderId, placeholder: 'Enter order number' })
          .placeholderColor(AppColors.placeholder)
          .placeholderFont({ size: AppType.body })
          .fontSize(AppType.body)
          .fontColor(AppColors.onSurface)
          .caretColor(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppRadii.medium)
          .borderWidth(1)
          .borderColor(AppColors.outline)
          .height(48)
          .width('100%')
          .onChange((value: string) => {
            this.orderId = value;
          })

        Text('Issue Description')
          .fontSize(AppType.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')

        TextArea({ text: this.issue, placeholder: 'Describe your issue' })
          .placeholderColor(AppColors.placeholder)
          .placeholderFont({ size: AppType.body })
          .fontSize(AppType.body)
          .fontColor(AppColors.onSurface)
          .caretColor(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppRadii.medium)
          .borderWidth(1)
          .borderColor(AppColors.outline)
          .height(120)
          .width('100%')
          .onChange((value: string) => {
            this.issue = value;
          })
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppRadii.large)
      .shadow({
        radius: 12,
        color: '#38D3C1FF',
        offsetX: 0,
        offsetY: 4
      })
      .alignItems(HorizontalAlign.Start)

      // Submit button
      Button('Submit Request', { type: ButtonType.Normal, stateEffect: true })
        .width('100%')
        .height(56)
        .fontSize(AppType.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppRadii.large)
        .onClick(() => {
          this.submitted = true;
        })

      // Success banner
      if (this.submitted) {
        Row() {
          Text('Request submitted successfully!')
            .fontSize(AppType.body)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.success)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.successBg)
        .borderRadius(AppRadii.medium)
      }
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
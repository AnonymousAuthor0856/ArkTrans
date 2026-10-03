// AppTokens - design system tokens
class AppColors {
  static readonly primary: ResourceColor = '#8E6BF2';
  static readonly secondary: ResourceColor = '#D3C1FF';
  static readonly tertiary: ResourceColor = '#B39DDB';
  static readonly background: ResourceColor = '#F5F3FF';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceVariant: ResourceColor = '#ECE6F8';
  static readonly outline: ResourceColor = '#D1C4E9';
  static readonly success: ResourceColor = '#4CAF50';
  static readonly warning: ResourceColor = '#FFB300';
  static readonly error: ResourceColor = '#E53935';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#2E1A47';
  static readonly onBackground: ResourceColor = '#2E1A47';
  static readonly onSurface: ResourceColor = '#2E1A47';
}

class AppShapes {
  static readonly small: Length = 8;
  static readonly medium: Length = 14;
  static readonly large: Length = 20;
}

class AppSpacing {
  static readonly sm: Length = 6;
  static readonly md: Length = 10;
  static readonly lg: Length = 16;
  static readonly xl: Length = 24;
}

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
      Column({ space: AppSpacing.lg }) {
        Text('After-Sale Service')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .width('100%')

        // Card with form fields
        Column() {
          Text('Order ID')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .width('100%')
            .margin({ bottom: AppSpacing.md })

          TextInput({ placeholder: 'Enter order number', text: this.orderId })
            .fontSize(14)
            .fontColor(AppColors.onSurface)
            .placeholderColor('rgba(46, 26, 71, 0.5)')
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.medium)
            .border({
              width: 1,
              color: this.orderIdFocused ? AppColors.primary : AppColors.outline
            })
            .height(56)
            .padding({ left: AppSpacing.md, right: AppSpacing.md })
            .onFocus(() => { this.orderIdFocused = true; })
            .onBlur(() => { this.orderIdFocused = false; })
            .onChange((value: string) => { this.orderId = value; })
            .margin({ bottom: AppSpacing.md })

          Text('Issue Description')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .width('100%')
            .margin({ bottom: AppSpacing.md })

          TextArea({ placeholder: 'Describe your issue', text: this.issue })
            .fontSize(14)
            .fontColor(AppColors.onSurface)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.medium)
            .border({
              width: 1,
              color: this.issueFocused ? AppColors.primary : AppColors.outline
            })
            .height(120)
            .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm as number + 4, bottom: AppSpacing.sm as number + 4 })
            .onFocus(() => { this.issueFocused = true; })
            .onBlur(() => { this.issueFocused = false; })
            .onChange((value: string) => { this.issue = value; })
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: 12,
          color: 'rgba(209, 196, 233, 0.22)',
          offsetY: 4
        })

        // Submit button
        Button('Submit Request', { type: ButtonType.Normal })
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .width('100%')
          .height(56)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.large)
          .onClick(() => { this.submitted = true; })

        // Success message
        if (this.submitted) {
          Text('Request submitted successfully!')
            .fontSize(14)
            .fontColor(AppColors.success)
            .width('100%')
            .padding(AppSpacing.lg)
            .backgroundColor('rgba(76, 175, 80, 0.15)')
            .borderRadius(AppShapes.medium)
            .textAlign(TextAlign.Center)
        }

        Blank()
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

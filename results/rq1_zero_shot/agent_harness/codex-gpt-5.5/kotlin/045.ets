const NAME: string = '059*AfterSale*en';
const UI_TYPE: string = 'ECommerce';
const STYLE_THEME: string = 'Clay Morph';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#8E6BF2';
  static readonly secondary: string = '#D3C1FF';
  static readonly tertiary: string = '#B39DDB';
  static readonly background: string = '#F5F3FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#ECE6F8';
  static readonly outline: string = '#D1C4E9';
  static readonly success: string = '#4CAF50';
  static readonly warning: string = '#FFB300';
  static readonly error: string = '#E53935';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#2E1A47';
  static readonly onBackground: string = '#2E1A47';
  static readonly onSurface: string = '#2E1A47';
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

@Entry
@Component
struct MainActivity {
  @State orderId: string = '';
  @State issue: string = '';
  @State submitted: boolean = false;

  @Builder
  FormCard(): void {
    Column({ space: AppSpacing.md }) {
      Text('Order ID')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      TextInput({ text: this.orderId, placeholder: 'Enter order number' })
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .placeholderColor('#802E1A47')
        .backgroundColor(AppColors.surfaceVariant)
        .border({ width: 1, color: AppColors.outline })
        .borderRadius(14)
        .width('100%')
        .height(48)
        .onChange((value: string) => {
          this.orderId = value;
        });
      Text('Issue Description')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      TextArea({ text: this.issue, placeholder: 'Describe your issue' })
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .placeholderColor('#802E1A47')
        .backgroundColor(AppColors.surfaceVariant)
        .border({ width: 1, color: AppColors.outline })
        .borderRadius(14)
        .width('100%')
        .height(120)
        .onChange((value: string) => {
          this.issue = value;
        });
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(20)
    .shadow({ radius: 12, color: '#382E1A47', offsetY: 4 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  SuccessBox(): void {
    if (this.submitted) {
      Stack() {
        Text('Request submitted successfully!')
          .fontSize(14)
          .fontColor(AppColors.success);
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .backgroundColor('#264CAF50')
      .borderRadius(14)
      .alignContent(Alignment.Center);
    }
  }

  build() {
    Column({ space: AppSpacing.lg }) {
      Text('After-Sale Service')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground);
      this.FormCard();
      Button('Submit Request')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(20)
        .width('100%')
        .height(56)
        .onClick(() => {
          this.submitted = true;
        });
      this.SuccessBox();
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background);
  }
}

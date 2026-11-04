class AfterSaleColors {
  static primary: string = '#8E6BF2';
  static secondary: string = '#D3C1FF';
  static tertiary: string = '#B39DDB';
  static background: string = '#F5F3FF';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#ECE6F8';
  static outline: string = '#D1C4E9';
  static success: string = '#4CAF50';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#2E1A47';
}

@Entry
@Component
struct Index {
  @State orderId: string = '';
  @State issue: string = '';
  @State submitted: boolean = false;

  @Builder
  FormCard() {
    Column() {
      Text('Order ID')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AfterSaleColors.onSurface)
        .lineHeight(24)
        .width('100%')
      TextInput({ text: this.orderId, placeholder: 'Enter order number' })
        .width('100%')
        .height(48)
        .fontColor(AfterSaleColors.onSurface)
        .placeholderColor('#802E1A47')
        .backgroundColor(AfterSaleColors.surfaceVariant)
        .border({ width: 1, color: AfterSaleColors.outline, radius: 14 })
        .borderRadius(14)
        .onChange((value: string) => {
          this.orderId = value;
        })
        .margin({ top: 10 })

      Text('Issue Description')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AfterSaleColors.onSurface)
        .lineHeight(24)
        .width('100%')
        .margin({ top: 10 })
      TextInput({ text: this.issue, placeholder: 'Describe your issue' })
        .width('100%')
        .height(120)
        .fontColor(AfterSaleColors.onSurface)
        .placeholderColor('#802E1A47')
        .backgroundColor(AfterSaleColors.surfaceVariant)
        .border({ width: 1, color: AfterSaleColors.outline, radius: 14 })
        .borderRadius(14)
        .onChange((value: string) => {
          this.issue = value;
        })
        .margin({ top: 10 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(AfterSaleColors.surface)
    .borderRadius(20)
    .shadow({ radius: 12, color: '#38D3C1FF', offsetX: 0, offsetY: 4 })
  }

  build() {
    Column() {
      Text('After-Sale Service')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AfterSaleColors.onSurface)
        .lineHeight(34)
        .width('100%')

      Column() {
        this.FormCard()
      }
      .width('100%')
      .margin({ top: 16 })

      Button('Submit Request')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AfterSaleColors.onPrimary)
        .width('100%')
        .height(56)
        .backgroundColor(AfterSaleColors.primary)
        .borderRadius(20)
        .margin({ top: 16 })
        .onClick(() => {
          this.submitted = true;
        })

      if (this.submitted) {
        Column() {
          Text('Request submitted successfully!')
            .fontSize(14)
            .fontColor(AfterSaleColors.success)
            .lineHeight(20)
        }
        .width('100%')
        .padding(16)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#264CAF50')
        .borderRadius(14)
        .margin({ top: 16 })
      }
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor(AfterSaleColors.background)
  }
}

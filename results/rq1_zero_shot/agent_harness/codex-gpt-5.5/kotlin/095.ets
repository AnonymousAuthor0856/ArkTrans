class ReceiptRow {
  label: string;
  value: string;
  icon: string;

  constructor(label: string, value: string, icon: string = '') {
    this.label = label;
    this.value = value;
    this.icon = icon;
  }
}

@Entry
@Component
struct MainActivity {
  private rows: ReceiptRow[] = [
    new ReceiptRow('To Merchant', 'TechSpace Solutions', 'i'),
    new ReceiptRow('Date', 'Dec 02, 2025 - 11:30 PM', '▣'),
    new ReceiptRow('Ref Number', '009281-XX-99'),
    new ReceiptRow('Payment Method', 'Credit Card •••• 4242')
  ];

  @Builder
  SuccessIcon() {
    Text('✓')
      .fontSize(36)
      .fontColor('#2E7D32')
      .textAlign(TextAlign.Center)
      .width(72)
      .height(72)
      .lineHeight(72)
      .backgroundColor('#E8F5E9')
      .borderRadius(36)
  }

  @Builder
  RowDetail(row: ReceiptRow, showDivider: boolean) {
    Column() {
      Row() {
        Row() {
          if (row.icon !== '') {
            Text(row.icon)
              .fontSize(18)
              .fontColor('#808080')
              .margin({ right: 8 })
          }
          Text(row.label)
            .fontSize(14)
            .fontColor('#808080')
        }
        .alignItems(VerticalAlign.Center)
        Text(row.value)
          .fontSize(14)
          .fontWeight(row.icon !== '' ? FontWeight.SemiBold : FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      if (showDivider) {
        Divider().color('#E0E0E0').margin({ top: 16 })
      }
    }
    .width('100%')
  }

  @Builder
  ReceiptDetailsCard() {
    Column({ space: 16 }) {
      ForEach(this.rows, (row: ReceiptRow, index: number) => {
        this.RowDetail(row, index === 0 || index === 1)
      })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F8F9FA')
    .border({ width: 1, color: '#EEEEEE' })
    .borderRadius(12)
  }

  @Builder
  ActionButtons() {
    Column({ space: 12 }) {
      Button('Done')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .width('100%')
        .height(50)
        .backgroundColor('#000000')
        .borderRadius(8)
      Button('↗  Share Receipt')
        .fontSize(16)
        .fontColor('#000000')
        .width('100%')
        .height(50)
        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#DDDDDD' })
        .borderRadius(8)
    }
    .width('100%')
  }

  build() {
    Column() {
      Blank().height(20)
      this.SuccessIcon()
      Text('Payment Success')
        .fontSize(16)
        .fontColor('#808080')
        .margin({ top: 16 })
      Text('$1,249.00')
        .fontSize(44)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .margin({ top: 8 })
      Blank().height(32)
      this.ReceiptDetailsCard()
      Blank().layoutWeight(1)
      this.ActionButtons()
      Blank().height(16)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFFFFF')
  }
}

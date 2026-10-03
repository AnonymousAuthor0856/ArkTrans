// index.ets
import { Length, ResourceStr } from '@ohos.arkui';

// Define colors to match the Compose theme
class Colors {
  static readonly White: string = '#FFFFFF';
  static readonly Black: string = '#000000';
  static readonly Gray: string = '#808080';
  static readonly LightGreen: string = '#E8F5E9';
  static readonly DarkGreen: string = '#2E7D32';
  static readonly LightGrayBg: string = '#F8F9FA';
  static readonly BorderLight: string = '#EEEEEE';
  static readonly Divider: string = '#E0E0E0';
  static readonly OutlinedBorder: string = '#DDDDDD';
}

@Entry
@Component
struct ReceiptScreen {
  build() {
    Column() {
      // Main Content Area
      Column() {
        // --- Header Section ---
        Blank().height(20)

        // Success Icon
        SuccessIcon()

        Blank().height(16)
        Text('Payment Success')
          .fontSize(16)
          .fontColor(Colors.Gray)
          .margin({ top: 4 })

        Blank().height(8)
        Text('$1,249.00')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.Black)

        Blank().height(32)

        // --- Receipt Card ---
        ReceiptDetailsCard()

        // Push buttons to the bottom
        Blank().layoutWeight(1)

        // --- Action Buttons ---
        ActionButtons()
        Blank().height(16)
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.White)
  }
}

// --- Success Icon Component ---
@Component
struct SuccessIcon {
  build() {
    Stack() {
      Text('✔') // Using text as a checkmark icon substitute
        .fontSize(36)
        .fontColor(Colors.DarkGreen)
    }
    .width(72)
    .height(72)
    .borderRadius(36) // CircleShape
    .backgroundColor(Colors.LightGreen)
    .alignContent(Alignment.Center)
  }
}

// --- Receipt Details Card Component ---
@Component
struct ReceiptDetailsCard {
  build() {
    Column() {
      // Recipient
      RowDetail({ label: 'To Merchant', value: 'TechSpace Solutions', icon: 'ℹ️' })

      // Divider
      Divider().color(Colors.Divider).strokeWidth(1).margin({ top: 16, bottom: 16 })

      // Date
      RowDetail({ label: 'Date', value: 'Dec 02, 2025 - 11:30 PM', icon: '📅' })

      // Divider
      Divider().color(Colors.Divider).strokeWidth(1).margin({ top: 16, bottom: 16 })

      // Transaction ID
      Row() {
        Text('Ref Number')
          .fontSize(14)
          .fontColor(Colors.Gray)
        Text('009281-XX-99')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.Black)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      // Payment Method
      Row() {
        Text('Payment Method')
          .fontSize(14)
          .fontColor(Colors.Gray)
        Text('Credit Card •••• 4242')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.Black)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 16 })
    }
    .width('100%')
    .padding(20)
    .backgroundColor(Colors.LightGrayBg)
    .borderRadius(12)
    .border({ width: 1, color: Colors.BorderLight })
  }
}

// --- Reusable Row Detail Component ---
@Component
struct RowDetail {
  @Prop label: string = '';
  @Prop value: string = '';
  @Prop icon: string = '';

  build() {
    Row() {
      Row() {
        Text(this.icon)
          .fontSize(14)
        // Spacer
        Blank().width(8)
        Text(this.label)
          .fontSize(14)
          .fontColor(Colors.Gray)
      }
      .alignItems(VerticalAlign.Center)

      Text(this.value)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.Black)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

// --- Action Buttons Component ---
@Component
struct ActionButtons {
  build() {
    Column({ space: 12 }) {
      // Done Button
      Button('Done') {
        // Empty block implies text-only button
      }
      .width('100%')
      .height(50)
      .backgroundColor(Colors.Black)
      .fontColor(Colors.White)
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .borderRadius(8)

      // Share Receipt Outlined Button
      Button() {
        Row() {
          Text('🔗').fontSize(14).fontColor(Colors.Black) // Share icon substitute
          Blank().width(8)
          Text('Share Receipt')
            .fontSize(16)
            .fontColor(Colors.Black)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Colors.White)
      .borderRadius(8)
      .border({ width: 1, color: Colors.OutlinedBorder })
    }
  }
}